-- 创建表时直接增加主键

create table my_pri1(
name varchar(20) not null comment  '姓名',
number char(10) primary key comment '学号'
)charset gbk;

-- 复合主键
create table my_pri2(
number char(10) comment '学号 0000',
course char(10) comment '课程代码：学校代码+0000',
score tinyint unsigned default 60 comment '成绩',
-- 增加主键限制  学号和课程号对应，具有唯一性
primary key(number,course)
)charset gbk;


--  追加主键
create table my_pri3(
course char(10) comment '课程代码：学校代码+0000',
name varchar(10) comment '课程名字'
)charset gbk;
-- 方法一
alter table my_pri3 modify course char(10) primary key comment '课程代码：学校代码+0000';
--  方法二(这里采用此方法)
alter table my_pri3 add primary key(course);


-- 向my_pri1表插入数据
insert into my_pri1 values('古','0001'),('蔡','0002');
insert into my_pri2 values('0001','39010001',90),
('0001','39010002',85),
('0002','39010001',92);

--  使主键冲突，以下两组均不能插入成功
insert into my_pri1 values('刘','0002'); 
insert into my_pri2 values('0001','39010001',100);


-- 删除主键
alter table my_pri3 drop primary key;


-- 自增长(以下创建会有误)
create table my_auto(
id int auto_increment comment '自增长',
name varchar(10) not null
)charset gbk;


--  以下创建还是有错
create table my_auto(
id varchar(1) primary key auto_increment comment '自增长',
name varchar(10) not null
)charset gbk;

-- 嗯，以下是成功的
create table my_auto(
id int primary key auto_increment comment '自增长',
name varchar(10) not null
)charset gbk;

-- 触发自增长,以下都能正确插入
insert into my_auto(name) values('邓');
insert into my_auto values(null,'龚');
insert into my_auto values(default,'张');


-- 指定数据
insert into my_auto values(6,'何');
insert into my_auto values(null,'陈');


-- 修改表选项的值  ,当前值为 8 时
alter table my_auto auto_increment = 4; -- 向下修改，变小，无效
alter table my_auto auto_increment = 10;  -- 向大的修改，有效


-- 查看自增长对应的变量：
show variables like 'auto_increment%';


-- 修改自增长步长并再插入
set auto_increment_increment = 5; -- 表示一次自增 5 

insert into my_auto values(null,'刘');


-- 删除自增长
alter table my_auto modify id int primary key; -- 错误：主键理论是单独存在

alter table my_auto modify id int; -- 有主键时不用加primary key ，此处是成功的



-- 唯一键的表的创建
create table my_unique(
number char(10) unique comment '学号，允许为空',
name varchar(20) not null
)charset gbk;


-- 以下表创建后用 desc my_unique2查看会发现KEY字段变成PRI，但是这不是
-- 主键，只是这个表没有指明主键，系统会把这个唯一键当做主键
create table my_unique2(
number char(10) not null comment '学号，允许为空',
name varchar(20) not null,
unique key(number)
)charset gbk;


create table my_unique3(
id int primary key auto_increment,
number char(10) not null,
name varchar(20) not null
)charset gbk;

-- 追加唯一键
alter table my_unique3 add unique key(number);

-- 插入数据
insert into my_unique values(null,'曾'),('0001','晁'),
(null,'李');

insert into my_unique values('0001','周'); -- 插入错误，冲突了


-- 删除唯一键
alter table my_unique3 drop index number;




























