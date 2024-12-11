-module(benchmark).

-export([
    run_drop_nth/0,
    run_drop_nth_slow/0,
    compare_drop_nth/0,
    run_is_even_digits/0,
    run_is_even_digits_with_integer_to_list/0
]).

run_is_even_digits() ->
    % warm up that JIT
    solution_day_11_2024:is_even_digits(10),

    %% Number = 100_000_000_000_000_000_000_000_000_000_000_000_000,
    Number = 10,
    List = lists:duplicate(100, Number),

    Timings =
        lists:map(fun (_X) ->
            T1 = erlang:monotonic_time(nanosecond),
            lists:foreach(fun (X) ->
                    solution_day_11_2024:is_even_digits(X)
                end,
                List
            ),
            T2 = erlang:monotonic_time(nanosecond),
            T2 - T1
        end,
        lists:seq(1, 10)
    ),
    Total = lists:foldl(fun (Elem, Acc) -> Acc + Elem end, 0, Timings),
    Total / length(Timings).

run_is_even_digits_with_integer_to_list() ->
    %% Number = 100_000_000_000_000_000_000_000_000_000_000_000_000,
    Number = 10,
    List = lists:duplicate(100, Number),
    Timings =
        lists:map(fun (_X) ->
            T1 = erlang:monotonic_time(nanosecond),
            lists:foreach(fun (X) ->
                AsList = integer_to_list(X),
                length(AsList) rem 2 =:= 0
            end,
            List),
            T2 = erlang:monotonic_time(nanosecond),
            T2 - T1
        end,
        lists:seq(1, 10)
    ),
    Total = lists:foldl(fun (Elem, Acc) -> Acc + Elem end, 0, Timings),
    Total / length(Timings).

run_drop_nth() ->
    List = lists:duplicate(10_000, 1),
    Get = [0, 100, 1_000, 10_000],
    Timings =
        lists:map(
            fun(X) ->
                T1 = erlang:monotonic_time(nanosecond),
                _ = list_utils:drop_nth(X, List),
                T2 = erlang:monotonic_time(nanosecond),
                T2 - T1
            end,
            Get
        ),
    Timings.

run_drop_nth_slow() ->
    List = lists:duplicate(10_000, 1),
    Get = [0, 100, 1_000, 10_000],
    Timings =
        lists:map(
            fun(X) ->
                T1 = erlang:monotonic_time(nanosecond),
                _ = list_utils:drop_nth_slow(X, List),
                T2 = erlang:monotonic_time(nanosecond),
                T2 - T1
            end,
            Get
        ),
    Timings.

compare_drop_nth() ->
    New = run_drop_nth(),
    Old = run_drop_nth_slow(),
    lists:zipwith(fun(X, Y) -> Y / X end, New, Old).
