--  创建一个账户表
create table my_account(
number char(16) not null unique comment '账户',
name varchar(20) not null,
money decimal(10,2) default 0.0 comment '账户余额'
)charset gbk;

-- 插入数据
insert into my_account values
('0000000000000001','张三',1000),
('0000000000000002','李四',2000);

-- 设置主键方便查找
alter table my_account add id int primary key auto_increment first;


-- 事务安全

-- 开启事务
start transaction;


-- 事务操作1:李四账户减少
update my_account set money = money - 1000 where id = 2;

-- 证明以上操作没有实际操作数据表，再开一个cmd，进入myql查看

-- 事务操作2：张三账户增加
update my_account set money = money + 1000 where id = 1;


-- 提交事务
commit;



-- 回滚点操作
-- 开启事务
start transaction;

-- 事务处理：张三加钱
update my_account set money = money + 10000 where id = 1;

--  设置回滚点
savepoint sp1;

-- 银行扣税
update my_account set money = money - 10000 * 0.05 where id = 2; -- 错误


-- 回到回滚点
rollback to sp1;

-- 继续操作
update my_account set money = money - 10000 * 0.05 where id = 1;

-- 查看结果
select * from my_account;

-- 提交事务
commit;


-- 关闭自动事务提交 
set autocommit = off; -- 或者 = 0



-- 查看所有系统变量
show variables;

-- 查看具体变量值
select @@version,@@autocommit;



-- 自定义变量
set @name = '张三';

-- 查看自定义变量
select @name ;

-- 定义变量
set @age := 18;


-- 从表中获取数据赋值给变量
select @money = money from my_account;

-- 以上 = 为比较符号，以下是正确的赋值
select @money := money from my_account;



-- 从表中获取数据赋值给变量,where条件要加，不能获取多条
select id,money from my_account where id =2 into @id,@age;


-- 创建表
create table my_goods(
id int primary key auto_increment,
name varchar(20) not null,
price decimal(10,2) default 1,
inv int comment '库存数量'
)charset gbk;

insert into my_goods values
(null,'iphone6s',5288,100),
(null,'s6',6088,100);


create table my_order(
id int primary key auto_increment,
g_id int not null comment '商品ID',
g_number int comment '商品数量'
)charset gbk;


-- 触发器：订单生成一个，商品库存减少一个

-- 临时修改语句结束符
delimiter $$

create trigger after_order after insert on my_order for each row
begin
   -- 触发器内容开始
   update my_goods set inv = inv - 1 where id = 2;
   
end -- 结束触发器
$$  -- 自定义结束符

-- 修改语句结束符
delimiter ;


-- 查看所有触发器
show triggers;

-- 查看创建触发器
show create trigger 触发器名字;


-- 插入订单：
insert into my_order values(null,1,2);



-- 删除触发器
drop trigger after_order;




