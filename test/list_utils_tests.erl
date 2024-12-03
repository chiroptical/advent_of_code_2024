-module(list_utils_tests).

-include_lib("eunit/include/eunit.hrl").

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
