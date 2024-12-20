Nonterminals map.

Terminals start stop track wall.

Rootsymbol map.

map -> start : to_map('$1').
map -> stop  : to_map('$1').
map -> track : to_map('$1').
map -> wall  : to_map('$1').
map -> start map : insert(to_kv('$1'), '$2').
map -> stop map : insert(to_kv('$1'), '$2').
map -> track map : insert(to_kv('$1'), '$2').
map -> wall map : insert(to_kv('$1'), '$2').

Erlang code.

to_map({track, Position, Atom}) ->
	#{Position => Atom}.

to_kv({track, Position, Atom}) ->
	{Position, Atom}.

insert({K, V}, M) ->
	maps:put(K, V, M).
