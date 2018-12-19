-- �������ͱ�
create table my_int(
int_1 tinyint,
int_2 smallint,
int_3 int,
int_4 bigint
)charset utf8;


-- ��������
insert into my_int values(100,100,100,100); -- ��Ч����
insert into my_int values('a','b','19','f'); -- ��Ч���ݣ������޶�
insert into my_int values(255,1000,10000,1000000); -- ���󣬳�����Χ


-- ����һ���޷�������
alter table my_int add int_5 tinyint unsigned;

-- �ٴβ�������
insert into my_int values(127,1000,10000,100000,225);


-- ָ����ʾ���Ϊ 1 ���ٲ�������
alter table my_int add int_6 tinyint(1) unsigned;
insert into my_int values(127,0,0,0,255,255);


-- �������ʱǰ����� 0 ����������
alter table my_int add int_7 tinyint(2) zerofill;
desc my_int; -- �Զ�����޷��ŵ�������
insert into my_int values(1,1,1,1,1,1,1);
insert into my_int values(100,100,100,100,100,100,100);


-- ������������
create table my_float(
f1 float,
f2 float(10,2),  --  10 �ھ��ȷ�Χ֮��
f3 float(6,2)   -- 6�ھ��ȷ�Χ֮��
)charset utf8;


--  ������������
insert into my_float values(1000.10,1000.10,1000.10); -- ok��
insert into my_float values(1234567890,12345678.90,1234.56); -- ok ��
insert into my_float values(9999999999,99999999.99,9999.99);  -- Max value
insert into my_float values(3e38,3.01e7,1234.56);

--  ���볬����������
insert into my_float values(123456,1234.123456768,123.9876543); -- С�����ֳ���
insert into my_float values(123456,1234.12,12345.56);  -- �������ֳ���


-- �������������Ը��������Ա�
create table my_decimal(
f1 float(10,2),
d1 decimal(10,2)
)charset utf8;

insert into my_decimal values(12345678.90,12345678.90); -- OK
insert into my_decimal values(1234.123456,1234.1234356); -- С�����ֳ���

-- �鿴����
show warnings;

insert into my_decimal values(99999999.99,99999999.99);
insert into my_decimal values(99999999.99,99999999.999); -- ������������Χ


-- ����ʱ�����ڱ�
create table my_date(
d1 datetime,
d2 date,
d3 time,
d4 timestamp,
d5 year
)charset utf8;

insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',2015);

-- ʱ��ʹ�ø���
insert into my_date values('2018-1-13 11:30:38','2018-1-13','-211:30:38','2018-1-13 11:39:39',2015);
insert into my_date values('2018-1-13 11:30:38','2018-1-13','-2 11:30:38','2018-1-13 11:39:39',2015);    -- -2 ��ʾ��ȥ����


-- ���ʹ����λ
insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',69);
insert into my_date values('2018-1-13 11:30:38','2018-1-13','11:30:38','2018-1-13 11:39:39',70);

-- �޸�timestamp���ݣ��ᷢ��������һ���ط�Ҳ�ı���
update my_date set d1 = '2018-1-13 11:48:46' where d5 = 2069;

-- ����ö�ٱ���������
create table my_enum(
gender enum('��','Ů','����')
)charset utf8;

insert into my_enum values('��'),('����'); -- ok 
insert into my_enum value('nan');        --  error

-- ���ֶν��ȡ�������� + 0 ����,֤���洢������ֵ������ʵ�ʵ��ַ���
select gender + 0 ,gender from my_enum;


-- ö�ٵ�����һ�ֲ��뷽ʽ����������һ�����鿴���
insert into my_enum values(1),(2); -- 1������2����Ů




-- �������ϱ�
create table my_set(
hobby set('����','����','ƹ����','��ë��','����','̨��','����','����')
)charset utf8;

-- ������ÿһ��Ԫ�ض�Ӧһ��������λ

insert into my_set values('����,̨��,����');
insert into my_set values(3); -- ��鿴�����Ľ��


-- �鿴��������
select hobby + 0,hobby from my_set;


-- 98 ת�ɶ����� 01100010������֮��Ϊ01000110������1�ֱ�˳���Ӧ����̨������

-- �ߵ�Ԫ�س��ֵ�˳��
insert into my_set values('����,̨��,����');








-- ���varchar ��utf8��GBK�µ�ʵ�����ֵ
create table my_utf8(
name varchar(21845)    -- 21845 *3  = 65535 ,����Ҫ���� 2 �ֽڳ��ȴ洢ֵ��Ϊ65534
)charset utf8;

create table my_gbk(
name varchar(32767)  -- 32767 * 2 + 2 = 65534
)charset gbk;


-- �����´���鿴  ������������ʵ��ֻ����65534���ֽڣ�

create table my_utf8(
name varchar(21844)    
)charset utf8;

create table my_gbk(
name varchar(32766)  
)charset gbk;


--  ��Ҫȫ������65535���ֽڣ����Զ�ʹ��һ���ֶ�
create table my_utf81(
age tinyint,
name varchar(21844)    
)charset utf8;

create table my_gbk1(
age tinyintl,
name varchar(32766)  
)charset gbk;

-- �������ϻ��ǲ��У�ԭ������
-- Mysql��¼�У�����κ�һ���ֶ�����Ϊ�գ���ôϵͳ���Զ�
-- ��������¼�б���һ���ֽڴ洢NULL�����ͷ����ֽڣ���Ҫ��֤
-- ���е��ֶζ�������Ϊ�գ��ٲ鿴���´���


-- �ͷ�null
create table my_utf82(
age tinyint not null,
name varchar(21844) not null    
)charset utf8;

create table my_gbk2(
age tinyint not null,
name varchar(32766) not null 
)charset gbk;


-- textռ��10���ֽڳ���֤��
create table my_text(
name varchar(21841) not null,-- 21841 *3 +2 = 65525 �ֽ�
content text  not null       -- 10 �ֽ�
)charset utf8;


-- �����༶��
create table my_class(
name varchar(20) not null,
room varchar(20)
)charset utf8;

-- comment ������
create table my_teacher(
name varchar(20) not null comment '����',
money decimal(10,2)not null comment '����'
)charset utf8;

-- ����Ĭ��ֵ
create table my_default(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('��','Ů','����') default '��'
)charset utf8;

insert into my_default (name) values('��ǿ');
insert into my_default values('������',18,default);



-- ��ע�⣬������MySQLʹ�õ�Ĭ���ַ���ΪGBK������� my_default 
-- ���������ݺ�Ĭ��ֵ��ʾ������������ʹ������ļ�����ʾ����˶϶���
-- �ַ��������⣬��һ�����Ƶ�����в�ͬ  @tbcע
create table my_default_gbk(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('��','Ů','����') default '��'
)charset gbk;

insert into my_default_gbk (name) values('��ǿ');
insert into my_default_gbk values('������',18,default);


