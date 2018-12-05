{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

-- |
-- Module: P2P.Node.RestAPI.Server
-- Copyright: Copyright © 2018 Kadena LLC.
-- License: MIT
-- Maintainer: Lars Kuhtz <lars@kadena.io>
-- Stability: experimental
--
-- TODO
--
module P2P.Node.RestAPI.Server
(
-- * Handlers
  peerGetHandler
, peerPutHandler

-- * P2P Server
, p2pServer

-- * Application for a single P2P Network
, chainP2pApp
, chainP2pApiLayout

-- * Some P2P Server for Multiple Chains
, someP2pServer
, someP2pServers

-- * Run server
, serveP2pOnPort
) where

import Control.Monad.IO.Class

import Data.Foldable
import Data.Proxy
import qualified Data.Text.IO as T

import Network.Wai.Handler.Warp hiding (Port)

import Servant.API
import Servant.Server

import qualified Streaming.Prelude as SP

-- internal modules

import Chainweb.ChainId
import Chainweb.HostAddress
import Chainweb.RestAPI.NetworkID
import Chainweb.RestAPI.Utils
import Chainweb.Utils
import Chainweb.TreeDB (Limit, NextItem)
import Chainweb.Version

import Data.Singletons

import P2P.Node.Configuration
import P2P.Node.PeerDB
import P2P.Node.RestAPI

-- -------------------------------------------------------------------------- --
-- Handlers

peerGetHandler
    :: PeerDb
    -> Maybe Limit
    -> Maybe (NextItem PeerId)
    -> Handler (Page (NextItem PeerId) PeerInfo)
peerGetHandler db limit next = do
    sn <- liftIO $ peerDbSnapshot db
    seekLimitedStreamToPage _peerId next limit
        . SP.each
        $ toList sn

peerPutHandler
    :: PeerDb
    -> PeerInfo
    -> Handler NoContent
peerPutHandler db e = liftIO $ NoContent <$ peerDbInsert db e

-- -------------------------------------------------------------------------- --
-- P2P API Server

p2pServer
    :: forall (v :: ChainwebVersionT) (n :: NetworkIdT)
    . SingI n
    => PeerDbT v n
    -> Server (P2pApi v n)
p2pServer (PeerDbT db) = case sing @_ @n of
    SCutNetwork -> peerGetHandler db :<|> peerPutHandler db
    SChainNetwork _ -> peerGetHandler db :<|> peerPutHandler db

-- -------------------------------------------------------------------------- --
-- Application for a single P2P Network

chainP2pApp
    :: forall v n
    . KnownChainwebVersionSymbol v
    => SingI n
    => PeerDbT v n
    -> Application
chainP2pApp db = case sing @_ @n of
    SCutNetwork -> serve (Proxy @(P2pApi v n)) (p2pServer db)
    SChainNetwork SChainId -> serve (Proxy @(P2pApi v n)) (p2pServer db)

chainP2pApiLayout
    :: forall v n
    . KnownChainwebVersionSymbol v
    => SingI n
    => PeerDbT v n
    -> IO ()
chainP2pApiLayout _ = case sing @_ @n of
    SCutNetwork -> T.putStrLn $ layout (Proxy @(P2pApi v n))
    SChainNetwork SChainId -> T.putStrLn $ layout (Proxy @(P2pApi v n))

-- -------------------------------------------------------------------------- --
-- Multichain Server

someP2pServer :: SomePeerDb -> SomeServer
someP2pServer (SomePeerDb (db :: PeerDbT v n)) = case sing @_ @n of
    SCutNetwork -> SomeServer (Proxy @(P2pApi v n)) (p2pServer db)
    SChainNetwork SChainId -> SomeServer (Proxy @(P2pApi v n)) (p2pServer db)

someP2pServers :: ChainwebVersion -> [(NetworkId, PeerDb)] -> SomeServer
someP2pServers v = mconcat
    . fmap (someP2pServer . uncurry (somePeerDbVal v))

-- -------------------------------------------------------------------------- --
-- Run Server

serveP2pOnPort
    :: Port
    -> ChainwebVersion
    -> [(NetworkId, PeerDb)]
    -> IO ()
serveP2pOnPort p v = run (int p) . someServerApplication . someP2pServers v

