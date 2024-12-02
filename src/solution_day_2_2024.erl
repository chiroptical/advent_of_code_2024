-module(solution_day_2_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-include("solution_day_2_2024.hrl").

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1,
    increasing_rule/2,
    decreasing_rule/2,
    evaluate_rules/2,
    evaluate_rules_with_dampener/3
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_2_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_2_2024:parse(Input).

-spec rule(integer(), integer(), function()) -> boolean().
rule(X, Y, Fun) ->
    maybe
        ok ?= case Fun(X, Y) of
            true -> ok;
            false -> error
            end,
        ok ?= case abs(Y - X) < 4 of
            true -> ok;
            false -> error
            end,
        true
    else
        error -> false
    end.

-spec increasing_rule(integer(), integer()) -> boolean().
increasing_rule(X, Y) ->
    rule(X, Y, fun(A, B) -> A < B end).

-spec decreasing_rule(integer(), integer()) -> boolean().
decreasing_rule(X, Y) ->
    rule(X, Y, fun(A, B) -> A > B end).

-spec evaluate_rules(list(integer()), #rules{}) -> #rules{}.
evaluate_rules(_, Rules = #rules{increases = false, decreases = false}) ->
    Rules;
evaluate_rules([_X], Rules) ->
    Rules;
evaluate_rules([], Rules) ->
    Rules;
evaluate_rules([X, Y | Rest], Rules = #rules{increases = true, decreases = false}) ->
    evaluate_rules(
        [Y | Rest],
        Rules#rules{increases = increasing_rule(X, Y)}
    );
evaluate_rules([X, Y | Rest], Rules = #rules{increases = false, decreases = true}) ->
    evaluate_rules(
        [Y | Rest],
        Rules#rules{decreases = decreasing_rule(X, Y)}
    );
evaluate_rules([X, Y | Rest], #rules{increases = true, decreases = true}) ->
    evaluate_rules(
        [Y | Rest],
        #rules{
            increases = increasing_rule(X, Y),
            decreases = decreasing_rule(X, Y)
        }
    ).

-spec part_one(list(list(integer()))) -> integer().
part_one(Input) ->
    lists:foldl(
        fun(X, Acc) ->
            case evaluate_rules(X, #rules{}) of
                #rules{decreases = false, increases = false} ->
                    Acc;
                _ ->
                    Acc + 1
            end
        end,
        0,
        Input
    ).

-spec drop_nth_inner(pos_integer(), list(), queue:queue()) -> list().
drop_nth_inner(1, [_Head | Tail], Acc) ->
    lists:append(queue:to_list(Acc), Tail);
drop_nth_inner(_N, [], Acc) ->
    queue:to_list(Acc);
drop_nth_inner(N, [Head | Tail], Acc) ->
    drop_nth_inner(N - 1, Tail, queue:in(Head, Acc)).

-spec drop_nth(pos_integer(), list()) -> list().
drop_nth(N, X) ->
    drop_nth_inner(N, X, queue:new()).

-spec evaluate_rules_with_dampener(list(integer()), pos_integer(), #rules{}) -> boolean().
evaluate_rules_with_dampener(Input, N, Rules = #rules{}) ->
    case N > length(Input) of
        true ->
            %% if we reach the end of the list, we didn't evaluate anything to true
            false;
        false ->
            NewList = drop_nth(N, Input),
            case evaluate_rules(NewList, #rules{}) of
                #rules{increases = true} ->
                    true;
                #rules{decreases = true} ->
                    true;
                _ ->
                    evaluate_rules_with_dampener(Input, N + 1, Rules)
            end
    end.

-spec part_two(list(list(integer()))) -> integer().
part_two(Input) ->
    lists:foldl(
        fun(X, Acc) ->
            case evaluate_rules(X, #rules{}) of
                #rules{decreases = false, increases = false} ->
                    case evaluate_rules_with_dampener(X, 1, #rules{}) of
                        true -> Acc + 1;
                        false -> Acc
                    end;
                _ ->
                    Acc + 1
            end
        end,
        0,
        Input
    ).
