-module(solution_day_11_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "125 17\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_11_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_11_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_11_2024:part_two(Parse)).

%% This one times out eunit :rofl:
%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-11.txt"),
%%     {ok, Lex} = solution_day_11_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_11_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_11_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_11_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_11_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(55312, solution_day_11_2024:part_one(Parse)).

part_one_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-11.txt"),
    {ok, Lex} = solution_day_11_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_11_2024:parse(Lex),
    ?assertEqual(189167, solution_day_11_2024:part_one(Parse)).
