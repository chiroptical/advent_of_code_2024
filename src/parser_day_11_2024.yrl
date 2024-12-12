Nonterminals stones.

Terminals stone.

Rootsymbol stones.

stones -> stone        : to_map('$1').
stones -> stone stones : insert(to_kv('$1'), '$2').

Erlang code.

to_map({stone, _Pos, N}) ->
	#{N => 1}.

to_kv({stone, _Pos, N}) ->
	{N, 1}.

insert({K, V}, M) ->
	maps:put(K, V, M).
