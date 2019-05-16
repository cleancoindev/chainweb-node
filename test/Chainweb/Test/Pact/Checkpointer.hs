{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}

module Chainweb.Test.Pact.Checkpointer
  ( tests, testKeyset
  ) where

import Control.Lens (preview, _Just)
import Control.Monad (void)
import Control.Monad.Reader
import Control.Concurrent.MVar

import Data.Aeson (Value(..), object, (.=))
import Data.Default (def)
import Data.Text (Text)

import NeatInterpolation (text)

import Pact.Gas (freeGasEnv)
import Pact.Interpreter (EvalResult(..), mkPureEnv)
import Pact.Types.Info
import Pact.Types.Runtime (ExecutionMode(Transactional))
import qualified Pact.Types.Hash as H
import Pact.Types.Logger (Loggers, newLogger)
import Pact.Types.PactValue
import Pact.Types.Persistence
import Pact.Types.RPC (ContMsg(..))
import Pact.Types.Runtime (noSPVSupport, peStep)
import Pact.Types.Server (CommandEnv(..))
import Pact.Types.SQLite
import Pact.Types.Term (PactId(..), Term(..), toTList, toTerm, KeySet(..), KeySetName(..), Name(..))
import Pact.Types.Type (PrimType(..), Type(..))

import Test.Tasty.HUnit

-- internal imports

import Chainweb.BlockHash (BlockHash(..), nullBlockHash)
import Chainweb.BlockHeader (BlockHeight(..))
import Chainweb.MerkleLogHash (merkleLogHash)
import Chainweb.Pact.Backend.ChainwebPactDb
import Chainweb.Pact.Backend.InMemoryCheckpointer (initInMemoryCheckpointEnv)
import Chainweb.Pact.Backend.RelationalCheckpointer
import Chainweb.Pact.Backend.MemoryDb (mkPureState)
import Chainweb.Pact.Backend.Types
import Chainweb.Pact.TransactionExec
    (applyContinuation', applyExec', buildExecParsedCode)
import Chainweb.Pact.Utils (toEnv', toEnvPersist')
import Chainweb.Test.Pact.Utils
import Chainweb.Test.Utils

tests :: ScheduledTest
tests = testGroupSch "Checkpointer"
  [ testCase "testInMemory" testInMemory, testCase "testRelationalKeyset" testKeyset ]

testInMemory :: Assertion
testInMemory = do
  let loggers = pactTestLogger False -- set to True to see debug logs
  cpEnv <- initInMemoryCheckpointEnv
        (newLogger loggers "inMemCheckpointer") freeGasEnv
  env <- mkPureEnv loggers
  state <- mkPureState env

  testCheckpointer loggers cpEnv state

assertEitherSuccess :: Show l => String -> Either l r -> IO r
assertEitherSuccess msg (Left l) = assertFailure (msg ++ ": " ++ show l)
assertEitherSuccess _ (Right r) = return r

defModule :: Text -> Text
defModule idx = [text| ;;

(define-keyset 'k$idx (read-keyset 'k$idx))

