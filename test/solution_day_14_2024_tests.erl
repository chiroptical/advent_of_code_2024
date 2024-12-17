-module(solution_day_14_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "p=0,4 v=3,-3\n"
    "p=6,3 v=-1,-3\n"
    "p=10,3 v=-1,2\n"
    "p=2,0 v=2,-1\n"
    "p=0,0 v=1,3\n"
    "p=3,0 v=-2,-2\n"
    "p=7,6 v=-1,-3\n"
    "p=3,0 v=-1,-2\n"
    "p=9,3 v=2,3\n"
    "p=7,3 v=-1,2\n"
    "p=2,4 v=2,-3\n"
    "p=9,5 v=-3,-3\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_14_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_14_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_14_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_14_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_14_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_14_2024:part_two(Parse)).

%% TODO: Finish Day 14
%% part_one_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_14_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_14_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(14, solution_day_14_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_14_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_14_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_14_2024:part_one(Parse)).
