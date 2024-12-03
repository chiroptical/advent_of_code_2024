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
        fun({X, Y}, Acc) ->
            Acc + X * Y
        end,
        0,
        Inp
    ).

%% -spec multiply_and_sum(list(integer()), file:io_device()) -> integer().
%% multiply_and_sum(Inp, Io) ->
%%     lists:foldl(
%%         fun ({X, Y}, Acc) ->
%%             io:format(Io, "~B ~B: ~B~n", [X, Y, X * Y]),
%%             Acc + X * Y
%%         end,
%%         0,
%%         Inp
%%     ).

-spec part_one(list(list(integer()))) -> integer().
part_one(Input) ->
    %% {ok, Io} = file:open("debugging/erlang-debug.txt", [write]),
    lists:foldl(
        fun(X, Acc) ->
            Acc + multiply_and_sum(X)
        end,
        0,
        Input
    ).

-spec part_two(_) -> integer().
part_two(_Input) ->
    42.
