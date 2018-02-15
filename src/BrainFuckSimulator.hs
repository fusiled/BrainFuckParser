module BrainFuckSimulator where

import BrainFuckCommon
import BrainFuckTranslator

simulate :: [(Context -> Maybe Context)] -> Maybe Context
simulate ar = bindToList (return $ emptyContext ) ar