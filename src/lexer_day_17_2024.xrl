Definitions.

REGISTER = Register
PROGRAM  = Program
ABC      = [ABC]
NEWLINE  = [\n\s]+
COLON    = :
COMMA    = ,
NUMBER   = [0-9]+

Rules.

{REGISTER} : {token, {register, TokenLoc}}.
{PROGRAM}  : {token, {program, TokenLoc}}.
{ABC}      : {token, {label, TokenLoc, from_abc(TokenChars)}}.
{NEWLINE}  : skip_token.
{COLON}    : skip_token.
{COMMA}    : skip_token.
{NUMBER}   : {token, {number, TokenLoc, list_to_integer(TokenChars)}}.

Erlang code.

from_abc("A") -> a; 
from_abc("B") -> b; 
from_abc("C") -> c.
