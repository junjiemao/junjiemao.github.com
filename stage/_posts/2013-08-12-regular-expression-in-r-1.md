---
layout: post
title: "R中使用正则表达式（1）"
description: ""
category: R
tags: [R,速查表,正则表达式]
---
{% include JB/setup %}


正则表达式对我来说一直是一个不明觉厉的东西，但是由于在处理文本的时候是必须使用的，所以稍微明一下总是好的。由于平时使用R比较多，所以就以在R中使用正则表达式做一个笔记，这样以后忘记了的时候还可以查看。

以下主要参考的是Ben Forta的《正则表达式必知必会》的中文版，其他的正则表达式的教材大多很厚，到现在为止我就发现这本比较靠谱，希望大家有更加好的可以给我推荐，谢谢。

# R中怎么使用正则表达式
在R中很多涉及到字符处理的函数都是可以使用正则表达式的，我们就以最正常字符处理函数为例：

{% highlight r %}
regexec(pattern, text, ignore.case = FALSE, fixed = FALSE, useBytes = FALSE)
# pattern就是我们要写的正则表达式 text是需要处理的文本
# ignore.case表示是不是忽略大小写
# fixed为FALSE则使用正则表达式匹配，否则就使用精确匹配，也就是把'.'之类的字符当作实义字符
# useBytes 暂时没有使用过
{% endhighlight %}

接下来都是在grep上使用正则表达式，其他的都是差不多的。

# R中使用正则表达式实战
## 匹配纯文本

