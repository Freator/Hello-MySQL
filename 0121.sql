insert into my_student values(null,'0001','��','��'),
(null,'0001','��','��'),
(null,'0001','��','Ů'),
(null,'0001','��','��'),
(null,'0001','С','��');

-- �ֶα���
select 
id,
number as ѧ��,
name as ����,
sex �Ա� from my_student;

-- �������Դ
select * from my_student,my_class;

-- �Ӳ�ѯ(�������Ҳ�Ƕ�ά����������Ϊas ���������)
select * from (select * from my_student) as s;

-- �����ֶ�
alter table my_student add age tinyint unsigned;
alter table my_student add height tinyint unsigned;

-- ����ֵ:rand ȡ��һ��0��1֮����������floor����ȡ��,ceil����ȡ��
update my_student set age=floor(rand() * 20 + 20),
height=floor(rand() * 20 + 170);


-- ������ѯ1����ѧ��IDΪ1��3��5��ѧ��
select * from my_student where id = 1 || id = 3 || id = 5;
-- ����
select * from my_student where id in(1,3,5);


-- ������ѯ2�������������180-190���֮���ѧ��
select * from my_student where height >= 180 && height <= 190;
-- ����(ע��between�Ǳ��������򣬲�����ߵ�ֵ����С)
select * from my_student where height between 180 and 190;
-- ����Ϊ�����
select * from my_student where height between 190 and 180;



select * from my_student where 1; -- 1 �������������㣬��û����������



-- �����Ա����
select * from my_student group by sex;

-- ����ͳ�ƣ���߸߰�������ƽ����������
select sex,count(*),max(height),min(height),avg(age),sum(age) from my_student group by sex;

-- �����е�һ��age ����ΪNULL���� ʹ����������Բ���count��䲻ͳ��NULL
select sex,count(*),max(height),min(height),avg(age),sum(age) from my_student group by sex;
select sex,count(*),count(age),max(height),min(height),avg(age),sum(age) from my_student group by sex;

-- �Լ���ϰ��ʱ��һ��avg�����Ƿ�Ҳ������


-- ���ý������
select sex,count(*),count(age),max(height),min(height),avg(age),sum(age) from my_student group by sex desc;

-- �ı���һЩ��ṹ������
alter table my_class add id int primary key auto_increment;
alter table my_student add c_id int ;
update my_student set c_id = ceil(rand()*3);


-- ��������ʾ���ֶη��飺�Ȱ༶����Ů
select c_id,sex,count(*) from my_student group by c_id,sex;

--  group_concat 
select c_id,sex,count(*),group_concat(name) from my_student group by c_id,sex;


-- ͳ��
select c_id,count(*) from my_student group by c_id;


-- ����ͳ��
select c_id,count(*) from my_student group by c_id with rollup;

-- ���ֶη������ͳ��
select c_id,sex,count(*),group_concat(name) from my_student group by c_id,sex with rollup;


-- ������а༶�������ڵ���2��ѧ������
select c_id,count(*) from my_student group by c_id having count(*) >= 2;
-- ���»ᱨ��
select c_id,count(*) from my_student where count(*) >= 2 group by c_id;

-- �Ż����ϲ�ѯ��ʹ�ñ���
select c_id,count(*) as total from my_student group by c_id having total >= 2;
-- ��һ�����Ǵ��
select c_id,count(*) as total from my_student where total >= 2 group by c_id;





-- ����
select * from my_student group by c_id;
select * from my_student order by c_id;

-- ���ֶ������Ȱ༶���Ա�
select * from my_student order by c_id,sex desc;



-- ��ѯǰ����ѧ��
select * from my_student limit 2;

-- ������ʼλ��
select * from my_student limit 2,2;














