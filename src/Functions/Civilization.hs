module Functions.Civilization where

import Data.Set qualified as S
import Data.Map.Strict qualified as M
import Data.Types
import Functions.Building
import Functions.Resources

createCivilization :: String -> Civilization
createCivilization name =
  Civilization
    { name,
      buildings = [Mine, Mine, Mine, Temple],
      technologies = S.empty,
      resources = createResources PopBank 10 <> createResources Worker 2,
      government = Despot,
      leader = Nothing,
      cards = []
    }

production :: Civilization -> Resources
production = M.unionsWith (+) . map produce . buildings

spend :: Civilization -> Building -> Maybe Civilization
spend c b = 
  let after = M.unionWith (-) (resources c) (cost b) in
  if null . M.filter (<0) $ after then
    Just c {resources = after, buildings = b:buildings c}
  else 
    Nothing