{% highlight r %}
x <- "Hello ,my name is Ben.Please visit my website"
m <- regexec(pattern = "Ben", text = x)
regmatches(x, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "Ben"
{% endhighlight %}



{% highlight r %}

# 全局匹配
m <- regexec(pattern = "my", text = x)  #注意只是给出第一个匹配的，要全局匹配需要使用gregexpr
regmatches(x, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "my"
{% endhighlight %}



{% highlight r %}

m <- gregexpr(pattern = "my", text = x)
regmatches(x, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "my" "my"
{% endhighlight %}



{% highlight r %}

# 不考虑字母大小写
m <- gregexpr(pattern = "My", text = x, ignore.case = TRUE)
regmatches(x, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "my" "my"
{% endhighlight %}


## 匹配任意字符
正则表达式中使用点(.)来匹配一个 **一个或者多个** 字符，可以匹配任意单个字符串，包括点(.)本身。

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls")
grep(pattern = "sales.", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales.xls"   "sales2.xls"  "sales3.xls"  "sales.4.xls"
{% endhighlight %}



{% highlight r %}

# 点(.)可以连着使用也可以分开使用
grep(pattern = ".a.", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales.xls"   "sales2.xls"  "sales3.xls"  "sales.4.xls" "apac1.xls"  
## [6] "na1.xls"     "na2.xls"     "sa1.xls"
{% endhighlight %}



{% highlight r %}
grep(pattern = ".a..", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales.xls"   "sales2.xls"  "sales3.xls"  "sales.4.xls" "apac1.xls"  
## [6] "na1.xls"     "na2.xls"     "sa1.xls"
{% endhighlight %}

## 匹配特殊字符
匹配特殊字符需要进行转义，转义一般使用\，但是在R中我们使用\\来表示，这个是需要注意的。还有一个需要注意的就是如果比需要表示\也是需要转义的。

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls")
grep(pattern = ".a.\\.", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "na1.xls" "na2.xls" "sa1.xls"
{% endhighlight %}



{% highlight r %}

x <- c("a\\d", "acd", "dsa")
grep(pattern = "a\\\\", x = x, value = TRUE)  #需要注意在R中，\本身是要用\\表示的
{% endhighlight %}



{% highlight text %}
## [1] "a\\d"
{% endhighlight %}


## 匹配一组字符
我们需要的几个字符中的任意一个

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls")
# 我们需要sa开是和na开始的
grep(pattern = "[sn]a.\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "na1.xls" "na2.xls" "sa1.xls"
{% endhighlight %}



{% highlight r %}

text <- "The phrase regullar expression is often abbreciated as RegEx or regex"
m <- gregexpr(pattern = "[Rr]eg[Ee]x", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "RegEx" "regex"
{% endhighlight %}


## 利用字符区间
使用集合的时候对于有规律的我们可以使用区间来表示

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls")
grep(pattern = "..[0123456789]\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "orders3.xls" "sales2.xls"  "sales3.xls"  "sales.4.xls" "apac1.xls"  
## [6] "na1.xls"     "na2.xls"     "sa1.xls"
{% endhighlight %}



{% highlight r %}
grep(pattern = "..[0-9]\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "orders3.xls" "sales2.xls"  "sales3.xls"  "sales.4.xls" "apac1.xls"  
## [6] "na1.xls"     "na2.xls"     "sa1.xls"
{% endhighlight %}



{% highlight r %}
grep(pattern = "..[0-2]\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales2.xls" "apac1.xls"  "na1.xls"    "na2.xls"    "sa1.xls"
{% endhighlight %}

这里只要是开始和结尾是合法的ASCII字符都是可以的，不过常用的还是字符区间和数字区间。

## 取非匹配

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls", "sam.xls")
grep(pattern = "..[^0123456789]\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales.xls" "sam.xls"
{% endhighlight %}



{% highlight r %}
grep(pattern = "[ns]a[^0-9]\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sam.xls"
{% endhighlight %}


## 匹配空白字符
空白字符有换页符\f，换行符\n，回车符\r，制表符\t，垂直制表符\v。
在匹配的时候记得转义就好了

{% highlight r %}
text <- "I am Justin\nHello   world\n"  #在justin和world之间换行了
m <- gregexpr(pattern = "\n.*", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "\nHello   world\n"
{% endhighlight %}

## 匹配特定的字符类型
### 匹配数字
可以使用[0-9]来匹配数字，也可以使用\d来匹配数字使用\D来匹配非数字,但是在R中我们要使用\\d和\\D来替代

{% highlight r %}
x <- c("sales.xls", "orders3.xls", "sales2.xls", "sales3.xls", "sales.4.xls", 
    "apac1.xls", "na1.xls", "na2.xls", "sa1.xls", "sam.xls")
grep(pattern = "..\\d\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "orders3.xls" "sales2.xls"  "sales3.xls"  "sales.4.xls" "apac1.xls"  
## [6] "na1.xls"     "na2.xls"     "sa1.xls"
{% endhighlight %}



{% highlight r %}
grep(pattern = "..\\D\\.xls", x = x, value = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "sales.xls" "sam.xls"
{% endhighlight %}

### 匹配字母和数字
匹配所有的字母和数字，用\w表示，等价于[0-9a-zA-Z]我们用\W表示非字母和数字。

{% highlight r %}
text <- "\n11213\nA1C2E3\n48075\nM184F2\n90046\nH1H2H2\n"
m <- gregexpr(pattern = "\\w\\d\\w\\d\\w\\d", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "A1C2E3" "M184F2" "H1H2H2"
{% endhighlight %}

### 匹配空白字符
\s，包含我们上面提到的所有的空白字符
### 匹配十六进制和八进制数值
使用\x0后跟十六进制数，\0后面跟八进制数

## 使用POSIX字符类
可以在R的帮助文档查看那些可以使用的

## 匹配一个或者多个字符
使用加号("+")来匹配一个或者多个字符

{% highlight r %}
text <- "Send personal emain to ben@forta.com or spam@gmail.com"
m <- gregexpr(pattern = "\\w+@\\w+\\.\\w+", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "ben@forta.com"  "spam@gmail.com"
{% endhighlight %}

## 匹配零个或者多个字符
使用星号(*)来匹配零个或者多个字符

{% highlight r %}
text <- "Hello ben@forta.com is my email address"
m <- gregexpr(pattern = "\\w+[\\w.]*@\\w+\\.\\w+", text = text)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "ben@forta.com"
{% endhighlight %}


## 匹配零个或者一个字符
使用问号(?)来匹配零个或者一个字符

{% highlight r %}
text <- "The URL is http://www.forta.com/,to connec securely use https://www.forta.com/ instead"
m <- gregexpr(pattern = "https?://[\\w./]+", text = text, perl = TRUE)  #注意perl参数的设置的结果的差异
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "http://www.forta.com/"  "https://www.forta.com/"
{% endhighlight %}


## 重复精确的次数
用大括号({})中写上数字来表示重复的次数

{% highlight r %}
text <- "<BOdy BGCOLOR=\"#336633\",TEXT=\"#FFFFFF\",MARGINWIDTH=\"0\">"
m <- gregexpr(pattern = "[[:xdigit:]]{6}", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "336633" "FFFFFF"
{% endhighlight %}

## 为重复设置一个区间
用大括号中写上范围({2,5})表示写重复的次数的范围

{% highlight r %}
text <- "4/8/03\n10-6-2004\n2/2/2\n01-01-01\n"
m <- gregexpr(pattern = "\\d{1,2}[-/]\\d{1,2}[-/]\\d{2,4}", text = text, 
    perl = TRUE)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "4/8/03"    "10-6-2004" "01-01-01"
{% endhighlight %}

## 至少重复的次数
使用{3,}表示至少重复3次

## 单词边界
使用\b表示单词的边界,\B表示不匹配边界

{% highlight r %}
text <- "The cat scattered his foof all over the room"
m <- gregexpr(pattern = "cat", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "cat" "cat"
{% endhighlight %}



{% highlight r %}

m <- gregexpr(pattern = "\\bcat\\b", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "cat"
{% endhighlight %}


## 字符串边界
使用乘方符号(^)和美元符号($)来表示首尾。

{% highlight r %}
text <- "This is bad,real bad.  <?xml version=\"1.0\"?> "
m <- gregexpr(pattern = "\\s*<\\?xml.*\\?>", text = text)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "  <?xml version=\"1.0\"?>"
{% endhighlight %}



{% highlight r %}
m <- gregexpr(pattern = "^\\s*<\\?xml.*\\?>", text = text)
regmatches(text, m)  #这样可以检验出不合法的xml文档
{% endhighlight %}



{% highlight text %}
## [[1]]
## character(0)
{% endhighlight %}


## 分行匹配模式
在分行模式下，还将匹配换行符后面的内容，使用分行模式需要使用(?m)来完成。

{% highlight r %}
text <- " %InLiNe_IdEnTiFiEr% \"#include<stdio.h>\"\n//ptrint Hello world\nint main()\n{\n//begin\nprintf(%,\"Hello world\");\nreturn 0;\n//end\n}\n"
m <- gregexpr(pattern = "^\\s*//.*$", text = text, perl = TRUE)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## character(0)
{% endhighlight %}



{% highlight r %}
m <- gregexpr(pattern = "(?m)^\\s*//.*$", text = text, perl = TRUE)
regmatches(text, m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "//ptrint Hello world" "//begin"              "//end"
{% endhighlight %}


## 子表达式
据一个例子来说明子表达式什么，比如我们处理"hellohellohello world hello world"这句话的时候我们想把其中的hello连在一起达到两次或者两次以上的字符串找出来，于是我们使用```hello{2,}```，但是发现出来的结果和我们想要的有很大的差距，因为表示次数的式子只对离着最近的一个字母起作用。我们想要达到预想的效果需要把hello当作是一个整体，这个时候我们就需要用到子表达式。

在正则表达式中，子表达式使用（）括起来就可以了，看下面的例子：

{% highlight r %}
text <- "hellohellohello world hello world"

m <- gregexpr(pattern = "hello{2,}", text = text)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## character(0)
{% endhighlight %}



{% highlight r %}

m <- gregexpr(pattern = "(hello){2,}", text = text)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "hellohellohello"
{% endhighlight %}


### 子表达式的嵌套
通过一个找出有效IP地址的例子中了解子表达式的嵌套，合法的IP必须满足数字小于255，我们看下面的例子:

{% highlight r %}
text <- "ping 167.42.223.4 and 56.256.2.3"
m <- gregexpr(pattern = "(((\\d{1,2})|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))\\.){3}((\\d{1,2})|(1\\d{2})|(a[0-4]\\d)|(25[0-5]))", 
    text = text)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "167.42.223.4"
{% endhighlight %}


## 回溯引用
回溯应用是对于子表达式来说的，简单的就是我们用一个符号来表示前面出现过的子表达式。通过下面的应用场合来了解，我们需要找出所有的标题：

{% highlight r %}
text <- "<BODY>\n<H1> H1</H1>\nBababallll~~~\n<H2> H2</H2>\nmiaomimaomi~~~~~\n<H3> H3</H3>\nwangwangwang~~~\n<H4> H4</H4>\n<BODY>"

m <- gregexpr(pattern = "<[hH][1-4]>.*?</[hH][1-4]>", text = text)  #懒惰型
regmatches(x = text, m = m)  #貌似可以工作，但是不通用
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "<H1> H1</H1>" "<H2> H2</H2>" "<H3> H3</H3>" "<H4> H4</H4>"
{% endhighlight %}



{% highlight r %}
m <- gregexpr(pattern = "<[hH][1-4]>.*</[hH][1-4]>", text = text)  #贪婪型
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "<H1> H1</H1>\nBababallll~~~\n<H2> H2</H2>\nmiaomimaomi~~~~~\n<H3> H3</H3>\nwangwangwang~~~\n<H4> H4</H4>"
{% endhighlight %}



{% highlight r %}
m <- gregexpr(pattern = "<[hH]([1-4])>.*</[hH]\\1>", text = text)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "<H1> H1</H1>" "<H2> H2</H2>" "<H3> H3</H3>" "<H4> H4</H4>"
{% endhighlight %}


## 回溯引用在替代中的使用
直接看下面的例子:

{% highlight r %}
text <- "balabala~~~  gmail@gmail.com miaomiaomaio~~"
m <- gregexpr(pattern = "\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+", text = text, 
    perl = TRUE)
regmatches(x = text, m = m)
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "gmail@gmail.com"
{% endhighlight %}



{% highlight r %}

sub(pattern = "(\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+)", replacement = "<A HREF=\\\"mailto:\\1\\\">\\1</A>", 
    x = text, perl = TRUE)
{% endhighlight %}



{% highlight text %}
## [1] "balabala~~~  <A HREF=\"mailto:gmail@gmail.com\">gmail@gmail.com</A> miaomiaomaio~~"
{% endhighlight %}

注意R中sub和gsub（sub的全局版本）函数的使用。下面再看一个对电话号码重新排序的问题：

{% highlight r %}
text <- "324-245-2521\n324-255-6156"
text <- gsub(pattern = "(\\d{3})(-)(\\d{3})(-)(\\d{4})", replacement = "\\(\\1\\) \\3-\\5", 
    x = text, perl = TRUE)
cat(text)
{% endhighlight %}



{% highlight text %}
## (324) 245-2521
## (324) 255-6156
{% endhighlight %}















