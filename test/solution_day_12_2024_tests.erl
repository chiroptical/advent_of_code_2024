-module(solution_day_12_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
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
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_12_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_12_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_12_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(14, solution_day_12_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_12_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_12_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_12_2024:part_one(Parse)).

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
        {[], 4},
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

count_sides_one_match_test() ->
    M = [{{1, 1}, "X"}, {{1, 2}, "X"}],
    ?assertEqual(
        {[{1, 2}], 3},
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

count_sides_no_match_test() ->
    M = [{{1, 1}, "X"}, {{1, 2}, "Y"}],
    ?assertEqual(
        {[], 4},
        solution_day_12_2024:count_sides({1, 1}, "X", M)
    ).

find_positions_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    Result = solution_day_12_2024:find_positions({8, 3}, "I", Parse, sets:from_list([{8, 3}])),
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
        ]
    ),
    ?assert(sets:is_equal(Expected, Result)).

find_positions_one_seven_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_12_2024:lex(TestInput),
    {ok, Parse} = solution_day_12_2024:parse(Lex),
    Result = solution_day_12_2024:find_positions({1, 7}, "C", Parse, sets:from_list([{1, 7}])),
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
        ]
    ),
    ?assert(sets:is_equal(Expected, Result)).
