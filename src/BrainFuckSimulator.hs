module BrainFuckSimulator
( simulate
) where

import BrainFuckCommon
import BrainFuckTranslator

simulate :: String -> [(Context -> Maybe Context)] -> Maybe Context
simulate inputStr ar = bindToList (return $ getContext inputStr ) ar