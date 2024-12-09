Nonterminals map.

Terminals blank antenna.

Rootsymbol map.

map -> antenna      : to_map('$1').
map -> blank        : to_map('$1').
map -> antenna map  : insert(to_kv('$1'), '$2').
map -> blank map    : insert(to_kv('$1'), '$2').

Erlang code.

to_map({antenna, Position, Antenna}) ->
	#{Position => {antenna, Antenna}};
to_map({blank, Position}) ->
	#{Position => blank}.

to_kv({antenna, Position, Antenna}) ->
	{Position, {antenna, Antenna}};
to_kv({blank, Position}) ->
	{Position, blank}.

insert({K, V}, M) ->
	maps:put(K, V, M).
