{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.Build where

import Data.Aeson.TH

import Data.Time.LocalTime

import Scylla.Types.Utils

data Project = Project {
    id         :: Integer
  , createdAt  :: ZonedTime
  , updatedAt  :: ZonedTime
  , name       :: String
  , buildCount :: Integer
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Project)
