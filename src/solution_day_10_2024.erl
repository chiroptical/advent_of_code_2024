-module(solution_day_10_2024).

-export([
    part_one/1,
    part_two/1,
    lex/1,
    parse/1
]).

-spec part_one(_) -> integer().
part_one(_Positions) ->
    42.

-spec part_two(_) -> integer().
part_two(_Positions) ->
    42.

lex(Input) ->
    {ok, Tokens, _} = lexer_day_10_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_10_2024:parse(Input).
