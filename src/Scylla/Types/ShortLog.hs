{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.ShortLog where

import Data.Aeson.TH

import Data.Time.LocalTime

import Scylla.Types.Utils

data ShortLog = ShortLog {
    time :: ZonedTime
  , line :: String
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''ShortLog)
