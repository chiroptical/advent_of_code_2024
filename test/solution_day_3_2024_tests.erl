-module(solution_day_3_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

random_one_test() ->
    TestInput = "select()% mul(41,999)&mul(615,164)/%[-#*&}mul(488,200)what\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(239419, solution_day_3_2024:part_one(Parse)).

nested_test() ->
    TestInput = "mul(41,mul(2,3))\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(6, solution_day_3_2024:part_one(Parse)).

next_to_eachother_test() ->
    TestInput = "mul(2,3)mul(2,3)\n",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(12, solution_day_3_2024:part_one(Parse)).

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

ancomplete_one_test() ->
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

issues_test() ->
    TestInput = "mul(690,168*),mulwhen(16,622),mulwho(185,234)",
    {ok, Lex} = solution_day_3_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
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
    ?assertEqual(182780583, solution_day_3_2024:part_one(Parse)).

part_two_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-3.txt"),
    {ok, Lex} = solution_day_3_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_3_2024:parse(Lex),
    ?assertEqual(90772405, solution_day_3_2024:part_two(Parse)).
