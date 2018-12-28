
-- ��ʱ�޸���������
delimiter $$

create trigger after_order after insert on my_order for each row
begin
   -- ���������ݿ�ʼ������һ��������old����û�У�new�����µĶ�����¼
   update my_goods set inv = inv - new.g_number where id = new.g_id;
   
end -- ����������
$$  -- �Զ��������

-- �޸���������
delimiter ;


-- �鿴������Ч����
select * from my_goods;
select * from my_order;

-- �ٲ��붩����¼���ٲ鿴���
-- ���붩����
insert into my_order values(null,1,2);




-- ����������������֮ǰҪ�ж�

-- �޸Ľ�����
delimiter %%

create trigger before_order before insert on my_order for each row
begin
     -- �жϿ����,��ȡ��Ʒ���
	 select inv from my_goods where id = new.g_id into @inv;
	 -- �ж�
	 if @inv < new.g_number then
	     -- ��治����������������ִ��һ���������
		 insert into XXX values(XXX);
	end if ;
end
%%
delimiter ;


-- �ֱ�ִ���������鿴���
select * from my_goods;
select * from my_order;

insert into my_order values(null,1,10000); 

select * from my_goods;
select * from my_order;


-- ������������
set @cn = '�������';
set @en = 'hello world';

-- �ַ�����ȡ(myql�е��±��1��ʼ)
select substring(@cn,1,1);
select substring(@en,1,1);

-- �ַ�������
select char_length(@cn),char_length(@en),length(@cn),length(@en);

-- instr �ж��ַ�����ĳ��������ַ������ڣ����ڷ���λ��,û���ҵ�����0
select instr(@cn,'��'),instr(@en,'ac');

-- lpad �����
select lpad(@cn,20,'��ӭ'),lpad(@en,20,'hello');


-- insert �滻����(���еĲ�������ı����ݱ���)
select insert(@en,3,3,'y'),@en;

-- strcmp :�ַ����Ƚ�(-1/0/1��С���ȡ���)
set @f = 'hello';
set @s = 'hey';
set @t = 'HEY';

select strcmp(@f,@s),strcmp(@s,@t),strcmp(@s,@f);


-- �����Զ��庯��,ֻ��һ��������ʡ��begin ��end
create function display1() return int
return 100;

-- ������������
select display1();



-- �鿴���к���(�Զ��庯������ָ�������ݿ⣬ֻ���ڵ�ǰ���ݿ��в��ܵ��ã����ǿ������������ݿ��в鿴)
show function status\G


-- �鿴����������
show create function display1;



-- ���庯������1��ָ����֮��ĺ�
delimiter $$
create function display1(int_1 int)returns int
begin 
        -- �������
	    set @i = 1;  -- @����ı���Ϊȫ�ֱ�����û�е�Ϊ�ֲ�����
	    set @res = 0;
        -- ѭ�����
	    while @i <= int_1 do
	        -- ��ͣ��κα���Ҫ�޸ı���ʹ��set�ؼ���
			-- mysql��û�� +=��++��--�ȷ���
			set @res = @res + @i;
			-- �޸�ѭ������
			set @i = @i + 1;
		end while ;

        -- ����ֵ
		return @res;
end
$$
delimiter ;



-- ��ͣ�5�ı�������
delimiter $$
create function display2(int_1 int)returns int
begin 
	    declare i int default 1;
	    declare res  int default 0; -- ����ֲ�����
        -- ѭ�����
	    mywhile:while i <= int_1 do
		    if i % 5 = 0 then 
			      set i = i + 1;
			      iterate mywhile;
			end if;
			set res = res + i;
			-- �޸�ѭ������
			set i = i + 1;
		end while ;

        -- ����ֵ
		return res;
end
$$
delimiter ;




-- �����洢����
create procedure pro1() -- ��������Ҫ��ʾ����ʹ��select
select * from my_goods;



-- ���̲���
delimiter $$
create procedure pro1(in int_1 int,out int_2 int,inout int_3 int)
begin 
    -- �Ȳ鿴��������
	select int_1,int_2,int_3; -- int_2��ֵһ����null
end
$$
delimiter ;

-- �������и�ֵ������
set @int_1 = 1;
set @int_2 = 3;
set @int_3 := 3;

select @int_1,@int_2,@int_3;
call pro1(@int_1,@int_2,@int_3);
select @int_1,@int_2,@int_3;



-- ���´������𲽽��У������in/out/inout�Լ�ȫ�ֺ;ֲ�������
delimiter $$
create procedure pro1(in int_1 int,out int_2 int,inout int_3 int)
begin 
    -- �Ȳ鿴��������
	select int_1,int_2,int_3; -- int_2��ֵһ����null
	-- �޸ľֲ�����
	set int_1 = 10;
    set int_2 = 100;
	set int_3 = 1000;
	-- �鿴�ֲ�����
	select int_1,int_2,int_3;
	-- �鿴ȫ�ֱ���
	select @int_1,@int_2,@int_3;
	-- �޸�ȫ�ֱ���
	set @int_1 = 'a';
	set @int_2 = 'b';
	set @int_3 = 'c';
end
$$
delimiter ;

-- �����ñ������ù���
set @int_1 = 1;
set @int_2 = 3;
set @int_3 := 3;

call pro2(@int_1,@int_2,@int_3);


-- ���̵������ٲ鿴�����������еı仯
select @int_1,@int_2,@int_3;

