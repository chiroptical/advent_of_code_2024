Nonterminals numbers winning_numbers current_numbers scorecard cards card_number integer.

Terminals int card card_separator number_separator.

Rootsymbol cards.

integer -> int : extract_integer('$1').

card_number -> card integer : '$2'.

winning_numbers -> card_separator numbers   : '$2'.
current_numbers -> number_separator numbers : '$2'.

scorecard -> card_number winning_numbers current_numbers : {'$1', '$2', '$3'}.

numbers -> integer         : ['$1'].
numbers -> integer numbers : ['$1'|'$2'].

cards -> scorecard       : ['$1'].
cards -> scorecard cards : ['$1'|'$2'].

Erlang code.

extract_integer({_Token, _Line, Value}) when is_integer(Value) -> Value;
extract_integer({_Token, _Line, Value}) when is_list(Value) -> list_to_integer(Value);
extract_integer({_Token, _Line, Value}) -> Value.
