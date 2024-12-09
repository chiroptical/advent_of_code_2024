-module(solution_day_8_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

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

unique_pairs(X) ->
    sets:from_list([{A, B} || A <- X, B <- X, A < B]).

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

-spec part_one(_) -> integer().
part_one(Positions) ->
    AntennaPositions = get_antenna_positions(Positions),
    Antinodes = maps:fold(
        fun(_Name, Antennas, Acc) ->
            Pairs = unique_pairs(Antennas),
            sets:fold(
                fun({X, Y}, Into) ->
                    Distance = distance(X, Y),
                    FollowX = follow(X, flip_vec(Distance), Into, once),
                    follow(Y, Distance, FollowX, once)
                end,
                Acc,
                Pairs
            )
        end,
        Positions,
        AntennaPositions
    ),
    maps:size(maps:filter(fun(_K, V) -> V =:= antinode end, Antinodes)).

-spec part_two(_) -> integer().
part_two(Positions) ->
    AntennaPositions = get_antenna_positions(Positions),
    Antinodes = maps:fold(
        fun(_Name, Antennas, Acc) ->
            Pairs = unique_pairs(Antennas),
            sets:fold(
                fun({X, Y}, Into) ->
                    Distance = distance(X, Y),
                    WithX = maps:put(X, antinode, Into),
                    WithY = maps:put(Y, antinode, WithX),
                    FollowX = follow(X, flip_vec(Distance), WithY, continue),
                    follow(Y, Distance, FollowX, continue)
                end,
                Acc,
                Pairs
            )
        end,
        Positions,
        AntennaPositions
    ),
    Filtered = maps:filter(fun(_K, V) -> V =:= antinode end, Antinodes),
    logger:notice(#{antinodes => Filtered}),
    maps:size(Filtered).
