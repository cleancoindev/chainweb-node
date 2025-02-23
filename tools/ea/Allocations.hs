{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
-- |
-- Module: Allocations
-- Copyright: Copyright © 2018 - 2020 Kadena LLC.
-- License: MIT
-- Maintainer: Colin Woodbury <colin@kadena.io>, Emily Pillmore <emily@kadena.io>
-- Stability: experimental
--
-- Generate allocations payloads
--
module Allocations
( -- * Allocation generation
  generateAllocations

  -- * Allocation data
, AllocationEntry(..)
, AllocationTx(..)
, mkAllocationTx

, AllocationKeys(..)
, AllocationKeyTx(..)
, mkAllocationKeyTx

, readAllocations
, readMainnetKeys
, readTestnetKeys

, rawAllocations
, rawMainnetKeys
, rawTestnetKeys
) where


import GHC.Generics

import Data.ByteString (ByteString)
import qualified Data.Csv as CSV
import Data.FileEmbed (embedFile)
import qualified Data.Map.Strict as M
import Data.String.Conv (toS)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Vector (Vector)
import qualified Data.Vector as V

import Chainweb.Utils

-- -------------------------------------------------------------------- --
-- Tx gen

generateAllocations :: IO ()
generateAllocations
    = allocations
    >> mainKeysets
    >> testKeysets
  where
    mainKeysets = T.writeFile (prefix $ "mainnet_keysets") $
      keysToYaml "mainnet-keysets" readMainnetKeys

    testKeysets = T.writeFile (prefix $ "testnet_keysets") $
      keysToYaml "testnet-keysets" readTestnetKeys

    allocations = flip M.traverseWithKey readAllocations $ \cid txs -> do
      let ys = allocToYaml cid txs
      T.writeFile (prefix $ "mainnet_allocations" <> T.unpack cid) ys

    prefix t = "pact/genesis/mainnet/" <> t <> ".yaml"

genTxs
    :: forall a b
    . CSV.FromRecord a
    => (a -> b)
    -> ByteString
    -> Vector b
genTxs f bs = case CSV.decode CSV.HasHeader (toS bs) of
    Left e -> error
      $ "cannot construct genesis allocations: "
      <> sshow e
    Right as -> fmap f as


keysToYaml :: Text -> Vector AllocationKeyTx -> Text
keysToYaml nonce ks = T.concat
    [ "code: |-\n"
    , go f ks
    , "\ndata:\n"
    , go g ks
    , "\nnonce: " <> nonce
    , "\nkeyPairs: []\n"
    ]
  where
    go k = V.foldl1' (<>) . V.map k
    wrap tx = "  " <> tx <> "\n"
    f = wrap . _allocationKeyTx
    g = wrap . _allocationKeyData

allocToYaml :: Text -> Vector AllocationTx -> Text
allocToYaml cid as = T.concat
    [ "code: |-\n"
    , go f as
    , "\nnonce: " <> "mainnet-genesis-allocations" <> cid
    , "\nkeyPairs: []\n"
    ]
  where
    go k = V.foldl1' (<>) . V.map k
    wrap tx = "  " <> tx <> "\n"
    f = wrap . _allocationTx


readAllocations :: M.Map Text (Vector AllocationTx)
readAllocations = txMap
  where
    txMap = V.foldl' go mempty $ genTxs mkAllocationTx rawAllocations
    go m a =
      let
        cid = _allocationTxChain a
      in case M.lookup cid m of
        Just v -> M.insert cid (V.cons a v) m
        Nothing -> M.insert cid (V.singleton a) m

readMainnetKeys :: Vector AllocationKeyTx
readMainnetKeys = genTxs mkAllocationKeyTx rawMainnetKeys

readTestnetKeys :: Vector AllocationKeyTx
readTestnetKeys = genTxs mkAllocationKeyTx rawTestnetKeys

-- -------------------------------------------------------------------- --
-- Allocation/Key/Coinbase data

data AllocationKeys = AllocationKeys
    { _allocKeysName :: Text
    , _allocKeysPred :: Text
    , _allocKey1 :: Text
    , _allocKey2 :: Text
    , _allocKey3 :: Text
    } deriving (Eq, Ord, Show, Generic)

instance CSV.FromRecord AllocationKeys

data AllocationKeyTx = AllocationKeyTx
    { _allocationKeyTx :: Text
    , _allocationKeyData :: Text
    } deriving (Eq, Show)

mkAllocationKeyTx :: AllocationKeys -> AllocationKeyTx
mkAllocationKeyTx (AllocationKeys n p k1 k2 k3) = AllocationKeyTx tx d
  where
    tx = T.concat
      [ "(define-keyset "
      , "\"" <> T.strip n <> "\" "
      , "(read-keyset "
      , "\"" <> T.strip n <> "\")"
      , ")"
      ]

    d = T.concat
      [ "\"" <> T.strip n <> "\": { "
      , "keys: " <> ks <> ", "
      , "pred: \"" <> T.strip p <> "\""
      , " }"
      ]

    ks = T.strip . sshow $ fmap T.strip [k1,k2,k3]

data AllocationEntry = AllocationEntry
    { _allocationName :: !Text
    , _allocationTime :: !Text
    , _allocationKeysetName :: !Text
    , _allocationAmount :: !CsvDecimal
    , _allocationChain :: !Text
    } deriving (Eq, Ord, Show, Generic)

instance CSV.FromRecord AllocationEntry

data AllocationTx = AllocationTx
    { _allocationTx :: Text
    , _allocationTxChain :: Text
    } deriving (Eq, Show)

mkAllocationTx :: AllocationEntry -> AllocationTx
mkAllocationTx (AllocationEntry n t ksn a c) = AllocationTx tx c
  where
    tx = T.concat
      [ "(coin.create-allocation-account "
      , "\"" <> T.strip n <> "\" "
      , "(time \"" <> T.strip t <> "\") "
      , "\"" <> T.strip ksn <> "\" "
      , T.pack (show a)
      , ")"
      ]

-- -------------------------------------------------------------------- --
-- Raw file bytes

rawAllocations :: ByteString
rawAllocations = $(embedFile "allocations/token_payments.csv")

rawMainnetKeys :: ByteString
rawMainnetKeys = $(embedFile "allocations/Mainnet-Keysets.csv")

rawTestnetKeys :: ByteString
rawTestnetKeys = $(embedFile "allocations/Testnet-Keysets.csv")
