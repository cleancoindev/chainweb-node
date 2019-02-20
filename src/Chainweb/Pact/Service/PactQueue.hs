-- |
-- Module: Chainweb.Pact.Service.PactQueue
-- Copyright: Copyright © 2018 Kadena LLC.
-- License: See LICENSE file
-- Maintainer: Mark Nichols <mark@kadena.io>
-- Stability: experimental
--
-- Pact execution service queue for Chainweb

module Chainweb.Pact.Service.PactQueue
    ( addRequest
    , addResponse
    , getNextRequest
    , getNextResponse
    , RequestId(..)
    , RequestMsg(..)
    , RequestType(..)
    , ResponseMsg(..)
    ) where

import Control.Concurrent.STM.TQueue
import Control.Concurrent.STM.TVar
import Control.Monad.STM

import System.Time.Extra

import Chainweb.Pact.Service.Types

-- | Add a request to the Pact execution queue
addRequest :: IO (TVar (TQueue RequestMsg)) -> RequestMsg -> IO ()
addRequest reqQVar msg = do
    var <- reqQVar
    q <- readTVarIO var
    atomically $ writeTQueue q msg
    return ()

-- | Get the next available request from the Pact execution queue
getNextRequest :: IO (TVar (TQueue RequestMsg)) -> IO RequestMsg
getNextRequest reqQVar = do
    var <- reqQVar
    q <- readTVarIO var
    mayM <- timeout 5.0 (tryRead q)
    case mayM of
        Just m -> return m
        Nothing -> error "No! (tryRead timeout)"
      where
        tryRead :: TQueue RequestMsg -> IO RequestMsg
        tryRead ku = do
            maybeMsg <- atomically $ tryReadTQueue ku
            case maybeMsg of
              Just msg -> return msg
              Nothing -> tryRead ku

-- | Add a response to the Pact execution response queue
addResponse :: IO (TVar (TQueue ResponseMsg)) -> ResponseMsg -> IO ()
addResponse respQVar msg = do
    var <- respQVar
    q <- readTVarIO var
    atomically $ writeTQueue q msg
    return ()

-- | Get the next available response from the Pact execution response queue
getNextResponse :: IO (TVar (TQueue ResponseMsg)) -> IO ResponseMsg
getNextResponse respQVar = do
    var <- respQVar
    q <- readTVarIO var
    atomically $ readTQueue q
