module Functions.Building where

import qualified Data.Map.Strict as M
import Data.Types
import Functions.Resources

produce :: Building -> Resources
produce Mine = createResources Ore 1
produce Lab = createResources Science 1
produce Temple = createResources Culture 1
produce _ = M.empty

bonus :: Building -> Resources
bonus Temple = createResources Happiness 5
bonus _ = M.empty
