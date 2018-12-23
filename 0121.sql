insert into my_student values(null,'0001','张','男'),
(null,'0001','李','男'),
(null,'0001','王','女'),
(null,'0001','赵','男'),
(null,'0001','小','男');

-- 字段别名
select 
id,
number as 学号,
name as 姓名,
sex 性别 from my_student;

-- 多表数据源
select * from my_student,my_class;

-- 子查询(查出来额也是二维表，而且名字为as 后面的名字)
select * from (select * from my_student) as s;

-- 增加字段
alter table my_student add age tinyint unsigned;
alter table my_student add height tinyint unsigned;

-- 增加值:rand 取得一个0到1之间的随机数，floor向下取整,ceil向上取整
update my_student set age=floor(rand() * 20 + 20),
height=floor(rand() * 20 + 170);


-- 条件查询1：找学生ID为1，3，5的学生
select * from my_student where id = 1 || id = 3 || id = 5;
-- 或者
select * from my_student where id in(1,3,5);


-- 条件查询2：查出区间落在180-190身高之间的学生
select * from my_student where height >= 180 && height <= 190;
-- 或者(注意between是闭区间区域，并且左边的值必须小)
select * from my_student where height between 180 and 190;
-- 以下为有误的
select * from my_student where height between 190 and 180;



select * from my_student where 1; -- 1 代表条件都满足，即没有条件限制



-- 根据性别分组
select * from my_student group by sex;

-- 分组统计：身高高矮，年龄平均和总年龄
select sex,count(*),max(height),min(height),avg(age),sum(age) from my_student group by sex;

-- 将其中的一个age 设置为NULL后，再 使用以上语句以测试count语句不统计NULL
select sex,count(*),max(height),min(height),avg(age),sum(age) from my_student group by sex;
select sex,count(*),count(age),max(height),min(height),avg(age),sum(age) from my_student group by sex;

-- 自己复习的时候看一下avg函数是否也是这样


-- 设置降序输出
select sex,count(*),count(age),max(height),min(height),avg(age),sum(age) from my_student group by sex desc;

-- 改变了一些表结构和数据
alter table my_class add id int primary key auto_increment;
alter table my_student add c_id int ;
update my_student set c_id = ceil(rand()*3);


-- 接下来演示多字段分组：先班级后男女
select c_id,sex,count(*) from my_student group by c_id,sex;

--  group_concat 
select c_id,sex,count(*),group_concat(name) from my_student group by c_id,sex;


-- 统计
select c_id,count(*) from my_student group by c_id;


-- 回溯统计
select c_id,count(*) from my_student group by c_id with rollup;

-- 多字段分组回溯统计
select c_id,sex,count(*),group_concat(name) from my_student group by c_id,sex with rollup;


-- 求出所有班级人数大于等于2的学生人数
select c_id,count(*) from my_student group by c_id having count(*) >= 2;
-- 以下会报错
select c_id,count(*) from my_student where count(*) >= 2 group by c_id;

-- 优化以上查询，使用别名
select c_id,count(*) as total from my_student group by c_id having total >= 2;
-- 这一句又是错的
select c_id,count(*) as total from my_student where total >= 2 group by c_id;





-- 排序
select * from my_student group by c_id;
select * from my_student order by c_id;

-- 多字段排序：先班级后性别
select * from my_student order by c_id,sex desc;



-- 查询前两个学生
select * from my_student limit 2;

-- 限制起始位置
select * from my_student limit 2,2;














