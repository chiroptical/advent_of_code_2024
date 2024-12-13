#!/usr/bin/env bash

INPUT_DAY=8
OUTPUT_DAY=12

if [ ! -f src/lexer_day_${OUTPUT_DAY}_2024.xrl ]; then
  cp src/lexer_day_${INPUT_DAY}_2024.xrl src/lexer_day_${OUTPUT_DAY}_2024.xrl  
fi

if [ ! -f src/parser_day_${OUTPUT_DAY}_2024.yrl ]; then
  cp src/parser_day_${INPUT_DAY}_2024.yrl src/parser_day_${OUTPUT_DAY}_2024.yrl
fi

if [ ! -f src/solution_day_${OUTPUT_DAY}_2024.erl ]; then
  cp src/solution_day_${INPUT_DAY}_2024.erl src/solution_day_${OUTPUT_DAY}_2024.erl
fi

if [ ! -f test/solution_day_${OUTPUT_DAY}_2024_tests.erl ]; then
  cp test/solution_day_${INPUT_DAY}_2024_tests.erl test/solution_day_${OUTPUT_DAY}_2024_tests.erl
fi
