Definitions.

WALL    = #
START   = S
END     = E
NEWLINE = \n
DOT     = \.

Rules.

{WALL}    : {token, {wall, TokenLoc}}.
{START}   : {token, {start, TokenLoc}}.
{END}     : {token, {stop, TokenLoc}}.
{NEWLINE} : skip_token.
{DOT}     : skip_token.

Erlang code.
