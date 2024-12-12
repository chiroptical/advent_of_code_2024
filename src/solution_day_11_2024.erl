-module(solution_day_11_2024).

-export([
    part_one/1,
    part_two/1,
    lex/1,
    parse/1
]).

is_even_digits(0) ->
    false;
is_even_digits(X) when X > 0 ->
    (floor(math:log10(X)) + 1) rem 2 =:= 0.

find_divisor(X, Base, Divisor) ->
    case (X div Divisor) > Divisor of
        true -> find_divisor(X, Base, Divisor * Base);
        false -> Divisor
    end.

split_digits(X) ->
    Divisor = find_divisor(X, 10, 10),
    Div = X div Divisor,
    Rem = X rem Divisor,
    {Div, Rem}.

blink(0) ->
    {one, 1};
blink(X) ->
    case is_even_digits(X) of
        false -> {one, X * 2024};
        true -> {two, split_digits(X)}
    end.

blink_map(M) ->
    maps:fold(
        fun(Num, Stones, Acc) ->
            Update = fun(Key, Map) ->
                maps:update_with(
                    Key,
                    fun(X) ->
                        X + Stones
                    end,
                    Stones,
                    Map
                )
            end,
            case blink(Num) of
                {one, A} ->
                    Update(A, Acc);
                {two, {A, B}} ->
                    Update(B, Update(A, Acc))
            end
        end,
        maps:new(),
        M
    ).

solve_map(Stones, N) ->
    Blinked =
        lists:foldl(
            fun(_X, Acc) ->
                blink_map(Acc)
            end,
            Stones,
            lists:seq(1, N)
        ),
    maps:fold(fun(_K, V, Acc) -> V + Acc end, 0, Blinked).

-spec part_one(list(integer())) -> integer().
part_one(Stones) ->
    solve_map(Stones, 25).

-spec part_two(list(integer())) -> integer().
part_two(Stones) ->
    solve_map(Stones, 75).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_11_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_11_2024:parse(Input).
