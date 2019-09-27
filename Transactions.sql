use TMPP_UNIVER
-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert AUditorium type' 'ÂÁÛÎ¸Ú‡Ú', * from AUDITORIUM_TYPE
	                                                                where AUDITORIUM_TYPE = 'SM';
	select @@SPID, 'update AUDITORIUM'  'ÂÁÛÎ¸Ú‡Ú',  * from AUDITORIUM   where AUDITORIUM_TYPE = 'SM';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert AUDITORIUM_TYPE values ('SM','Something'); 
	update AUDITORIUM set AUDITORIUM_TYPE  =  'SM' 
                           where AUDITORIUM_TYPE = 'À ' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;




	-- A ---
          set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from AUDITORIUM 	where AUDITORIUM_TYPE = 'À¡-X';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update AUDITORIUM'  'ÂÁÛÎ¸Ú‡Ú', count(*)
	                           from AUDITORIUM  where AUDITORIUM_TYPE = 'À¡-X';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update AUDITORIUM set AUDITORIUM_TYPE = 'À¡-X' 
                                       where AUDITORIUM_TYPE = 'À ' 
          commit; 
	-------------------------- t2 --------------------	
	rollback



	-- A ---
          set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM_TYPE = 'À¡-— ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when AUDITORIUM_CAPACITY = 130 then 'insert  AUDITORIUM'  else ' ' 
end 'ÂÁÛÎ¸Ú‡Ú', AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = 'À¡-— ';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('555-1', 'À¡-— ', 130,'555-1' );
          commit; 
	-------------------------- t2 --------------------



	      -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 10;  
			insert AUDITORIUM values ('556-1', 'À ', 140,'556-1' );
          update AUDITORIUM set AUDITORIUM_CAPACITY = 10 where AUDITORIUM_TYPE = 'À ';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = 'À ';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = 'À ';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
begin transaction 
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 10;  
			insert AUDITORIUM values ('556-1', 'À ', 140,'556-1' );
          update AUDITORIUM set AUDITORIUM_CAPACITY = 10 where AUDITORIUM_TYPE = 'À ';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = 'À ';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM_TYPE = 'À ';

	rollback
