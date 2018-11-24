{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.BuildStatus where

import Data.Aeson.TH

import Scylla.Types.Utils

data BuildStatus = Success | Failure | Build | Queue | Clone | Checkout
  deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''BuildStatus)
