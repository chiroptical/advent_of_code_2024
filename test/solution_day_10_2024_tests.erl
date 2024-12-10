-module(solution_day_10_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "89010123\n"
    "78121874\n"
    "87430965\n"
    "96549874\n"
    "45678903\n"
    "32019012\n"
    "01329801\n"
    "10456732\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_10_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_10_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_10_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-10.txt"),
%%     {ok, Lex} = solution_day_10_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_10_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_10_2024:part_two(Parse)).

part_one_test() ->
    TestInput = test_input(),
    {ok, Lex} = solution_day_10_2024:lex(TestInput),
    ?LOG(#{lex => Lex}),
    {ok, Parse} = solution_day_10_2024:parse(Lex),
    ?LOG(#{parse => Parse}),
    ?assertEqual(42, solution_day_10_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-10.txt"),
%%     {ok, Lex} = solution_day_10_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_10_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_10_2024:part_one(Parse)).
