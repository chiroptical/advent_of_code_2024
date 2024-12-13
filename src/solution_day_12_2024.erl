-module(solution_day_12_2024).

-record(state, {
    % Keeps the labels for each group
    % If you find a po
    % e.g. #{1 => "X"}
    labels = maps:new(),
    % Keeps the positions for each group
    % e.g. #{1 => sets:from_list([{1, 1}])}
    positions = maps:new(),
    % Keeps the sides for the group
    % e.g. #{1 => 2}
    sides = maps:new(),
    % Keeps the number of spaces for the group
    spaces = maps:new(),
    % Keep the current group
    current_group = 0
}).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1,
    find_group_number/3,
    count_sides/3,
    find_positions/4
]).

find_group_number(Position, Groups, CurrentGroup) ->
    Result = maps:filter(
        fun(_K, V) ->
            sets:is_element(Position, V)
        end,
        Groups
    ),
    case maps:keys(Result) of
        [Group] ->
            {seen, Group};
        _ ->
            {new, CurrentGroup + 1}
    end.

check_plant_matches_group(Plant, GroupNumber, Labels) ->
    GroupLabel = maps:get(GroupNumber, Labels),
    case GroupLabel =/= Plant of
        true ->
            logger:notice(#{plant => Plant, group_number => GroupNumber, labels => Labels}),
            throw("Group label doesn't match plant");
        false ->
            ok
    end.

look(P, Plant, Garden) ->
    case proplists:get_value(P, Garden, nope) of
        nope ->
            false;
        X when X =:= Plant ->
            true;
        _ ->
            false
    end.

get_all(Look, Pos, Plant, Garden, Set) ->
    case Look of
        false ->
            Set;
        true ->
            case sets:is_element(Pos, Set) of
                true ->
                    Set;
                false ->
                    find_positions(Pos, Plant, Garden, sets:add_element(Pos, Set))
            end
    end.

find_positions({X, Y}, Plant, Garden, Set) ->
    Up = {X + 1, Y},
    Down = {X - 1, Y},
    Left = {X, Y - 1},
    Right = {X, Y + 1},

    LookUp = look(Up, Plant, Garden),
    LookDown = look(Down, Plant, Garden),
    LookLeft = look(Left, Plant, Garden),
    LookRight = look(Right, Plant, Garden),

    UpSet = get_all(LookUp, Up, Plant, Garden, Set),
    DownSet = get_all(LookDown, Down, Plant, Garden, UpSet),
    LeftSet = get_all(LookLeft, Left, Plant, Garden, DownSet),
    RightSet = get_all(LookRight, Right, Plant, Garden, LeftSet),

    RightSet.

count_sides({X, Y}, Plant, Garden) ->
    Positions = [{X, Y + 1}, {X, Y - 1}, {X + 1, Y}, {X - 1, Y}],
    Matches = lists:filter(
        fun(P) ->
            Result = proplists:get_value(P, Garden, nope),
            Result =:= Plant
        end,
        Positions
    ),
    4 - length(Matches).

-spec part_one(_) -> integer().
part_one(Garden) ->
    State =
        lists:foldl(
            fun({Pos, Plant}, State) ->
                %% logger:notice(#{start => Pos}),
                case find_group_number(Pos, State#state.positions, State#state.current_group) of
                    {seen, GroupNumber} ->
                        check_plant_matches_group(Plant, GroupNumber, State#state.labels),
                        Sides = count_sides(Pos, Plant, Garden),
                        NewState = State#state{
                            sides = maps:update_with(
                                GroupNumber, fun(X) -> X + Sides end, State#state.sides
                            ),
                            spaces = maps:update_with(
                                GroupNumber, fun(X) -> X + 1 end, State#state.spaces
                            )
                        },
                        NewState;
                    {new, GroupNumber} ->
                        GroupPositions = find_positions(
                            Pos, Plant, Garden, sets:from_list([Pos], [{version, 2}])
                        ),
                        Sides = count_sides(Pos, Plant, Garden),
                        NewState = State#state{
                            labels = maps:put(GroupNumber, Plant, State#state.labels),
                            sides = maps:put(GroupNumber, Sides, State#state.sides),
                            spaces = maps:put(GroupNumber, 1, State#state.spaces),
                            positions = maps:put(
                                GroupNumber, GroupPositions, State#state.positions
                            ),
                            current_group = GroupNumber
                        },
                        NewState
                end
            end,
            #state{},
            Garden
        ),
    Labels = State#state.labels,
    Sides = State#state.sides,
    Spaces = State#state.spaces,
    maps:fold(
        fun(K, _V, Acc) ->
            Si = maps:get(K, Sides),
            Sp = maps:get(K, Spaces),
            Acc + (Si * Sp)
        end,
        0,
        Labels
    ).

-spec part_two(_) -> integer().
part_two(_Garden) ->
    42.

lex(Input) ->
    {ok, Tokens, _} = lexer_day_12_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_12_2024:parse(Input).
