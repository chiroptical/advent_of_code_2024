-module(solution_day_1_2024).

-export([
    scan/1,
    parse/1,
    test_input/0,
    part_one_test/0,
    part_one/0,
    part_two_test/0,
    part_two/0
]).

-define(DEBUG, false).

scan(Input) ->
    {ok, Tokens, _} = lexer_day_1_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_1_2024:parse(Input).

% NOTE: Unable to use """ """ here because the formatter doesn't support it
test_input() ->
    "3   4\n"
    "4   3\n"
    "2   5\n"
    "1   3\n"
    "3   9\n"
    "3   3\n".

handle_input(Input) when is_binary(Input) ->
    {ok, Leex} = scan(binary_to_list(Input)),
    {ok, Yecc} = parse(Leex),
    lists:unzip(Yecc);
handle_input(Input) ->
    {ok, Leex} = scan(Input),
    with:log(?DEBUG, #{leex => Leex}),
    {ok, Yecc} = parse(Leex),
    with:log(?DEBUG, #{yecc => Yecc}),
    lists:unzip(Yecc).

part_one_test() ->
    {Left, Right} = handle_input(test_input()),

    SortLeft = lists:sort(Left),
    SortRight = lists:sort(Right),
    with:log(?DEBUG, #{sort_left => SortLeft, sort_right => SortRight}),

    Differences = lists:zipwith(fun(X, Y) -> abs(Y - X) end, SortLeft, SortRight),
    lists:sum(Differences).

part_one() ->
    {ok, Input} = file:read_file("inputs/2024-day-1.txt"),
    {Left, Right} = handle_input(Input),

    SortLeft = lists:sort(Left),
    SortRight = lists:sort(Right),

    Differences = lists:zipwith(fun(X, Y) -> abs(Y - X) end, SortLeft, SortRight),

    lists:sum(Differences).

part_two_test() ->
    {Left, Right} = handle_input(test_input()),

    Groups = maps:groups_from_list(fun(X) -> X end, Right),
    with:log(?DEBUG, #{groups => Groups}),
    Counts = maps:map(fun(_, X) -> length(X) end, Groups),
    with:log(?DEBUG, #{counts => Counts}),

    % Note: both folds take (X, Acc) as function input!
    lists:foldl(fun(X, Acc) -> Acc + X * maps:get(X, Counts, 0) end, 0, Left).

part_two() ->
    {ok, Input} = file:read_file("inputs/2024-day-1.txt"),
    {Left, Right} = handle_input(Input),

    Groups = maps:groups_from_list(fun(X) -> X end, Right),
    Counts = maps:map(fun(_, X) -> length(X) end, Groups),

    % Note: both folds take (X, Acc) as function input!
    lists:foldl(fun(X, Acc) -> Acc + X * maps:get(X, Counts, 0) end, 0, Left).
