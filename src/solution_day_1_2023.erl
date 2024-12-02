-module(solution_day_1_2023).

-export([
    scan/1,
    parse/1,
    attempt/1
]).

scan(Input) ->
    {ok, Tokens, _} = scanner_day_1_2023:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_1_2023:parse(Input).

attempt(Input) ->
    {ok, Leex} = scan(Input),
    logger:notice(#{leex => Leex}),
    {ok, Calibrations} = parse(Leex),
    logger:notice(#{calibrations => Calibrations}).
