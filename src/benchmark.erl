-module(benchmark).

-export([
    run_drop_nth/0,
    run_drop_nth_slow/0,
    compare_drop_nth/0
]).

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
