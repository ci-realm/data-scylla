module Scylla.Types.Utils where

import Data.Char
import Data.Aeson.TH

import Data.Time.LocalTime

camelCase :: String -> String
camelCase (x:xs) = (toLower x):xs
camelCase [] = ""

paramsToData :: String -> String
paramsToData "params" = "data"
paramsToData x = x

scyllaOptions :: Options
scyllaOptions = defaultOptions {
    fieldLabelModifier = paramsToData
  , constructorTagModifier = camelCase
  , omitNothingFields = True }

instance Eq ZonedTime where
  ZonedTime t1 tz1 == ZonedTime t2 tz2 = t1 == t2 && tz1 == tz2

instance Ord ZonedTime where
    compare a b = compare (f a) (f b)
        where f t = (zonedTimeToUTC t, zonedTimeZone t)
