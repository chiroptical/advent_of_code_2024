Definitions.

DOT     = \.
OCTO    = #
CARROT  = [<>^v]
NEWLINE = \n

Rules.

{CARROT}  : {token, {guard, TokenLoc, to_atom(TokenChars)}}.
{OCTO}    : {token, {obstacle, TokenLoc}}.
{DOT}     : skip_token. 
{NEWLINE} : skip_token.

Erlang code.

to_atom("<") ->
	west;
to_atom(">") ->
	east;
to_atom("^") ->
	south;
to_atom("v") ->
	north.
