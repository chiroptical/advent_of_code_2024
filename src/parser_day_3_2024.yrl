Nonterminals instruction memory computer else.

Terminals mul int open_paren close_paren comma space newline skip.

Rootsymbol computer.

instruction -> mul open_paren int comma int close_paren : {ok, extract_integer('$3'), extract_integer('$5')}.
instruction -> mul open_paren int comma int             : incomplete.
instruction -> mul open_paren int comma                 : incomplete.
instruction -> mul open_paren int                       : incomplete.
instruction -> mul open_paren                           : incomplete.
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

remove_incomplete(incomplete) ->
	[];
remove_incomplete({ok, A, B}) ->
	[{A, B}].

remove_incomplete_rec(incomplete, X) ->
	X;
remove_incomplete_rec({ok, A, B}, Rest) ->
	[{A, B} | Rest].

