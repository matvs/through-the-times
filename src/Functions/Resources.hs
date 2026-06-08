module Functions.Resources where

import qualified Data.Map.Strict as M

import Data.Types

createResources :: ResourceType -> Integer -> Resources
createResources = M.singleton