Nonterminals integer instructions rules update updates.

Terminals number pipe comma newline.

Rootsymbol instructions.

integer -> number : value('$1').

instructions -> rules newline updates : {'$1', '$3'}.

rules -> integer pipe integer newline       : [{'$1', '$3'}].
rules -> integer pipe integer newline rules : [{'$1', '$3'} | '$5'].

update -> integer comma        : ['$1'].
update -> integer              : ['$1'].
update -> integer comma update : ['$1' | '$3'].

updates -> update newline         : ['$1'].
updates -> update newline updates : ['$1' | '$3'].

Erlang code.

value({number, _Loc, Value}) -> 
	Value.
