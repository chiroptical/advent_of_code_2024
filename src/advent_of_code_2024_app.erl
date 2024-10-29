%%%-------------------------------------------------------------------
%% @doc advent_of_code_2024 public API
%% @end
%%%-------------------------------------------------------------------

-module(advent_of_code_2024_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    advent_of_code_2024_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
