Nonterminals maze.

Terminals wall start stop.

Rootsymbol maze.

maze -> wall  : to_map('$1').  
maze -> start : to_map('$1'). 
maze -> stop  : to_map('$1').
maze -> wall maze  : insert(to_kv('$1'), '$2').  
maze -> start maze : insert(to_kv('$1'), '$2').  
maze -> stop maze  : insert(to_kv('$1'), '$2').  

Erlang code.

to_map({X, Loc}) ->	#{Loc => X}.

to_kv({X, Loc}) -> {Loc, X}.

insert({K, V}, M) -> maps:put(K, V, M).
