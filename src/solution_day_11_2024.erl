-module(solution_day_11_2024).

-export([
    part_one/1,
    part_two/1,
    split_digits/1,
    is_even_digits/1,
    lex/1,
    parse/1
]).

%% TODO: Use this instead of integer_to_list/1
is_even_digits(X) when X > 0 ->
    (round(math:log10(X)) + 1) rem 2 =:= 0.

find_divisor(X, Base, Divisor) ->
    case (X div Divisor) > Divisor of
        true -> find_divisor(X, Base, Divisor * Base);
        false -> Divisor
    end.

split_digits(X) ->
    Divisor = find_divisor(X, 10, 10),
    Div = X div Divisor,
    Rem = X rem Divisor,
    {length(integer_to_list(X)) rem 2 =:= 0, Div, Rem}.

blink(X, N, Max) ->
    {IsEven, A, B} = split_digits(X),
    case X of
        0 ->
            case N =:= Max of
                true -> 1;
                false -> blink(1, N + 1, Max)
            end;
        _ when IsEven ->
            case N =:= Max of
                true -> 1;
                false -> blink(A, N + 1, Max) + blink(B, N + 1, Max)
            end;
        _ ->
            case N =:= Max of
                true -> 1;
                false -> blink(X * 2024, N + 1, Max)
            end
    end.

evolve(X, Max) ->
    blink(X, 0, Max).

-spec part_one(_) -> integer().
part_one(Stones) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + evolve(X, 25)
        end,
        0,
        Stones
    ).

-spec part_two(_) -> integer().
part_two(Stones) ->
    lists:foldl(
        fun(X, Acc) ->
            logger:notice(#{starting => X}),
            Evolve = evolve(X, 75),
            logger:notice(#{done => X}),
            Acc + Evolve
        end,
        0,
        Stones
    ).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_11_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_11_2024:parse(Input).
