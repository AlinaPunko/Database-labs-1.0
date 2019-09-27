use TMPP_UNIVER
-- A ---
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
