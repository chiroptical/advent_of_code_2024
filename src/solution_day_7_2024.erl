-module(solution_day_7_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_7_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_7_2024:parse(Input).

clip(TestValue, Result) ->
    case Result > TestValue of
        true -> nil;
        false -> Result
    end.

concat_clip(TestValue, X, Y) ->
    clip(
        TestValue,
        list_to_integer(integer_to_list(Y) ++ integer_to_list(X))
    ).

add_clip(TestValue, X, Y) -> clip(TestValue, X + Y).

mul_clip(TestValue, X, Y) -> clip(TestValue, X * Y).

build_magmas(TestValue, Threes) ->
    [fun(A, B) -> F(TestValue, A, B) end || F <- Threes].

is_valid_equation({TestValue, Inputs}, Threes) ->
    Magmas = build_magmas(TestValue, Threes),
    Leaves = lists:foldl(
        fun(X, Acc) ->
            case Acc of
                [] ->
                    [X];
                _ ->
                    [F(X, Y) || F <- Magmas, Y <- Acc, F(X, Y) =/= nil]
            end
        end,
        [],
        Inputs
    ),
    case lists:any(fun(X) -> X == TestValue end, Leaves) of
        true -> TestValue;
        false -> 0
    end.

solve(Equations, Threes) ->
    lists:foldl(
        fun(Equation, Acc) ->
            Acc + is_valid_equation(Equation, Threes)
        end,
        0,
        Equations
    ).

-spec part_one(_) -> integer().
part_one(Equations) ->
    solve(Equations, [fun add_clip/3, fun mul_clip/3]).

-spec part_two(_) -> integer().
part_two(Equations) ->
    solve(Equations, [fun add_clip/3, fun mul_clip/3, fun concat_clip/3]).
