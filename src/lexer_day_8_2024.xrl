Definitions.

ANTENNA = [0-9a-zA-z]
DOT     = \.
NEWLINE = \n

Rules.

{ANTENNA} : {token, {antenna, TokenLoc, TokenChars}}.
{DOT}     : {token, {blank, TokenLoc}}. 
{NEWLINE} : skip_token.

Erlang code.
