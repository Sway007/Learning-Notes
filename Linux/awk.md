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