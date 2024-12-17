Nonterminals integer robot robots.

Terminals position velocity number.

Rootsymbol robots.

integer -> number : from_number('$1').

robot ->  position integer integer velocity integer integer : {{'$2', '$3'}, {'$5', '$6'}}.

robots -> robot        : ['$1'].
robots -> robot robots : ['$1'|'$2'].

Erlang code.

from_number({number, _Loc, X}) ->
	X.
