# re

- 默认匹配模式是单行匹配，开启多行匹配模式 re.M
    - even in MULTILINE mode, re.match() will only match at the beginning of the string and not at the beginning of each line.
- 默认`.`不匹配换行符，开启 re.S
- `re.sub(pattern, repl, string, count=0, flags=0)`
    - count must be a non-negative integer. If omitted or zero, all occurrences will be replaced

## repeater

- {count}
- {min,}
- {min, max}