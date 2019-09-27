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
print '���������� ���������= ' + cast(@k1 as nvarchar(10));
--2--
go
declare @k int = 0, @r int =0, @p varchar(20);
exec @k = PSUBJECT @p='����', @c=@r output;
print '����� ��������� = ' + cast(@k as varchar(10));
print '��������� �� ������� '  + cast(@r as varchar(10));
--3--
create table #Subject (Subject char(10) primary key , Subject_name varchar(100), Pulpit char(20))
Insert #Subject exec PSUBJECT @p='����';
Insert #Subject exec PSUBJECT @p='��';
Insert #Subject exec PSUBJECT @p='������';
Insert #Subject exec PSUBJECT @p='��';
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
print '����� ������ ' + cast(error_number() as  varchar(6));
print '��������� ������ ' + cast(error_state() as  varchar(8));
print '����������� ������ ' + cast(error_severity() as  varchar(8));
print '��������� ' + error_message();
if error_procedure() is not null
print '��� ��������� ' + error_procedure();
return -1;
end catch
go
declare @rc int;  
exec @rc = PAUDITORIUM_INSERT @a  = '666-1', @n = '��', @c = 90, @t='666-1';  
print '��� ������ : ' + cast(@rc as varchar(3)); 
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
          raiserror('������', 11, 1);
       else 
      open ZkSub;	  
  fetch  ZkSub into @tv;   
  print   '�������';   
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
        print '������ � ����������' 
        if error_procedure() is not null   
  print '��� ��������� : ' + error_procedure();
        return @rc;
   end catch; 
   go
declare @rc int;  
exec @rc = Subject_REPORT1 @p  = '����';  
print '���������� ��������� = ' + cast(@rc as varchar(3)); 
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
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rc int;  
exec @rc = PAUDITORIUMInsert_X @a ='667-1' , @n = '667-1', @c = 100, @t =  'SM', @tn = 'Something';  
print '��� ������=' + cast(@rc as varchar(3));  
go



