-- ������ʱֱ����������

create table my_pri1(
name varchar(20) not null comment  '����',
number char(10) primary key comment 'ѧ��'
)charset gbk;

-- ��������
create table my_pri2(
number char(10) comment 'ѧ�� 0000',
course char(10) comment '�γ̴��룺ѧУ����+0000',
score tinyint unsigned default 60 comment '�ɼ�',
-- ������������  ѧ�źͿγ̺Ŷ�Ӧ������Ψһ��
primary key(number,course)
)charset gbk;


--  ׷������
create table my_pri3(
course char(10) comment '�γ̴��룺ѧУ����+0000',
name varchar(10) comment '�γ�����'
)charset gbk;
-- ����һ
alter table my_pri3 modify course char(10) primary key comment '�γ̴��룺ѧУ����+0000';
--  ������(������ô˷���)
alter table my_pri3 add primary key(course);


-- ��my_pri1���������
insert into my_pri1 values('��','0001'),('��','0002');
insert into my_pri2 values('0001','39010001',90),
('0001','39010002',85),
('0002','39010001',92);

--  ʹ������ͻ��������������ܲ���ɹ�
insert into my_pri1 values('��','0002'); 
insert into my_pri2 values('0001','39010001',100);


-- ɾ������
alter table my_pri3 drop primary key;


-- ������(���´���������)
create table my_auto(
id int auto_increment comment '������',
name varchar(10) not null
)charset gbk;


--  ���´��������д�
create table my_auto(
id varchar(1) primary key auto_increment comment '������',
name varchar(10) not null
)charset gbk;

-- �ţ������ǳɹ���
create table my_auto(
id int primary key auto_increment comment '������',
name varchar(10) not null
)charset gbk;

-- ����������,���¶�����ȷ����
insert into my_auto(name) values('��');
insert into my_auto values(null,'��');
insert into my_auto values(default,'��');


-- ָ������
insert into my_auto values(6,'��');
insert into my_auto values(null,'��');


-- �޸ı�ѡ���ֵ  ,��ǰֵΪ 8 ʱ
alter table my_auto auto_increment = 4; -- �����޸ģ���С����Ч
alter table my_auto auto_increment = 10;  -- �����޸ģ���Ч


-- �鿴��������Ӧ�ı�����
show variables like 'auto_increment%';


-- �޸��������������ٲ���
set auto_increment_increment = 5; -- ��ʾһ������ 5 

insert into my_auto values(null,'��');


-- ɾ��������
alter table my_auto modify id int primary key; -- �������������ǵ�������

alter table my_auto modify id int; -- ������ʱ���ü�primary key ���˴��ǳɹ���



-- Ψһ���ı�Ĵ���
create table my_unique(
number char(10) unique comment 'ѧ�ţ�����Ϊ��',
name varchar(20) not null
)charset gbk;


-- ���±������� desc my_unique2�鿴�ᷢ��KEY�ֶα��PRI�������ⲻ��
-- ������ֻ�������û��ָ��������ϵͳ������Ψһ����������
create table my_unique2(
number char(10) not null comment 'ѧ�ţ�����Ϊ��',
name varchar(20) not null,
unique key(number)
)charset gbk;


create table my_unique3(
id int primary key auto_increment,
number char(10) not null,
name varchar(20) not null
)charset gbk;

-- ׷��Ψһ��
alter table my_unique3 add unique key(number);

-- ��������
insert into my_unique values(null,'��'),('0001','��'),
(null,'��');

insert into my_unique values('0001','��'); -- ������󣬳�ͻ��


-- ɾ��Ψһ��
alter table my_unique3 drop index number;




























