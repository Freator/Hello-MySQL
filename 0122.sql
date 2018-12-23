-- 改变某个字段的位置，modify/change
alter table my_class change id id int first;

-- 交叉连接查询
select * from my_student cross join my_class;
-- 其中 from 后面的整个句子是数据源即先连接后查询



-- 内连接
select * from my_student inner join my_class on my_student.c_id = my_class.id ;
-- 等价于
select * from my_student inner join my_class on c_id = my_class.id;

-- 加上字段和表别名,显然后面的语句先执行才会有 s 和 c
select s.*,c.name as c_name,c.room from  
my_student as s inner join my_class as c
on s.c_id = c.id;

-- 当有一条记录中的 c_id为空时，这条记录匹配不会成功
update my_student set c_id = null where id = 5;

select s.*,c.name as c_name,c.room from  
my_student as s inner join my_class as c
on s.c_id = c.id;


--  左连接（外）,与内连接语法差不多，记录数不少于左表已有的记录数
select s.*,c.name as c_name,c.room from  
my_student as s left join my_class as c
on s.c_id = c.id;

-- 右连接，记录数不少于右表已有的记录数
select s.*,c.name as c_name,c.room from  
my_student as s right join my_class as c
on s.c_id = c.id;


-- 自然内连接
select * from my_student natural join my_class;

-- 改变某个相同字段的名字，使得两个表只有一个同名字段，modify/change
alter table my_class change name c_name varchar(20) not null;

-- 自然左外连接
select * from my_student natural left join my_class;


-- 外连接模拟自然外连接 ：using
select * from my_student left join my_class using(id);





