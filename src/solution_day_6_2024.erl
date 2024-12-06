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

step(_Positions, _GuardPosition, SeenPositions) ->
    {done, SeenPositions}.

walk(Positions, GuardPosition) ->
    case step(Positions, GuardPosition, maps:new()) of
        {continue, NextPositions, CurrentGuardPositions, SeenPositions} ->
            step(NextPositions, CurrentGuardPositions, SeenPositions);
        {done, SeenPositions} ->
            maps:size(SeenPositions)
    end.

-spec part_one(_) -> integer().
part_one(Input) ->
    InputPositions = maps:from_list(Input),
    {ok, GuardPosition} = find_starting_position(InputPositions),
    logger:notice(#{guard_position => GuardPosition}),
    walk(InputPositions, GuardPosition).

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.
