-module(solution_day_3_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

simple_test() ->
    TestInput = "mul(2,3)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(6, solution_day_3_2024:part_one(Parse)).

spaces_test() ->
    TestInput = "mul ( 2 , 4 )\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

incomplete_one_test() ->
    TestInput = "mul(4*\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

incomplete_two_test() ->
    TestInput = "mul(6,9!\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

incomplete_three_test() ->
    TestInput = "?(12,34)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

too_large_test() ->
    TestInput = "mul(1234,3456)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

first_too_large_test() ->
    TestInput = "mul(1234,3)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

second_too_large_test() ->
    TestInput = "mul(1,1234)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(0, solution_day_3_2024:part_one(Parse)).

part_one_test() ->
    TestInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(161, solution_day_3_2024:part_one(Parse)).

part_one_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-3.txt"),
    {ok, Lex} = solution_day_3_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    % This isn't the correct number
    ?assertNotEqual(182949745, solution_day_3_2024:part_one(Parse)).
