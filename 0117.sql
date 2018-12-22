--  my_class 表中插入数据
insert into my_class values('PHP0810','B203');
insert into my_class values('PHP0710','B203');

insert into my_class values('PHP0810','B205'); -- 主键冲突


--  冲突处理(发现有两行受影响，如果有自增长，需考虑当前
-- 自增长的值加了两次)
insert into my_class values('PHP0810','B205')
on duplicate key update
room = 'B205';


--  主键替换(若有冲突，则两行收影响，无冲突，则直接
--  插入数据且只有一行受影响)
replace into my_class values('PHP0710','A203');
replace into my_class values('PHP0910','A203');
 

 
 
-- 蠕虫复制创建表(只会复制结构不会复制数据)
create table  my_copy like my_gbk;



--  蠕虫复制
insert into my_copy select * from my_collate_bin;
insert into my_copy select * from my_copy;


-- 更新部分a变成c(前三条)
update my_copy set name = 'c' where name = 'a' limit 3;


-- 删除10条记录数
delete from my_copy where name = 'b' limit 10;


-- 清空表，重置自增长
truncate my_student;


--  select选项(以下两条语句相同)
select * from my_copy;
select all * from my_copy;


--  select去重
select distinct * from my_copy;







