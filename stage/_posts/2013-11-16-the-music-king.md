---
layout: post
title: "The Music King"
description: ""
category: R
tags: [R, 吐槽, 生活]
comments: true
share: true
---

快收工的时候刷了下微博看到了有人很无聊地去统计了汪峰老师（没有黑他的意思，其实人家音乐还是很有力量的好吧）歌词的词频率。于是我想这得多有(wu)趣(liao)啊，于是就决定自己也统计下。于是的于是，我放弃了看TBBT的时间来给统计下汪峰老师的歌词。

要想统计就得有歌词啊，一个个找也不是懒人的风格，于是想到了[虾米](http://www.xiami.com/)上是有歌词的，去抓下来就好了嘛，其实也很简单，把网页抓下来解析一下。以前这活都是给Pyhon干的，今天想想用R尝试下吧。R解析HTML应该可以用XML包，但是因为以前都是使用Python来解析HTML,所有XML包压根就没有用过，于是决定自己写正则表达式来完成吧。


# 抓取歌词
汪峰在虾米上的ID是887，使用```http://www.xiami.com/artist/album/id/887/d//p//page/1```的网址可以直接查看其专辑。

我们首先获得其专辑的信息，这里主要是名字和专辑的链接。

{% highlight r linenos %}
artistSearch <- c("http://www.xiami.com/artist/album/id/887/d//p//page/1",
                  "http://www.xiami.com/artist/album/id/887/d//p//page/2")
text <- getURL(artistSearch)
m <- gregexpr(pattern="<p class=\"name\">.*<strong>",text=text,perl=TRUE)
album <- regmatches(x=text,m=m)

#取得专辑的名字
getName <- function(text){
m=gregexpr(pattern="(?<=title=\").*(?=\")",text=text,perl=TRUE) #需要使用正则的零宽度断言
return(regmatches(x=text,m=m))
}

#取得专辑的链接
getLink <- function(text){
m=gregexpr(pattern="(?<=href=\").*[0-9](?=\")",text=text,perl=TRUE) #需要使用正则的零宽度断言
return(regmatches(x=text,m=m))
}

#获得专辑的名字和链接
albumDetails <- data.frame(name=unname(unlist(sapply(X=ablum,FUN=getName,simplify="vector"))),
                          link=unname(unlist(sapply(X=ablum,FUN=getLink,simplify="vector"))))

> ablumDetial
                       name              link
					   1                  生来彷徨  /album/784338853
					   2                  一起摇摆  /album/580530673
					   3    汪峰2011生无所求演唱会 /album/2075241743
					   4                  生无所求     /album/478379
					   5              像梦一样自由     /album/432313
					   6            信仰在空中飘扬     /album/337989
					   7                  勇敢的心       /album/4423
					   8                怒放的生命       /album/4424
					   9  Live In Beijing 飞得更高       /album/4425
					   10                   笑着哭       /album/4426
					   11       爱是一颗幸福的子弹       /album/4427
					   12  十七岁的单车 电影原声带     /album/168383
					   13             花火(台湾版)     /album/374017
					   14                     花火       /album/4428

{% endhighlight %}

以上获得了专辑的名字和专辑的链接地址，接下来要做的就是去这个专辑中找到这些歌曲然后找到这些歌曲的歌词就可以了。

{% highlight r linenos %}
#获取专辑中歌曲信息
getSongDetails  <- function(ablumDetails){
text <- getURL(url=paste0("http://www.xiami.com",ablumDetails$link))
m=gregexpr(pattern="(?<=<td class=\"song_name\">).*?(?=</a>)",text=text,perl=TRUE) #需要使用正则的零宽度断言 非贪婪
songs <- regmatches(x=text,m=m)
#获取歌曲名字
getName <- function(text){
m=gregexpr(pattern="(?<=title=\"\">).*",text=text,perl=TRUE) #需要使用正则的零宽度断言,
return(regmatches(x=text,m=m))
}
#歌曲链接名字
getLink <- function(text){
m=gregexpr(pattern="(?<=<a href=\").*[0-9](?=\")",text=text,perl=TRUE) #需要使用正则的零宽度断言
return(regmatches(x=text,m=m))
}
songDetails <-  data.frame(name=unname(unlist(sapply(X=songs,FUN=getName,simplify="vector"))),
link=unname(unlist(sapply(X=songs,FUN=getLink,simplify="vector"))))
return(songDetial)
}

#获得歌曲的信息
songDetail <- getSongDetail(ablumDetial)


#获取歌词
getLrc <- function(songDetail){
text <- getURL(url=paste0("http://www.xiami.com/",songDetail$link))
m=gregexpr(pattern="(?<=<div class=\"lrc_main\">)[^..]*?(?=<.div>)",text=text,perl=TRUE) #需要使用正则的零宽度断言 非贪婪 注意空行的匹配
lrc <- regmatches(x=text,m=m)
lrc <- gsub(pattern="(\\s)",replacement="",x=lrc)
lrc <- gsub(pattern="<br/>",replacement="\n",x=lrc)
return(lrc)
}

Lrc <- getLrc(songDetail)

#把歌词的信息加入
songDetail$Lrc <- Lrc

> songDetail[1,]
      name             link
	  1 生来彷徨 /song/1772331683
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Lrc
																																																																																																																																																																																																 1 每天走在疯狂逐梦的大街上\n我们精神褴褛却又毫无倦意\n徘徊着寻找着那虚空的欢愉\n奔波着抗争着那无常的命运\n\n朋友啊这生活会把你的心伤烂\n可它从来就不会有一丝怜悯\n再也别象个傻瓜一样的哭了\n因为象我们这样的人生来彷徨\n\n传真机到炼钢厂有一万光年\n那只是我们失梦之路的起点\n妈妈你善良的孩子还没放弃\n他想在今夜的街上爱到死去\n\n朋友啊这世界会将你的梦破败\n而它从来就不会有一丝同情\n再也别象个疯子一样的拼了\n因为象我们这样的人生来彷徨\n\n路上散落着花朵般受伤的英雄\n如同我们一起挣扎着的那些片段\n明天我们是否活着却依然不在\n明天我们是否存在却迷惘依然\n\n朋友啊这生活会把你的骨折断\n而它从来就只是在袖手旁观\n不如象一块石头一样的滚吧\n因为象我们这样的人生来彷徨\n\n朋友啊这世界会将你的爱破灭\n而它从来就不会给一次拯救\n不如让我们一起放任自流吧\n反正象我们这样的人生来彷徨
{% endhighlight %}

# 分词

接下来就是统计词频率了,分词使用分词包[Rwordseg](http://jliblog.com/app/rwordseg)。
{% highlight r linenos %}
library(Rwordseg)
segWords <- segmentCN(strwords=songDetail$Lrc,nature=TRUE)

segWords <- unlist(segWords)
stopwords <- read.table("./Document/Temp/stopwords.txt")
segWords <- segWords[!segWords%in%c("的","是","在","也","得","地","制作人","录音师")]

#去掉ul
segWords <- segWords[!names(segWords)=="ul"]
#去掉uj
segWords <- segWords[!names(segWords)=="uj"]


#统计动词
verbWords <- segWords[names(segWords)=="v"]
x <- as.data.frame(table(verbWords))
x[order(x$Freq,decreasing=TRUE),][1:30,]

#统计名词
nounWords <- segWords[names(segWords)=="n"]
x <- as.data.frame(table(nounWords))
x[order(x$Freq,decreasing=TRUE),][1:30,]

#统计形容词/副词语
aWords <- segWords[names(segWords)=="a"]
x <- as.data.frame(table(aWords))
x[order(x$Freq,decreasing=TRUE),][1:30,]

#统计量词
mWords <- segWords[names(segWords)=="m"]
x <- as.data.frame(table(mWords))
x[order(x$Freq,decreasing=TRUE),][1:30,]

{% endhighlight %}

# 结果
结果是基本上就是下面这样的
{% highlight sql linenos %}
#动词的统计
   verbWords Freq
   823        像  227
   900        有  191
   1          爱  173
   340        会  156
   515      没有  146
   618        让  135
   950      知道  120
   162        到  113
   868        要  110
   149        带   97
   426        可   94
   816        想   80
   493      录音   76
   447        来   73
   613        去   73
   166      等待   71
   341        混   67
   120      处理   64
   928        找   57
   428      可以   52
   538        能   51
   433      哭泣   49
   432        哭   48
   785        无   48
   986        走   47
   913      再见   44
   696        说   41
   407      觉得   39
   252      感到   38
   585      破碎   38


#名词的统计
nounWords Freq
574      生命  125
177      感觉  118
526        人  106
785        音   94
692        象   88
421        梦   85
203    工作室   78
408      妈妈   75
843      助理   64
711        心   53
305      键盘   51
293      吉他   50
589      世界   50
164        风   45
148      方向   40
627      天空   39
528      人们   37
227      孩子   36
1        爱情   33
804        雨   33
784      意义   32
386      灵魂   29
582      时光   28
783      意思   28
92       大地   26
201      工程   26
397    录音室   26
467      朋友   26
396    录音棚   24
767      阳光   24

#形容词和副词
 aWords Freq
 63    孤独   65
 144   美丽   42
 268   自由   37
 151   迷惘   32
 178   亲爱   32
 51    疯狂   28
 90    坚强   27
 12    悲伤   24
 22    灿烂   24
 236   幸福   21
 85    辉煌   17
 206     碎   16
 246   勇敢   16
 88    寂寞   15
 48    繁华   14
 102     紧   14
 150   迷茫   14
 14    蹩脚   13
 42      大   13
 56      高   13
 111     倦   13
 113   绝望   13
 125   快乐   13
 31    炽热   12
 132     乐   12
 251     远   12
 257   真实   12
 26      长   11
 70      好   11
 172   平静   11
{% endhighlight %}
最后肯定要总结下，要不然就文不对题了。

+ 其实汪峰歌还是很好的，就算不是Music King，可人家在章子怡心中就是King啊。
+ 章子怡很漂亮的，我基本不黑漂亮的女孩。
+ 那些把Music King翻译成“音帝”的人，你东西掉了……

嗯，差不多就这样。PS：这代码的显示太差劲了，等这个周末以后得把版面改改了。
