module Functions.Building where

import qualified Data.Set as S
import qualified Data.Map.Strict as M
import Data.Types
import Functions.Resources

produce :: Building -> Resources
produce Mine = createResources Ore 1
produce Lab = createResources Science 1
produce Temple = createResources Culture 1


cost :: Building -> Resources
cost Mine = createResources Ore 2
cost Lab = createResources Ore 3
cost Temple = createResources Ore 3

bonus :: Building -> Resources
bonus Temple = createResources Happiness 5
bonus _ = M.empty

requires :: Building -> S.Set Technology
requires Mine = S.empty
requires Lab = S.empty
requires Temple = S.empty
