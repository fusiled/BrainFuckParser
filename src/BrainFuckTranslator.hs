module BrainFuckTranslator
(translate
) where

import BrainFuckCommon
import BrainFuckParser


replaceNth :: Int -> a -> [a] -> [a]
replaceNth n newElement xs= take n xs ++ [newElement] ++ drop (n + 1) xs

translatingFunction :: Stmt -> (Context -> Maybe Context)
translatingFunction Add =
  \ctx  ->
    let oldIdx = index ctx
        oldTape = tape ctx
        newVal = ((tape ctx)!!oldIdx )+1
        newTape =replaceNth oldIdx newVal oldTape
    in  Just Context {index=oldIdx, tape=newTape, inputString=inputString ctx, outputString=outputString ctx  }


translatingFunction Sub =
  \ctx  ->
    let oldIdx = index ctx
        oldTape = tape ctx
        newVal = ((tape ctx)!!oldIdx )-1
        newTape =replaceNth oldIdx newVal oldTape
    in  Just Context {index=oldIdx, tape=newTape, inputString=inputString ctx, outputString=outputString ctx  }

translatingFunction Inc = \ctx -> Just Context{
                                          index=(index ctx)+ 1,
                                          tape=tape ctx,
                                          inputString=inputString ctx,
                                          outputString=outputString ctx
                                        }
translatingFunction Dec =
  \ctx ->
    if (index ctx) - 1 >= 0 then 
        Just Context{
                index=(index ctx) - 1,
                tape=tape ctx,
                inputString=inputString ctx,
                outputString=outputString ctx
              }
    else 
      Nothing

translatingFunction Inp = \ctx -> 
    if (length $ inputString ctx)==0 then
      Nothing
    else
      let
        newByte = toEnum (fromEnum $ head $ inputString ctx)::Byte
      in
        Just Context {
          index=index ctx,
          tape = replaceNth (index ctx) newByte (tape ctx),
          inputString=tail $ inputString ctx,
          outputString=outputString ctx 
        }


translatingFunction Out = \ctx -> 
      let
        selectedByte = toEnum (fromEnum $ (tape ctx)!! (index ctx))::Char
      in
        Just Context {
          index=index ctx,
          tape = tape ctx,
          inputString=inputString ctx,
          outputString=(outputString ctx)++[selectedByte] 
        }

translatingFunction (Seq stmtSeq) =
  \ctx ->
  let 
    idx= index ctx
    ar = tape ctx
  in
    if (ar !! idx) == 0
      then Just ctx
      else (bindToList (Just ctx) $ translate (Seq stmtSeq)) >>=
           translatingFunction (Seq stmtSeq)

translate :: Stmt -> [(Context -> Maybe Context)]
translate (Seq arr) = map translatingFunction arr


translateSequence :: Stmt -> [Context -> Maybe Context ]
translateSequence stmtSeq = translate stmtSeq