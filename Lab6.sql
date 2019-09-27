use master;
use PUNKO_UNIVER;
select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM inner join 
AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE;

select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM inner join 
AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%компьютер%';

select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM, 
AUDITORIUM_TYPE ;


select T2.AUDITORIUM_TYPE,T2.AUDITORIUM_TYPENAME, T1.AUDITORIUM from AUDITORIUM as T1, 
AUDITORIUM_TYPE as T2 where T1.AUDITORIUM_TYPE=T2.AUDITORIUM_TYPE and T2.AUDITORIUM_TYPENAME Like '%компьютер%';

select  FACULTY.FACULTY_NAME as [факультет] , 
		PULPIT.PULPIT_NAME as [кафедра],
		GROUPS.PROFESSION as [специальность],
		SUBJECT.SUBJECT_NAME as [дисциплина],
		STUDENT.NAME as [ФИО],
   Case 
   when ( PROGRESS.NOTE=6) then 'шесть'
   when ( PROGRESS.NOTE=7) then 'семь'
   when ( PROGRESS.NOTE=8) then 'восемь'
    end     [оценка]  
FROM    FACULTY  join GROUPS  on FACULTY.FACULTY =GROUPS.FACULTY 
				  join STUDENT  on STUDENT.IDGROUP=GROUPS.IDGROUP
				  join PROGRESS  on PROGRESS.idstudent=STUDENT.IDSTUDENT
				  join SUBJECT  on SUBJECT.[SUBJECT]=Progress.SUBJECT
				  join PULPIT on PULPIT.PULPIT=Subject.Pulpit
where 	PROGRESS.NOTE between 6 and 8
order by  FACULTY.FACULTY asc 


select  FACULTY.FACULTY_NAME as [факультет] , 
		PULPIT.PULPIT_NAME as [кафедра],
		GROUPS.PROFESSION as [специальность],
		SUBJECT.SUBJECT_NAME as [дисциплина],
		STUDENT.NAME as [ФИО],
   Case 
   when ( PROGRESS.NOTE=6) then 'шесть'
   when ( PROGRESS.NOTE=7) then 'семь'
   when ( PROGRESS.NOTE=8) then 'восемь'
    end     [оценка]  
FROM    FACULTY  join GROUPS  on FACULTY.FACULTY =GROUPS.FACULTY 
				  join STUDENT  on STUDENT.IDGROUP=GROUPS.IDGROUP
				  join PROGRESS  on PROGRESS.idstudent=STUDENT.IDSTUDENT
				  join SUBJECT  on SUBJECT.[SUBJECT]=Progress.SUBJECT
				  join PULPIT on PULPIT.PULPIT=Subject.Pulpit
where 	PROGRESS.NOTE between 6 and 8
		order by 
		(case when(PROGRESS.NOTE='6')then 3
			when(PROGRESS.NOTE='7')then 2
		else 1 end)

select  PULPIT.PULPIT_NAME[Кафедра], isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]from PULPIT left outer join TEACHER 
 on TEACHER.PULPIT=PULPIT.PULPIT;

 select  PULPIT.PULPIT_NAME[Кафедра], isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]from  TEACHER left outer join PULPIT
 on TEACHER.PULPIT=PULPIT.PULPIT;

 select  PULPIT.PULPIT_NAME[Кафедра], isnull(TEACHER.TEACHER_NAME,'***')[Преподаватель]from  TEACHER right outer join  PULPIT
 on TEACHER.PULPIT=PULPIT.PULPIT;

 SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM_TYPE.AUDITORIUM_TYPE
  From AUDITORIUM Cross Join AUDITORIUM_TYPE 
  Where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE

  
   SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM_TYPE.AUDITORIUM_TYPE
  From AUDITORIUM right Join AUDITORIUM_TYPE 
  on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE; 

SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM_TYPE.AUDITORIUM_TYPE
  From AUDITORIUM cross Join AUDITORIUM_TYPE where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE union 
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM_TYPE.AUDITORIUM_TYPE
  From AUDITORIUM cross Join AUDITORIUM_TYPE where AUDITORIUM.AUDITORIUM_TYPE!=AUDITORIUM_TYPE.AUDITORIUM_TYPE; 

use Punko_MyBase
SELECT * from Реклама FULL OUTER JOIN Передачи
on реклама.Передача = Передачи.Название
Order by Реклама.Передача;
-- коммутативность
SELECT * from Реклама FULL OUTER JOIN Передачи
on Передачи.Название = реклама.Передача
Order by Реклама.Передача;
-- соединение left и right outer join'ов
SELECT * from Реклама left OUTER JOIN Передачи
on Передачи.Название = реклама.Передача union
SELECT * from Реклама right OUTER JOIN Передачи
on Передачи.Название = реклама.Передача
Order by Реклама.Передача;
-- включает inner join этих таблиц
SELECT * from Реклама inner JOIN Передачи
on Передачи.Название = реклама.Передача
Order by Реклама.Передача

SELECT * FROM Реклама left outer join Передачи on Передачи.Название = реклама.Передача union select * from Реклама 
					  right outer join Передачи on Передачи.Название = реклама.Передача except select * from реклама 
					  full outer join Передачи on Передачи.Название = реклама.Передача
Order by  Реклама.Передача
--10-- is null / is not null

SELECT * from Реклама inner JOIN Передачи
on Передачи.Название = реклама.Передача
where Реклама.Длительность_в_минутах is null;

SELECT * from Реклама inner JOIN Передачи
on Передачи.Название = реклама.Передача
where Реклама.Длительность_в_минутах is not null;

