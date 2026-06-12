module Functions.Resources where

import qualified Data.Map.Strict as M

import Data.Types

resource :: ResourceType -> Integer -> Resources
resource t n = Resources (M.singleton t n)

minus :: Resources -> Resources -> Resources
minus (Resources x) (Resources y) = Resources (M.unionWith (-) x y)

missing :: Resources -> Resources
missing (Resources x) = Resources (M.filter (<0) x)

exists :: Resources -> Bool
exists (Resources x) = not . M.null $ x

canAfford :: Resources -> Resources -> Bool
canAfford available = exists . missing . minus available