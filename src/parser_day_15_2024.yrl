Nonterminals input warehouse movement movements.

Terminals wall robot box newline left right up down.

Rootsymbol input.

warehouse -> wall  : to_map('$1').  
warehouse -> robot : to_map('$1'). 
warehouse -> box   : to_map('$1').
warehouse -> wall warehouse  : insert(to_kv('$1'), '$2').  
warehouse -> robot warehouse : insert(to_kv('$1'), '$2').  
warehouse -> box warehouse   : insert(to_kv('$1'), '$2').  

movement -> left  : from_movement('$1').
movement -> right : from_movement('$1').
movement -> up    : from_movement('$1').
movement -> down  : from_movement('$1').

movements -> movement           : ['$1'].
movements -> movement movements : ['$1'|'$2'].

input -> warehouse movements : {'$1', '$2'}.

Erlang code.

from_movement({X, _Loc}) -> X.

to_map({X, Loc}) ->	#{Loc => X}.

to_kv({X, Loc}) -> {Loc, X}.

insert({K, V}, M) -> maps:put(K, V, M).
