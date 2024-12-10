Definitions.

NUMBER  = [0-9]
NEWLINE = \n

Rules.

{NUMBER} : {token, {height, TokenLoc, list_to_integer(TokenChars)}}.
{NEWLINE} : skip_token.

Erlang code.
