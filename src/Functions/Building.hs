module Functions.Building where

import qualified Data.Set as S
import qualified Data.Map.Strict as M
import Data.Types
import Functions.Resources




buildingDef :: Building -> BuildingDef
buildingDef Mine = BuildingDef {
    cost = resource Ore 5,
    produces = resource Ore 1,
    bonus = mempty,
    requires = mempty
}