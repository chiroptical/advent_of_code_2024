Nonterminals operands equations equation.

Terminals number newline colon.

Rootsymbol equations.

operands -> number         : [extract_value('$1')].
operands -> number operands : [extract_value('$1')|'$2'].

equation -> number colon operands : {extract_value('$1'),'$3'}.

equations -> equation newline           : ['$1'].
equations -> equation newline equations : ['$1'|'$3'].

Erlang code.

extract_value({number, _Loc, Value}) ->
	Value.
