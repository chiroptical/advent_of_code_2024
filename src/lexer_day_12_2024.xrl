Definitions.

PLANT   = [A-Z]
NEWLINE = \n

Rules.

{PLANT}   : {token, {plant, TokenLoc, TokenChars}}.
{NEWLINE} : skip_token.

Erlang code.
