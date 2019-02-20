## [es6中对正则表达式的扩展](http://es6.ruanyifeng.com/#docs/regex)

### u修饰符

> ES6 对正则表达式添加了u修饰符，含义为“Unicode 模式”，用来正确处理大于\uFFFF的 Unicode 字符

简单来说，就是加了修饰符`u`后的正则匹配才能识别被匹配的utf-8/utf-16编码的字符串

### dotAll模式

`s`修饰符

## 函数的扩展

### [函数的 length 属性](http://es6.ruanyifeng.com/#docs/function)

> 指定了默认值以后，函数的length属性，将返回没有指定默认值的参数个数。也就是说，指定了默认值后，length属性将失真。

> length属性的含义是，该函数预期传入的参数个数。某个参数指定默认值以后，预期传入的参数个数就不包括这个参数了。同理，`rest` 参数也不会计入length属性。

### 箭头函数

- 如果箭头函数的代码块部分多于一条语句，就要使用大括号将它们括起来，并且使用return语句返回。
- 由于大括号被解释为代码块，所以如果箭头函数直接返回一个对象，必须在对象外面加上括号，否则会报错。

    ```js
    // 报错
    let getTempItem = id => { id: id, name: "Temp" };

    // 不报错
    let getTempItem = id => ({ id: id, name: "Temp" });
    ```

- 箭头函数的函数体只要加了大括号则必须用return语句返回返回值，没有则视为直接返回箭头后面的js表达式运算结果

#### 箭头函数注意事项

1. 函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。
2. 不可以当作构造函数，也就是说，不可以使用new命令，否则会抛出一个错误
3. 不可以使用arguments对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。
4. 不可以使用yield命令，因此箭头函数不能用作 Generator 函数。

### 尾调用优化

> 我们知道，函数调用会在内存形成一个“调用记录”，又称“调用帧”（call frame），保存调用位置和内部变量等信息。如果在函数A的内部调用函数B，那么在A的调用帧上方，还会形成一个B的调用帧。等到B运行结束，将结果返回到A，B的调用帧才会消失。如果函数B内部还调用函数C，那就还有一个C的调用帧，以此类推。所有的调用帧，就形成一个“调用栈”（call stack）。  
尾调用由于是函数的最后一步操作，所以不需要保留外层函数的调用帧，因为调用位置、内部变量等信息都不会再用到了，只要直接用内层函数的调用帧，取代外层函数的调用帧就可以了。

### 尾递归

- 函数调用自身，称为递归。如果尾调用自身，就称为尾递归。  
- 对于尾递归来说，由于只存在一个调用帧，所以永远不会发生“栈溢出”错误。

    > ES6 的尾调用优化只在严格模式下开启，正常模式是无效的。
    > 这是因为在正常模式下，函数内部有两个变量，可以跟踪函数的调用栈。
    - func.arguments：返回调用时函数的参数。
    - func.caller：返回调用当前函数的那个函数。
    > 尾调用优化发生时，函数的调用栈会改写，因此上面两个变量就会失真。严格模式禁用这两个变量，所以尾调用模式仅在严格模式下生效。
    ```js
     function restricted() {
        'use strict';
        restricted.caller;    // 报错
        restricted.arguments; // 报错
    }
    restricted();
    ```

## 数组的扩展

### 扩展运算符 "`...`"

> 它好比 rest 参数的逆运算，将一个数组转为用逗号分隔的参数序列

## 对象的扩展

> 属性名表达式如果是一个对象，默认情况下会自动将对象转为字符串[object Object]

## Proxy

> 要使得Proxy起作用，必须针对Proxy实例进行操作，而不是针对目标对象进行操作

## Promise

> 注意，调用resolve或reject并不会终结 Promise 的参数函数的执行。

### Promise.prototype.catch

是`.then(null, rejection)`或`.then(undefined, rejection)`的别名，用于指定发生错误时的回调函数。另外，then方法指定的回调函数，如果运行中抛出错误，也会被catch方法捕获。

- reject方法的作用，等同于抛出错误。
- 如果 Promise 状态已经变成resolved，再抛出错误是无效的。

### Promise.all()
### Promise.race()

## Iterator

> 遍历器对象除了具有next方法，还可以具有return方法和throw方法。如果你自己写遍历器对象生成函数，那么next方法是必须部署的，return方法和throw方法是否部署是可选的。
> 注意，return方法必须返回一个对象，这是 Generator 规格决定的。

## Generator

> 由于 Generator 函数就是遍历器生成函数，因此可以把 Generator 赋值给对象的Symbol.iterator属性，从而使得该对象具有 Iterator 接口。
> next()、throw()、return()这三个方法本质上是同一件事，可以放在一起理解。它们的作用都是让 Generator 函数恢复执行，并且使用不同的语句替换yield表达式。

  - next()是将yield表达式替换成一个值。
  - throw()是将yield表达式替换成一个throw语句。
  - return()是将yield表达式替换成一个return语句。

## async函数

> async函数返回的 Promise 对象，必须等到内部所有await命令后面的 Promise 对象执行完，才会发生状态改变，除非遇到return语句或者抛出错误。也就是说，只有async函数内部的异步操作执行完，才会执行then方法指定的回调函数。
> async函数内部return语句返回的值，会成为then方法回调函数的参数。

### await命令
> 正常情况下，await命令后面是一个 Promise 对象，返回该对象的结果（`调用resolve函数的参数`）。如果不是 Promise 对象，就直接返回对应的值。

## Class的基本语法

> 实例属性除了定义在constructor()方法里面的this上面，也可以定义在类的最顶层