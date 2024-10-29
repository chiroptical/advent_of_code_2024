Nonterminals list elems winning_numbers current_numbers card cards card_number.
Terminals '[' ']' ',' int card_separator number_separator.
Rootsymbol list.

card_number -> card ',' int : extract_token('$3').
winning_numbers -> card_separator ',' elems ',' number_separator : '$3'.
current_numbers -> elems : '$1'.

card -> card_number ',' winning_numbers ',' current_numbers : {'$1', '$3', '$5'}.

elems -> int           : [extract_token('$1')].
elems -> int ',' elems : [extract_token('$1')|'$3'].

list -> '[' cards ']' : '$2'.

cards -> card : ['$1'].
cards -> card ',' cards : ['$1'|'$3'].

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
