
-- �������ݱ���
select * into outfile 'd:/mysql_data_temp/student.txt' from my_student;
select * into outfile 'd:/mysql_data_temp/class.txt' from my_class;


-- ָ�����ݴ���ʽ
select * into outfile 'd:/mysql_data_temp/class.txt' 
-- �ֶδ���
fields 
enclosed by '"' -- ����ʹ��˫���Ű���
terminated by '|' -- ʹ�����߷ָ��ֶ�����
-- �д���
lines
starting by 'START:'
from my_class;


-- ��ԭ����
load data infile 'd:/mysql_data_temp/class.txt'  into table my_class
-- �ֶδ���
fields 
enclosed by '"' -- ����ʹ��˫���Ű���
terminated by '|' -- ʹ�����߷ָ��ֶ�����
-- �д���
lines
starting by 'START:';




-- SQL ���ݣ�����(ע��û�зֺţ�����Ҫ���˳���ǰmysql��������\q)
-- �����-proot�м��벻Ҫ�ո񣬲�Ȼ���鷳
mysqldump -uroot -proot mydatabase my_student > D:/mysql_data_temp/student.sql


-- SQL���ⱸ��
mysqldump -uroot -proot mydatabase > D:/mysql_data_temp/mydatabase.sql

-- SQL ��ԭ���ݣ�mysql�ͻ��˻�ԭ����
mysql -uroot -proot mydatabase < D:/mysql_data_temp/student.sql


-- SQL ָ�ԭ����
source D:/mysql_data_temp/student.sql;













