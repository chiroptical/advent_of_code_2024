Definitions.

NUMBER = [0-9]

Rules.

{NUMBER} : {token, {number, TokenCol, list_to_integer(TokenChars)}}.

Erlang code.
