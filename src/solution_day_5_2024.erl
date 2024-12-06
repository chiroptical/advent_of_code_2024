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
part_two(_Input) ->
    42.
