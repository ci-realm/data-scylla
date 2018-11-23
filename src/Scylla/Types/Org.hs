{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.Org where

import Data.Aeson.TH

import Scylla.Types.Utils

data Org = Org {
    owner      :: String
  , url        :: String
  , buildCount :: Integer
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Org)
