Nonterminals colors patterns designs input.

Terminals color comma newline.

Rootsymbol input.

colors -> color        : [from('$1')].
colors -> color colors : [from('$1') | '$2'].

patterns -> colors newline        : ['$1'].
patterns -> colors comma patterns : ['$1' | '$3'].

designs -> colors newline         : ['$1'].
designs -> colors newline designs : ['$1' | '$3']. 

input -> patterns newline designs : {'$1', '$3'}.

Erlang code.

from({color, _Loc, X}) -> X.
