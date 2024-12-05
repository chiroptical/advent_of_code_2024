Nonterminals integer instructions rules updates.

Terminals number pipe comma newline.

Rootsymbol instructions.

integer -> number : value('$1').

instructions -> rules newline updates : {'$1', '$3'}.

rules -> integer pipe integer newline       : [{'$1', '$3'}].
rules -> integer pipe integer newline rules : [{'$1', '$3'} | '$5'].

updates -> integer comma           : ['$1'].
updates -> integer newline         : ['$1'].
updates -> integer comma updates   : ['$1' | '$3'].
updates -> integer newline updates : ['$1' | '$3'].

Erlang code.

value({number, _Loc, Value}) -> 
	Value.
