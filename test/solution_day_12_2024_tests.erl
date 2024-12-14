-module(solution_day_12_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

%% TODO: figure out how to define this properly
-ifdef(run_slow_tests).
-define(RUN(X), X).
-else.
-define(RUN(X), ?_assert(true)).
-endif.

test_input() ->
    "RRRRIICCFF\n"
    "RRRRIICCCF\n"
    "VVRRRCCFFF\n"
    "VVRCCCJFFF\n"
    "VVVVCJJCFE\n"
    "VVIVCCJJEE\n"
    "VVIIICJJEE\n"
    "MIIIIIJJEE\n"
    "MIIISIJEEE\n"
    "MMMISSJEEE\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_12_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_12_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_12_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-12.txt"),
%%     {ok, Lex} = solution_day_12_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_12_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_12_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(1930, solution_day_12_2024:part_one(Parse)).

%% This is called a "Test Generator", https://learnyousomeerlang.com/eunit
%% has good information on these. The only thing you need to do is use
%% ?_assert... instead. Note, this doesn't have _test, we are going to use
%% it below.
part_one_solution() ->
    {ok, Input} = file:read_file("inputs/2024-day-12.txt"),
    {ok, Lex} = solution_day_12_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    ?_assertEqual(1381056, solution_day_12_2024:part_one(Parse)).

part_one_solution_test_() ->
    {setup, fun() -> ok end, fun(_) ->
        {
            timeout,
            60,
            [?RUN(part_one_solution())]
        }
    end}.

find_group_empty_test() ->
    M = maps:new(),
    Pos = {1, 1},
    ?assertEqual(
        {new, 1},
        solution_day_12_2024:find_group_number(Pos, M, 0)
    ).

find_group_exists_test() ->
    M = maps:from_list([{1, sets:from_list([{1, 1}])}]),
    Pos = {1, 1},
    ?assertEqual(
        {seen, 1},
        solution_day_12_2024:find_group_number(Pos, M, 1)
    ).

count_sides_empty_test() ->
    M = [{{1, 1}, "X"}],
    ?assertEqual(
        4,
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

count_sides_one_match_test() ->
    M = [{{1, 1}, "X"}, {{1, 2}, "X"}],
    ?assertEqual(
        3,
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

count_sides_no_match_test() ->
    M = [{{1, 1}, "X"}, {{1, 2}, "Y"}],
    ?assertEqual(
        4,
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

find_positions_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    Start = {8, 3},
    Result = solution_day_12_2024:find_positions(
        Start,
        "I",
        Parse,
        sets:from_list(
            [Start],
            [{version, 2}]
        )
    ),
    Expected = sets:from_list(
        [
            {6, 3},
            {7, 3},
            {7, 4},
            {7, 5},
            {8, 2},
            {8, 3},
            {8, 4},
            {8, 5},
            {8, 6},
            {9, 2},
            {9, 3},
            {9, 4},
            {9, 6},
            {10, 4}
        ],
        [{version, 2}]
    ),
    ?assert(Expected =:= Result).

find_positions_one_seven_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    Start = {1, 7},
    Result = solution_day_12_2024:find_positions(
        Start,
        "C",
        Parse,
        sets:from_list([Start], [{version, 2}])
    ),
    Expected = sets:from_list(
        [
            {1, 7},
            {1, 8},
            {2, 7},
            {2, 8},
            {2, 9},
            {3, 6},
            {3, 7},
            {4, 4},
            {4, 5},
            {4, 6},
            {5, 5},
            {6, 5},
            {6, 6},
            {7, 6}
        ],
        [{version, 2}]
    ),
    ?assert(Expected =:= Result).

find_positions_group_two_test() ->
    Input =
        "WWWWWWEEEEEEEEEEEEEEHHH\n"
        "WWWWWWEEEEEEEEEEEEHHHHH\n"
        "WWWMWWEEEEEEEEEEEEHHHHH\n"
        "WWMMWWEEEEEEEEEEEEEHHHH\n"
        "MMMWWEEEEEEEEEEMMEHHHHH\n"
        "MMMEEEEEEEEEEEMMMEMHHHH\n"
        "MMMEEEEEEEEEMMMMMMMHHHH\n"
        "MMMMEEEEEEMMMMMMMMMMHHH\n"
        "MMEEEEEEEEMMMMMMMMMMHHU\n"
        "MMMEEEEEKEMMMMMMMMMMMHH\n"
        "MMMEMEEEECMMMMMMMMMMMHH\n"
        "MMMMMMMMMMMMMMMMMMMUUHU\n",
    {ok, Lex} = solution_day_12_2024:lex(Input),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    solution_day_12_2024:find_positions(
        {1, 7},
        "E",
        Parse,
        sets:from_list([{1, 7}], [{version, 2}])
    ),
    ok.
