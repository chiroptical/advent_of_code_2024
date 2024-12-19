Nonterminals integer position memory.

Terminals number.

Rootsymbol memory.

integer -> number : from('$1').

position -> integer integer : {'$1', '$2'}.

memory -> position        : to_map('$1').
memory -> position memory : insert(to_kv('$1'), '$2').

Erlang code.

from({number, _Loc, X}) -> X.

to_map(Position) ->
	#{Position => corrupt}.

to_kv(Position) ->
	{Position, corrupt}.

insert({K, V}, M) ->
	maps:put(K, V, M).
