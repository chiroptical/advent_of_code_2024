Nonterminals integer left_and_right left_and_rights.

Terminals int.

Rootsymbol left_and_rights.

integer -> int : extract_integer('$1').

left_and_right -> integer integer : {'$1', '$2'}.

left_and_rights -> left_and_right : ['$1'].
left_and_rights -> left_and_right left_and_rights : ['$1'|'$2'].

Erlang code.

extract_integer({_Token, _Line, Value}) -> Value.
