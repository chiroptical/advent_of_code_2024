-module(solution_day_9_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() -> "2333133121414131402".

%% TODO: Use part_one_solution_test_ as an example to get run this test without timing out
%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_9_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_9_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_9_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-9.txt"),
%%     {ok, Lex} = solution_day_9_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_9_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_9_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_9_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_9_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(1928, solution_day_9_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-9.txt"),
%%     {ok, Lex} = solution_day_9_2024:lex(string:trim(binary_to_list(Input))),
%%     {ok, Parse} = solution_day_9_2024:parse(Lex),
%%     ?assertEqual(6399153661894, solution_day_9_2024:part_one(Parse)).
