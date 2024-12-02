-module(with).

-export([
    with/2,
    log/2
]).

-spec with(boolean(), function()) -> ok.
with(true, Fun) ->
    Fun();
with(false, _Fun) ->
    ok.

-spec log(boolean(), map()) -> ok.
log(true, Log) ->
    logger:notice(Log);
log(false, _Log) ->
    ok.
