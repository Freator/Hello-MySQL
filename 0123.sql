-- ע�⣬��Ƶ�е�MYSQLĬ��UTF8�ַ���������MYSQLĬ�ϵ���
-- gbk �ַ������˴�����Ƶ������ĵ��������г���


-- �������
create table my_foreign1(
id int primary key auto_increment,
name varchar(20) not null comment 'ѧ������',
c_id int comment '�༶id',
foreign key(c_id) references my_class(id)
)charset gbk;


-- ������֮���������������ʱ����ʵ�����޸ı�ṹ
create table my_foreign2(
id int primary key auto_increment,
name varchar(20) not null comment 'ѧ������',
c_id int comment '�༶id'
)charset gbk;


alter table my_foreign2 add
--  ָ�������
constraint student_class_1
-- ָ������ֶ�
foreign key(c_id)
-- ���ø�������
references my_class(id);


-- ɾ�����(�޷�ֱ�Ӵӱ�ṹ�п�����Ҫ��show create table ���鿴�������)
alter table my_foreign1 drop foreign key my_foreign1_ibfk_1;

-- �������ݣ�����ֶ��ڸ����в�����ʱ���鿴������Ϣ
insert into my_foreign2 values(null,'��',4);


insert into my_foreign2 values(null,'����',1);
insert into my_foreign2 values(null,'����',2);
insert into my_foreign2 values(null,'����',2);


-- ��ʱ���¸����¼ʱ
update my_class set id = 4 where id = 1; -- ʧ�ܣ�ID=1�Ѿ���ѧ��
update my_class set id = 4 where id = 3; -- ����

-- ��������(����û��3�࣬�������ܲ���ɹ�)
insert into my_foreign1 values(null,'��',3);

-- �ټ����ʱ,��ʧ�ܣ���Ϊ�����Ѿ�����
-- ����������ʱ���޷��ı䲻��ƥ�����ݵ���ʵ
alter table my_foreign1 add foreign key(c_id) references my_class(id);


-- �����±�ָ�����ģʽ��ɾ���ÿգ����¼���
-- ��ע������д���ı����ţ������Ƕ��ţ���������ﲻ��
create table my_foreign3(
id int primary key auto_increment,
name varchar(20) not null comment 'ѧ������',
c_id int comment '�༶id',
-- �������
foreign key(c_id) references my_class(id)
-- ָ��ɾ��ģʽ
on delete set null
-- ָ������ģʽ
on update cascade
)charset gbk;


-- ��������
insert into my_foreign3 values(null,'����',1),
(null,'�ܲ�',1),
(null,'��Ȩ',1),
(null,'�����',2),
(null,'���',2);

-- ��֤my_class������ֻ��my_foreign3�����������Լ��ɾ��
alter table my_foreign2 drop foreign key student_class_1;

-- Ȼ���������ģʽ�����¸�������,
update my_class set id = 3 where id = 1;
-- �鿴my_class��My_foreign3���ֶ������ˣ����Ǽ�������


-- ɾ����������,ɾ���ÿ�ģʽ
delete from my_class where id = 2;





-- ���ϲ�ѯ(Ĭ��ȥ��)
select * from my_class
union
select * from my_class;

-- ��ȥ�أ�����Ϊall
select * from my_class
union all
select * from my_class;


-- �ֶ�����ͬ�����Ͳ�ͬʱ(ֻ������һ������ֶ�����)
select id,c_name,room from my_class
union all
select name,number,id from my_student;


-- ����������������Ů������


select * from my_student where sex = '��' order by age asc
union
select * from my_student where sex = 'Ů' order by age desc;

-- �ţ������Ǿ��Ǵ��,��������ǶԵ�
(select * from my_student where sex = '��' order by age asc)
union
(select * from my_student where sex = 'Ů' order by age desc);

-- ��������order by û����Ч��Ҫ����limit,������������ν
-- �����������ȫ������������
(select * from my_student where sex = '��' order by age asc limit 9999)
union
(select * from my_student where sex = 'Ů' order by age desc limit 9999);







-- �����Ӳ�ѯ,��ѯ�༶PHP0710������ѧ��
select * from my_student where c_id = (select id from my_class where c_name = 'PHP0710');



-- ���������Ա��������Ӳ���
insert into my_class values(1,'PHP1027','A206');


-- �в�ѯ�������ڶ��༶��ѧ��
-- 1 ȷ������Դ��ѧ��
-- select * from my_student where c_id in (?)
-- 2 ȷ����Ч�İ༶ID
-- select id from my_class
select * from my_student where c_id in (select id from my_class);


-- any ,some , all
select * from my_student where c_id =any(select id from my_class);
select * from my_student where c_id =some(select id from my_class);
select * from my_student where c_id =all(select id from my_class);


