Nonterminals track.

Terminals position.

Rootsymbol track.

track -> position       : to_map('$1').
track -> position track : insert(to_kv('$1'), '$2').

Erlang code.

to_map({position, Position, Str}) ->
	#{Position => from(Str)}.

to_kv({position, Position, Str}) ->
	{Position, from(Str)}.

insert({K, V}, M) ->
	maps:put(K, V, M).

from("S") -> start;
from("E") -> stop;
from(".") -> track;
from("#") -> wall.
