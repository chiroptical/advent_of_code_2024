-module(solution_day_4_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_4_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_4_2024:parse(Input).

%% TODO: would be nice to describe these as a list of kernels
get_right({Row, Col}, Xmas) ->
    X = maps:get({Row, Col + 1}, Xmas, none),
    Y = maps:get({Row, Col + 2}, Xmas, none),
    Z = maps:get({Row, Col + 3}, Xmas, none),
    [X, Y, Z].

get_down({Row, Col}, Xmas) ->
    X = maps:get({Row + 1, Col}, Xmas, none),
    Y = maps:get({Row + 2, Col}, Xmas, none),
    Z = maps:get({Row + 3, Col}, Xmas, none),
    [X, Y, Z].

get_positive_diagonal({Row, Col}, Xmas) ->
    X = maps:get({Row + 1, Col + 1}, Xmas, none),
    Y = maps:get({Row + 2, Col + 2}, Xmas, none),
    Z = maps:get({Row + 3, Col + 3}, Xmas, none),
    [X, Y, Z].

get_negative_diagonal({Row, Col}, Xmas) ->
    X = maps:get({Row + 1, Col - 1}, Xmas, none),
    Y = maps:get({Row + 2, Col - 2}, Xmas, none),
    Z = maps:get({Row + 3, Col - 3}, Xmas, none),
    [X, Y, Z].

get_x({Row, Col}, Xmas) ->
    A = maps:get({Row - 1, Col - 1}, Xmas, none),
    B = maps:get({Row + 1, Col + 1}, Xmas, none),
    C = maps:get({Row - 1, Col + 1}, Xmas, none),
    D = maps:get({Row + 1, Col - 1}, Xmas, none),
    [{A, B}, {C, D}].

search(Key, Xmas, Compare) ->
    Right = get_right(Key, Xmas),
    Down = get_down(Key, Xmas),
    PosDiagonal = get_positive_diagonal(Key, Xmas),
    NegDiagonal = get_negative_diagonal(Key, Xmas),
    lists:foldl(
        fun(X, Acc) ->
            case X =:= Compare of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        [Right, Down, PosDiagonal, NegDiagonal]
    ).

search_xmas(Key, Xmas) ->
    search(Key, Xmas, ["M", "A", "S"]).

search_samx(Key, Xmas) ->
    search(Key, Xmas, ["A", "M", "X"]).

check(X) ->
    (X =:= {"M", "S"}) or (X =:= {"S", "M"}).

search_cross(Key, Xmas) ->
    [X, Y] = get_x(Key, Xmas),
    case check(X) and check(Y) of
        true -> 1;
        false -> 0
    end.

-spec part_one(list(list(string()))) -> integer().
part_one(Input) ->
    Xmas = maps:from_list(Input),
    maps:fold(
        fun(Key, Value, Acc) ->
            case Value of
                "X" ->
                    Acc + search_xmas(Key, Xmas);
                "S" ->
                    Acc + search_samx(Key, Xmas);
                _ ->
                    Acc
            end
        end,
        0,
        Xmas
    ).

-spec part_two(list(list(string()))) -> integer().
part_two(Input) ->
    Xmas = maps:from_list(Input),
    maps:fold(
        fun(Key, Value, Acc) ->
            case Value of
                "A" ->
                    Acc + search_cross(Key, Xmas);
                _ ->
                    Acc
            end
        end,
        0,
        Xmas
    ).
