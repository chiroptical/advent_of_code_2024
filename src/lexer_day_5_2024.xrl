Definitions.

NUMBER  = [0-9]+
PIPE    = \|
COMMA   = ,
NEWLINE = \n

Rules.

{NUMBER}  : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.
{PIPE}    : {token, {pipe, TokenLoc}}.
{COMMA}   : {token, {comma, TokenLoc}}.
{NEWLINE} : {token, {newline, TokenLoc}}.

Erlang code.
