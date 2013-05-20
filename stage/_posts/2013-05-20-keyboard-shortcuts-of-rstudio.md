---
layout: post
title: "Rstudio快捷建速查"
description: ""
category: R
tags: [R,快捷键,速查表]
---
{% include JB/setup %}
手不离键盘是我们的追求，这也是我学习使用Emacs的主要原因之一，虽然很享受Emacs那种学会一招大小通吃的感觉，即使学习曲线陡了一点也还是值得的。但是Rstudio的吸引力实在太大了，使得我不得不放弃Emacs的ESS而投奔她。为了达到手不离键盘的程度，决定学习下快捷键，当我打开帮助文档的那一刹那惊呆了——怎么能有这么多快捷键，怎么能这么没规律！现在想想Emcas还是很人性的。以下是在尝试使用的时候记录下来的对键位的描述，其实就是对英文文档的简单翻译，自己记录下来留用。需要注意的是，无论在Windows下还是在Linux下，都会有少数几个快捷键会和系统快捷键冲突。我是没找到在Rstudio中设置快捷键的地方，如果需要只能把系统快捷键换了。

#控制台

<table>
<tr>
<td>描述</td>
<td>键位(Windows和Linux)</td>
</tr>

<tr>
<td>光标移动到控制台</td>
<td>Ctrl+2</td>
</tr>

<tr>
<td>清除控制台</td>
<td>Ctrl+L</td>
</tr>

<tr>
<td>移动光标到行首</td>
<td>Home</td>
</tr>

<tr>
<td>移动光标到行尾</td>
<td>End</td>
</tr>

<tr>
<td>调出以前使用过的命令</td>
<td>上箭头/下箭头</td>
</tr>

<tr>
<td>弹出历史命令的菜单</td>
<td>Ctrl+上箭头</td>
</tr>

<tr>
<td>中断当前正在执行的命令</td>
<td>Esc</td>
</tr>

<tr>
<td>改变工作目录</td>
<td>Ctrl+Shift+K</td>
</tr>
</table>


#源代码编辑区
<table>
<tr>
<td>描述</td>
<td>键位(Windows和Linux)</td>
</tr>

<tr>
<td>跳到上方的前往文件和函数的搜索框</td>
<td>Ctrl+.</td>
</tr>

<tr>
<td>使光标移向源文件编辑区</td>
<td>Ctrl+1</td>
</tr>

<tr>
<td>新建文件(在Windows和Chrome中不起作用)</td>
<td>Ctrl+Shift+N</td>
</tr>

<tr>
<td>打开文件</td>
<td>Ctrl+O</td>
</tr>

<tr>
<td>保存文件</td>
<td>Ctrl+S</td>
</tr>

<tr>
<td>关闭当前文件（Chrome中不起作用）</td>
<td>Ctrl+W</td>
</tr>

<tr>
<td>关闭当前文件（仅在Chrome中其作用）</td>
<td>Ctrl+Alt+W</td>
</tr>

<tr>
<td>关闭所有打开的文件</td>
<td>Ctrl+Shift+W</td>
</tr>

<tr>
<td>预览HTML</td>
<td>Ctrl+Shift+Y</td>
</tr>

<tr>
<td>使用Knitr转换成HTML</td>
<td>Ctrl+Shift+H</td>
</tr>

<tr>
<td>编译PDF</td>
<td>Ctrl+Shift+I</td>
</tr>

<tr>
<td>插入chunk（Sweave和Knitr）</td>
<td>Ctrl+Atl+I</td>
</tr>

<tr>
<td>插入代码段</td>
<td>Ctrl+Shift+R</td>
</tr>

<tr>
<td>运行当前行或者选择的行</td>
<td>Ctrl+Enter</td>
</tr>

<tr>
<td>再次运行上次选择的块</td>
<td>Ctrl+Shift+R</td>
</tr>

<tr>
<td>运行当前文件</td>
<td>Ctrl+Alt+R</td>
</tr>

<tr>
<td>从文件开头运行到该行</td>
<td>Ctrl+Alt+B</td>
</tr>

<tr>
<td>从该行运行到文件结束</td>
<td>Ctrl+Alt+E</td>
</tr>

<tr>
<td>运行当前函数的定义部分</td>
<td>Ctrl+Alt+F</td>
</tr>

<tr>
<td>运行当前的Sweave快</td>
<td>Ctrl+Alt+C</td>
</tr>


<tr>
<td>运行下一个Sweave块</td>
<td>Ctrl+Alt+N</td>
</tr>

<tr>
<td>加载一个文件</td>
<td>Ctrl+Shift+O</td>
</tr>

<tr>
<td>加载当前文件</td>
<td>Ctrl+Shift+S</td>
</tr>

<tr>
<td>加载当前文件，不输出结果</td>
<td>Ctrl+Shift+Enter</td>
</tr>

<tr>
<td>折叠选择的代码</td>
<td>ALt+L</td>
</tr>

<tr>
<td>展开折叠的代码</td>
<td>Alt+Shift+L</td>
</tr>

<tr>
<td>折叠左右代码</td>
<td>Alt+O</td>
</tr>

<tr>
<td>展开所有代码</td>
<td>Alt+Shift+O</td>
</tr>

<tr>
<td>想要达到的行</td>
<td>Shift+Alt+G</td>
</tr>

<tr>
<td>跳转到</td>
<td>Shift+Alt+J</td>
</tr>

<tr>
<td>切换到选项卡</td>
<td>Ctrl+Alt+Down(Linux会和默认的系统快捷键冲突)</td>
</tr>

<tr>
<td>上一个选项卡</td>
<td>Ctrl+PageUp</td>
</tr>

<tr>
<td>下一个选项卡</td>
<td> Ctrl+PageDown</td>
</tr>

<tr>
<td>第一个选项卡</td>
<td> Ctrl+Shift+Alt+Left</td>
</tr>

<tr>
<td>最后一个选项卡</td>
<td> Ctrl+Shift+Alt+Right</td>
</tr>

<tr>
<td>选项卡向后导航</td>
<td> Ctrl+F9</td>
</tr>

<tr>
<td> 选项卡想钱导航</td>
<td> Ctrl+F10</td>
</tr>

<tr>
<td>把选择的代码提取为一个函数</td>
<td> Ctrl+Shift+U</td>
</tr>

<tr>
<td>行缩进进行整理代码 </td>
<td>Ctrl+I</td>
</tr>

<tr>
<td> 注释/消除注释当前行或者所选代码</td>
<td> Ctrl+Shift+C</td>
</tr>

<tr>
<td>回流注释（不知道什么意思）</td>
<td>Shift+Ctrl+/ </td>
</tr>

<tr>
<td>上下移动整行 </td>
<td>Alt+上肩头/下箭头</td>
</tr>

<tr>
<td>复制行</td>
<td> Shift+Alt+上箭头/下箭头</td>
</tr>

<tr>
<td>跳转到匹配的括号</td>
<td> Ctrl+P</td>
</tr>

<tr>
<td>查找替换</td>
<td> Ctrl+F</td>
</tr>

<tr>
<td>查找上一个</td>
<td>Shift+F3(Windows);Ctrl+Shift+G(Linux) </td>
</tr>

<tr>
<td>查找下一个</td>
<td> F3（Windows）；Ctrl+G</td>
</tr>

<tr>
<td>在文件中寻找</td>
<td> Ctrl+Shift+F</td>
</tr>

<tr>
<td>检查拼写（需要字典的支持）</td>
<td> F7</td>
</tr>
<tr>
</tr>
</table>

未完，头晕了，比学Emacs的时候还有郁闷，明天继续。