---
layout: post
title: "在slidify中使用rCharts"
description: ""
category: R
tags: [R,slidify,rCharts]
comments: true
share: true
---
slidify制作slides虽然很方便，但是插入rCharts等交互图片的时候会存在无法显示的问题。网上能找到很多解决方案，但是都比较复杂，本文介绍一个简单的实现方法——使用`iframe`元素插入到slides中。

实现的步骤为

- 把`rCharts`生成的交互结果存成html
- 使用`iframe`插入保存的html

以下演示下实现的整个过程
{% highlight r linenos %}
```{r defFun,echo=FALSE,warning=FALSE}
renderHtmlPlot <- function(obj,fileName){
  fileName <- paste0("/path/to/path/html/",
                     fileName,".html")
  obj$save(fileName)
  res <- paste0("<iframe src='",fileName,"'></iframe>")
  return(res)
}
```

## 绘制交互
```{r test1,echo=FALSE,results='asis',warning=FALSE,}
require(rCharts)
n1 <- nPlot(BrowPV ~ Date, 
      data = dat, 
       group = "Group",
      type = 'lineWithFocusChart')

## 修复X轴的显示
n1$xAxis(
  tickFormat = 
    "#!
      function(d){
        f =  d3.time.format.utc('%Y-%m-%d');
        return f(new Date( d*24*60*60*1000 ));
      }
    !#"
)
cat(renderHtmlPlot(n1,fileName = "test1"))
```
{%  endhighlight %}
