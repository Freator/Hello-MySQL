-- �ı�ĳ���ֶε�λ�ã�modify/change
alter table my_class change id id int first;

-- �������Ӳ�ѯ
select * from my_student cross join my_class;
-- ���� from �������������������Դ�������Ӻ��ѯ



-- ������
select * from my_student inner join my_class on my_student.c_id = my_class.id ;
-- �ȼ���
select * from my_student inner join my_class on c_id = my_class.id;

-- �����ֶκͱ����,��Ȼ����������ִ�вŻ��� s �� c
select s.*,c.name as c_name,c.room from  
my_student as s inner join my_class as c
on s.c_id = c.id;

-- ����һ����¼�е� c_idΪ��ʱ��������¼ƥ�䲻��ɹ�
update my_student set c_id = null where id = 5;

select s.*,c.name as c_name,c.room from  
my_student as s inner join my_class as c
on s.c_id = c.id;


--  �����ӣ��⣩,���������﷨��࣬��¼��������������еļ�¼��
select s.*,c.name as c_name,c.room from  
my_student as s left join my_class as c
on s.c_id = c.id;

-- �����ӣ���¼���������ұ����еļ�¼��
select s.*,c.name as c_name,c.room from  
my_student as s right join my_class as c
on s.c_id = c.id;


-- ��Ȼ������
select * from my_student natural join my_class;

-- �ı�ĳ����ͬ�ֶε����֣�ʹ��������ֻ��һ��ͬ���ֶΣ�modify/change
alter table my_class change name c_name varchar(20) not null;

-- ��Ȼ��������
select * from my_student natural left join my_class;


-- ������ģ����Ȼ������ ��using
select * from my_student left join my_class using(id);





