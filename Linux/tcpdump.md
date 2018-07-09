# Overview
```shell
tcpdump [ -adeflnNOpqStvx ] [ -c 数量 ] [ -F 文件名 ]
　　　　　　　　　　[ -i 网络接口 ] [ -r 文件名] [ -s snaplen ]
　　　　　　　　　　[ -T 类型 ] [ -w 文件名 ] [表达式 ]
```

## flags

- `-XX`:  
    打印报文数据，包含链路层数据  
- `-X`:   
    打印报文数据，不包含链路层数据

# Tcpdump

1. `-i`

    指定监听端口
    ```shell
    tcmpdump -i entho
    ```

2. `-X`, `-XX`:

    输出数据包内容，前者不包含数据链路层头部，后者包括
