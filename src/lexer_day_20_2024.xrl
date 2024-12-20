Definitions.

COLOR   = [SE\.#]
NEWLINE = \n

Rules.

{COLOR}   : {token, {track, TokenLoc, from(TokenChars)}}.
{NEWLINE} : skip_token.

Erlang code.

from("S") -> start;
from("E") -> stop;
from(".") -> track;
from("#") -> wall.
