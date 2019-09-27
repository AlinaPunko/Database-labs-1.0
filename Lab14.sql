use Punko_Univer;
--1--
go
alter procedure PSUBJECT as
begin
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT;
return @k;
end;
go
declare @k1 int = 0;
exec @k1 = PSUBJECT;
print 'Количество предметов= ' + cast(@k1 as nvarchar(10));
--2--
go
declare @k int = 0, @r int =0, @p varchar(20);
exec @k = PSUBJECT @p='ИСиТ', @c=@r output;
print 'Всего предметов = ' + cast(@k as varchar(10));
print 'Предметов на кафедре '  + cast(@r as varchar(10));
--3--
create table #Subject (Subject char(10) primary key , Subject_name varchar(100), Pulpit char(20))
Insert #Subject exec PSUBJECT @p='ИСиТ';
Insert #Subject exec PSUBJECT @p='ТЛ';
Insert #Subject exec PSUBJECT @p='ПОиСОИ';
Insert #Subject exec PSUBJECT @p='ЛУ';
select * from #Subject;
--4--
go
create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int =null , @t char(10) as
declare @rc int =1;
begin try
	insert into AUDITORIUM values(@a,@n, @c, @t);
	return @rc;
end try
begin catch
print 'Номер ошибки ' + cast(error_number() as  varchar(6));
print 'Состояние ошибки ' + cast(error_state() as  varchar(8));
print 'Серъёзность ошибки ' + cast(error_severity() as  varchar(8));
print 'Сообщение ' + error_message();
if error_procedure() is not null
print 'имя процедуры ' + error_procedure();
return -1;
end catch
go
declare @rc int;  
exec @rc = PAUDITORIUM_INSERT @a  = '666-1', @n = 'ЛК', @c = 90, @t='666-1';  
print 'код ошибки : ' + cast(@rc as varchar(3)); 
--5--
use PUNKO_UNIVER
go
create procedure Subject_REPORT1  @p CHAR(50)
   as  
   declare @rc int = 0;                            
   begin try    
      declare @tv char(20), @t char(300) = ' ';  
      declare ZkSub CURSOR  for 
      select SUBJECT from SUBJECT where Pulpit = @p;
      if not exists (select SUBJECT from SUBJECT where Pulpit = @p)
          raiserror('ошибка', 11, 1);
       else 
      open ZkSub;	  
  fetch  ZkSub into @tv;   
  print   'Предмет';   
  while @@fetch_status = 0                                     
   begin 
       set @t = rtrim(@tv) + ', ' + @t;  
       set @rc = @rc + 1;       
       fetch  ZkSub into @tv; 
    end;   
print @t;        
close  ZkSub;
    return @rc;
   end try  
   begin catch              
        print 'ошибка в параметрах' 
        if error_procedure() is not null   
  print 'имя процедуры : ' + error_procedure();
        return @rc;
   end catch; 
   go
declare @rc int;  
exec @rc = Subject_REPORT1 @p  = 'ИСиТ';  
print 'количество предметов = ' + cast(@rc as varchar(3)); 
--6--
go
create  procedure PAUDITORIUMInsert_X
    @a char(20), @n varchar(50), @c int =null , @t char(10), @tn varchar(50)   
as  declare @rc int=1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
    insert into AUDITORIUM_TYPE values (@t, @tn)
    exec @rc=PAUDITORIUM_INSERT @a, @t, @c, @n;  
    commit tran; 
    return @rc;           
end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rc int;  
exec @rc = PAUDITORIUMInsert_X @a ='667-1' , @n = '667-1', @c = 100, @t =  'SM', @tn = 'Something';  
print 'код ошибки=' + cast(@rc as varchar(3));  
go



