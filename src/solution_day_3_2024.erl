-module(solution_day_3_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_3_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_3_2024:parse(Input).

-spec part_one(list(list(integer()))) -> integer().
part_one(Input) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + lists:sum(X)
        end,
        0,
        Input
    ).

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.
