-module(solution_day_9_2024).

-export([
    part_one/1,
    part_two/1,
    lex/1,
    parse/1
]).

to_dense(Sparse) ->
    {Dense, NextIndex} =
        lists:foldl(
            fun(Elem, {Acc, Idx}) ->
                case Elem of
                    {file, Count} ->
                        Add = queue:from_list(lists:duplicate(Count, {some, Idx})),
                        {queue:join(Acc, Add), Idx + 1};
                    {free_space, Count} ->
                        Add = queue:from_list(lists:duplicate(Count, none)),
                        {queue:join(Acc, Add), Idx}
                end
            end,
            {queue:new(), 0},
            Sparse
        ),
    {Dense, NextIndex - 1}.

find_last(Q) ->
    case queue:out_r(Q) of
        {{value, {some, X}}, Rest} ->
            {X, Rest};
        {empty, _} ->
            empty;
        {{value, none}, Rest} ->
            find_last(Rest)
    end.

solve_one(Q, Acc) ->
    case queue:out(Q) of
        {{value, {some, X}}, Rest} ->
            solve_one(Rest, queue:in(X, Acc));
        {{value, none}, Rest} ->
            case find_last(Rest) of
                empty ->
                    Acc;
                {X, Continue} ->
                    solve_one(Continue, queue:in(X, Acc))
            end;
        {empty, _} ->
            Acc
    end.

-spec part_one(_) -> integer().
part_one(Sparse) ->
    {Dense, _} = to_dense(Sparse),
    Result = solve_one(Dense, queue:new()),
    {Acc, _} = lists:foldl(
        fun(Elem, {Acc, Idx}) ->
            {Acc + (Elem * Idx), Idx + 1}
        end,
        {0, 0},
        queue:to_list(Result)
    ),
    Acc.

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.

lex(Input) ->
    {ok, Tokens, _} = lexer_day_9_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_9_2024:parse(Input).
