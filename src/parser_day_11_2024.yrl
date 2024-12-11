Nonterminals stones.

Terminals stone.

Rootsymbol stones.

stones -> stone        : [to_value('$1')].
stones -> stone stones : [to_value('$1')|'$2'].

Erlang code.

to_value({stone, _Position, Value}) ->
	Value.
