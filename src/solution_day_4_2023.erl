-module(solution_day_4_2023).

-export([
    build_scanner/0,
    build_parser/0,
    scan/1,
    parse/1,
    attempt/0
]).

build_scanner() ->
    {ok, _} = leex:file("src/scanner_day_4_2023.xrl").

build_parser() ->
    {ok, _} = yecc:file("src/parser_day_4_2023.yrl").

scan(Input) ->
    {ok, Tokens, _} = scanner_day_4_2023:string(Input),
    {ok, Tokens}.

parse(Input) ->
    parser_day_4_2023:parse(Input).

attempt() ->
    {ok, Leex} = scan("Card 1: 1 2 3 | 4 5 6"),
    logger:notice(#{leex => Leex}),
    parse(Leex).
