-module(list_utils).

-export([
    drop_nth/2,
    drop_nth_slow/2
]).

-spec drop_nth(pos_integer(), list()) -> list().
drop_nth(N, X) ->
    drop_nth_inner(N, X, queue:new()).

-spec drop_nth_inner(pos_integer(), list(), queue:queue()) -> list().
drop_nth_inner(1, [_Head | Tail], Acc) ->
    lists:append(queue:to_list(Acc), Tail);
drop_nth_inner(_N, [], Acc) ->
    queue:to_list(Acc);
drop_nth_inner(N, [Head | Tail], Acc) ->
    drop_nth_inner(N - 1, Tail, queue:in(Head, Acc)).

% Note: this is wildy slow, see benchmarks
-spec drop_nth_slow(pos_integer(), list()) -> list().
drop_nth_slow(N, X) ->
    drop_nth_slow_inner(N, X, []).

-spec drop_nth_slow_inner(pos_integer(), list(), list()) -> list().
drop_nth_slow_inner(1, [_Head | Tail], Acc) ->
    lists:append(Acc, Tail);
drop_nth_slow_inner(_N, [], Acc) ->
    Acc;
drop_nth_slow_inner(N, [Head | Tail], Acc) ->
    drop_nth_slow_inner(N - 1, Tail, lists:append(Acc, [Head])).
