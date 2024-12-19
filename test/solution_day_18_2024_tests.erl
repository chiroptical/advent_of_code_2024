-module(solution_day_18_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "5,4\n"
    "4,2\n"
    "4,5\n"
    "3,0\n"
    "2,1\n"
    "6,3\n"
    "2,4\n"
    "1,5\n"
    "0,6\n"
    "3,3\n"
    "2,6\n"
    "5,1\n"
    "1,2\n"
    "5,5\n"
    "2,5\n"
    "6,5\n"
    "1,4\n"
    "0,4\n"
    "6,4\n"
    "1,1\n"
    "6,1\n"
    "1,0\n"
    "0,5\n"
    "1,6\n"
    "2,0\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_18_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_18_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_18_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_18_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_18_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_18_2024:part_two(Parse)).

%% TODO: Finish day 18
%% part_one_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_18_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_18_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(14, solution_day_18_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_18_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_18_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_18_2024:part_one(Parse)).
