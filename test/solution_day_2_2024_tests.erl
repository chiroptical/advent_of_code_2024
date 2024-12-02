-module(solution_day_2_2024_tests).
-include("solution_day_2_2024.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

part_two_test() ->
    TestInput =
        "7 6 4 2 1\n"
        "1 2 7 8 9\n"
        "9 7 6 2 1\n"
        "1 3 2 4 5\n"
        "8 6 4 4 1\n"
        "1 3 6 7 9\n",

    {ok, Lex} = solution_day_2_2024:lex(TestInput),
    with:log(?DEBUG, #{lex => Lex}),

    {ok, Parse} = solution_day_2_2024:parse(Lex),
    with:log(?DEBUG, #{parse => Parse}),

    ?assertEqual(4, solution_day_2_2024:part_two(Parse)).

part_two_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-2.txt"),
    {ok, Lex} = solution_day_2_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_2_2024:parse(Lex),
    ?assertEqual(455, solution_day_2_2024:part_two(Parse)).

evaluate_rules_with_dampener_test() ->
    Input = [52, 50, 48, 45, 48],
    ?assertEqual(true, solution_day_2_2024:evaluate_rules_with_dampener(Input, 1, #rules{})).

part_one_test() ->
    TestInput =
        "7 6 4 2 1\n"
        "1 2 7 8 9\n"
        "9 7 6 2 1\n"
        "1 3 2 4 5\n"
        "8 6 4 4 1\n"
        "1 3 6 7 9\n",

    {ok, Lex} = solution_day_2_2024:lex(TestInput),
    with:log(?DEBUG, #{lex => Lex}),

    {ok, Parse} = solution_day_2_2024:parse(Lex),
    with:log(?DEBUG, #{parse => Parse}),

    ?assertEqual(2, solution_day_2_2024:part_one(Parse)).

part_one_solution_test() ->
    {ok, Input} = file:read_file("inputs/2024-day-2.txt"),
    {ok, Lex} = solution_day_2_2024:lex(binary_to_list(Input)),
    {ok, Parse} = solution_day_2_2024:parse(Lex),
    ?assertEqual(402, solution_day_2_2024:part_one(Parse)).

evaluate_rules_increasing_works_test() ->
    ?assertEqual(
        #rules{increases = true, decreases = false},
        solution_day_2_2024:evaluate_rules(
            [1, 2, 3],
            #rules{increases = true, decreases = true}
        )
    ).

evaluate_rules_decreasing_works_test() ->
    ?assertEqual(
        #rules{increases = false, decreases = true},
        solution_day_2_2024:evaluate_rules(
            [3, 2, 1],
            #rules{increases = true, decreases = true}
        )
    ).

evaluate_rules_sames_fails_test() ->
    ?assertEqual(
        #rules{increases = false, decreases = false},
        solution_day_2_2024:evaluate_rules(
            [1, 1, 1],
            #rules{increases = true, decreases = true}
        )
    ).

evaluate_rules_large_change_fails_test() ->
    ?assertEqual(
        #rules{increases = false, decreases = false},
        solution_day_2_2024:evaluate_rules(
            [1, 7, 15],
            #rules{increases = true, decreases = true}
        )
    ).

increasing_rule_test() ->
    ?assertEqual(
        true,
        solution_day_2_2024:increasing_rule(1, 2)
    ).

increasing_rule_same_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:increasing_rule(1, 1)
    ).

increasing_rule_more_than_three_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:increasing_rule(1, 5)
    ).

increasing_rule_decreasing_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:increasing_rule(2, 1)
    ).

decreasing_rule_test() ->
    ?assertEqual(
        true,
        solution_day_2_2024:decreasing_rule(2, 1)
    ).

decreasing_rule_same_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:decreasing_rule(1, 1)
    ).

decreasing_rule_more_than_three_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:decreasing_rule(5, 1)
    ).

decreasing_rule_increasing_test() ->
    ?assertEqual(
        false,
        solution_day_2_2024:decreasing_rule(1, 2)
    ).
