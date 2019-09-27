use Punko_Univer;
exec SP_HElpindex 'Groups';
exec SP_HElpindex 'Student';
exec SP_HElpindex 'Auditorium';
go
CREATE table  #EXPLRE2
 (   TIND int,  
  TFIELD varchar(100)
      );
set nocount on;
Declare @i int =0;
while @i<5001
begin
insert #EXPLRE2 ( TIND , TFIELD ) values (@i*RAND(1000),REPLICATE( 'строка',10));
set @i=@i+1;
end;
select * from #EXPLRE2; --0.045
SELECT * FROM #EXPLRE2 where TIND between 500 and 900 order by TIND ; --0.065
CREATE clustered index #EXPLRE_CL  on #EXPLRE2(TIND asc)
--drop index #EXPLRE_CL on #EXPLRE2;
select * from #EXPLRE2; --0.045
SELECT * FROM #EXPLRE2 where TIND between 500 and 900 order by TIND ; --0.0075


go
CREATE table #EX
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100));

  set nocount on;           
  declare @i int = 0;
  while   @i < 20000       -- добавление в таблицу 20000 строк
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @i = @i + 1; 
  end;
  SELECT * from  #EX where  TKEY = 556 and  CC > 3 --0.01
  SELECT count(*)[количество строк] from #EX; --0.15
  SELECT * from #EX --0.437
CREATE index #EX_NONCLU on #EX(TKEY, CC)
SELECT * from  #EX where  TKEY > 1500 and  CC < 4500;  --0.437
SELECT * from  #EX order by  TKEY, CC --3.64
SELECT * from  #EX where  TKEY = 556 and  CC > 3 --0.0102
--drop index #EX_NONCLU on #EX;
go
SELECT CC from #EX where TKEY>15000  --0.437
--drop index #EX_TKEY_X on #EX;
CREATE  index #EX_TKEY_X on #EX(TKEY) INCLUDE (CC)
SELECT CC from #EX where TKEY>15000  --0.073

go
--drop  index #EX_TKEY on #EX
SELECT TKEY from  #EX where TKEY between 5000 and 19999; --0.073
SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000  --0.026
SELECT TKEY from  #EX where TKEY=17000 --0.0032
--drop  index #EX_WHERE on #EX
CREATE  index #EX_WHERE on #EX(TKEY) where (TKEY>=15000 and 
 TKEY < 20000);  
 SELECT TKEY from  #EX where TKEY between 5000 and 19999; --0.073
SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000  --0.013
SELECT TKEY from  #EX where TKEY=17000 --0.0032

go
CREATE TABLE TEMP( 
ID int IDENTITY(1,1), 
NAME nvarchar(100), 
AGE int); 

CREATE INDEX indx ON TEMP(ID); 

DECLARE @k int = 1,@y int; 
WHILE @k < 100
BEGIN 
SET @y = @k%3; 
INSERT TEMP(NAME,AGE) VALUES ( 
CASE @y 
WHEN 0 THEN N'ноль' 
WHEN 1 THEN N'один' 
WHEN 2 THEN N'два' 
END, 
FLOOR(RAND()*20)); 
SET @k = @k + 1; 
END; 
select * from TEMP;

SELECT tab2.name [Индекс], tab1.avg_fragmentation_in_percent [Фрагментация (%)] FROM 
sys.dm_db_index_physical_stats(DB_ID(N'Punko_Univer'),OBJECT_ID(N'TEMP'),NULL,NULL,NULL) tab1 
JOIN 
sys.indexes tab2 
ON tab1.object_id = tab2.object_id AND tab1.index_id = tab2.index_id 
WHERE tab2.name IS NOT NULL; 

DECLARE @k1 int = 1, @y1 int;
WHILE @k1 < 5000
BEGIN 
SET @y1 = @k1%3; 
INSERT TEMP(NAME,AGE) VALUES ( 
CASE @y1 
WHEN 0 THEN N'ноль' 
WHEN 1 THEN N'один' 
WHEN 2 THEN N'два' 
END, 
FLOOR(RAND()*20)); 
SET @k1 = @k1 + 1; 
END; 

ALTER INDEX indx ON TEMP REORGANIZE; 

ALTER INDEX indx ON TEMP REBUILD WITH(ONLINE = OFF ); 

drop table TEMP;

DROP index #EX_TKEY on #EX;
CREATE TABLE TEMP( 
ID int IDENTITY(1,1), 
NAME nvarchar(100), 
AGE int); 
    CREATE index #EX_TKEY on TEMP(ID) with (fillfactor = 65);

    INSERT top(50)percent INTO TEMP(NAME, AGE) SELECT TKEY, LEN(TF)  FROM #EX;
	select * from TEMP;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
                                     ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                                                                                          WHERE name is not null;


