Definitions.

BUTTON = Button
PRIZE  = Prize
ABXY   = [ABXY]
PLUS   = \+
EQ     = \=
COMMA  = ,
COLON  = :
SPACE  = [\s\n]+
NUM    = [0-9]+

Rules.

{BUTTON} : {token, {button, TokenLoc}}.
{PRIZE}  : {token, {prize, TokenLoc}}.
{ABXY}   : {token, {to_atom(TokenChars), TokenLoc}}.
{PLUS}   : skip_token.
{EQ}     : skip_token.
{COMMA}  : skip_token.
{COLON}  : skip_token.
{SPACE}  : skip_token.
{NUM}    : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.

Erlang code.

to_atom("A") -> a;
to_atom("B") -> b;
to_atom("X") -> x;
to_atom("Y") -> y.