-- ��,���������������
select * from my_student where c_id !=any(select id from my_class);
select * from my_student where c_id !=some(select id from my_class);
select * from my_student where c_id !=all(select id from my_class);


-- ���Ӳ�ѯ���������ѧ������������������ߵ�ѧ��
-- 1 ȷ������Դ
-- select * from my_student where age = ? and height = ?;
-- 2 ȷ�������������
-- select max(age),max(height) from my_student;
-- ע�����Ҫ�ֿ�
select * from my_student where
age = (select max(age) from my_student)
and
height = (select max(height) from my_student);

-- �������治�������Ӳ�ѯ����Ϊ���Ӳ�ѯ��Ҫ������
-- Ԫ�أ���Ԫ���ɶ���ֶι���,���ԣ�����һ������Ƿ���������
select * from my_student where
(age,height)  -- ��Ԫ��
= (select max(age),max(height) from my_student);



-- ���Ӳ�ѯ
-- �����ҳ�ÿ������ߵ�ѧ��
-- 1.�Ȱ���߽���Ȼ��ȷ������Դ
-- select * from my_student order by height desc;
-- 2.��ÿ������ѡ����һ��ѧ��
-- select * from my_student group by c_id;
-- ��ע��Ա��������������������from ����ֻ�ܸ�����������Ҫȡ�����

select * from my_student group by c_id order by height desc; -- ����������ȷ�����order by
select * from (select * from my_student order by height desc) as student group by c_id;


-- exists�Ӳ�ѯ

-- �鿴���ؽ��
select exists(select * from my_student); --  = 1
select exists(select * from my_student where c_id = 1000); --  = 0

-- ���� ����ѯ���е�ѧ����ǰ���ǰ༶����
-- 1. ȷ������Դ
-- select * from my_student where ?;
-- 2 ȷ�������Ƿ�����
-- exists (select * from my_class)

-- �Ա�
select * from my_student where 
exists (select * from my_class where id =3);
select * from my_student where 
exists (select * from my_class where id =5);




-- ��ͼ������+ ���
create view my_v1 as
select * from my_student;

create view my_v2 as
select * from my_class;

-- �������ֶΣ����洴������
create view my_v3 as
select * from my_student as s left join my_class c on s.c_id = c.id;

-- ��ͼ�����ж��ŵ�����²������ظ��ֶ���
create view my_v3 as
select s.*,c.c_name,c.room from my_student as s 
left join my_class c 
on s.c_id = c.id;



-- �鿴��ͼ�Ĵ�����䣬������table ����view
show create view my_v1\G


-- ��ͼʹ��
select * from my_v1;
select * from my_v2;
select * from my_v3;



-- �޸���ͼ
alter view my_v1 as
select id,name,age,sex,height,c_id from my_student;

-- ɾ����ͼ,ֻ����view��������table
create view my_v4 as select * from my_class;

drop view my_v4;






-- �����ͼ�������ݣ����ֲ��ܲ���
insert into my_v3 values(null,'0008','������','��',150,180,1,'PHP0326','D306');


-- ������ͼ���룬����������й�������
-- �����е�ѧ�ţ�����ѧ���ֲ���Ϊ�գ����������������Ҳ�д�
insert into my_v1 values(null,'���޼�',68,'��',174,2);


-- ������ͼ�ɹ�������������,������Ҳ��ı�
insert into my_v2 values(2,'PHP0326','D306');


-- �����ͼ����ɾ������
delete from my_v3 where id = 1;


-- ͨ��������ͼ����ɾ������
delete from my_v2 where id = 4;


-- �����ͼ��������
update my_v3 set c_id = 3 where id =5;



-- ��ͼ��age �ֶ����Ƹ���
create view my_v4 as 
select * from my_student where age > 30 with check option; 
-- ��ʾ��ͼ�����䶼�Ǵ���30 ��ģ����Ǻ���� with check option ��
-- ��ʾ�ڽ��и��²���ʱ���ܰѴ������ݵ�����ĳ�30������

-- ����ͼ���Բ鵽�����ݸĳ�����С��30�������д�
update my_v4 set age =29 where id = 1;

-- �������޸�����ͼ���Բ鵽�����ݣ����Ƿ��ֿ��Ը�ȴû��Ч��
-- ��Ϊid = 6 ������ͼ�в�����
update my_v4 set age =129 where id = 6;


-- �������ѧ������������������ߵ�ѧ��
create view my_v5 as 
select * from my_student order by height desc;

select * from my_v5 group by c_id;

-- ����ִ�к�Ч��������������Ҫ�ģ�ԭ�������ͼ�㷨��

-- ���£�ָ���㷨Ϊ��ʱ��,������ȷ
create algorithm = temptable view my_v6 as 
select * from my_student order by height desc;

select * from my_v6 group by c_id;

-- �鿴�汾
select @@version;

-- ����myisam��
create table my_myisam(
id int)charset gbk engine = myisam;










