Nonterminals integer csv computer registers programs.

Terminals register program label number.

Rootsymbol computer.

integer -> number : from('$1').

registers -> register label integer           : [{from('$2'), '$3'}].
registers -> register label integer registers : [{from('$2'), '$3'}|'$4'].

csv -> integer     : ['$1'].
csv -> integer csv : ['$1'|'$2'].

programs -> program csv : '$2'.

computer -> registers programs : {'$1', '$2'}.

Erlang code.

from({label, _Loc, X}) -> X;
from({number, _Loc, X}) -> X.
