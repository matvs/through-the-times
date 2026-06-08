module Functions.Civilization where 

import qualified Data.Map.Strict as M

import Data.Types
import Functions.Building
import Functions.Technology

createCivilization :: String -> Civilization 
createCivilization name = Civilization {name, buildings = [Mine, Mine, Mine, Temple], technologies = [], resources = M.empty }

production :: Civilization -> Resources
-- function composition 
production = M.unionsWith (+) . map produce . buildings
