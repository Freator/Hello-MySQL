-- 创建整型表
create table my_int(
int_1 tinyint,
int_2 smallint,
int_3 int,
int_4 bigint
)charset utf8;


-- 插入数据
insert into my_int values(100,100,100,100); -- 有效数据
insert into my_int values('a','b','19','f'); -- 无效数据：类型限定
insert into my_int values(255,1000,10000,1000000); -- 错误，超出范围


-- 增加一个无符号类型
alter table my_int add int_5 tinyint unsigned;

-- 再次插入数据
insert into my_int values(127,1000,10000,100000,225);


-- 指定显示宽度为 1 ，再插入数据
alter table my_int add int_6 tinyint(1) unsigned;
insert into my_int values(127,0,0,0,255,255);


-- 不够宽度时前面填充 0 ，插入数据
alter table my_int add int_7 tinyint(2) zerofill;
desc my_int; -- 自动变成无符号的整形了
insert into my_int values(1,1,1,1,1,1,1);
insert into my_int values(100,100,100,100,100,100,100);


-- 创建浮点数表
create table my_float(
f1 float,
f2 float(10,2),  --  10 在精度范围之外
f3 float(6,2)   -- 6在精度范围之类
)charset utf8;


--  插入正常数据
insert into my_float values(1000.10,1000.10,1000.10); -- ok的
insert into my_float values(1234567890,12345678.90,1234.56); -- ok 的
insert into my_float values(9999999999,99999999.99,9999.99);  -- Max value
insert into my_float values(3e38,3.01e7,1234.56);

--  插入超出长度数据
insert into my_float values(123456,1234.123456768,123.9876543); -- 小数部分超出
insert into my_float values(123456,1234.12,12345.56);  -- 整数部分超出


-- 创建定点数表，以浮点数做对比
create table my_decimal(
f1 float(10,2),
d1 decimal(10,2)
)charset utf8;

insert into my_decimal values(12345678.90,12345678.90); -- OK
insert into my_decimal values(1234.123456,1234.1234356); -- 小数部分超长

-- 查看警告
show warnings;

insert into my_decimal values(99999999.99,99999999.99);
insert into my_decimal values(99999999.99,99999999.999); -- 定点数超出范围


-- 创建时间日期表
create table my_date(
d1 datetime,
d2 date,
d3 time,
d4 timestamp,
d5 year
)charset utf8;

insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',2015);

-- 时间使用负数
insert into my_date values('2018-1-13 11:30:38','2018-1-13','-211:30:38','2018-1-13 11:39:39',2015);
insert into my_date values('2018-1-13 11:30:38','2018-1-13','-2 11:30:38','2018-1-13 11:39:39',2015);    -- -2 表示过去两天


-- 年份使用两位
insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',69);
insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',70);

-- 修改timestamp数据，会发现有另外一个地方也改变了
update my_date set d1 = '2018-1-13 11:48:46' where d5 = 2069;

-- 创建枚举表并加入数据
create table my_enum(
gender enum('男','女','保密')
)charset utf8;

insert into my_enum values('男'),('保密'); -- ok 
insert into my_enum value('nan');        --  error

-- 将字段结果取出来进行 + 0 运算,证明存储的是数值而不是实际的字符串
select gender + 0 ,gender from my_enum;


-- 枚举的另外一种插入方式，再用上面一个语句查看结果
insert into my_enum values(1),(2); -- 1代表男2代表女




-- 创建集合表
create table my_set(
hobby set('篮球','足球','乒乓球','羽毛球','排球','台球','网球','棒球')
)charset utf8;

-- 集合中每一个元素对应一个二进制位

insert into my_set values('足球,台球,网球');
insert into my_set values(3); -- 请查看此语句的结果


-- 查看集合数据
select hobby + 0,hobby from my_set;


-- 98 转成二进制 01100010（逆序之后为01000110，其中1分别顺序对应足球，台球，网球）

-- 颠倒元素出现的顺序
insert into my_set values('网球,台球,足球');








-- 求出varchar 在utf8和GBK下的实际最大值
create table my_utf8(
name varchar(21845)    -- 21845 *3  = 65535 ,但还要加上 2 字节长度存储值，为65534
)charset utf8;

create table my_gbk(
name varchar(32767)  -- 32767 * 2 + 2 = 65534
)charset gbk;


-- 用以下代码查看  （以下两个表实际只用了65534个字节）

create table my_utf8(
name varchar(21844)    
)charset utf8;

create table my_gbk(
name varchar(32766)  
)charset gbk;


--  想要全部用完65535个字节，可以多使用一个字段
create table my_utf81(
age tinyint,
name varchar(21844)    
)charset utf8;

create table my_gbk1(
age tinyintl,
name varchar(32766)  
)charset gbk;

-- 发现以上还是不行，原因如下
-- Mysql记录中，如果任何一个字段允许为空，那么系统会自动
-- 从整个记录中保留一个字节存储NULL，想释放其字节，则要保证
-- 所有的字段都不允许为空，再查看以下代码


-- 释放null
create table my_utf82(
age tinyint not null,
name varchar(21844) not null    
)charset utf8;

create table my_gbk2(
age tinyint not null,
name varchar(32766) not null 
)charset gbk;


-- text占用10个字节长度证明
create table my_text(
name varchar(21841) not null,-- 21841 *3 +2 = 65525 字节
content text  not null       -- 10 字节
)charset utf8;


-- 创建班级表
create table my_class(
name varchar(20) not null,
room varchar(20)
)charset utf8;

-- comment 的作用
create table my_teacher(
name varchar(20) not null comment '姓名',
money decimal(10,2)not null comment '工资'
)charset utf8;

-- 设置默认值
create table my_default(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('男','女','保密') default '男'
)charset utf8;

insert into my_default (name) values('高强');
insert into my_default values('范立峰',18,default);



-- 请注意，本机的MySQL使用的默认字符集为GBK，上面的 my_default 
-- 表格插入数据后默认值显示不出来，但是使用下面的即可显示，因此断定是
-- 字符集的问题，这一点和视频中稍有不同  @tbc注
create table my_default_gbk(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('男','女','保密') default '男'
)charset gbk;

insert into my_default_gbk (name) values('高强');
insert into my_default_gbk values('范立峰',18,default);


