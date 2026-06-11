module Functions.Resources where

import qualified Data.Map.Strict as M

import Data.Types

createResources :: ResourceType -> Integer -> Resources
createResources = M.singleton

createMultipleResources :: [(ResourceType, Integer)] -> Resources
createMultipleResources x = M.unionsWith (+) (map (uncurry createResources) x)

civil :: Resources
civil = M.singleton CivilActionToken 1

ar :: Resources -> Resources -> Resources
ar = M.unionWith (+) 