-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
-module(parser_day_3_2024).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.erl", 3).
-export([parse/1, parse_and_scan/1, format_error/1]).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 26).

extract_integer({_Token, _Line, Value}) -> Value.

remove_incomplete({ok, operands, {A, B}}) ->
    [{operands, {A, B}}];
remove_incomplete({ok, enable}) ->
    [enable];
remove_incomplete({ok, disable}) ->
    [disable];
remove_incomplete(incomplete) ->
    [].

remove_incomplete_rec({ok, operands, {A, B}}, Rest) ->
    [{operands, {A, B}} | Rest];
remove_incomplete_rec({ok, enable}, Rest) ->
    [enable | Rest];
remove_incomplete_rec({ok, disable}, Rest) ->
    [disable | Rest];
remove_incomplete_rec(incomplete, X) ->
    X.

-file(
    "/nix/store/5pjd6c7jnc7dzb4mjbjq1028s806yvhf-erlang-27.1.2/lib/erlang/lib/parsetools-2.6/include/yeccpre.hrl",
    0
).
%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 1996-2024. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parser generator will insert appropriate declarations before this line.%

-type yecc_ret() :: {'error', _} | {'ok', _}.

-ifdef(YECC_PARSE_DOC).
-doc ?YECC_PARSE_DOC.
-endif.
-spec parse(Tokens :: list()) -> yecc_ret().
parse(Tokens) ->
    yeccpars0(Tokens, {no_func, no_location}, 0, [], []).

-ifdef(YECC_PARSE_AND_SCAN_DOC).
-doc ?YECC_PARSE_AND_SCAN_DOC.
-endif.
-spec parse_and_scan(
    {function() | {atom(), atom()}, [_]}
    | {atom(), atom(), [_]}
) -> yecc_ret().
parse_and_scan({F, A}) ->
    yeccpars0([], {{F, A}, no_location}, 0, [], []);
parse_and_scan({M, F, A}) ->
    Arity = length(A),
    yeccpars0([], {{fun M:F/Arity, A}, no_location}, 0, [], []).

-ifdef(YECC_FORMAT_ERROR_DOC).
-doc ?YECC_FORMAT_ERROR_DOC.
-endif.
-spec format_error(any()) -> [char() | list()].
format_error(Message) ->
    case io_lib:deep_char_list(Message) of
        true ->
            Message;
        _ ->
            io_lib:write(Message)
    end.

%% To be used in grammar files to throw an error message to the parser
%% toplevel. Doesn't have to be exported!
-compile({nowarn_unused_function, return_error/2}).
-spec return_error(erl_anno:location(), any()) -> no_return().
return_error(Location, Message) ->
    throw({error, {Location, ?MODULE, Message}}).

-define(CODE_VERSION, "1.4").

yeccpars0(Tokens, Tzr, State, States, Vstack) ->
    try
        yeccpars1(Tokens, Tzr, State, States, Vstack)
    catch
        error:Error:Stacktrace ->
            try yecc_error_type(Error, Stacktrace) of
                Desc ->
                    erlang:raise(
                        error,
                        {yecc_bug, ?CODE_VERSION, Desc},
                        Stacktrace
                    )
            catch
                _:_ -> erlang:raise(error, Error, Stacktrace)
            end;
        %% Probably thrown from return_error/2:
        throw:{error, {_Location, ?MODULE, _M}} = Error ->
            Error
    end.

yecc_error_type(function_clause, [{?MODULE, F, ArityOrArgs, _} | _]) ->
    case atom_to_list(F) of
        "yeccgoto_" ++ SymbolL ->
            {ok, [{atom, _, Symbol}], _} = erl_scan:string(SymbolL),
            State =
                case ArityOrArgs of
                    [S, _, _, _, _, _, _] -> S;
                    _ -> state_is_unknown
                end,
            {Symbol, State, missing_in_goto_table}
    end.

yeccpars1([Token | Tokens], Tzr, State, States, Vstack) ->
    yeccpars2(State, element(1, Token), States, Vstack, Token, Tokens, Tzr);
yeccpars1([], {{F, A}, _Location}, State, States, Vstack) ->
    case apply(F, A) of
        {ok, Tokens, EndLocation} ->
            yeccpars1(Tokens, {{F, A}, EndLocation}, State, States, Vstack);
        {eof, EndLocation} ->
            yeccpars1([], {no_func, EndLocation}, State, States, Vstack);
        {error, Descriptor, _EndLocation} ->
            {error, Descriptor}
    end;
yeccpars1([], {no_func, no_location}, State, States, Vstack) ->
    Line = 999999,
    yeccpars2(
        State,
        '$end',
        States,
        Vstack,
        yecc_end(Line),
        [],
        {no_func, Line}
    );
