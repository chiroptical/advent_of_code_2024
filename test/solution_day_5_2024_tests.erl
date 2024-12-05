-module(solution_day_5_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, true).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "47|53\n"
    "97|13\n"
    "97|61\n"
    "97|47\n"
    "75|29\n"
    "61|13\n"
    "75|53\n"
    "29|13\n"
    "97|29\n"
    "53|29\n"
    "61|53\n"
    "97|53\n"
    "61|29\n"
    "47|13\n"
    "75|47\n"
    "97|75\n"
    "47|61\n"
    "75|61\n"
    "47|29\n"
    "75|13\n"
    "53|13\n"
    "\n"
    "75,47,61,53,29\n"
    "97,61,53,29,13\n"
    "75,29,13\n"
    "75,97,47,61,53\n"
    "61,13,29\n"
    "97,13,75,29,47\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_5_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_5_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(9, solution_day_5_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-5.txt"),
%%     {ok, Lex} = solution_day_5_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_5_2024:parse(Lex),
%%     ?assertEqual(1900, solution_day_5_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_5_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_5_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(18, solution_day_5_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-5.txt"),
%%     {ok, Lex} = solution_day_5_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_5_2024:parse(Lex),
%%     ?assertEqual(2427, solution_day_5_2024:part_one(Parse)).
