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

- word class

    - `[:alnum:]`
    - `[:alpha:]`
    - `[:blank:]`   space and tab
    - `[:cntrl:]`
    - `[:digit:]`
    - `[:graph:]`
    - `[:lower:]`
    - `[:print:]`
    - `[:punct:]`
    - `[:space:]`
    - `[:upper:]`
    - `[:xdigit:]`

- summary

    - written as `/.../`
    - match expression using `~` and `!~`

## Reading input files

- The input is read in units called records, and is processed by the rules of your program one record at a time. By default, each record is one line. Each record is automatically split into chunks called fields.

- fields are separated by whitespace by default, can be referred by `$`
    - `$0` refer to the whole input record.
    - `NR`: the number of records read so far.
    - `NF`: the number of fields

> it is a common error to try to change the field separators in a record simply by setting FS and OFS, and then expecting a plain ‘print’ or ‘print $0’ to print the modified record.  
> But this does not work, because nothing was done to change the record itself. Instead, you must force the record to be rebuilt, typically with a statement such as ‘$1 = $1’, as described earlier.

- `FS`: specify the field separator, whitespace by default.

- `-F`: set field separator in command line.
- `RS=""`: set the blank lines to be the record separator, same as `RS="\n\n+"`

## Printing Output

- `print` with no arguments is equivalent to `print $0`. To print a blank line, use `print ""`.
- specify output field separator using `OFS`, the initial value is `" "`
- specify output record separator using `ORS`, the initial value is `\n`
- format-control letters

    - start with `%` and end with a _format-control letter_.
    -  flags
        -  `-`: left-justify
        -  `+`: always supply a sign
        -  `0`: padding with `0` instead of spaces

- `print` and `printf` redirection
    - `print items >> output-file`
        _redirect and append_

## Expressions

# TODO Page. 114