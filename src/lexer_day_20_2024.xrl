Definitions.

COLOR   = [SE\.#]
NEWLINE = \n

Rules.

{COLOR}   : {token, {position, TokenLoc, TokenChars}}.
{NEWLINE} : skip_token.

Erlang code.
