Definitions.

WALL    = #
ROBOT   = @
BOX     = O
NEWLINE = \n
LEFT    = <
DOWN    = v
RIGHT   = >
UP      = \^
DOT     = \.

Rules.

{WALL}    : {token, {wall, TokenLoc}}.
{ROBOT}   : {token, {robot, TokenLoc}}.
{BOX}     : {token, {box, TokenLoc}}.
{NEWLINE} : skip_token.
{LEFT}    : {token, {left, TokenLoc}}.
{RIGHT}   : {token, {right, TokenLoc}}.
{UP}      : {token, {up, TokenLoc}}.
{DOWN}    : {token, {down, TokenLoc}}.
{DOT}     : skip_token.

Erlang code.
