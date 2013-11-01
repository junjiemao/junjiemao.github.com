---
layout: post
title: "MySQL和MS SQL Server的一些区别"
description: ""
category: 数据库
tags: [MySQL,MS SQL]
---
{% include JB/setup %}
以前也用过MySQL的数据库，但是主要使用的都是查询，几乎没有使用到触发器、存储过程和函数等功能，最近需要从MS SQL Server迁移到MySQL，在使用过程中发现了一些区别，记录下来。关于查询语句的区别就不说了，主要说说触发器和存储过程等等的区别。

# 触发器
在MySQL中触发器的语法和MS SQL有点区别，下面是一个实例
{% highlight sql linenos %}
DELIMITER $$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `test`.`t_afterinsert_on_tab1`
AFTER INSERT ON `test`.`test`
FOR EACH ROW
BRGIN
sql语句；
END$$
{% endhighlight %}
和MS SQL不同的是MySQL的触发器类型有六种，分别是```AFTER/BEFORE```和```INSERT/UPDATE/DELETE```之间的组合。而MS SQL的触发器是```INSERT```,```UPDATE```,```DELETE```以及```INSTEAD OF```四种，其中前三种是之后触发，最后一种是之前触发。如果使用习惯了MS SQL的话，在写触发器中的SQL语句就会遇到一个小小的坑。比如有一张表格有x和y两列，需要一个触发器判断x大于0就插入x否则插入-x。如果习惯了M$ SQL会这样写：
{% highlight sql linenos %}
DELIMITER $$
CREATE TRIGGER	'test'.'error_trigger'
BEFORE INSTER ON `test`.`test`
FOR EACH　ROW
BEGIN
if new.x<0 then
inster into test values(-new.x,new.y);
else
inster into test values(new.x,new.y);
end if;
END$$
DELIMITER;
{% endhighlight %}
但是这样话是无法运行的，因为这样已经相当于循环插入了，正确的做法是:
{% highlight sql linenos %}
DELIMITER $$
CREATE TRIGGER	'test'.'error_trigger'
BEFORE INSTER ON `test`.`test`
FOR EACH　ROW
BEGIN
if new.x<0 then
set new.x=-new.x
else
set new.x=new.x #也可以不要这句
end if;
END$$
DELIMITER ;
{% endhighlight %}
在写触发器的时候还要注意的就是```new```和```old```的使用，这在MS SQL中是没有的。```new```加上点(.)加上列名就可以取出相应的列，```old```在删除的时候会用得比较多点。而在MS SQL中是需要使用```select```来取出的。

# 存储过程

存储过程没有很大的区别，发现有几点。

* 在MySQL中定义变量是不需要使用```@```符号的。

* 声明参数的格式为```输入（IN）变量还是输出（OUT）变量  变量名 变量类型```，比如 ```IN par_name INT```这种就表示是INT型的名字韦par_name的输入型变量。

* 在给变量赋值的时候和MS SQL也是有点区别的，在SQL中可以```selct  @a=a,@b=b from test```,其中```@a```、``` @b```为声明的变量,而在MySQL中只能```selet a,b into aa,bb  form test```,其中```aa```和```bb```为声明的变量。

* ERROR 1093错误经常发生在修改A表的时候使用了A表, 比如 A表中x，y列那么：
{% highlight sql linenos %}
UPDATE A
set A.x=new.x
where x in select x from A as t_xxxx;
{% endhighlight %}
这样是会报错的，解决方案为
{% highlight sql linenos %}
UPDATE A
set A.x=new.x
where x in
select x from(select x from A as t_xxxx)
{% endhighlight %}
因为对其原理不明白，个人猜想，这可能和SQL语句的内部执行顺序是有关系的，必须在更新之前查找出数据存入临时表中以备用。

# 函数
差别不是很大，注意的也就是参数的声明。

# 事件调度
MySQL中的EVENT功能是在5.1版本以后才有的，MS SQL也是有的，但是在08版的Express版本（用不起正版的完整版）是不支持调度的,所以只能苦逼的在外部写一个程序调用。创建在MySQL中创建EVENT的过程如下，具体的语法可以查看手册。
{% highlight sql linenos %}
show variables like 'event_scheduler';  #查看是否开启定时器  
set global event_scheduler=1;  #开启定时器 

DELIMITER $$
CREATE EVENT IF NOT EXISTS EVENT_CheckOnLine
ON SCHEDULE EVERY 30 SECOND
ON COMPLETION PRESERVE
DO BEGIN
call checkOnline(30);
END$$
DELIMITER ;

SELECT * FROM information_schema.EVENTS;   #查看事件的调用情况
{% endhighlight %}

# 其他需要注意的
在使用的过程还发现了其他一些可能导致的错误：

* ERROR 1175的解决方案是```SET SQL_SAFE_UPDATES=0```,原因是当要执行的SQL语句是进行批量更新或者删除的时候就会提示这个错误，这是一个保护机制，去掉就是了。

* workbench中编辑数据的时候（估计直接编辑数据也就在测试阶段使用），如果该表没有设置主键的时候是不能直接编辑数据的。吐槽下workbench的可视化编辑器真的```print('很'*10000)```难用的。

* 自增加(```AUTO_INCREMENT```)必须是主键的一部分，并且一张表只能有一个```AUTO_INCREMENT```属性,其可以是任何整数类型的数据。

就目前的使用来说，暂时就发现这些差异，随着使用肯定会有更加多的问题，到时候再补充。下次去了解下[Postgresql](http://www.postgresql.org/)这个号称 __"The world's most advanced open source database"__ 的数据库，这个数据库到目前为止也只是使用过她的查询语句。

