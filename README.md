# BrainFuckParser


This is a simulator of the BrainFuck Language. The purpose of this project was to test what i learnt about Haskell.

### Requirements

`stack` should be sufficient to handle everything you need.

### Explanation

At the moment the code in condensed in the single file `src/BrainFuckParser.hs`. The idea is to split this file in modules.

The code is functionally divided in three section: the parser, the translator, and the simulator. The idea is the following:

1. **Parse** the BrainFuck source. I used this [tutorial](https://wiki.haskell.org/Parsing_a_simple_imperative_language) to create the parser. This step 
produces a list of statements
2. Every statement of the list is **translated** into a function with the following signature: `(Context -> Maybe Context)`. Some optimization may be 
implemented in the future.
3. **Simulate** the execution of the BrainFuck code by simply applying the functions in a monadic style. The functions are applied to the cited Context. The 
Context is defined with `type Context = (Int, [W8.Word8])`: the first element of the tuple is the pointer of the current element of the list (the 
second element of the tuple).

At the moment the Context is limited by a list of 10 elements initialized to zero. The idea is to lazily instanciate the list: just instanciate cells only if 
they're needed.
