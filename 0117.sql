--  my_class ���в�������
insert into my_class values('PHP0810','B203');
insert into my_class values('PHP0710','B203');

insert into my_class values('PHP0810','B205'); -- ������ͻ


--  ��ͻ����(������������Ӱ�죬��������������迼�ǵ�ǰ
-- ��������ֵ��������)
insert into my_class values('PHP0810','B205')
on duplicate key update
room = 'B205';


--  �����滻(���г�ͻ����������Ӱ�죬�޳�ͻ����ֱ��
--  ����������ֻ��һ����Ӱ��)
replace into my_class values('PHP0710','A203');
replace into my_class values('PHP0910','A203');
 

 
 
-- ��渴�ƴ�����(ֻ�Ḵ�ƽṹ���Ḵ������)
create table  my_copy like my_gbk;



--  ��渴��
insert into my_copy select * from my_collate_bin;
insert into my_copy select * from my_copy;


-- ���²���a���c(ǰ����)
update my_copy set name = 'c' where name = 'a' limit 3;


-- ɾ��10����¼��
delete from my_copy where name = 'b' limit 10;


-- ��ձ�����������
truncate my_student;


--  selectѡ��(�������������ͬ)
select * from my_copy;
select all * from my_copy;


--  selectȥ��
select distinct * from my_copy;







