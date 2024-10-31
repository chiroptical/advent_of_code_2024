Definitions.

NEWLINE = [\n]+
INT = [1-9]
ONE = one
TWO = two
THREE = three
FOUR = four
FIVE = fix
SIX = six
SEVEN = seven
EIGHT = eight
NINE = nine
ELSE = [a-z]

Rules.

{NEWLINE}   : {token, {calibration_separator, TokenLine}}.
{INT}       : {token, {number, TokenLine, list_to_integer(TokenChars)}}.

{ONE}       : {token, {number, TokenLine, 1}, "e"}.
{TWO}       : {token, {number, TokenLine, 2}, "o"}.
{THREE}     : {token, {number, TokenLine, 3}, "e"}.
{FOUR}      : {token, {number, TokenLine, 4}, "r"}.
{FIVE}      : {token, {number, TokenLine, 5}, "e"}.
{SIX}       : {token, {number, TokenLine, 6}, "x"}.
{SEVEN}     : {token, {number, TokenLine, 7}, "n"}.
{EIGHT}     : {token, {number, TokenLine, 8}, "t"}.
{NINE}      : {token, {number, TokenLine, 9}, "e"}.

{ELSE}      : skip_token.


Erlang code.
