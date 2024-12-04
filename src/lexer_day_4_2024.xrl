Definitions.

XMAS    = [XMAS]
NEWLINE = \n

Rules.

{XMAS}    : {token, {xmas, TokenLoc, TokenChars}}.
{NEWLINE} : skip_token.

Erlang code.
