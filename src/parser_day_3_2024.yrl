Nonterminals instruction memory computer else.

Terminals mul int open_paren close_paren comma space newline skip do dont.

Rootsymbol computer.

instruction -> mul open_paren int comma int close_paren : {ok, operands, {extract_integer('$3'), extract_integer('$5')}}.
instruction -> mul open_paren int comma int             : incomplete.
instruction -> mul open_paren int comma                 : incomplete.
instruction -> mul open_paren int                       : incomplete.
instruction -> mul open_paren                           : incomplete.
instruction -> do                                       : {ok, enable}.
instruction -> dont                                     : {ok, disable}.
instruction -> else                                     : incomplete.

memory -> instruction             : remove_incomplete('$1').
memory -> instruction memory      : remove_incomplete_rec('$1', '$2').

computer -> memory           : ['$1'].
computer -> memory computer  : ['$1'|'$2'].

else -> mul.
else -> int.
else -> open_paren.
else -> close_paren.
else -> comma.
else -> space.
else -> newline.
else -> skip.

Erlang code.

extract_integer({_Token, _Line, Value}) -> Value.

remove_incomplete({ok, operands, {A, B}}) ->
	[{operands, {A, B}}];
remove_incomplete({ok, enable}) ->
	[enable];
remove_incomplete({ok, disable}) ->
	[disable];
remove_incomplete(incomplete) ->
	[].

remove_incomplete_rec({ok, operands, {A, B}}, Rest) ->
	[{operands, {A, B}} | Rest];
remove_incomplete_rec({ok, enable}, Rest) ->
	[enable | Rest];
remove_incomplete_rec({ok, disable}, Rest) ->
	[disable | Rest];
remove_incomplete_rec(incomplete, X) ->
	X.

