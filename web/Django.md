## STATIC_ROOT, STATIC_URL和STATICFILES_DIRS的区分

- STATIC_URL

    html中用于区分静态资源(js,css,img等)url请求的前缀，即统一将<static_url>/app.js映射到app.js在服务器的本地地址，这里的本地地址官方解释为STATIC_ROOT的地址，经试验不对，应该是STATICFILES_DIRS的地址，STATICFILES_DIRS的是Django再服务器本地查找静态资源的唯一路径配置参数。

- STATIC_ROOT

    Django用于收集项目中需要用到的所有的静态资源文件夹。

## TODO