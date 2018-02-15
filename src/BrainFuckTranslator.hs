module BrainFuckTranslator where

import BrainFuckCommon
import BrainFuckParser

translatingFunction :: Stmt -> (Context -> Maybe Context)
translatingFunction Add =
  \(idx, ar) ->
    Just (idx, take idx ar ++ [(ar !! idx) + 1] ++ drop (idx + 1) ar)
translatingFunction Sub =
  \(idx, ar) ->
    Just (idx, take idx ar ++ [(ar !! idx) - 1] ++ drop (idx + 1) ar)
translatingFunction Inc = \(idx, ar) -> Just (idx + 1, ar)
translatingFunction Dec =
  \(idx, ar) ->
    if idx - 1 >= 0
      then Just (idx - 1, ar)
      else Nothing


translatingFunction Inp = \(idx, ar) -> Just (idx, ar)
translatingFunction Out = \(idx, ar) -> Just (idx, ar)
translatingFunction (Seq stmtSeq) =
  \(idx, ar) ->
    if (ar !! idx) == 0
      then Just (idx, ar)
      else (bindToList (Just (idx, ar)) $ translate (Seq stmtSeq)) >>=
           translatingFunction (Seq stmtSeq)

translate :: Stmt -> [(Context -> Maybe Context)]
translate (Seq arr) = map translatingFunction arr


translateSequence :: Stmt -> [Context -> Maybe Context ]
translateSequence stmtSeq = translate stmtSeq