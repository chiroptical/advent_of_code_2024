Definitions.

NUMBER = [0-9]+
SPACES = \s+
COLON = :
NEWLINE = \n

Rules.

{NUMBER}     : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.
{NEWLINE}    : {token, {newline, TokenLoc}}.
{COLON}      : {token, {colon, TokenLoc}}.
{SPACES}     : skip_token.

Erlang code.
