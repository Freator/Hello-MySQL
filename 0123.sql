-- 注意，视频中的MYSQL默认UTF8字符集。本机MYSQL默认的是
-- gbk 字符集，此处与视频中相关文档讲解稍有出入


-- 创建外键
create table my_foreign1(
id int primary key auto_increment,
name varchar(20) not null comment '学生姓名',
c_id int comment '班级id',
foreign key(c_id) references my_class(id)
)charset gbk;


-- 创建表之后再增加外键，此时操作实际是修改表结构
create table my_foreign2(
id int primary key auto_increment,
name varchar(20) not null comment '学生姓名',
c_id int comment '班级id'
)charset gbk;


alter table my_foreign2 add
--  指定外键名
constraint student_class_1
-- 指定外键字段
foreign key(c_id)
-- 引用父表主键
references my_class(id);


-- 删除外键(无法直接从表结构中看出，要用show create table 语句查看创建语句)
alter table my_foreign1 drop foreign key my_foreign1_ibfk_1;

-- 插入数据，外键字段在父表中不存在时，查看错误信息
insert into my_foreign2 values(null,'张',4);


insert into my_foreign2 values(null,'项羽',1);
insert into my_foreign2 values(null,'刘邦',2);
insert into my_foreign2 values(null,'韩信',2);


-- 此时更新父表记录时
update my_class set id = 4 where id = 1; -- 失败，ID=1已经有学生
update my_class set id = 4 where id = 3; -- 可以

-- 插入数据(现在没有3班，但数据能插入成功)
insert into my_foreign1 values(null,'马超',3);

-- 再加外键时,会失败，因为数据已经存在
-- 在新增数据时，无法改变不能匹配数据的事实
alter table my_foreign1 add foreign key(c_id) references my_class(id);


-- 创建新表，指定外键模式，删除置空，更新级联
-- 请注意以下写法的标点符号，尤其是逗号，哪里加哪里不加
create table my_foreign3(
id int primary key auto_increment,
name varchar(20) not null comment '学生姓名',
c_id int comment '班级id',
-- 增加外键
foreign key(c_id) references my_class(id)
-- 指定删除模式
on delete set null
-- 指定更新模式
on update cascade
)charset gbk;


-- 插入数据
insert into my_foreign3 values(null,'刘备',1),
(null,'曹操',1),
(null,'孙权',1),
(null,'诸葛亮',2),
(null,'周瑜',2);

-- 保证my_class的主键只是my_foreign3的外键，其他约束删除
alter table my_foreign2 drop foreign key student_class_1;

-- 然后测试设置模式，更新父表主键,
update my_class set id = 3 where id = 1;
-- 查看my_class和My_foreign3表发现都更新了，这是级联更新


-- 删除父表主键,删除置空模式
delete from my_class where id = 2;





-- 联合查询(默认去重)
select * from my_class
union
select * from my_class;

-- 不去重，设置为all
select * from my_class
union all
select * from my_class;


-- 字段数相同，类型不同时(只保留第一个表的字段名字)
select id,c_name,room from my_class
union all
select name,number,id from my_student;


-- 需求，男生年龄升序，女生降序


select * from my_student where sex = '男' order by age asc
union
select * from my_student where sex = '女' order by age desc;

-- 嗯，上面那句是错的,下面这句是对的
(select * from my_student where sex = '男' order by age asc)
union
(select * from my_student where sex = '女' order by age desc);

-- 但是上面order by 没有生效，要搭配limit,后面数字无所谓
-- 下面这句是完全符合需求的语句
(select * from my_student where sex = '男' order by age asc limit 9999)
union
(select * from my_student where sex = '女' order by age desc limit 9999);







-- 标量子查询,查询班级PHP0710的所有学生
select * from my_student where c_id = (select id from my_class where c_name = 'PHP0710');



-- 增加数据以便后面的例子操作
insert into my_class values(1,'PHP1027','A206');


-- 列查询，所有在读班级的学生
-- 1 确定数据源：学生
-- select * from my_student where c_id in (?)
-- 2 确定有效的班级ID
-- select id from my_class
select * from my_student where c_id in (select id from my_class);


-- any ,some , all
select * from my_student where c_id =any(select id from my_class);
select * from my_student where c_id =some(select id from my_class);
select * from my_student where c_id =all(select id from my_class);


