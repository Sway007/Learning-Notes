## I/O redirection

* ### **Standard ouput** commands: '>', '>>'

    > \> : To redirect standard output to a file , after excuting, the file redirected to will be overwritten .
    ``` shell
    echo redirection > test.txt
    ```

    > \>> : same function as '>' , but output is appended to file instead of overwritening file .
    ``` shell
    echo append >> test.txt
    ```

* ### **Standard input** commands: '<'

    > one self-explained example
    ```shell
    sort < file_list.txt > sorted_file_list.txt
    ```

## Pipeline

### `$ firt command | second commond`
the standard output of first command is fed into the input of second

``` shell
ls -l | less
```

## show directory size
```shell
du -sh [sub dir]
```

## grep

<font color=#00ff00 size=72>**TODO!**</font>    


---------------------------------

[<font size=35>**Resoure link** </font>](http://linuxcommand.org/lc3_learning_the_shell.php)

# file system

## check file stat

    stat *file*

# xargs

- `-I`: Replace occurrences of replace-str in the initial-arguments with  names  read  from standard  input

# 查询监听某个端口的进程信息

```shell
sudo lsof -i: port
```