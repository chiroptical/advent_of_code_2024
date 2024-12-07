Definitions.

DOT     = \.
OCTO    = #
CARROT  = [<>^v]
NEWLINE = \n

Rules.

{CARROT}  : {token, {guard, TokenLoc, to_atom(TokenChars)}}.
{OCTO}    : {token, {obstacle, TokenLoc}}.
{DOT}     : {token, {blank, TokenLoc}}. 
{NEWLINE} : skip_token.

Erlang code.

to_atom("<") ->
	west;
to_atom(">") ->
	east;
to_atom("^") ->
	north;
to_atom("v") ->
	south.
