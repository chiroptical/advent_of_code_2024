Nonterminals level report reports.

Terminals int newline.

Rootsymbol reports.

level -> int : extract_level('$1').

report -> level         : ['$1'].
report -> level report  : ['$1'|'$2'].

reports -> report newline         : ['$1'].
reports -> report newline reports : ['$1'|'$3'].

Erlang code.

extract_level({_Token, _Line, Value}) -> Value.
