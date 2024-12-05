Nonterminals integer integer_and_loc instructions rules update updates.

Terminals number pipe comma newline.

Rootsymbol instructions.

integer -> number : value('$1').

integer_and_loc -> number : value_and_loc('$1'). 

instructions -> rules newline updates : {'$1', '$3'}.

rules -> integer pipe integer newline       : [{'$1', '$3'}].
rules -> integer pipe integer newline rules : [{'$1', '$3'} | '$5'].

update -> integer_and_loc comma        : ['$1'].
update -> integer_and_loc              : ['$1'].
update -> integer_and_loc comma update : ['$1' | '$3'].

updates -> update newline         : ['$1'].
updates -> update newline updates : ['$1' | '$3'].

Erlang code.

value({number, _Loc, Value}) -> 
	Value.

value_and_loc({number, {_Row, Col}, Value}) -> 
	{Value, Col}.
