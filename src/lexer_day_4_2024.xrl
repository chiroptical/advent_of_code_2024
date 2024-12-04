Definitions.

XMAS    = [XMAS]
NEWLINE = \n

Rules.

{XMAS}    : {token, {xmas, TokenLoc, to_atom(TokenChars)}}.
{NEWLINE} : skip_token.

Erlang code.

to_atom("X") ->
	x;
to_atom("M") ->
	m;
to_atom("A") ->
	a;
to_atom("S") ->
	s.
