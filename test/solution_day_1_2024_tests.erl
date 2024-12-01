-module(solution_day_1_2024_tests).
-include_lib("eunit/include/eunit.hrl").

part_one_test(_Config) ->
    ?assert(solution_day_1_2024:part_one_test() =:= 11),
    ?assert(solution_day_1_2024:part_one() =:= 2031679).

part_two_test(_Config) ->
    ?assert(solution_day_1_2024:part_two_test() =:= 31),
    ?assert(solution_day_1_2024:part_two() =:= 19678534).
