Definitions.

POSITION = p
VELOCITY = v
NUM      = \-?[0-9]+
COMMA    = ,
EQUAL    = \=
SPACE    = [\s\n]+

Rules.

{POSITION} : {token, {position, TokenLoc}}.
{VELOCITY} : {token, {velocity, TokenLoc}}.
{COMMA}    : skip_token.
{EQUAL}    : skip_token.
{SPACE}    : skip_token.
{NUM}      : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.

Erlang code.
