Nonterminals instruction memory computer else.

Terminals mul int open_paren close_paren comma space newline.

Rootsymbol computer.

instruction -> mul open_paren int comma int close_paren : {ok, extract_integer('$3'), extract_integer('$5')}.
instruction -> mul open_paren int comma int             : incomplete.
instruction -> mul open_paren int comma                 : incomplete.
instruction -> mul open_paren int                       : incomplete.
instruction -> mul open_paren                           : incomplete.
instruction -> else                                     : incomplete.

memory -> instruction             : remove_incomplete('$1').
memory -> instruction memory      : remove_incomplete_rec('$1', '$2').

computer -> memory newline          : ['$1'].
computer -> memory newline computer : ['$1'|'$3'].

else -> mul.
else -> int.
else -> open_paren.
else -> close_paren.
else -> comma.
else -> space.

Erlang code.

extract_integer({_Token, _Line, Value}) -> Value.

remove_incomplete(incomplete) ->
	[];
remove_incomplete({ok, A, B}) ->
	X = length(integer_to_list(A)),
	Y = length(integer_to_list(B)),
	case (X > 3) or (Y > 3) of
		true -> 
			[];
		false ->
			[A * B]
	end.

remove_incomplete_rec(incomplete, X) ->
	X;
remove_incomplete_rec({ok, A, B}, Rest) ->
	X = length(integer_to_list(A)),
	Y = length(integer_to_list(B)),
	case (X > 3) or (Y > 3) of
		true -> 
			Rest;
		false ->
			[A * B | Rest]
	end.

