{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.Log where

import Data.Aeson.TH

import Data.Time.LocalTime

import Scylla.Types.Utils

data Log = Log {
    id        :: Integer
  , buildId   :: Integer
  , createdAt :: ZonedTime
  , line      :: String
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Log)
