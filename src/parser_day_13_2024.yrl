Nonterminals buttons prizes machine machines.

Terminals button a b x y number prize.

Rootsymbol machines.

buttons -> button a x number y number : {from_number('$4'), from_number('$6')}.
buttons -> button b x number y number : {from_number('$4'), from_number('$6')}.

prizes -> prize x number y number : {from_number('$3'), from_number('$5')}.

machine ->  buttons buttons prizes : {machine, ['$1', '$2'], '$3'}.

machines -> machine          : ['$1'].
machines -> machine machines : ['$1'|'$2'].

Erlang code.

from_number({number, _Loc, X}) ->
	X.
