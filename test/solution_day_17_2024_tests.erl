-module(solution_day_17_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "Register A: 729\n"
    "Register B: 0\n"
    "Register C: 0\n"
    "\n"
    "Program: 0,1,5,4,3,0\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_17_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_17_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_17_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_17_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_17_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_17_2024:part_two(Parse)).

%% TODO: Finish day 17
%% part_one_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_17_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_17_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(14, solution_day_17_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_17_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_17_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_17_2024:part_one(Parse)).
