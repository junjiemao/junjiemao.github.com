---
layout: post
title: "使用Google的小技巧"
description: ""
category: Google
tags: [Google,tips]
comments: true
share: true
---
首先反驳下，百度更懂中文是不成立的，搜索下『黃』（不是『黄』，而是『黃』），会发现百度给出的结果全部都是关于『黄』的，洋鬼子Google在第二条和第三条给出了正确的结果。

一般的搜索就会觉得其质量之高，而Google的高级指令则更加令人感到其强大，下面介绍一些小技巧和常见操作符的使用，本文大部分内容都摘自[Google Hacking技术手册](http://book.douban.com/subject/3676292/)，且只是整本书的冰山一角，想要自定义个人搜索引擎的看官可以看看这本书。

# 小技巧
* 首先得科学上网
* 可以直接对图片进行搜索
* [偏好设置](www.google.com/preferences)
* 防止跳转，如果你在中国大陆，但是你不想使用.hk的Google，那么可以使用www.google.com/ncr来防止跳转
* Google不区分大小写
* 使用**关键字**，**千万**不要使用类似于『我的U盘无法读取了怎么办？』这种句子搜索，如果非要这样，建议换成英文试试[WolframAlpha](http://www.wolframalpha.com/)，会发现一个不一样的世界。
* 通配符合和`*nix`中的通配符不一样
* 停词（比如the等等）可能会被忽略
* 最多搜索32个单词
* Google的空格表示的是并且（AND）的意思
* 操作符之后不能跟空格，要不然这个操作符就会被当做搜索词来进行搜索
* Google的URL语法，这个比较复杂，使用这个可以拼接出想要的查询请求

# Google的常见操作符
* 加号(+)会强制Google搜索后面的单词，比如搜索`tom+jerry`的结果中会同时含有两个单词。注意：加号必须是英文的加号！如果同时搜索两个词组需要加上引号，比如`“美丽的小鹿“ +“可爱的小猪“`，可以比较`美丽的小鹿+可爱的小猪`之间的差别。
* 减号(-)会要求Google去掉包含前面一个单词但是不包含后面一个单词的结果，比如查询词语`"熊猫" -"动物"`会搜索出包含『熊猫』但是不包含『动物』的结果。
* intitle和allintitle：对标题栏中的文字进行筛选，比如搜索`intitle:duang 草泥马`会搜索标题中有『下载』以及整个网页包括标题中有『草泥马』的结果，使用`allintitle:duang 草泥马`则要求标题中必须同时含有这两个关键词。
* allintext：只是在网页内容中搜索关键字
* inurl和allinurl：使用方法和intitle类似，比如搜索`inurl:草泥马`会得到几乎所有url中包含『草泥马』的链接。
* site：可以在站内搜索，当然这得在网站允许爬虫抓取的条件下，比如想在知乎下搜索『草泥马』，但是知乎自己的搜索做的渣烂烂的怎么办呢，可以试试`草泥马 site:zhihu.com`。注意：需要直接使用顶级域名，不能使用类似于`www.zhihu.com`或者`www.zhihu.com/xxx`这种。
* filetype：指定搜索的文件类型，你想找本kindle的电子书（啊喂~盗版可耻啊！），那么可以试试`爱你就像爱生命 filetype:mobi`。啊喂，有一条记录还是github的链接，好像有点讽刺。其他格式，比如xlsx，docx，pdf类似，文件的扩展名可以去filext.org上去看看。
* link：搜索与当前网页存在链接的网页,比如搜索`link:www.gov.cn`可以看到哪些网站链接了最牛逼的网站。
* inanchor：与link相似，不同的是，这个搜索的不是链接，是链接对应的文本，比如我们搜索`inanchor:中华人民共和国中央人民政府`,会得到带有『中华人民共和国中央人民政府』这个链接的网站，但是链接到哪里就不能确定了。
* cache：这个可查到被删除的网页，具体适用场景你知道的。
* numrange：搜索最大值和最小值之间的数，比如搜索`numrange:144-147`，会得到含有145之间146数值的结果。
* daterange：可以查询在某一段时间中发布的网页。
* info：显示Google对某一个站点的摘要信息，后面必须跟一个有效的URL，试试`info:www.zhihu.com`。
* related：显示相关站点，后面也必须跟一个有效的URL，试试`related:www.v2ex.com`
* stocks:搜索股票的信息，比如`stocks:google`
* define:搜索某个术语的定义，看看这段时间最热门的PM2.5，`define:pm2.5`
* weather：查询某一个城市的天气，`weather:南京`

