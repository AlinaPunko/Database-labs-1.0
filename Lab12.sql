use PUNKO_UNIVER;
declare @tv char(20), @t char(300)=' ';
--1
Declare ISIT CURSOR for select SUBJECT from SUBJECT where PULPIT='ИСиТ';
open ISIT;
Fetch ISIT into @tv;
print 'Дисциплины на кафедра ИСИТ';
while @@FETCH_STATUS=0
begin
set @t=rtrim(@tv)+ ', '+ @t;
fetch ISIT into @tv;
end;
print @t;
close ISIT;

--2
DECLARE auditorii0 CURSOR LOCAL for SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY from AUDITORIUM;
DECLARE @tv1 char(20), @cena1 real;      
OPEN auditorii0;	  
	fetch  auditorii0 into @tv1, @cena1; 	
      print '1. '+@tv1+cast(@cena1 as varchar(6));   
      go
 DECLARE @tv1 char(20), @cena1 real;     	
	fetch  auditorii0 into @tv1, @cena1; 	
      print '2. '+@tv1+cast(@cena1 as varchar(6));  
  go   

  DECLARE auditorii1 CURSOR global  for SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY from AUDITORIUM;
DECLARE @tv2 char(20), @cena2 real;      
	OPEN auditorii1;	  
	fetch  auditorii1 into @tv2, @cena2; 	
      print '1. '+@tv2+cast(@cena2 as varchar(6));   
      go
 DECLARE @tv2 char(20), @cena2 real;     	
	fetch  auditorii1 into @tv2, @cena2; 	
      print '2. '+@tv2+cast(@cena2 as varchar(6));  
  go   

--3
select * from AUDITORIUM;
SELECT * FROM Auditorium where AUditorium_type = 'ЛК';
        DECLARE @tid char(10), @tnm char(40), @tgn char(10), @tgt char(10), @tid1 char(10);  
	DECLARE Cursor1 CURSOR LOCAL STATIC                              
		 for SELECT * FROM Auditorium where AUditorium_type = 'ЛК';				   
	open Cursor1;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    --UPDATE Auditorium set AUDITORIUM_CAPACITY = 100 where AUDITORIUM_NAME is null;
	INSERT Auditorium (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY,AUDITORIUM_NAME) 
	                 values ('510-1', 'ЛК', 100, '510-1'); DELETE Auditorium where AUDITORIUM_CAPACITY = 100;
	FETCH  Cursor1 into @tid, @tnm, @tgn, @tgt, @tid1;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn+ ' '+ @tgt+ ' '+ @tid1;      
          fetch Cursor1 into @tid, @tnm, @tgn, @tgt, @tid1; 
       end;          
   CLOSE  Cursor1;

   go
   DECLARE Cursor2 CURSOR LOCAL DYNAMIC                              
		 for SELECT * FROM Auditorium where AUditorium_type = 'ЛК';		
    DECLARE @tid char(10), @tnm char(40), @tgn char(10), @tgt char(10), @tid1 char(10);  		   
	open Cursor2;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    UPDATE Auditorium set AUDITORIUM_CAPACITY = 200 where AUDITORIUM_NAME is null;
	DELETE Auditorium where AUDITORIUM_CAPACITY = 100;
	INSERT Auditorium (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY,AUDITORIUM_NAME) 
	                 values ('506-1', 'ЛК', 100, '505-1'); 
	FETCH  Cursor2 into @tid ,@tnm ,@tgn, @tgt,@tid1;   
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5));   
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn+ ' '+ @tgt+ ' '+ @tid1;      
          fetch Cursor2 into @tid, @tnm, @tgn, @tgt, @tid1; 
       end;          
   CLOSE  Cursor2;
   go



  select * from AUDITORIUM where AUDITORIUM_TYPE='ЛБ-К';
  DECLARE  @tc int, @rn char(50);  
         DECLARE Primer1 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by AUDITORIUM_NAME) N,
	                          AUDITORIUM_NAME FROM AUDITORIUM where AUDITORIUM_TYPE= 'ЛБ-К' FOR UPDATE
	OPEN Primer1;
	FETCH  Primer1 into  @tc, @rn;                 
	print 'следующая строка        : ' + cast(@tc as varchar(3))+ rtrim(@rn);      
	FETCH  LAST from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn); 
		FETCH  PRIOR from  Primer1 into @tc, @rn;       
	print 'предыдущая строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
	FETCH  FIRST from  Primer1 into @tc, @rn;       
	print 'первая строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
	FETCH  NEXT from  Primer1 into @tc, @rn;       
	print 'следующая строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
		FETCH  RELATIVE 2 from  Primer1 into @tc, @rn;       
	print 'вторая строка вперед от текущей          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);
			FETCH  ABSOLUTE -1 from  Primer1 into @tc, @rn;       
	print 'первая строка от конца          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);    
      CLOSE Primer1;

