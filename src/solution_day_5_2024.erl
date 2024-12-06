-module(solution_day_5_2024).

% NOTE: this makes the LSP happy, but shouldn't be necessary
-feature(maybe_expr, enable).

-export([
    lex/1,
    parse/1,
    part_one/1,
    part_two/1
]).

lex(Input) ->
    {ok, Tokens, _} = lexer_day_5_2024:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_5_2024:parse(Input).

rule_is_invalid(Positions, {X, Y}) ->
    maybe
        {ok, A} ?= maps:find(X, Positions),
        {ok, B} ?= maps:find(Y, Positions),
        %% should return true if they are in the wrong order!
        A > B
    else
        %% i.e. the rule doesn't apply
        _ -> false
    end.

get_middle_value(Positions) ->
    List = maps:to_list(Positions),
    Sort = lists:sort(fun({_, A}, {_, B}) -> A < B end, List),
    Midpoint = round(length(Sort) / 2),
    % NOTE: nth throws
    {Value, _} = lists:nth(Midpoint, Sort),
    Value.

evaluate_rules(Rules, Positions) ->
    RulesViolated = lists:any(fun(Rule) -> rule_is_invalid(Positions, Rule) end, Rules),
    case RulesViolated of
        true -> 0;
        false -> get_middle_value(Positions)
    end.

evaluate_reorderings(Rules, Positions) ->
    RulesViolated = lists:any(fun(Rule) -> rule_is_invalid(Positions, Rule) end, Rules),
    case RulesViolated of
        true -> reorder_violated_rules(Rules, Positions);
        false -> 0
    end.

reorder(RulesViolated, Positions) ->
    lists:foldl(
        fun({X, Y}, Acc) ->
            maybe
                {ok, A} ?= maps:find(X, Acc),
                {ok, B} ?= maps:find(Y, Acc),
                maps:update(X, B, maps:update(Y, A, Positions))
            else
                _ -> Acc
            end
        end,
        Positions,
        lists:sort(fun({X, _}, {Y, _}) -> X < Y end, RulesViolated)
    ).

reorder_violated_rules(Rules, Positions) ->
    RulesViolated = lists:foldl(
        fun(Rule, Acc) ->
            case rule_is_invalid(Positions, Rule) of
                true -> [Rule | Acc];
                false -> Acc
            end
        end,
        [],
        Rules
    ),
    case RulesViolated of
        [] ->
            get_middle_value(Positions);
        _ ->
            %% logger:notice(#{rules_violated => RulesViolated, positions => Positions}),
            reorder_violated_rules(Rules, reorder(RulesViolated, Positions))
    end.

-spec part_one(_) -> integer().
part_one({Rules, Updates}) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + evaluate_rules(Rules, maps:from_list(X))
        end,
        0,
        Updates
    ).

-spec part_two(_) -> integer().
part_two({Rules, Updates}) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc + evaluate_reorderings(Rules, maps:from_list(X))
        end,
        0,
        Updates
    ).
