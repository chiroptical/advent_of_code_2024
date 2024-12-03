-module(list_utils).

-export([
    window/2,
    drop_nth/2,
    drop_nth_slow/2
]).

%% NOTE: requires that you take exactly N elements each time
%% i.e. window(2, [1, 2, 3]) ~ [[1, 2], [2, 3]]
%%      window(2, [1]) ~ []
-spec window(pos_integer(), list()) -> list(list()).
window(_N, []) ->
    [];
window(N, List = [_Head | Tail]) ->
    Take = lists:sublist(List, N),
    case length(Take) =:= N of
        true ->
            [Take | window(N, Tail)];
        false ->
            []
    end.

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
