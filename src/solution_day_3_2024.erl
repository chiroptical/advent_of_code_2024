-module(solution_day_3_2024).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_3_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_3_2024:parse(Input).

-spec multiply_and_sum(list(integer())) -> integer().
multiply_and_sum(Inp) ->
    lists:foldl(
        fun(Item, Acc) ->
            case Item of
                {operands, {X, Y}} ->
                    Acc + X * Y;
                enable ->
                    Acc;
                disable ->
                    Acc
            end
        end,
        0,
        Inp
    ).

-spec multiply_and_sum_with_mode(list(integer())) -> integer().
multiply_and_sum_with_mode(Inp) ->
    lists:foldl(
        fun(Item, {Mode, Sum}) ->
            case Item of
                {operands, {X, Y}} ->
                    case Mode of
                        enable ->
                            {Mode, Sum + X * Y};
                        disable ->
                            {Mode, Sum}
                    end;
                enable ->
                    {Item, Sum};
                disable ->
                    {Item, Sum}
            end
        end,
        {enable, 0},
        Inp
    ).

-spec part_one(list(list(integer()))) -> integer().
part_one(Input) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + multiply_and_sum(X)
        end,
        0,
        Input
    ).

-spec part_two(_) -> integer().
part_two(Input) ->
    lists:foldl(
        fun(X, Acc) ->
            {_Mode, Sum} = multiply_and_sum_with_mode(X),
            Acc + Sum
        end,
        0,
        Input
    ).
