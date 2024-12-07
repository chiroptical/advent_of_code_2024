-module(solution_day_6_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_6_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_6_2024:parse(Input).

find_starting_position(M) ->
    GuardPositions = maps:fold(
        fun(Key, Value, Acc) ->
            case Value of
                {guard, _} -> [Key | Acc];
                _ -> Acc
            end
        end,
        [],
        M
    ),
    case GuardPositions of
        [] -> {error, not_found};
        [X] -> {ok, X};
        _ -> {error, more_than_one}
    end.

turn(north) -> east;
turn(east) -> south;
turn(south) -> west;
turn(west) -> north.

get_path(Positions, Direction, Row, Col) ->
    NewSpot =
        case Direction of
            north ->
                {Row - 1, Col};
            south ->
                {Row + 1, Col};
            east ->
                {Row, Col + 1};
            west ->
                {Row, Col - 1}
        end,
    {NewSpot, maps:get(NewSpot, Positions, off)}.

step(Positions, GuardPosition = {Row, Col}, SeenPositions) ->
    NewSeenPositions = sets:add_element(GuardPosition, SeenPositions),
    {guard, Direction} = maps:get(GuardPosition, Positions),
    {NewSpot, Path} = get_path(Positions, Direction, Row, Col),
    case Path of
        off ->
            {done, NewSeenPositions};
        obstacle ->
            NewGuard = {guard, turn(Direction)},
            NewPositions = maps:update(GuardPosition, NewGuard, Positions),
            step(NewPositions, GuardPosition, NewSeenPositions);
        blank ->
            WithNewGuard = maps:update(NewSpot, {guard, Direction}, Positions),
            WithNewBlank = maps:update(GuardPosition, blank, WithNewGuard),
            step(WithNewBlank, NewSpot, NewSeenPositions)
    end.

walk(Positions, GuardPosition) ->
    case step(Positions, GuardPosition, sets:new()) of
        {done, SeenPositions} ->
            sets:size(SeenPositions)
    end.

-spec part_one(_) -> integer().
part_one(Input) ->
    InputPositions = maps:from_list(Input),
    {ok, GuardPosition} = find_starting_position(InputPositions),
    walk(InputPositions, GuardPosition).

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.
