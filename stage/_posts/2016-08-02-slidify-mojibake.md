---
layout: post
title: "slidify中的中文乱码解决方案"
description: ""
category: R
tags: [R,slidify]
comments: true
share: true
---
slidify一直是做slides的一个很好的选择，但是在Windows平台下的一直存在乱码的问题。引起的原因
就是Windows下的编码混乱，鉴于编码这件事情本来就是一个无敌大坑，所以就不展开说了。

之前为了解决中文问题，最快的方法就是换到Mac或者Linux上去，但是仍然无法解决在必须用Windows
的场合下遇到的问题。

为了测底解决中文的乱码问题，也在网上查了相关的资料，从Stack Overflow到github都没有找到比较好的
解决方案，于是打开了slidify的源码自己改改吧。查看了代码，发现主要有三个地方存在编码问题。

- `readLines`在读取数据的时候需要指定编码，否则在Windows下会跟随系统，默认为`GBK`的编码

- `yaml.load`是`yaml`package中的函数，返回的字符串是没有编码信息的，查看了源码是C写成的，
本来是想改C代码的，但是本着迅速解决问题的原则，直接对返回值进行`Encoding`操作了，改成了`UTF-8`
的编码

- `cat`用来生成最后的html文件，这里也是没有指定写文件的时候的编码的，这样的问题就是网页指定
的编码是`UTF-8`,但是最后写入是使用`GBK`编码写入的。

解决以上三个问题也就解决了中文乱码的问题。最后，放上修改版本的slidify的链接，可以直接访问我的
[github](https://github.com/junjiemao/slidify)。使用`devtools::install_github('junjiemao/slidify')`
即可安装使用。
