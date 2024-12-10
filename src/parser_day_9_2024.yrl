Nonterminals value disk_map file free_space.

Terminals number.

Rootsymbol disk_map.

value -> number : to_value('$1').

file -> value : to_file('$1').

free_space -> value : to_free_space('$1').

disk_map -> file                     : ['$1'].
disk_map -> file free_space disk_map : ['$1', '$2' | '$3'].

Erlang code.

to_value({number, _Col, Value}) ->
	Value.

to_file(X) ->
	{file, X}.

to_free_space(X) ->
	{free_space, X}.
