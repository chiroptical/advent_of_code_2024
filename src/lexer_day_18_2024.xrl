Definitions.

COMMA   = ,
NUMBER  = [0-9]+
NEWLINE = \n

Rules.

{NUMBER}   : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.
{NEWLINE}  : skip_token.
{COMMA}    : skip_token.

Erlang code.
