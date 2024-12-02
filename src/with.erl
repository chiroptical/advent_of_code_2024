-module(with).

-export([
    with/2,
    log/2
]).

with(true, Fun) ->
    Fun();
with(false, _Fun) ->
    ok.

log(true, Log) ->
    logger:notice(Log);
log(false, _Log) ->
    ok.
