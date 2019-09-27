Use PUNKO_UNIVER
--1-- ����� ������� ����������
-- ���������� ����������, ���� ����������� ���� �� ��������� ����������: 
-- CREATE, DROP; ALTER TABLE; INSERT, DELETE, UPDATE, SELECT, TRUNCATE TABLE; OPEN, FETCH; GRANT; REVOKE 
-- ������� ���������� ������������ �� ��� ���, ���� �� ����� �������� COMMIT ��� ROLLBACK
set nocount on
if  exists (select * from  SYS.OBJECTS 
         where OBJECT_ID=object_id(N'DBO.TAB')) 
drop table TAB;           
declare @c int, @flag char = 'c'; -- ���� �������� � �� r, �� ������� �� ����������

SET IMPLICIT_TRANSACTIONS ON -- ��������� ����� ������� ����������
	create table TAB(K int );       -- ������ ����������                   
	insert TAB values (1),(2),(3),(4),(5);
	set @c = (select count(*) from TAB);
	print '���������� ����� � ������� TAB: ' + cast(@c as varchar(2));
	if @flag = 'c' commit  -- ���������� ����������: �������� 
		else rollback;     -- ���������� ����������: �����                           
SET IMPLICIT_TRANSACTIONS OFF   -- ���������� ����� ������� ����������
	-- ��������� ����� ������������
if  exists (select * from  SYS.OBJECTS 
          where OBJECT_ID= object_id(N'DBO.TAB')) print '������� TAB ����';  
else print '������� TAB ���'



--2-- �������� ����������� ����� ����������
-- BEGIN TRANSACTION -> COMMIT TRAN ��� ROLLBACK TRAN
-- ����� ���������� ����� ���������� ���������� ������� � �������� ����� (������������ ��� ������� ����������)
-- ����������� ����������: ������� ���������� �� ����� ������������� � �� ��������: ��������� ��������� ��, 
-- ���������� � ����������, ���� ���������� ���, ���� �� ���������� �� ����. � �� ��� �������� ����������� 
-- � ������� ��������� ������, ������������ �������� �����������, �� ����������������� ��������� ��
begin try        
	begin tran                 -- ������  ����� ����������
		insert FACULTY values ('��', '��������� ������ ����');
	    --insert FACULTY values ('���', '��������� print-���������� � �����������������');
	commit tran;               -- �������� ����������
end try
begin catch
	print '������: '+ case 
		when error_number() = 2627 and patindex('%FACULTY_PK%', error_message()) > 0 then '������������ '
		else '����������� ������: '+ cast(error_number() as  varchar(5))+ error_message()  
	end;
	if @@trancount > 0 rollback tran; -- ���� �������� ������ ����, �� ���������� �� ��������� 	  
end catch;

select * from FACULTY;



--3-- �������� SAVETRAN
-- ���� ���������� ������� �� ���������� ����������� ������ ���������� T-SQL, �� ����� ���� ����������� 
-- �������� SAVE TRANSACTION, ����������� ����������� ����� ����������
use Punko_Univer
declare @point varchar(32);
 
begin try
	begin tran                              
		delete AUDITORIUM where AUDITORIUM_CAPACITY =100;
		set @point = 'p1'; 
		save tran @point;  -- ����������� ����� p1
insert AUDITORIUM values ('120-1', '��-�', 40,'120-1');

		set @point = 'p2'; 
		save tran @point; -- ����������� ����� p2 (������������, ������� ��-�������)

insert AUDITORIUM values ('413-1', '��', 140,'413-1');
	commit tran;                                              
end try
begin catch
	print '������: '+ case 
		when error_number() = 2627 and patindex('%STUDENT_PK%', error_message()) > 0 then '������������ ��������' 
		else '����������� ������: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
    if @@trancount > 0 -- ���� ���������� �� ��������� //������� �����������
	begin
	   print '����������� �����: '+ @point;
	   rollback tran @point; -- ����� � ��������� ����������� �����
	   commit tran; -- �������� ���������, ����������� �� ����������� ����� 
	end;     
end catch;

select * from AUDITORIUM; 



--4. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� READ UNCOMMITED, 
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED (�� ���������). 
--�������� A ������ ���������������, ��� ������� READ UNCOMMITED ��������� ����������������, 
--��������������� � ��������� ������. 

