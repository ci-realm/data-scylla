{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Scylla.Types.API (
    Response(..)
  , Query(..)
  , queryLastBuilds
  , queryBuild
  , queryRestart
  , queryOrganizations
  , queryOrganizationBuilds
  )
  where

import qualified Data.Map as M

import Data.Aeson
import Data.Aeson.TH

import Scylla.Types.Utils
import qualified Scylla.Types.Build as B
import qualified Scylla.Types.Org as O
import qualified Scylla.Types.ShortLog as S

data Kind =
    LastBuilds
  | Organizations
  | OrganizationBuilds
  | Build
  | BuildLogWatch
  | BuildLogUnwatch
  | Restart
  deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Kind)

data Query = Query {
    kind :: Kind
  , params :: Maybe (M.Map String String)
  } deriving (Show, Eq, Ord)

$(deriveJSON scyllaOptions ''Query)

queryLastBuilds :: Query
queryLastBuilds = Query LastBuilds Nothing

queryBuild :: Integer -> Query
queryBuild bId = Query Build $ Just $ M.fromList [("id", show bId)]

queryRestart :: Integer -> Query
queryRestart bId = Query Restart $ Just $ M.fromList [("id", show bId)]

queryOrganizations :: Query
queryOrganizations = Query Organizations Nothing

queryOrganizationBuilds :: String -> Query
queryOrganizationBuilds orgName = Query OrganizationBuilds $ Just $ M.fromList [("orgName", orgName)]

data Response =
    RBuild B.Build
  | RBuilds [B.Build]
  | RBuildLog S.ShortLog
  | ROrgs [O.Org]
  | ROrgBuilds [B.Build]
  | RRestart
  deriving (Show)

instance FromJSON Response where
  parseJSON = withObject "resp" $ \o -> do
    mutation <- o .: "mutation"
    respData <- o .: "data"

    case mutation of
      "lastBuilds" -> do
        bs <- respData .: "builds"
        RBuilds <$> parseJSON bs

      "build" -> do
        b <- respData .: "build"
        RBuild <$> parseJSON b

      "buildLog" -> do
        bl <- respData .: "buildLog"
        RBuildLog <$> parseJSON bl

      "organizations" -> do
        os <- respData .: "organizations"
        ROrgs <$> parseJSON os

      "organizationBuilds" -> do
        ob <- respData .: "organizationBuilds"
        ROrgBuilds <$> parseJSON ob

      "restart" -> do
        return $ RRestart

      _            -> fail $ "Unknown mutation: " ++ mutation
