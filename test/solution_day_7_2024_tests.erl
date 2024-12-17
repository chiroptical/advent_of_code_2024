-module(solution_day_7_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

% NOTE: the solutions are pretty slow here so I don't want to run them every time

test_input() ->
    "190: 10 19\n"
    "3267: 81 40 27\n"
    "83: 17 5\n"
    "156: 15 6\n"
    "7290: 6 8 6 15\n"
    "161011: 16 10 13\n"
    "192: 17 8 14\n"
    "21037: 9 7 18 13\n"
    "292: 11 6 16 20\n".

part_two_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_7_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_7_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(11387, solution_day_7_2024:part_two(Parse)).

%% TODO: Use part_one_solution_test_ as an example to get run this test without timing out
%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-7.txt"),
%%     {ok, Lex} = solution_day_7_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_7_2024:parse(Lex),
%%     ?assertEqual(105517128211543, solution_day_7_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_7_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_7_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(3749, solution_day_7_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-7.txt"),
%%     {ok, Lex} = solution_day_7_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_7_2024:parse(Lex),
%%     ?assertEqual(3245122495150, solution_day_7_2024:part_one(Parse)).
