Nonterminals map.

Terminals height.

Rootsymbol map.

map -> height     : to_map('$1').
map -> height map : insert(to_kv('$1'), '$2').

Erlang code.

to_map({height, Position, Value}) ->
	#{Position => Value}.

to_kv({height, Position, Value}) ->
	{Position, Value}.

insert({K, V}, M) ->
	maps:put(K, V, M).
