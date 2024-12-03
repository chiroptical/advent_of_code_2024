-module(list_utils_tests).

-include_lib("eunit/include/eunit.hrl").

take_length_test() ->
    Input = [1, 2, 3],
    Length = length(Input),
    ?assertEqual([1, 2, 3], list_utils:take(Length, Input)).

take_too_many_test() ->
    Input = [1, 2, 3],
    ?assertEqual([1, 2, 3], list_utils:take(6, Input)).

take_empty_test() ->
    ?assertEqual([], list_utils:take(1, [])).

take_two_test() ->
    ?assertEqual([1, 2], list_utils:take(2, [1, 2, 3])).

window_short_test() ->
    Input = [1],
    ?assertEqual([], list_utils:window(2, Input)).

window_one_test() ->
    Input = [1, 2, 3],
    Output = [[1], [2], [3]],
    ?assertEqual(Output, list_utils:window(1, Input)).

window_two_test() ->
    Input = [1, 2, 3],
    Output = [[1, 2], [2, 3]],
    ?assertEqual(Output, list_utils:window(2, Input)).

window_three_test() ->
    Input = [1, 2, 3],
    Output = [[1, 2, 3]],
    ?assertEqual(Output, list_utils:window(3, Input)).

