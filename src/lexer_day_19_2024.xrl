Definitions.

COLOR   = [wubrg]
NEWLINE = \n
COMMA   = ,
SPACE   = [\s]+

Rules.

{COLOR}   : {token, {color, TokenLoc, to_color(TokenChars)}}.
{NEWLINE} : {token, {newline, TokenLoc}}.
{COMMA}   : {token, {comma, TokenLoc}}.
{SPACE}   : skip_token.

Erlang code.

to_color("w") -> white;
to_color("u") -> blue;
to_color("b") -> black;
to_color("r") -> red;
to_color("g") -> green.