--���������������� ������ ������ ���������� ��������������� �� ���������� ��������������� ����������.
--��������������� ������. ���� ���������� ������ ������ ��������� ���, � ������ ����-���� �� �� ������ ����� ����� ���������� ������ � ������ ��������. �� ���� ������� ������, ����������� � ��������� ���������, ����� �������. 
--��������� ������. ��� ���������������� �������� ������ ����� �������� ��������� ��������, �. �. �������������� ������, ���������� ����������, ����� ����������� �����-�� ������������.
-- A ---
use ���PUNKO_UNIVER;
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert AUditorium type' '���������', * from AUDITORIUM_TYPE
	                                                                where AUDITORIUM_TYPE = 'SM';
	select @@SPID, 'update AUDITORIUM'  '���������',  * from AUDITORIUM   where AUDITORIUM_TYPE = 'SM';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert AUDITORIUM_TYPE values ('SM','Something'); 
	update AUDITORIUM set AUDITORIUM_TYPE  =  'SM' 
                           where AUDITORIUM_TYPE = '��' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;




--5. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� A ������ ���������������, ��� ������� READ COMMITED �� ��������� ����������������� ������, 
--�� ��� ���� ��������  ��������������� � ��������� ������. 

	-- A ---
          set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from AUDITORIUM 	where AUDITORIUM_TYPE = '��-X';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update AUDITORIUM'  '���������', count(*)
	                           from AUDITORIUM  where AUDITORIUM_TYPE = '��-X';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update AUDITORIUM set AUDITORIUM_TYPE = '��-X' 
                                       where AUDITORIUM_TYPE = '��' 
          commit; 
	-------------------------- t2 --------------------	
	rollback

--6. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� REPEATABLE READ. 
--���-����� B � ����� ���������� � ������� ��������������� READ COMMITED. 

-- A ---
          set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM_TYPE = '��-��';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when AUDITORIUM_CAPACITY = 130 then 'insert  AUDITORIUM'  else ' ' 
end '���������', AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = '��-��';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('555-1', '��-��', 130,'555-1' );
          commit; 
	-------------------------- t2 --------------------

--7. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� ������������ ����� ����� ���������� � ������� ��������������� Serializable. 
--�������� B � ����� ���������� � ������� ��������������� READ COM-MITED. 

    -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 10;  
			insert AUDITORIUM values ('556-1', '��', 140,'556-1' );
          update AUDITORIUM set AUDITORIUM_CAPACITY = 10 where AUDITORIUM_TYPE = '��';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = '��';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = '��';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
begin transaction 
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 10;  
			insert AUDITORIUM values ('556-1', '��', 140,'556-1' );
          update AUDITORIUM set AUDITORIUM_CAPACITY = 10 where AUDITORIUM_TYPE = '��';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = '��';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = '��';

	rollback
--8. ����������� ��� �����-���: A � B �� ������� ���� ������ X_BSTU. 
--�������� ������������ ����� ����� ���������� � ������� ��������������� SE-RIALIZABLE. 
--�������� B � ����� ���������� � ������� ��������������� READ COM-MITED. 
--�������� A ������ ��������������� ���������� ����������, ����������������� � ��-�������������� ������.

use PUNKO_UNIVER ;
      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		  delete TEACHER where TEACHER = '���';  
          insert TEACHER values ('���a�', '������a� ������ ���������', '�', '��');
          update TEACHER set TEACHER = '�����' where TEACHER = '���';
          select TEACHER from TEACHER  where PULPIT = '��';
	-------------------------- t1 -----------------
	begin tran
	 select TEACHER from TEACHER  where PULPIT = '��';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
	delete TEACHER where TEACHER = '���';  
          insert TEACHER values ('���a�', '������a ������ ���������', '�', '������              ');
          update TEACHER set TEACHER = '����' where TEACHER = '���';
          select TEACHER from TEACHER  where PULPIT = '��';
          -------------------------- t1 --------------------
          commit; 
           select TEACHER from TEACHER  where PULPIT = '��';
      -------------------------- t2 --------------------







--9-- ��������� ����������
-- ����������, ������������� � ������ ������ ����������, ���������� ���������. 
-- �������� COMMIT ��������� ���������� ��������� ������ �� ���������� �������� ��������� ����������; 
-- �������� ROLLBACK ������� ���������� �������� ��������������� �������� ���������� ����������; 
-- �������� ROLLBACK ��������� ���������� ��������� �� ���-����� ������� � ���������� ����������, 
-- � ����� ��������� ��� ����������; 
-- ������� ����������� ���������� ����� ���������� � ������� ��������� ������� @@TRANCOUT. 

select (select count(*) from dbo.PULPIT where FACULTY = '����') '������� �����', 
(select count(*) from FACULTY where FACULTY.FACULTY = '����') '����'; 

select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='������� �����' where PULPIT.FACULTY = '����';
	commit;
if @@TRANCOUNT > 0 rollback;

-- ����� ���������� ���������� ����������� ��������� ����� ��������; 
-- �������� ROLLBACK ������� ���������� �������� ��������������� �������� ���������� ����������. 