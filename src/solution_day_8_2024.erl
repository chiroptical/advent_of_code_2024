-module(solution_day_8_2024).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_8_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_8_2024:parse(Input).

pairs([]) -> [];
pairs([H | T]) -> [{H, X} || X <- T] ++ pairs(T).

distance({A, B}, {C, D}) ->
    {C - A, D - B}.

add_vec({A, B}, {C, D}) ->
    {A + C, B + D}.

flip_vec({A, B}) ->
    {-A, -B}.

get_antenna_positions(Positions) ->
    maps:fold(
        fun(Key, Value, Acc) ->
            case Value of
                {antenna, Antenna} ->
                    maps:update_with(Antenna, fun(Pos) -> [Key | Pos] end, [Key], Acc);
                blank ->
                    Acc
            end
        end,
        #{},
        Positions
    ).

follow(X, V, M, continue) ->
    NewX = add_vec(X, V),
    CurX = maps:get(NewX, M, nil),
    case CurX of
        nil ->
            M;
        antinode ->
            follow(NewX, V, M, continue);
        _ ->
            follow(NewX, V, maps:put(NewX, antinode, M), continue)
    end;
follow(X, V, M, once) ->
    NewX = add_vec(X, V),
    CurX = maps:get(NewX, M, nil),
    case CurX of
        nil ->
            M;
        antinode ->
            M;
        _ ->
            maps:put(NewX, antinode, M)
    end.

solve(Follow, Positions, AntennaPositions) ->
    maps:fold(
        fun(_Name, Antennas, Acc) ->
            Pairs = pairs(Antennas),
            lists:foldl(
                fun({X, Y}, Into) ->
                    Distance = distance(X, Y),
                    FollowX = follow(X, flip_vec(Distance), Into, Follow),
                    follow(Y, Distance, FollowX, Follow)
                end,
                Acc,
                Pairs
            )
        end,
        Positions,
        AntennaPositions
    ).

-spec part_one(_) -> integer().
part_one(Positions) ->
    AntennaPositions = get_antenna_positions(Positions),
    NewPositions = solve(once, Positions, AntennaPositions),
    Antinodes = maps:filter(fun(_K, V) -> V =:= antinode end, NewPositions),
    maps:size(Antinodes).

is_antenna({antenna, _}) -> true;
is_antenna(_) -> false.

-spec part_two(_) -> integer().
part_two(Positions) ->
    AntennaPositions = get_antenna_positions(Positions),
    NewPositions = solve(continue, Positions, AntennaPositions),
    Antinodes = maps:filter(
        fun(_K, V) ->
            (V =:= antinode) or is_antenna(V)
        end,
        NewPositions
    ),
    maps:size(Antinodes).
