Definitions.

NUMBER = [0-9]+
SPACE  = [\s\n]+

Rules.

{NUMBER} : {token, {stone, TokenLoc, list_to_integer(TokenChars)}}.
{SPACE}  : skip_token.

Erlang code.
