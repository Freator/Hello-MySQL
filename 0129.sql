--  ����һ���˻���
create table my_account(
number char(16) not null unique comment '�˻�',
name varchar(20) not null,
money decimal(10,2) default 0.0 comment '�˻����'
)charset gbk;

-- ��������
insert into my_account values
('0000000000000001','����',1000),
('0000000000000002','����',2000);

-- ���������������
alter table my_account add id int primary key auto_increment first;


-- ����ȫ

-- ��������
start transaction;


-- �������1:�����˻�����
update my_account set money = money - 1000 where id = 2;

-- ֤�����ϲ���û��ʵ�ʲ������ݱ��ٿ�һ��cmd������myql�鿴

-- �������2�������˻�����
update my_account set money = money + 1000 where id = 1;


-- �ύ����
commit;



-- �ع������
-- ��������
start transaction;

-- ������������Ǯ
update my_account set money = money + 10000 where id = 1;

--  ���ûع���
savepoint sp1;

-- ���п�˰
update my_account set money = money - 10000 * 0.05 where id = 2; -- ����


-- �ص��ع���
rollback to sp1;

-- ��������
update my_account set money = money - 10000 * 0.05 where id = 1;

-- �鿴���
select * from my_account;

-- �ύ����
commit;


-- �ر��Զ������ύ 
set autocommit = off; -- ���� = 0



-- �鿴����ϵͳ����
show variables;

-- �鿴�������ֵ
select @@version,@@autocommit;



-- �Զ������
set @name = '����';

-- �鿴�Զ������
select @name ;

-- �������
set @age := 18;


-- �ӱ��л�ȡ���ݸ�ֵ������
select @money = money from my_account;

-- ���� = Ϊ�ȽϷ��ţ���������ȷ�ĸ�ֵ
select @money := money from my_account;



-- �ӱ��л�ȡ���ݸ�ֵ������,where����Ҫ�ӣ����ܻ�ȡ����
select id,money from my_account where id =2 into @id,@age;


-- ������
create table my_goods(
id int primary key auto_increment,
name varchar(20) not null,
price decimal(10,2) default 1,
inv int comment '�������'
)charset gbk;

insert into my_goods values
(null,'iphone6s',5288,100),
(null,'s6',6088,100);


create table my_order(
id int primary key auto_increment,
g_id int not null comment '��ƷID',
g_number int comment '��Ʒ����'
)charset gbk;


-- ����������������һ������Ʒ������һ��

-- ��ʱ�޸���������
delimiter $$

create trigger after_order after insert on my_order for each row
begin
   -- ���������ݿ�ʼ
   update my_goods set inv = inv - 1 where id = 2;
   
end -- ����������
$$  -- �Զ��������

-- �޸���������
delimiter ;


-- �鿴���д�����
show triggers;

-- �鿴����������
show create trigger ����������;


-- ���붩����
insert into my_order values(null,1,2);



-- ɾ��������
drop trigger after_order;




