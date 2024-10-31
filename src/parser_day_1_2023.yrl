Nonterminals numbers calibrations integer.

Terminals number calibration_separator.

Rootsymbol calibrations.

integer -> number          : extract_integer('$1').

numbers -> integer         : ['$1'].
numbers -> integer numbers : ['$1'|'$2'].

calibrations -> numbers                                    : ['$1'].
calibrations -> numbers calibration_separator              : ['$1'].
calibrations -> numbers calibration_separator calibrations : ['$1'|'$3'].

Erlang code.

extract_integer({_Token, _Line, Value}) -> Value.
