
-- 临时修改语句结束符
delimiter $$

create trigger after_order after insert on my_order for each row
begin
   -- 触发器内容开始：新增一条订单：old代表没有，new代表新的订单记录
   update my_goods set inv = inv - new.g_number where id = new.g_id;
   
end -- 结束触发器
$$  -- 自定义结束符

-- 修改语句结束符
delimiter ;


-- 查看触发器效果，
select * from my_goods;
select * from my_order;

-- 再插入订单记录，再查看结果
-- 插入订单：
insert into my_order values(null,1,2);




-- 触发器：订单生成之前要判断

-- 修改结束符
delimiter %%

create trigger before_order before insert on my_order for each row
begin
     -- 判断库存量,获取商品库存
	 select inv from my_goods where id = new.g_id into @inv;
	 -- 判断
	 if @inv < new.g_number then
	     -- 库存不够，暴力报错发，即执行一条错误语句
		 insert into XXX values(XXX);
	end if ;
end
%%
delimiter ;


-- 分别执行下面代码查看结果
select * from my_goods;
select * from my_order;

insert into my_order values(null,1,10000); 

select * from my_goods;
select * from my_order;


-- 定义两个变量
set @cn = '世界你好';
set @en = 'hello world';

-- 字符串截取(myql中的下标从1开始)
select substring(@cn,1,1);
select substring(@en,1,1);

-- 字符串长度
select char_length(@cn),char_length(@en),length(@cn),length(@en);

-- instr 判断字符串在某个具体的字符串存在，存在返回位置,没有找到返回0
select instr(@cn,'好'),instr(@en,'ac');

-- lpad 左填充
select lpad(@cn,20,'欢迎'),lpad(@en,20,'hello');


-- insert 替换函数(所有的操作不会改变数据本身)
select insert(@en,3,3,'y'),@en;

-- strcmp :字符串比较(-1/0/1：小、等、大)
set @f = 'hello';
set @s = 'hey';
set @t = 'HEY';

select strcmp(@f,@s),strcmp(@s,@t),strcmp(@s,@f);


-- 创建自定义函数,只有一条语句可以省略begin 和end
create function display1() return int
return 100;

-- 调用上述函数
select display1();



-- 查看所有函数(自定义函数属于指定的数据库，只有在当前数据库中才能调用，但是可以在任意数据库中查看)
show function status\G


-- 查看函数创建：
show create function display1;



-- 定义函数计算1到指定数之间的和
delimiter $$
create function display1(int_1 int)returns int
begin 
        -- 定义变量
	    set @i = 1;  -- @定义的变量为全局变量，没有的为局部变量
	    set @res = 0;
        -- 循环求和
	    while @i <= int_1 do
	        -- 求和：任何变量要修改必须使用set关键字
			-- mysql中没有 +=，++，--等符号
			set @res = @res + @i;
			-- 修改循环变量
			set @i = @i + 1;
		end while ;

        -- 返回值
		return @res;
end
$$
delimiter ;



-- 求和：5的倍数不加
delimiter $$
create function display2(int_1 int)returns int
begin 
	    declare i int default 1;
	    declare res  int default 0; -- 定义局部变量
        -- 循环求和
	    mywhile:while i <= int_1 do
		    if i % 5 = 0 then 
			      set i = i + 1;
			      iterate mywhile;
			end if;
			set res = res + i;
			-- 修改循环变量
			set i = i + 1;
		end while ;

        -- 返回值
		return res;
end
$$
delimiter ;




-- 创建存储过程
create procedure pro1() -- 过程中需要显示数据使用select
select * from my_goods;



-- 过程参数
delimiter $$
create procedure pro1(in int_1 int,out int_2 int,inout int_3 int)
begin 
    -- 先查看三个变量
	select int_1,int_2,int_3; -- int_2的值一定是null
end
$$
delimiter ;

-- 以下两中赋值都可以
set @int_1 = 1;
set @int_2 = 3;
set @int_3 := 3;

select @int_1,@int_2,@int_3;
call pro1(@int_1,@int_2,@int_3);
select @int_1,@int_2,@int_3;



-- 以下代码请逐步进行，以体会in/out/inout以及全局和局部的区别
delimiter $$
create procedure pro1(in int_1 int,out int_2 int,inout int_3 int)
begin 
    -- 先查看三个变量
	select int_1,int_2,int_3; -- int_2的值一定是null
	-- 修改局部变量
	set int_1 = 10;
    set int_2 = 100;
	set int_3 = 1000;
	-- 查看局部变量
	select int_1,int_2,int_3;
	-- 查看全局变量
	select @int_1,@int_2,@int_3;
	-- 修改全局变量
	set @int_1 = 'a';
	set @int_2 = 'b';
	set @int_3 = 'c';
end
$$
delimiter ;

-- 再设置变量调用过程
set @int_1 = 1;
set @int_2 = 3;
set @int_3 := 3;

call pro2(@int_1,@int_2,@int_3);


-- 过程调用完再查看结果，体会其中的变化
select @int_1,@int_2,@int_3;

