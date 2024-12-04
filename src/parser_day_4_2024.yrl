Nonterminals chars.

Terminals xmas.

Rootsymbol chars.

chars -> xmas       : [reshape('$1')].
chars -> xmas chars : [reshape('$1')|'$2'].

Erlang code.

reshape({xmas, {Row, Col}, Xmas}) ->
	{{Row, Col}, Xmas}.
