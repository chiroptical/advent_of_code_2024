Nonterminals map.

Terminals guard obstacle blank.

Rootsymbol map.

map -> guard        : [from_guard('$1')].
map -> obstacle     : [from_obstacle('$1')].
map -> blank        : [from_blank('$1')].
map -> guard map    : [from_guard('$1')|'$2'].
map -> obstacle map : [from_obstacle('$1')|'$2'].
map -> blank map    : [from_blank('$1')|'$2'].

Erlang code.

from_guard({guard, {X, Y}, Direction}) ->
	{{X, Y}, {guard, Direction}}.

from_obstacle({obstacle, {X, Y}}) ->
	{{X, Y}, obstacle}.

from_blank({blank, {X, Y}}) ->
	{{X, Y}, blank}.
