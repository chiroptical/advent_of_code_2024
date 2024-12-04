-module(solution_day_4_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "MMMSXXMASM\n"
    "MSAMXMSMSA\n"
    "AMXSXMAAMM\n"
    "MSAMASMSMX\n"
    "XMASAMXAMM\n"
    "XXAMMXXAMA\n"
    "SMSMSASXSS\n"
    "SAXAMASAAA\n"
    "MAMMMXMMMM\n"
    "MXMXAXMASX\n".

%% part_two_test() ->
%%     TestInput = test_input(),

%%     {ok, Lex} = solution_day_4_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),

%%     {ok, Parse} = solution_day_4_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),

%%     ?assertEqual(4, solution_day_4_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-2.txt"),
%%     {ok, Lex} = solution_day_4_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_4_2024:parse(Lex),
%%     ?assertEqual(455, solution_day_4_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),

    {ok, Lex} = solution_day_4_2024:lex(TestInput),
    %% ?LOG(#{lex => Lex}),

    {ok, Parse} = solution_day_4_2024:parse(Lex),
    %% ?LOG(#{parse => Parse}),

    ?assertEqual(18, solution_day_4_2024:part_one(Parse)).

part_one_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-4.txt"),
    {ok, Lex} = solution_day_4_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_4_2024:parse(Lex),
    ?assertEqual(2427, solution_day_4_2024:part_one(Parse)).
