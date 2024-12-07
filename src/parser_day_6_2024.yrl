Nonterminals map.

Terminals guard obstacle blank.

Rootsymbol map.

map -> guard        : to_map('$1').
map -> obstacle     : to_map('$1').
map -> blank        : to_map('$1').
map -> guard map    : insert(to_kv('$1'), '$2').
map -> obstacle map : insert(to_kv('$1'), '$2').
map -> blank map    : insert(to_kv('$1'), '$2').

Erlang code.

to_map({guard, Position, Direction}) ->
	#{Position => {guard, Direction}};
to_map({Atom, Position}) ->
	#{Position => Atom}.

to_kv({guard, Position, Direction}) ->
	{Position, {guard, Direction}};
to_kv({Atom, Position}) ->
	{Position, Atom}.

insert({K, V}, M) ->
	maps:put(K, V, M).
