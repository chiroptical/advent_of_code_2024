-module(solution_day_15_2024_tests).

-include_lib("eunit/include/eunit.hrl").

-define(DEBUG, false).

-if(?DEBUG =:= true).
-define(LOG(X), logger:notice(X)).
-else.
-define(LOG(X), ok).
-endif.

test_input() ->
    "##########\n"
    "#..O..O.O#\n"
    "#......O.#\n"
    "#.OO..O.O#\n"
    "#..O@..O.#\n"
    "#O#..O...#\n"
    "#O..O..O.#\n"
    "#.OO.O.OO#\n"
    "#....O...#\n"
    "##########\n"
    "\n"
    "<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^\n"
    "vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v\n"
    "><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<\n"
    "<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^\n"
    "^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><\n"
    "^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^\n"
    ">^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^\n"
    "<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>\n"
    "^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>\n"
    "v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^\n".

%% part_two_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_15_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_15_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(34, solution_day_15_2024:part_two(Parse)).

%% part_two_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_15_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_15_2024:parse(Lex),
%%     ?assertEqual(1229, solution_day_15_2024:part_two(Parse)).

%% TODO: Finish day 15
%% part_one_test() ->
%%     TestInput = test_input(),
%%     {ok, Lex} = solution_day_15_2024:lex(TestInput),
%%     ?LOG(#{lex => Lex}),
%%     {ok, Parse} = solution_day_15_2024:parse(Lex),
%%     ?LOG(#{parse => Parse}),
%%     ?assertEqual(14, solution_day_15_2024:part_one(Parse)).

%% part_one_solution_test() ->
%%     {ok, Input} = file:read_file("inputs/2024-day-8.txt"),
%%     {ok, Lex} = solution_day_15_2024:lex(binary_to_list(Input)),
%%     {ok, Parse} = solution_day_15_2024:parse(Lex),
%%     ?assertEqual(371, solution_day_15_2024:part_one(Parse)).
