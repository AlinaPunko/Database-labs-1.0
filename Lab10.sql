use PUNKO_UNIVER;
declare @vchar char = 't',@vvarchar varchar ='qwe',@dt datetime, @time time,@vint int,@vsint smallint, @vtint tinyint, @vnumeric numeric(12,5);
set @dt = getdate();
set @vint = (select count(*) from AUDITORIUM);
select @vsint = 5000;
select @vtint = 100;
select @time = getdate();
select @vchar, @vint, @vnumeric, @dt;
print @vvarchar;
print @dt;
print @vsint;
print @vtint;

declare
    @int_example int,
    @dt_example datetime,
    @str_example varchar(255);
 
select
    @int_example = 1,
    @dt_example = getdate(),
    @str_example = 'qwe';
--set
--@int_example = 1,
--@dt_example = getdate(),
--@str_example = 'qwe';
select @int_example = note from PROGRESS;
print @int_example;
set @int_example = (select note from PROGRESS);
print @int_example;
declare @sum int = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM)
declare @avg float = ( select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
declare @k int = ( select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY<@avg);
if @sum< 200
select @sum
else
select count(*)[Общее количество аудиторий],cast (avg(AUDITORIUM_CAPACITY)  as float(4))[Средняя вместимость],(select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY<@avg)[Количество аудиторий с вместимостью меньше среднего],
cast ( @k*100 as float)/(select count(*) from AUDITORIUM) [Процент таких аудиторий]  from AUDITORIUM;

declare @x  float= 1, @t float=1 ;
if  @t>@x
begin
print sin(@t)*sin(@t)
print 'sin(@t)*sin(@t)';
end
else if @t<@x
begin
print 4*(@t+@x);
print '4*(@t+@x)'
end
else if @t=@x
begin
print '1 - Exp(@x-2)';
print 1 - Exp(@x-2) ;
end

print @@ROWCOUNT ;
print @@VERSION ;
print @@SPID ; 
print @@ERROR ; 
print @@SERVERNAME; 
print @@TRANCOUNT ; 
print @@FETCH_STATUS ; 
print @@NESTLEVEL;

DECLARE 
@name nvarchar(100) = (SELECT stud.NAME FROM STUDENT stud WHERE stud.IDSTUDENT = 1010), 
@fist_name nvarchar(50), 
@midle_name nvarchar(50), 
@last_name nvarchar(50), 
@position_one int, 
@position_two int; 

SET @position_one = CHARINDEX(' ',@name); 
SET @position_two = LEN(@name) - CHARINDEX(' ',REVERSE(@name)); 
SET @fist_name = SUBSTRING(@name,0,@position_one) 
SET @midle_name = SUBSTRING(@name,@position_one + 1,1); 
SET @last_name = SUBSTRING(@name,@position_two + 2,1); 

PRINT @fist_name+' '+@midle_name+'.'+@last_name+'.'; 


DECLARE 
@month int; 

SET @month = DATEPART(month,SYSDATETIME()) + 1; 

SELECT 
stud.NAME, 
stud.BDAY, 
DATEPART(year,SYSDATETIME()) - DATEPART(year,BDAY) [возраст] 
FROM STUDENT stud 
WHERE DATEPART(month,stud.BDAY) = @month;
 
declare @res int = datepart(dw,(select PDATE from progress where SUBJECt='СУБД' group by PDATE));
print @res;

select case  when Note between 0 and 3 then 'плохо'
			 when Note between 4 and 6 then 'ну такое'
             when Note between 7 and 8 then 'хорошо'
			 else 'отлично'
			 end Note, count(*)
from PROGRESS
group by case when Note between 0 and 3 then 'плохо'
			 when Note between 4 and 6 then 'ну такое'
             when Note between 7 and 8 then 'хорошо'
			 else 'отлично'
			 end;

CREATE table  #EXPLRE
 (   TIND int,  
  TFIELD varchar(100)
      );
set nocount on;
Declare @i int =0;
while @i<10
begin
insert #EXPLRE ( TIND , TFIELD ) values (@i, 'строка');
set @i=@i+1;
end;
select * from #EXPLRE;

begin Try
print(10/0)
end try
begin CATCH
PRINT ERROR_NUMBER();
PRINT ERROR_Message();
PRINT ERROR_line();
PRINT ERROR_state();
PRINT ERROR_severity();
PRINT ERROR_procedure();
END Catch
go
Declare @k int = 10;
print @k/2
print @k/5
return
print @k/10