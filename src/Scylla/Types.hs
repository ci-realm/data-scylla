{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types (
    ScyllaState(..)
  , updateState
  , B.Build(..)
  , O.Org(..)
  )
  where

import Data.Default

import qualified Scylla.Types.API      as A
import qualified Scylla.Types.Build    as B
import qualified Scylla.Types.Org      as O
--import qualified Scylla.Types.Log      as L
import qualified Scylla.Types.ShortLog as S

data ScyllaState = ScyllaState {
    connected :: Bool
  , reconnects :: Integer
  , reconnectError :: Bool
  , message :: String
  , errorMessage :: String
  , lastBuilds :: [B.Build]
  , organizations :: [O.Org]
  , organizationBuilds :: [B.Build]
  , build :: Maybe B.Build
  , buildLines :: [S.ShortLog]
  } deriving (Show, Eq, Ord)

instance Default ScyllaState where
  def = ScyllaState {
      connected = False
    , reconnects = 0
    , reconnectError = False
    , message = ""
    , errorMessage = ""
    , lastBuilds = []
    , organizations = []
    , organizationBuilds = []
    , build = Nothing
    , buildLines = []
    }

updateState :: A.Response -> ScyllaState -> ScyllaState
updateState (A.RBuild b)      = \x -> x { build = Just b }
updateState (A.RBuilds bs)    = \x -> x { lastBuilds = bs }
updateState (A.ROrgs os)      = \x -> x { organizations = os }
updateState (A.ROrgBuilds bs) = \x -> x { organizationBuilds = bs }
updateState (A.RBuildLog bl)  = \x -> x { buildLines = (buildLines x) ++ [bl] }
updateState (A.RRestart)      = id