INSERT FACULTY(FACULTY,FACULTY_NAME) VALUES (N'FIT',N'Факультет IT'); 

--5
print 5
DECLARE cur CURSOR LOCAL SCROLL DYNAMIC FOR 
SELECT f.FACULTY FROM FACULTY f FOR UPDATE; 

DECLARE @s nvarchar(5); 
OPEN cur 
FETCH FIRST FROM cur INTO @s; 
UPDATE FACULTY SET FACULTY = N'myFIT' WHERE CURRENT OF cur; 
FETCH FIRST FROM cur INTO @s; 
DELETE FACULTY WHERE CURRENT OF cur; 
GO 

--6 
print 6;
DECLARE cur CURSOR LOCAL DYNAMIC FOR 
SELECT stud.NAME FROM GROUPS gr JOIN STUDENT stud ON gr.IDGROUP = stud.IDGROUP 
JOIN PROGRESS prog ON prog.IDSTUDENT = stud.IDSTUDENT WHERE prog.NOTE < 4 FOR UPDATE; 
--SELECT stud.NAME FROM GROUPS gr JOIN STUDENT stud ON gr.IDGROUP = stud.IDGROUP 
--JOIN PROGRESS prog ON prog.IDSTUDENT = stud.IDSTUDENT WHERE prog.NOTE < 6 
OPEN cur; 
DECLARE @s nvarchar(10); 
WHILE 0 = 0 
BEGIN 
FETCH cur INTO @s; 
IF (@@FETCH_STATUS != 0) BREAK; 
DELETE FACULTY WHERE CURRENT OF cur; 
END; 
GO 

DECLARE cur CURSOR LOCAL DYNAMIC FOR SELECT prog.NOTE FROM PROGRESS prog WHERE prog.IDSTUDENT = 1001 FOR UPDATE; 
OPEN cur; 
DECLARE @s nvarchar(10); 
FETCH cur INTO @s; 
UPDATE dbo.PROGRESS SET dbo.PROGRESS.NOTE = @s + 1 WHERE CURRENT OF cur; 

GO 

DECLARE cur CURSOR LOCAL SCROLL STATIC FOR 
SELECT f.FACULTY, p.PULPIT, 
(SELECT * FROM PULPIT p1 LEFT JOIN FACULTY f1 ON p1.FACULTY = f1.FACULTY RIGHT JOIN [SUBJECT] sub1 ON sub1.PULPIT = p1.PULPIT WHERE p.PULPIT = p1.PULPIT),
(SELECT COUNT(*) FROM PULPIT p1 LEFT JOIN FACULTY f1 ON p1.FACULTY = f1.FACULTY RIGHT JOIN TEACHER t1 ON t1.PULPIT = p1.PULPIT WHERE p.PULPIT = p1.PULPIT) 
FROM 
PULPIT p LEFT JOIN FACULTY f ON p.FACULTY = f.FACULTY RIGHT JOIN TEACHER t ON t.PULPIT = p.PULPIT 
ORDER BY f.FACULTY; 


DECLARE 
@faculty_name nvarchar(10), 
@pulpit nvarchar(10), 
@count_techers int = 0, 
@sub nvarchar(50), 
@str nvarchar(max) = N' '; 

OPEN cur; 
WHILE 0 = 0 
BEGIN 
FETCH cur INTO @faculty_name,@pulpit,@sub,@count_techers; 
IF(@@FETCH_STATUS != 0) BREAK; 
SET @str = @str + N'Факультет : ' + @faculty_name + CHAR(10) 
SET @str = @str + CHAR(9) + N'Кафедра : ' + @pulpit +CHAR(10); 
SET @str = @str + CHAR(9) + CHAR(9) + N'Количество преподавателей : ' + CAST(@count_techers AS nvarchar(10)) + N'.' + CHAR(10); 
WHILE 0 = 0 
BEGIN 
FETCH cur INTO @faculty_name,@pulpit,@sub,@count_techers; 
END; 
SET @str = @str + CHAR(9) + CHAR(9) + N'Дисциплины : ' + @sub + CHAR(10); 
END; 
PRINT SUBSTRING(@str,1,LEN(@str)); 
GO