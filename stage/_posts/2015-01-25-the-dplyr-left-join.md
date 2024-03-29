---
layout: post
title: "dplyr中的join类函数的使用注意点"
description: ""
category: R
tags: [R, dplyr,tips]
comments: true
share: true
---
前一段时间在进行数据分析的时候，因为追究效率，就没有使用base包中的`merge`函数，而是使用了
`dplyr::left_join`。和`merge`一样，在对两个数据框进行关联的时候，会对列名相同的列进行重命名，
一般都是在结尾加上x或者y。在这次使用的过程中，因为多次使用`left_join`，并且在每次关联结束之后
没有对列名进行重命名，于是悲剧就产生了。关于悲剧是怎么产生的，下面构建了一个例子：

{% highlight R %}
require(dplyr)
# 使用left_join的得到的结果，没有返回警告
df1 <- data.frame(x = 1:5,y = 1:5,y.y = 5:1)
df2 <- data.frame(x = 1:5,y = 1:5)
lfmp <- left_join(df1,df2,"x",copy = TRUE)
left_join(lfmp,df1,by="x",copy = TRUE)
#   x y.x y.y.x y.y.x y y.y.y
# 1 1   1     5     5 1     5
# 2 2   2     4     4 2     4
# 3 3   3     3     3 3     3
# 4 4   4     2     2 4     2
# 5 5   5     1     1 5     1

# 使用merge返回的结果，同时返回警告
metmp <- merge(x = df1,y = df2,by = "x")
merge(x = metmp,y = df1,by = "x")
#   x y.x y.y.x y.y.x y y.y.y
# 1 1   1     5     1 1     5
# 2 2   2     4     2 2     4
# 3 3   3     3     3 3     3
# 4 4   4     2     4 4     2
# 5 5   5     1     5 5     1
{% endhighlight %}
从上面的例子中可以看到，在使用`left_join`的时候第四列的值不是期望的值，而且第三列的列名和
第四列的列名是一样的。啊哈，原来是因为列名是一样的，所以该列的值被篡改了。

然后去看了`dplyr::left_join`的源码,在`left_join_impl`（[代码在这里](https://github.com/hadley/dplyr/blob/11dfbcacb68937312a02feb3345e000fcdb3c54e/src/dplyr.cpp#L1143)）
中有一个函数为`subset`（[代码在这里](https://github.com/hadley/dplyr/blob/11dfbcacb68937312a02feb3345e000fcdb3c54e/src/dplyr.cpp#L919)）。
在里面我们可以看到里面修改列名的方法以及进行赋值的方法,特别需要注意的
地方为[这里](https://github.com/hadley/dplyr/blob/11dfbcacb68937312a02feb3345e000fcdb3c54e/src/dplyr.cpp#L960)。

解决方案有两个：

* 修改`subset`这个函数的源代码
* 每次join之后修改列名

从实用和实现来说，都是第二种方案比较好。使用`left_join`之所以容易犯以上的错误主要是因为在使用的过程
中没有出警告，而且如果列名正常的话（指没有`.x`这种字符）是要等到第七次join才会出错的。所以，为了以后
的方便，还是把`left_join`的R代码处理下，加上列名的判断的异常处理就可以了，修改源代码之后重新编译下，
下次再也不会出错了。哦耶~

作者已经修复 https://github.com/tidyverse/dplyr/issues/896

-EOF
