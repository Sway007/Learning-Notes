# The `awk` Language

- how to run

    ```awk
    awk 'program' input-file1 input-file2 ...
    ```
    ```awk
    awk -f program-file input-file1 input-file2 ...
    ```

    program consists of
    ```awk
    pattern { action }
    pattern { action }
    ...
    ```

- base notes

    - `$0`: current line
    - patterns starting with `/` represents a regular expression
    - either pattern or action can be omiteed, but nit both.
        - pattern omitted: action is performed for every input line.
        - action omitted: print all lines that match the pattern.

- `-f`

    The -f option may be used more than once on the command line. If it is, awk reads its program source from all of the named files, as if they had been concatenated together into one big file.

- Command-Line Arguments

    - all command-line arguments are available to awk in the `ARGV` array.  
    - command-line options and the program text are omitted from `ARGV`

- Environment Variables by `gawk`

    - `AWKPATH`

- `@include`

## Regular Expression used by `awk`

- `~` and `!`

    regex comparison operator. For example, the following expression is true if comparison match succeed:
    ```awk
    exp ~ /regexp/
    ```

- `\`

    escape character

- `^` and `$`
- `.`

    match any singile character

- `[ ... ]` and `[ ^... ]`

    option match, only one character
- `*`, `+`, `?`, `{n}`, `{n,}`, `{n,m}`

    repeat operator

# TODO p.53