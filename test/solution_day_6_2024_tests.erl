-module(solution_day_6_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "....#.....\n"
    ".........#\n"
    "..........\n"
    "..#.......\n"
    ".......#..\n"
    "..........\n"
    ".#..^.....\n"
    "........#.\n"
    "#.........\n"
    "......#...\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_6_2024:lex(TestInput),
%%     %% ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_6_2024:parse(Lex),
%%     %% ?LOG(#{parse => Parse}),
%%     ?assertEqual(9, solution_day_6_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-6.txt"),
%%     {ok, Lex} = solution_day_6_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_6_2024:parse(Lex),
%%     ?assertEqual(1900, solution_day_6_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_6_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_6_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(42, solution_day_6_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-6.txt"),
%%     {ok, Lex} = solution_day_6_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_6_2024:parse(Lex),
%%     ?assertEqual(2427, solution_day_6_2024:part_one(Parse)).
