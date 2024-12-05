Definitions.

INT         = [0-9]+
MULTIPLY    = mul
DO          = do\(\)
DONT        = don't\(\)
OPEN_PAREN  = \(
CLOSE_PAREN = \)
COMMA       = ,
NEWLINE     = \n
ELSE        = .

Rules.

{INT}                 : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{MULTIPLY}            : {token, {mul, TokenLine}}.
{DO}                  : {token, {do, TokenLine}}.
{DONT}                : {token, {dont, TokenLine}}.
{OPEN_PAREN}          : {token, {open_paren, TokenLine}}.
{CLOSE_PAREN}         : {token, {close_paren, TokenLine}}.
{COMMA}               : {token, {comma, TokenLine}}.
{NEWLINE}             : {token, {skip, TokenLine}}.
{ELSE}                : {token, {skip, TokenLine}}.

Erlang code.
