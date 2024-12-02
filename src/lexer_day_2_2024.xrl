Definitions.

INT        = [0-9]+
WHITESPACE = [\s\t\r]+
NEWLINE    = \n

Rules.

{INT}                 : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{NEWLINE}             : {token, {newline, TokenLine}}.
{WHITESPACE}          : skip_token.

Erlang code.
