use Punko_univer;
go
create function Count_Student (@f varchar(20)) returns int as
 begin declare @rc int=0;
 set @rc = (select count(*) from STUDENT s join GROUPS g on s.IDGROUP = g.IDGROUP
  join Faculty f on f.FACULTY = g.FACULTY where f.FACULTY=@f)
 return @rc;
 end;
 go 
 declare @i int = dbo.Count_Student('ТОВ');
 print @i;
 go;
 create FUNCTION FSubject(@tz char(20)) returns char(300) 
     as
     begin  
     declare @tv char(20);  
     declare @t varchar(300) = 'Дисциплины: ';  
     declare ZkSubject CURSOR LOCAL 
     for select SUBJECT from SUBJECT where PULPIT = @tz;
     open ZkSubject;	  
     fetch  ZkSubject into @tv;   	 
     while @@fetch_status = 0                                     
     begin 
         set @t = @t + ', ' + rtrim(@tv);         
         FETCH  ZkSubject into @tv; 
     end;    
     return @t;
     end;  
go;
   select PULPIT,  dbo.FSubject(PulPit) from PULPIT;
go
create function FFACPUL(@f varchar(20), @p varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT
  on FACULTY.FACULTY = PULPIT.FACULTY
   where FACULTY.FACULTY = ISNULL(@f, FACULTY.FACULTY) and 
    PULPIT.PULPIT = ISNULL(@p, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(null, null);
select * from dbo.FFACPUL('ИДиП', null);
select * from dbo.FFACPUL(null, 'ИСиТ');
select * from dbo.FFACPUL('ИДиП', 'ОХ');
go
create function FCTEACHER (@p varchar(50)) returns int as
begin
declare @rc int = (select count(*) from Teacher where PULPIT=isnull(@p,PULPIT));
return @rc;
end;
go;
select PULPIT, dbo.FCTEACHER(Pulpit)[Количество преподавателей] from Pulpit;
go
create function FACULTY_REPORT1(@c int) returns @fr table
	                        ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
	                                                                 [Количество студентов] int, [Количество специальностей] int )
	as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY where dbo.Count_Student(FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),  dbo.Count_Student(@f),
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;
go
	select* from  dbo.FACULTY_REPORT1(20);