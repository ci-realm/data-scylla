{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.Build where

import Data.Aeson.TH

import Data.Time.LocalTime

import Scylla.Types.Utils
import Scylla.Types.Log (Log)
import Scylla.Types.BuildStatus (BuildStatus)

data Build = Build {
    id          :: Integer
  , status      :: BuildStatus
  , createdAt   :: ZonedTime
  , updatedAt   :: ZonedTime
  , statusAt    :: ZonedTime
  , finishedAt  :: ZonedTime
  , projectName :: String
  , log         :: Maybe [Log]
--  , Hook :: WatchEvent
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Build)
