-module(solution_day_13_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "Button A: X+94, Y+34\n"
    "Button B: X+22, Y+67\n"
    "Prize: X=8400, Y=5400\n"
    "\n"
    "Button A: X+26, Y+66\n"
    "Button B: X+67, Y+21\n"
    "Prize: X=12748, Y=12176\n"
    "\n"
    "Button A: X+17, Y+86\n"
    "Button B: X+84, Y+37\n"
    "Prize: X=7870, Y=6450\n"
    "\n"
    "Button A: X+69, Y+23\n"
    "Button B: X+27, Y+71\n"
    "Prize: X=18641, Y=10279\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_13_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_13_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_13_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_13_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_13_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_13_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_13_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_13_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(14, solution_day_13_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_13_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_13_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_13_2024:part_one(Parse)).
