-module(solution_day_6_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_6_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_6_2024:parse(Input).

-spec part_one(_) -> integer().
part_one(_Input) ->
    42.

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.
