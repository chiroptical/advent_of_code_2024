Nonterminals map.

Terminals plant.

Rootsymbol map.

map -> plant     : [to_prop('$1')].
map -> plant map : [to_prop('$1')|'$2'].

Erlang code.

to_prop({plant, Position, Label}) ->
	{Position, Label}.
