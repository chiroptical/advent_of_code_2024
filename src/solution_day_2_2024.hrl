-record(rules, {
    increases = true :: boolean(),
    decreases = true :: boolean()
}).

-record(dampened_rules, {
    increases = true :: boolean(),
    increases_dampened = false :: boolean(),
    decreases = true :: boolean(),
    decreases_dampened = false :: boolean()
}).
