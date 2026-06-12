module Functions.Civilization where

import Data.Set qualified as S
import Data.Map.Strict qualified as M
import Data.Types
import Functions.Building
import Functions.Resources

civilization :: Civilization
civilization =
  Civilization
    { 
      buildings = [Mine, Mine, Mine],
      technologies = S.empty,
      resources = resource PopBank 10 <> resource Worker 2,
      government = Despot,
      leader = Nothing,
      cards = []
    }