(module m$idx 'k$idx

  (defschema sch col:integer)

  (deftable tbl:{sch})

  (defun insertTbl (a i)
    (insert tbl a { 'col: i }))

  (defun readTbl ()
    (sort (map (at 'col)
      (select tbl (constantly true)))))

  (defpact dopact (n)
    (step { 'name: n, 'value: 1 })
    (step { 'name: n, 'value: 2 }))

)
(create-table tbl)
(insertTbl "a" 1)
|]

tIntList :: [Int] -> Term n
tIntList = toTList (TyPrim TyInteger) def . map toTerm

testCheckpointer :: Loggers -> CheckpointEnv -> PactDbState -> Assertion
testCheckpointer loggers CheckpointEnv{..} dbState00 = do

  let logger = newLogger loggers "testCheckpointer"

      runExec :: Env' -> Maybe Value -> Text -> IO EvalResult
      runExec (Env' pactDbEnv) eData eCode = do
          let cmdenv = CommandEnv Nothing Transactional pactDbEnv logger freeGasEnv def
          execMsg <- buildExecParsedCode eData eCode
          applyExec' cmdenv def execMsg [] (H.toUntypedHash (H.hash "" :: H.PactHash)) noSPVSupport

      runCont :: Env' -> PactId -> Int -> IO EvalResult
      runCont (Env' pactDbEnv) pactId step = do
          let contMsg = ContMsg pactId step False Null
              cmdenv = CommandEnv Nothing Transactional pactDbEnv logger freeGasEnv def
          applyContinuation' cmdenv def contMsg [] (H.toUntypedHash (H.hash "" :: H.PactHash)) noSPVSupport

      ksData :: Text -> Value
      ksData idx =
          object [("k" <> idx) .= object [ "keys" .= ([] :: [Text]), "pred" .= String ">=" ]]

      unwrapState :: PactDbState -> IO Env'
      unwrapState dbs = toEnv' (_pdbsDbEnv dbs)

      wrapState :: Env' -> IO PactDbState
      wrapState dbe' = PactDbState <$> toEnvPersist' dbe'


  void $ saveInitial _cpeCheckpointer dbState00
    >>= assertEitherSuccess "saveInitial"

  ------------------------------------------------------------------
  -- s01 : new block workflow (restore -> discard), genesis
  ------------------------------------------------------------------

  -- hmm `restoreInitial` has implicit dependency on (BlockHeight 0), nullBlockHash

  let bh00 = BlockHeight 0
      hash00 = nullBlockHash

  s01 <- restoreInitial _cpeCheckpointer
    >>= assertEitherSuccess "restoreInitial (new block)"
    >>= unwrapState

  void $ runExec s01 (Just $ ksData "1") $ defModule "1"

  runExec s01 Nothing "(m1.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1]]

  void $ wrapState s01
    >>= discard _cpeCheckpointer
    >>= assertEitherSuccess "discard (initial) (new block)"


  ------------------------------------------------------------------
  -- s02 : validate block workflow (restore -> save), genesis
  ------------------------------------------------------------------

  s02 <- restoreInitial _cpeCheckpointer
    >>= assertEitherSuccess "restoreInitial (validate)"
    >>= unwrapState

  -- by defining m1/inserting anew, we ensure it didn't exist before
  -- otherwise would fail at least on table create

  void $ runExec s02 (Just $ ksData "1") $ defModule "1"

  runExec s02 Nothing "(m1.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1]]

  void $ wrapState s02
    >>= save _cpeCheckpointer bh00 hash00
    >>= assertEitherSuccess "save (validate)"


  ------------------------------------------------------------------
  -- s03 : new block 01
  ------------------------------------------------------------------

  s03 <- restore _cpeCheckpointer bh00 hash00
    >>= assertEitherSuccess "restore for new block 01"
    >>= unwrapState

  void $ runExec s03 Nothing "(m1.insertTbl 'b 2)"

  runExec s03 Nothing "(m1.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1,2]]

  -- start a pact
  -- test is that exec comes back with proper step
  let pactId = "DldRwCblQ7Loqy6wYJnaodHl30d3j3eH-qtFzfEv46g"
      pactCheckStep = preview (_Just . peStep) . _erExec

  runExec s03 Nothing "(m1.dopact 'pactA)"
    >>= ((Just 0 @=?) . pactCheckStep)


  void $ wrapState s03
    >>= discard _cpeCheckpointer
    >>= assertEitherSuccess "discard for block 01"
  -- ^^ note that this is the same discard as on s01 above, and yet ... it works
  -- (ie, doesn't blow away genesis??)


  ------------------------------------------------------------------
  -- s04 : validate block 01
  ------------------------------------------------------------------

  let bh01 = BlockHeight 01
  hash01 <- BlockHash <$> merkleLogHash "0000000000000000000000000000001a"

  s04 <- restore _cpeCheckpointer bh00 hash00
    >>= assertEitherSuccess "restore for validate block 01"
    >>= unwrapState

  -- insert here would fail if new block 01 had not been discarded
  void $ runExec s04 Nothing "(m1.insertTbl 'b 2)"

  runExec s04 Nothing "(m1.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1,2]]

  -- start a pact at txid 4, would fail if new block 01 had not been discarded
  runExec s04 Nothing "(m1.dopact 'pactA)"
    >>= ((Just 0 @=?) . pactCheckStep)

  void $ wrapState s04
    >>= save _cpeCheckpointer bh01 hash01
    >>= assertEitherSuccess "save block 01"


  ------------------------------------------------------------------
  -- s05: validate block 02
  -- create m2 module, exercise RefStore checkpoint
  -- exec next part of pact
  ------------------------------------------------------------------

  let bh02 = BlockHeight 02
  hash02 <- BlockHash <$> merkleLogHash "0000000000000000000000000000002a"

  s05 <- restore _cpeCheckpointer bh01 hash01
    >>= assertEitherSuccess "restore for validate block 02"
    >>= unwrapState

  void $ runExec s05 (Just $ ksData "2") $ defModule "2"

  runExec s05 Nothing "(m2.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1]]

  runCont s05 pactId 1
    >>= ((Just 1 @=?) . pactCheckStep)

  void $ wrapState s05
    >>= save _cpeCheckpointer bh02 hash02
    >>= assertEitherSuccess "save block 02"

  ------------------------------------------------------------------
  -- s06 : new block 03
  ------------------------------------------------------------------

  s06 <- restore _cpeCheckpointer bh02 hash02
    >>= assertEitherSuccess "restore for new block 03"
    >>= unwrapState

  void $ runExec s06 Nothing "(m2.insertTbl 'b 2)"

  runExec s06 Nothing "(m2.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1,2]]

  void $ wrapState s06
    >>= discard _cpeCheckpointer
    >>= assertEitherSuccess "discard for block 02"

  ------------------------------------------------------------------
  -- s07 : validate block 03
  ------------------------------------------------------------------

  let bh03 = BlockHeight 03
  hash03 <- BlockHash <$> merkleLogHash "0000000000000000000000000000003a"

  s07 <- restore _cpeCheckpointer bh02 hash02
    >>= assertEitherSuccess "restore for validate block 03"
    >>= unwrapState

  -- insert here would fail if new block 03 had not been discarded
  void $ runExec s07 Nothing "(m2.insertTbl 'b 2)"

  runExec s07 Nothing "(m2.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1,2]]

  void $ wrapState s07
    >>= save _cpeCheckpointer bh03 hash03
    >>= assertEitherSuccess "save block 01"


------------------------------------------------------------------
  -- s08: FORK! block 02, new hash
  -- recreate m2 module, exercise RefStore checkpoint
  -- exec next part of pact
  ------------------------------------------------------------------

  hash02Fork <- BlockHash <$> merkleLogHash "0000000000000000000000000000002b"

  s08 <- restore _cpeCheckpointer bh01 hash01
    >>= assertEitherSuccess "restore for validate block 02"
    >>= unwrapState

  void $ runExec s08 (Just $ ksData "2") $ defModule "2"

  runExec s08 Nothing "(m2.readTbl)"
    >>= \EvalResult{..} -> Right _erOutput @?= traverse toPactValue [tIntList [1]]

  -- this would fail if not a fork
  runCont s08 pactId 1
    >>= ((Just 1 @=?) . pactCheckStep)

  void $ wrapState s08
    >>= save _cpeCheckpointer bh02 hash02Fork
    >>= assertEitherSuccess "save block 02"

testKeyset :: Assertion
testKeyset =
  void $ withTempSQLiteConnection []  $ \sqlenv -> do
    let initBlockState = BlockState 0 Nothing (BlockVersion 0 0)
        loggers = pactTestLogger False
    msql <- newMVar (BlockEnv sqlenv initBlockState)
    runBlockEnv msql initSchema
    cpEnv <- initRelationalCheckpointerNew msql (newLogger loggers "RelationalCheckpointer") freeGasEnv
    keytestTest msql cpEnv

type Table = [[SType]]

runOnVersionTables ::
     (MonadReader SQLiteEnv m, MonadIO m)
  => (Table -> IO ())
  -> (Table -> IO ())
  -> (Table -> IO ())
  -> m ()
runOnVersionTables f g h = do
  blocktable <- callDb $ \db -> qry_ db "SELECT * FROM BlockHistory;" [RInt, RBlob]
  versionhistory <- callDb $ \db -> qry_ db "SELECT * FROM VersionHistory;" [RInt, RInt]
  vtables <-  callDb $ \db -> qry_ db "SELECT * FROM VersionedTables;" [RText]
  void $ liftIO $ f blocktable
  void $ liftIO $ g versionhistory
  liftIO $ h vtables

keytestTest :: MVar (BlockEnv SQLiteEnv) -> CheckpointEnvNew SQLiteEnv -> Assertion
keytestTest mvar CheckpointEnvNew {..} = do

  let hash00 = nullBlockHash
  menv00 <- restoreInitialNew _cpeCheckpointerNew Nothing
  _ <- liftIO $ assertEitherSuccess "initial restore failed" menv00
  runBlockEnv mvar $ runOnVersionTables
    (\blocktable -> assertEqual "block table initialized" blocktable bt00)
    (\versionhistory -> assertEqual "version history initialized" versionhistory vht00)
    (\vtables -> assertEqual "versioned tables table initialized" vtables vtt)

  addKeyset "k1" (KeySet [] (Name ">=" (Info Nothing))) mvar

  runBlockEnv mvar $ do
    keysetsTable <- callDb $ \db ->
        qry_ db ("SELECT * FROM " <> domainTableName KeySets) [RText, RInt, RInt, RInt, RBlob]
    liftIO $ assertEqual "keyset table" keysetsTable ks1

  -- next block (blockheight 1, version 0)

  let bh01 = BlockHeight 1
  hash01 <- BlockHash <$> liftIO (merkleLogHash "0000000000000000000000000000001a")
  menv01 <- restoreNew _cpeCheckpointerNew bh01 hash00 Nothing
  _ <- liftIO $ assertEitherSuccess "restore failed" menv01
  addKeyset "k2" (KeySet [] (Name ">=" (Info Nothing))) mvar

  runBlockEnv mvar $ do
    keysetsTable <- callDb $ \db ->
        qry_ db ("SELECT * FROM " <> domainTableName KeySets) [RText, RInt, RInt, RInt, RBlob]
    liftIO $ assertEqual "keyset table" keysetsTable ks2

  saveNew _cpeCheckpointerNew bh01 hash01 0 >>= assertEitherSuccess "save failed"

  runBlockEnv mvar $ runOnVersionTables
    (\blocktable -> assertEqual "block table " blocktable bt01)
    (\versionhistory -> assertEqual "version history " versionhistory vht01)
    (\vtables -> assertEqual "versioned tables table " vtables vtt)

  -- fork on blockheight = 1

  let bh11 = BlockHeight 1

  hash11 <- BlockHash <$> liftIO (merkleLogHash "0000000000000000000000000000001b")

  menv11 <- restoreNew _cpeCheckpointerNew bh11 hash00 Nothing
  _ <- liftIO $ assertEitherSuccess "restore failed" menv11

  addKeyset "k1" (KeySet [] (Name ">=" (Info Nothing))) mvar

  saveNew _cpeCheckpointerNew bh11 hash11 0 >>= assertEitherSuccess "save failed"

  runBlockEnv mvar $ runOnVersionTables
    (\blocktable -> assertEqual "block table " blocktable bt11)
    (\versionhistory -> assertEqual "version history " versionhistory vht11)
    (\vtables -> assertEqual "versioned tables table " vtables vtt)

  where
    bt00 =
      [[SInt 0,SBlob "\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL"]]
    vht00 = [[SInt 0,SInt 0]]
    vtt = [[SText "SYSKeySets"],[SText "SYSModules"],[SText "SYSNamespaces"],[SText "SYSPacts"]]
    ks1 = [[SText "k1",SInt 0,SInt 0,SInt 0,SBlob "{\"pred\":\">=\",\"keys\":[]}"]]
    ks2 = [[SText "k1",SInt 0,SInt 0,SInt 0,SBlob "{\"pred\":\">=\",\"keys\":[]}"],[SText "k2",SInt 1,SInt 0,SInt 0,SBlob "{\"pred\":\">=\",\"keys\":[]}"]]
    bt01 = [[SInt 0,SBlob "\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL"],[SInt 1,SBlob "0000000000000000000000000000001a"]]
    vht01 = [[SInt 0,SInt 0],[SInt 0,SInt 1]]
    bt11 = [[SInt 0,SBlob "\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL\NUL"],[SInt 1,SBlob "0000000000000000000000000000001b"]]
    vht11 = [[SInt 0,SInt 0],[SInt 0,SInt 1],[SInt 1,SInt 1]]

addKeyset :: KeySetName -> KeySet -> Method (BlockEnv SQLiteEnv) ()
addKeyset = _writeRow chainwebpactdb Insert KeySets