-- 否定,请认真体会结果区别
select * from my_student where c_id !=any(select id from my_class);
select * from my_student where c_id !=some(select id from my_class);
select * from my_student where c_id !=all(select id from my_class);


-- 行子查询，查出整个学生中年龄最大且身高最高的学生
-- 1 确定数据源
-- select * from my_student where age = ? and height = ?;
-- 2 确定最大年龄和身高
-- select max(age),max(height) from my_student;
-- 注意语句要分开
select * from my_student where
age = (select max(age) from my_student)
and
height = (select max(height) from my_student);

-- 但是上面不符合行子查询，因为行子查询需要构造行
-- 元素，行元素由多个字段构成,所以，下面一条语句是符合条件的
select * from my_student where
(age,height)  -- 行元素
= (select max(age),max(height) from my_student);



-- 表子查询
-- 需求：找出每个班最高的学生
-- 1.先按身高降序，然后确定数据源
-- select * from my_student order by height desc;
-- 2.从每个班中选出第一个学生
-- select * from my_student group by c_id;
-- 请注意对比下面两天语句结果，另外from 后面只能跟表名，所以要取表别名

select * from my_student group by c_id order by height desc; -- 这条语句是先分组再order by
select * from (select * from my_student order by height desc) as student group by c_id;


-- exists子查询

-- 查看返回结果
select exists(select * from my_student); --  = 1
select exists(select * from my_student where c_id = 1000); --  = 0

-- 需求 ：查询所有的学生，前提是班级存在
-- 1. 确定数据源
-- select * from my_student where ?;
-- 2 确定条件是否满足
-- exists (select * from my_class)

-- 对比
select * from my_student where 
exists (select * from my_class where id =3);
select * from my_student where 
exists (select * from my_class where id =5);




-- 视图：单表+ 多表
create view my_v1 as
select * from my_student;

create view my_v2 as
select * from my_class;

-- 有重名字段，下面创建不了
create view my_v3 as
select * from my_student as s left join my_class c on s.c_id = c.id;

-- 视图基表有多张的情况下不能有重复字段名
create view my_v3 as
select s.*,c.c_name,c.room from my_student as s 
left join my_class c 
on s.c_id = c.id;



-- 查看视图的创建语句，可以用table 或者view
show create view my_v1\G


-- 视图使用
select * from my_v1;
select * from my_v2;
select * from my_v3;



-- 修改视图
alter view my_v1 as
select id,name,age,sex,height,c_id from my_student;

-- 删除视图,只能用view，不能用table
create view my_v4 as select * from my_class;

drop view my_v4;






-- 多表视图插入数据，发现不能插入
insert into my_v3 values(null,'0008','张三丰','男',150,180,1,'PHP0326','D306');


-- 单表视图插入，但下面语句中国不包含
-- 基表中的学号，而且学号又不能为空，所有下面的语句插入也有错
insert into my_v1 values(null,'张无忌',68,'男',174,2);


-- 单表视图成功插入以下数据,基表中也会改变
insert into my_v2 values(2,'PHP0326','D306');


-- 多表视图不能删除数据
delete from my_v3 where id = 1;


-- 通过单表视图可以删除数据
delete from my_v2 where id = 4;


-- 多表视图更新数据
update my_v3 set c_id = 3 where id =5;



-- 视图：age 字段限制更新
create view my_v4 as 
select * from my_student where age > 30 with check option; 
-- 表示视图的年龄都是大于30 岁的，但是后面的 with check option 是
-- 表示在进行更新操作时不能把此条数据的年龄改成30岁以下

-- 将视图可以查到的数据改成年龄小于30，发现有错
update my_v4 set age =29 where id = 1;

-- 但可以修改让视图可以查到的数据，但是发现可以改却没有效果
-- 因为id = 6 的在视图中不存在
update my_v4 set age =129 where id = 6;


-- 查出整个学生中年龄最大且身高最高的学生
create view my_v5 as 
select * from my_student order by height desc;

select * from my_v5 group by c_id;

-- 发现执行后效果并不是我们想要的，原因出在视图算法上

-- 以下，指定算法为临时表,则结果正确
create algorithm = temptable view my_v6 as 
select * from my_student order by height desc;

select * from my_v6 group by c_id;

-- 查看版本
select @@version;

-- 创建myisam表
create table my_myisam(
id int)charset gbk engine = myisam;










