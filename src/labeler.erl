-module(labeler).

-export([
    run_test/0,
    run/0,
    solve/1
]).

test_input() ->
    "RRRRI\n"
    "RRRRI\n"
    "VVRRR\n".

run_test() ->
    {ok, Lex} = solution_day_12_2024:lex(test_input()),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    case ets:whereis(visited) of
        undefined -> ok;
        _ -> ets:delete(visited)
    end,
    solve(Parse).

run() ->
    {ok, Input} = file:read_file("inputs/2024-day-12.txt"),
    {ok, Lex} = solution_day_12_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    case ets:whereis(visited) of
        undefined -> ok;
        _ -> ets:delete(visited)
    end,
    T1 = erlang:monotonic_time(millisecond),
    solve(Parse),
    T2 = erlang:monotonic_time(millisecond),
    T2 - T1.

insert_to(Visited, Position) ->
    ets:insert(Visited, {Position, true}).

lookup_from(Visited, Position) ->
    case ets:lookup(Visited, Position) of
        [] -> false;
        _ -> true
    end.

look(Position, Label, AllPositions) ->
    Lookup = proplists:lookup(Position, AllPositions),
    case Lookup of
        {_, A} when A =:= Label -> true;
        _ -> false
    end.

get_valid_looks({X, Y}, Looks, Visited) ->
    lists:foldl(
        fun({A, B}, Acc) ->
            LookPos = {X + A, Y + B},
            case lookup_from(Visited, LookPos) of
                true -> Acc;
                false -> [{A, B} | Acc]
            end
        end,
        [],
        Looks
    ).

find_all_matches(Position = {X, Y}, Label, ValidLooks, AllPositions, Visited) ->
    lists:foldl(
        fun({A, B}, Acc) ->
            LookPos = {X + A, Y + B},
            case look(LookPos, Label, AllPositions) of
                true ->
                    insert_to(Visited, LookPos),
                    KeepGoing = inner(LookPos, Label, AllPositions, Visited),
                    s2:union(KeepGoing, s2:insert(LookPos, Acc));
                false ->
                    insert_to(Visited, LookPos),
                    Acc
            end
        end,
        s2:singleton(Position),
        ValidLooks
    ).

inner(Position, Label, AllPositions, Visited) ->
    insert_to(Visited, Position),
    Looks = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
    ValidLooks = get_valid_looks(Position, Looks, Visited),
    find_all_matches(Position, Label, ValidLooks, AllPositions, Visited).

%% TODO: have a new ETS table that counts the number of times a particular
%% position has been visited
%%
%% TODO: At a high level, I:
%% - find an arbitrary point in the map (min key, but it doesn't matter)
%% - recursively find all adjacent keys that point to the same value
%% - split the map into one that has the keys I found and one that doesn't
%% Then just unfold that
solve(Input) ->
    lists:foldl(
        fun({Key, Val}, {CurrentGroup, Acc}) ->
            case maps:find(Key, Acc) of
                error ->
                    Visited = ets:new(visited, [set]),
                    Matches = inner(Key, Val, Input, Visited),
                    NewAcc =
                        s2:fold(
                            fun(Elem, In) ->
                                maps:put(Elem, CurrentGroup, In)
                            end,
                            Acc,
                            Matches
                        ),
                    {CurrentGroup + 1, NewAcc};
                _ ->
                    {CurrentGroup, Acc}
            end
        end,
        {0, maps:new()},
        Input
    ).
