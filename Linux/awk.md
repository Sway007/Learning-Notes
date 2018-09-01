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

- a regexp constants appear by itself, it has the same meaning as `'($0 ~ /foo/)'`

    > expression `'match = /foo/'` assigns either 0 or 1 to variable match. It is equivalent to `'match = ($0 ~ /foo/)'`

- strongly typed regexp constants
    - preceded by `'@'` sign:

        ```awk
        re = @/foo/ # Regexp variable
        ```

- variables
    - variables are initialized to the empty string, which is zero if converted to a number.
    - assign variable on the command line
        ```awk
        varible=text # set at the beginning of awk or in between input files.
        # or
        -v varible=text # at the very beginnig.
        ```

    - conversion between numbers and strings
        - number to string: concatenate number with empty string `""`.
        - string to number: add zero to the string.
        - strings that cannot be interpreted as valid unmber convert to zero.
        - number are conerted using the `sprintf()` function with `CONVFMT` as the format specifier.    
            > `CONVFMT`'s default value is `"%.6g"`
            - as a special case, if a number is an integer, the result of conversion is **_always_** an integer.
            - example
                ```awk
                awk 'BEGIN {OFMT="%2.1f"
                CONVFMT="%1.3f"
                a=12.23232
                print a"";print a}'
                ```

        - there is only one string operation: concatenation.

        ```awk
        awk `BEGIN {print -12 "" -24}`
        # equivalent to -12(" " - 24), so get output: -12-24
        ```

        - Fields, `getline` input, `FILENAME`, `ARGV` elements, `ENVIRON` elements and the elements of an array created bu `match()`, `split()`, and `patsplit()` that are numeric strings have the **_strnum_** attribute. Otherwise, they have the _string_ attribute. Uninitialized variables also have the **_strnum_** attribute.
        
> the righthand operand of the `~` and `!~` operators may be either a regex constant`(/.../)` or an ordinary expression. In the latter case, the 
> value of the expression as a string is used as a dynamic regex.

- boolean expressions
    - Boolean expression have numeric values(1 for true, 0 for false) if the result of the boolean expression is stored in a variable or used in arithmetic.

# Chapter 7. 141

## Patter Elements

- patter elements class
    - _`/regex/`_
    - _`expression`_
        
        match when its value is nonzero or non-null
    - _`begpat, endpat`_
    - `BEGIN`, `END`
    - `BEGINEFILE`, `ENDFILE`
    - _`empty`_

        match every input record

- the expression in pattern is reevaluated each time the rule is tested against a new input record
- boolean expression are also commonly used as patterns. for example:

    ```awk
    awk ’/edu/ && /li/’ mail-list
    # match if the record  contain 'edu' and `li`
    ```
- `begpat, endpat`

    - when a record matchs `begpat`, the range pattern is turned on. as long as the range pattern stays turned on, it automatically matched every input read.
    - If the record satisfies both conditions, then the action is executed for just that record.
    - range patterns donot combine with other patterns

- input/ouput from `EBGIN` and `END` rules
    - no input record for `BEGIN`
    - `$0` and `NF` are undefined inside an `END` rule.

## Actions

- action is enclosed in braces ('{...}'), statement are separated by newlines or semicolons.

## Control Statements in Actions

- `if-else`

    ```awk
    if (condition) then-body [else else-body]
    ```

- `for`

    ```awk
    for (initialization; condition; increment)
        body
    ```
    - It isn’t possible to set more than one variable in the initialization part without using a multiple assignment statement such as ‘x = y = 0’.

- `switch`

    ```awk
    switch (expression) {
        case value or regular expression:
            case-body
        default:
            default-body
    }
    ```

- `next`

    - the `next` statement forces `awk` to immediately stop processing the current record and go on to the next record. the rest fo the current rule's action won't be executed.

- `nextfile`
    - stop processing the current data file

- `exit`
    - when an `exit` statement is executed, as part of executing the `exit`, the `END` rule is executed

## Predefined Variables

- _`CONVFMT`_
- _`FIELDWIDTHS`_
- _`FPAT`_
    > A regular expression (as a string) that tells gawk to create the fields based on text that matches the regular expression.
- _`FS`_
- _`OFMT`_
- _`OFS`_
- _`ORS`_
- _`RS`_
- _`ARGC, ARGV`_
- _`ARGIND`_
    >  The index in _`ARGV`_ of the current file being processed.
- _`ENVIRON`_
- _`FILENAME`_
- _`FNR`_
    >  The current record number in the current file
- _`NF`_
    > The number of fields in the current input record 
- _`NR`_
    > The number of input records awk has processed since the beginning of the program’s execution 

# Chapter 8. Arrays in _`AWK`_

## The Basics of Arrays

- any number or string, not just consecutive integers, may be used as an array index.
- each array in _`awk`_ is a collection of pairs—an index and its corresponding array element value
- When awk creates an array (e.g., with the split() built-in function), **_that array’s indices are consecutive integers starting at one_**.
- reffer to an array element
    ```awk
    array[index-expression]
    ```
- _A reference to an element that does not exist automatically creates that array element, with the null string as its value._
- check if an element exists at a certain index:   
    ```awk
    # index in array
    if (2 in frequencies)
        print "Subscript 2 is present."
    ```
- loop array
    ```awk
    for (indx in array)
        body
    ```
- the awk implementation determines the order in which the array is traversed.
- set `PROCINFO["sorted_in"]` to specify the order in which _`awk`_ traverse an array [**_only for gawk_**]
    - "@unsorted" _default_
    - "@ind_str_asc"
    - "@ind_num_asc"
    - "@val_type_asc"
    - and so on ...

## `delete` statement

```awk
delete array[index-expression]
```
- It is not an error to delete an element that does not exist.
- delete all elements:
    ```awk
    delete array
    ``` 

## Multidimensional Arrays

- Multidimensional arrays are supported in awk through concatenation of indices into one string. The separator used for combiantion is the value of the built-in variable _`SUBSEP`_

# Functions

## string manipulation function

- gsub(regexp, replacement [, target])
     Search target for all of the longest, leftmost, nonoverlapping matching substrings it can find and replace them with replacement. The ‘g’ in gsub() stands for “global,” which means replace everywhere.

## User-defined function
```awk
function name([parameter-list])
{
    body-of-function
}
```

## Passing Function Arguments by Value Or by Reference
> the passing convention is determined at runtime when the function is called, according to the following rule: if the argument is an array variable, then it is passed by reference. Otherwise, the argument is passed by value.

- pass array by reference, otherwise by value