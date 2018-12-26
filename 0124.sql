
-- 单表数据备份
select * into outfile 'd:/mysql_data_temp/student.txt' from my_student;
select * into outfile 'd:/mysql_data_temp/class.txt' from my_class;


-- 指定备份处理方式
select * into outfile 'd:/mysql_data_temp/class.txt' 
-- 字段处理
fields 
enclosed by '"' -- 数据使用双引号包裹
terminated by '|' -- 使用竖线分隔字段数据
-- 行处理
lines
starting by 'START:'
from my_class;


-- 还原数据
load data infile 'd:/mysql_data_temp/class.txt'  into table my_class
-- 字段处理
fields 
enclosed by '"' -- 数据使用双引号包裹
terminated by '|' -- 使用竖线分隔字段数据
-- 行处理
lines
starting by 'START:';




-- SQL 备份，单表(注意没有分号，而且要先退出当前mysql服务器：\q)
-- 下面的-proot中间请不要空格，不然会麻烦
mysqldump -uroot -proot mydatabase my_student > D:/mysql_data_temp/student.sql


-- SQL整库备份
mysqldump -uroot -proot mydatabase > D:/mysql_data_temp/mydatabase.sql

-- SQL 还原数据：mysql客户端还原单表
mysql -uroot -proot mydatabase < D:/mysql_data_temp/student.sql


-- SQL 指令还原数据
source D:/mysql_data_temp/student.sql;