yeccpars1([], {no_func, EndLocation}, State, States, Vstack) ->
    yeccpars2(
        State,
        '$end',
        States,
        Vstack,
        yecc_end(EndLocation),
        [],
        {no_func, EndLocation}
    ).

%% yeccpars1/7 is called from generated code.
%%
%% When using the {includefile, Includefile} option, make sure that
%% yeccpars1/7 can be found by parsing the file without following
%% include directives. yecc will otherwise assume that an old
%% yeccpre.hrl is included (one which defines yeccpars1/5).
yeccpars1(State1, State, States, Vstack, Token0, [Token | Tokens], Tzr) ->
    yeccpars2(
        State,
        element(1, Token),
        [State1 | States],
        [Token0 | Vstack],
        Token,
        Tokens,
        Tzr
    );
yeccpars1(State1, State, States, Vstack, Token0, [], {{_F, _A}, _Location} = Tzr) ->
    yeccpars1([], Tzr, State, [State1 | States], [Token0 | Vstack]);
yeccpars1(State1, State, States, Vstack, Token0, [], {no_func, no_location}) ->
    Location = yecctoken_end_location(Token0),
    yeccpars2(
        State,
        '$end',
        [State1 | States],
        [Token0 | Vstack],
        yecc_end(Location),
        [],
        {no_func, Location}
    );
yeccpars1(State1, State, States, Vstack, Token0, [], {no_func, Location}) ->
    yeccpars2(
        State,
        '$end',
        [State1 | States],
        [Token0 | Vstack],
        yecc_end(Location),
        [],
        {no_func, Location}
    ).

%% For internal use only.
yecc_end(Location) ->
    {'$end', Location}.

yecctoken_end_location(Token) ->
    try erl_anno:end_location(element(2, Token)) of
        undefined -> yecctoken_location(Token);
        Loc -> Loc
    catch
        _:_ -> yecctoken_location(Token)
    end.

-compile({nowarn_unused_function, yeccerror/1}).
yeccerror(Token) ->
    Text = yecctoken_to_string(Token),
    Location = yecctoken_location(Token),
    {error, {Location, ?MODULE, ["syntax error before: ", Text]}}.

-compile({nowarn_unused_function, yecctoken_to_string/1}).
yecctoken_to_string(Token) ->
    try erl_scan:text(Token) of
        undefined -> yecctoken2string(Token);
        Txt -> Txt
    catch
        _:_ -> yecctoken2string(Token)
    end.

yecctoken_location(Token) ->
    try
        erl_scan:location(Token)
    catch
        _:_ -> element(2, Token)
    end.

-compile({nowarn_unused_function, yecctoken2string/1}).
yecctoken2string(Token) ->
    try
        yecctoken2string1(Token)
    catch
        _:_ ->
            io_lib:format("~tp", [Token])
    end.

-compile({nowarn_unused_function, yecctoken2string1/1}).
yecctoken2string1({atom, _, A}) ->
    io_lib:write_atom(A);
yecctoken2string1({integer, _, N}) ->
    io_lib:write(N);
yecctoken2string1({float, _, F}) ->
    io_lib:write(F);
yecctoken2string1({char, _, C}) ->
    io_lib:write_char(C);
yecctoken2string1({var, _, V}) ->
    io_lib:format("~s", [V]);
yecctoken2string1({string, _, S}) ->
    io_lib:write_string(S);
yecctoken2string1({reserved_symbol, _, A}) ->
    io_lib:write(A);
yecctoken2string1({_Cat, _, Val}) ->
    io_lib:format("~tp", [Val]);
yecctoken2string1({dot, _}) ->
    "'.'";
yecctoken2string1({'$end', _}) ->
    [];
yecctoken2string1({Other, _}) when is_atom(Other) ->
    io_lib:write_atom(Other);
