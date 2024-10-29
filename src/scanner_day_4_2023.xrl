Definitions.

INT        = [0-9]+
WHITESPACE = [\s\t\n\r]

Rules.

Card                  : {token, {card, TokenLine}}.
{INT}                 : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
\:                    : {token, {card_separator, TokenLine}}.
\|                    : {token, {number_separator, TokenLine}}.
{WHITESPACE}+         : skip_token.

Erlang code.
