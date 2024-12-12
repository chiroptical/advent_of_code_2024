-module(solution_day_11_2024_old).

-export([
    part_one/1
]).

%% NOTE: this is too slow for part 2!
part_one(Stones) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + evolve(X, 25)
        end,
        0,
        Stones
    ).

blink_recursive(X, N, Max) ->
    IsEven = solution_day_11_2024:is_even_digits(X),
    case X of
        0 ->
            case N =:= Max of
                true -> 1;
                false -> blink_recursive(1, N + 1, Max)
            end;
        _ when IsEven ->
            {A, B} = solution_day_11_2024:split_digits(X),
            case N =:= Max of
                true -> 1;
                false -> blink_recursive(A, N + 1, Max) + blink_recursive(B, N + 1, Max)
            end;
        _ ->
            case N =:= Max of
                true -> 1;
                false -> blink_recursive(X * 2024, N + 1, Max)
            end
    end.

evolve(X, Max) ->
    blink_recursive(X, 0, Max).