yecctoken2string1(Other) ->
    io_lib:format("~tp", [Other]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.erl", 216).

-dialyzer({nowarn_function, yeccpars2/7}).
-compile({nowarn_unused_function, yeccpars2/7}).
yeccpars2(0 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_0(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(1=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_1(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(2=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_2(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(3=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_3(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(4 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_4(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(5 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_5(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(6 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_6(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(7 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_7(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(8 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_8(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(9 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_9(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(10 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_10(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(11 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_11(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(12 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(13 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_13(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(14 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_14(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(15 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_15(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(16 = S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_16(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(17=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_17(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(Other, _, _, _, _, _, _) ->
    erlang:error({yecc_bug, "1.4", {missing_state_in_action_table, Other}}).

-dialyzer({nowarn_function, yeccpars2_0/7}).
-compile({nowarn_unused_function, yeccpars2_0/7}).
yeccpars2_0(S, 'close_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 4, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'comma', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 5, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'do', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 6, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'dont', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 7, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'int', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 8, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'mul', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 9, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'open_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 10, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(S, 'skip', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 11, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(_, _, _, _, T, _, _) ->
    yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_1/7}).
-compile({nowarn_unused_function, yeccpars2_1/7}).
yeccpars2_1(_S, '$end', _Ss, Stack, _T, _Ts, _Tzr) ->
    {ok, hd(Stack)};
yeccpars2_1(_, _, _, _, T, _, _) ->
    yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_2/7}).
-compile({nowarn_unused_function, yeccpars2_2/7}).
yeccpars2_2(S, 'close_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 4, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'comma', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 5, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'do', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 6, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'dont', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 7, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'int', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 8, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'mul', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 9, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'open_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 10, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(S, 'skip', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 11, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_2_(Stack),
    yeccgoto_memory(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_3/7}).
-compile({nowarn_unused_function, yeccpars2_3/7}).
yeccpars2_3(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_3_(Stack),
    yeccgoto_instruction(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_4/7}).
-compile({nowarn_unused_function, yeccpars2_4/7}).
yeccpars2_4(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_4_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_5/7}).
-compile({nowarn_unused_function, yeccpars2_5/7}).
yeccpars2_5(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_5_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_6/7}).
-compile({nowarn_unused_function, yeccpars2_6/7}).
yeccpars2_6(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_6_(Stack),
    yeccgoto_instruction(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_7/7}).
-compile({nowarn_unused_function, yeccpars2_7/7}).
yeccpars2_7(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_7_(Stack),
    yeccgoto_instruction(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_8/7}).
-compile({nowarn_unused_function, yeccpars2_8/7}).
yeccpars2_8(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_8_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_9/7}).
-compile({nowarn_unused_function, yeccpars2_9/7}).
yeccpars2_9(S, 'open_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 12, Ss, Stack, T, Ts, Tzr);
yeccpars2_9(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_9_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_10/7}).
-compile({nowarn_unused_function, yeccpars2_10/7}).
yeccpars2_10(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_10_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_11/7}).
-compile({nowarn_unused_function, yeccpars2_11/7}).
yeccpars2_11(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    NewStack = yeccpars2_11_(Stack),
    yeccgoto_else(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_12/7}).
-compile({nowarn_unused_function, yeccpars2_12/7}).
yeccpars2_12(S, 'int', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 13, Ss, Stack, T, Ts, Tzr);
yeccpars2_12(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_ | Nss] = Ss,
    NewStack = yeccpars2_12_(Stack),
    yeccgoto_instruction(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_13/7}).
-compile({nowarn_unused_function, yeccpars2_13/7}).
yeccpars2_13(S, 'comma', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 14, Ss, Stack, T, Ts, Tzr);
yeccpars2_13(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_, _ | Nss] = Ss,
    NewStack = yeccpars2_13_(Stack),
    yeccgoto_instruction(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_14/7}).
-compile({nowarn_unused_function, yeccpars2_14/7}).
yeccpars2_14(S, 'int', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 15, Ss, Stack, T, Ts, Tzr);
yeccpars2_14(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_, _, _ | Nss] = Ss,
    NewStack = yeccpars2_14_(Stack),
    yeccgoto_instruction(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_15/7}).
-compile({nowarn_unused_function, yeccpars2_15/7}).
yeccpars2_15(S, 'close_paren', Ss, Stack, T, Ts, Tzr) ->
    yeccpars1(S, 16, Ss, Stack, T, Ts, Tzr);
yeccpars2_15(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_, _, _, _ | Nss] = Ss,
    NewStack = yeccpars2_15_(Stack),
    yeccgoto_instruction(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_16/7}).
-compile({nowarn_unused_function, yeccpars2_16/7}).
yeccpars2_16(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_, _, _, _, _ | Nss] = Ss,
    NewStack = yeccpars2_16_(Stack),
    yeccgoto_instruction(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_17/7}).
-compile({nowarn_unused_function, yeccpars2_17/7}).
yeccpars2_17(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
    [_ | Nss] = Ss,
    NewStack = yeccpars2_17_(Stack),
    yeccgoto_memory(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_else/7}).
-compile({nowarn_unused_function, yeccgoto_else/7}).
yeccgoto_else(0 = _S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_3(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_else(2 = _S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_3(_S, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_instruction/7}).
-compile({nowarn_unused_function, yeccgoto_instruction/7}).
yeccgoto_instruction(0, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_2(2, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_instruction(2, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_2(2, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_memory/7}).
-compile({nowarn_unused_function, yeccgoto_memory/7}).
yeccgoto_memory(0, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_1(1, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_memory(2 = _S, Cat, Ss, Stack, T, Ts, Tzr) ->
    yeccpars2_17(_S, Cat, Ss, Stack, T, Ts, Tzr).

-compile({inline, yeccpars2_2_/1}).
-dialyzer({nowarn_function, yeccpars2_2_/1}).
-compile({nowarn_unused_function, yeccpars2_2_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 12).
yeccpars2_2_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            remove_incomplete(___1)
        end
        | __Stack
    ].

-compile({inline, yeccpars2_3_/1}).
-dialyzer({nowarn_function, yeccpars2_3_/1}).
-compile({nowarn_unused_function, yeccpars2_3_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 10).
yeccpars2_3_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            incomplete
        end
        | __Stack
    ].

-compile({inline, yeccpars2_4_/1}).
-dialyzer({nowarn_function, yeccpars2_4_/1}).
-compile({nowarn_unused_function, yeccpars2_4_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_4_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_5_/1}).
-dialyzer({nowarn_function, yeccpars2_5_/1}).
-compile({nowarn_unused_function, yeccpars2_5_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_5_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_6_/1}).
-dialyzer({nowarn_function, yeccpars2_6_/1}).
-compile({nowarn_unused_function, yeccpars2_6_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 8).
yeccpars2_6_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            {ok, enable}
        end
        | __Stack
    ].

-compile({inline, yeccpars2_7_/1}).
-dialyzer({nowarn_function, yeccpars2_7_/1}).
-compile({nowarn_unused_function, yeccpars2_7_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 9).
yeccpars2_7_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            {ok, disable}
        end
        | __Stack
    ].

-compile({inline, yeccpars2_8_/1}).
-dialyzer({nowarn_function, yeccpars2_8_/1}).
-compile({nowarn_unused_function, yeccpars2_8_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_8_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_9_/1}).
-dialyzer({nowarn_function, yeccpars2_9_/1}).
-compile({nowarn_unused_function, yeccpars2_9_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_9_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_10_/1}).
-dialyzer({nowarn_function, yeccpars2_10_/1}).
-compile({nowarn_unused_function, yeccpars2_10_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_10_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_11_/1}).
-dialyzer({nowarn_function, yeccpars2_11_/1}).
-compile({nowarn_unused_function, yeccpars2_11_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 0).
yeccpars2_11_(__Stack0) ->
    [___1 | __Stack] = __Stack0,
    [
        begin
            '$undefined'
        end
        | __Stack
    ].

-compile({inline, yeccpars2_12_/1}).
-dialyzer({nowarn_function, yeccpars2_12_/1}).
-compile({nowarn_unused_function, yeccpars2_12_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 7).
yeccpars2_12_(__Stack0) ->
    [___2, ___1 | __Stack] = __Stack0,
    [
        begin
            incomplete
        end
        | __Stack
    ].

-compile({inline, yeccpars2_13_/1}).
-dialyzer({nowarn_function, yeccpars2_13_/1}).
-compile({nowarn_unused_function, yeccpars2_13_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 6).
yeccpars2_13_(__Stack0) ->
    [___3, ___2, ___1 | __Stack] = __Stack0,
    [
        begin
            incomplete
        end
        | __Stack
    ].

-compile({inline, yeccpars2_14_/1}).
-dialyzer({nowarn_function, yeccpars2_14_/1}).
-compile({nowarn_unused_function, yeccpars2_14_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 5).
yeccpars2_14_(__Stack0) ->
    [___4, ___3, ___2, ___1 | __Stack] = __Stack0,
    [
        begin
            incomplete
        end
        | __Stack
    ].

-compile({inline, yeccpars2_15_/1}).
-dialyzer({nowarn_function, yeccpars2_15_/1}).
-compile({nowarn_unused_function, yeccpars2_15_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 4).
yeccpars2_15_(__Stack0) ->
    [___5, ___4, ___3, ___2, ___1 | __Stack] = __Stack0,
    [
        begin
            incomplete
        end
        | __Stack
    ].

-compile({inline, yeccpars2_16_/1}).
-dialyzer({nowarn_function, yeccpars2_16_/1}).
-compile({nowarn_unused_function, yeccpars2_16_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 3).
yeccpars2_16_(__Stack0) ->
    [___6, ___5, ___4, ___3, ___2, ___1 | __Stack] = __Stack0,
    [
        begin
            {ok, operands, {extract_integer(___3), extract_integer(___5)}}
        end
        | __Stack
    ].

-compile({inline, yeccpars2_17_/1}).
-dialyzer({nowarn_function, yeccpars2_17_/1}).
-compile({nowarn_unused_function, yeccpars2_17_/1}).
-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 13).
yeccpars2_17_(__Stack0) ->
    [___2, ___1 | __Stack] = __Stack0,
    [
        begin
            remove_incomplete_rec(___1, ___2)
        end
        | __Stack
    ].

-file("/Users/chiroptical/programming/erlang/advent_of_code_2024/src/parser_day_3_2024.yrl", 48).
