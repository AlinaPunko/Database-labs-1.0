use PUNKO_UNIVER;
--go
--create view [Преподаватель] 
--as select Teacher[Код], TEACHER_NAME[Имя преподавателя], Gender[пол],PULPIT[код кафедры]
-- from TEACHER;

--CREATE VIEW [Количество кафедр]
--as select FACULTY.FACULTY_NAME [Факультет], count(*) [Количество]
--from FACULTY join PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;

--create view [Аудитории]
-- as select AUDITORIUM[Код], AUDITORIUM_NAME[Наименование аудитории] from AUDITORIUM where AUDITORIUM_TYPE like ('ЛК%');
--create view [Лекционные аудитории]
-- as select AUDITORIUM[Код], AUDITORIUM_NAME[Наименование аудитории] from AUDITORIUM where AUDITORIUM_TYPE like ('ЛК%') WITH CHECK OPTION;

--insert into [Лекционные аудитории] values ('611-1','611-1');

--create view [Дисциплины]
-- as select TOP 150 SUBJECT[Код], SUBJECT_NAME[Наименование дисциплины], PULPIT[Кафедра]
--  from SUBJECT order by SUBJECT;

--alter VIEW [Количество кафедр] WITH SCHEMABINDING
--as select FACULTY.FACULTY_NAME [Факультет], count(*) [Количество]
--from dbo.FACULTY join dbo.PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;
--1-- представление таблицы TEACHER
go
CREATE VIEW [Преподаватели] 
as select TEACHER [Код], TEACHER_NAME [Имя преподавателя], GENDER [Пол], PULPIT [Код кафедры] 
from  TEACHER;

select * from Преподаватели

--drop view [Преподаватели];


--2-- количество кафедр на каждом факультете
CREATE VIEW [Количество кафедр]
as select FACULTY.FACULTY_NAME [Факультет], count(*) [Количество]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

CREATE VIEW [Кафедры]
as select FACULTY.FACULTY_NAME [Факультет], count(*) [Количество]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
select * from [Кафедры];

--drop view [Количество кафедр];


--3-- все лекционные аудитории
go
CREATE VIEW [Аудитории] (Наименование_аудитории, код_аудитории)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE  
from AUDITORIUM
where  AUDITORIUM.AUDITORIUM_TYPE like '%ЛК%';        
go
select * from Аудитории

INSERT [Аудитории] values ('33333322', 'ЛК');
INSERT [Аудитории] values ('33999', 'ЛБ-К');


--drop view [Аудитории]


--4-- п.3 with check option
go
CREATE VIEW [Лекционные_аудитории] (Наименование_аудитории, тип)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE  
from AUDITORIUM
where  AUDITORIUM.AUDITORIUM_TYPE like '%ЛК%'        
WITH CHECK OPTION;
go
select * from Лекционные_аудитории

INSERT [Лекционные_аудитории] values ('3333314213', 'ЛБ');

--drop view [Лекционные_аудитории]


--5-- дисциплины в алфавитном порядке
go
create view [Дисциплины] (Код, Наименование_дисциплины, Код_кафедры) 
as select top 15 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
from SUBJECT 
order by SUBJECT.SUBJECT_NAME;
go
alter view [Дисциплины] (Код, Наименование_дисциплины, Код_кафедры) WITH SCHEMABINDING
as select top 15 dbo.SUBJECT.SUBJECT, dbo.SUBJECT.SUBJECT_NAME, dbo.SUBJECT.PULPIT
from dbo.SUBJECT 
order by dbo.SUBJECT.SUBJECT_NAME;
drop table dbo.Subject;
go
select * from Дисциплины
go
alter VIEW [Кафедры] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [Факультет], count(*) [Количество]
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
drop table dbo.Pulpit;
go
--alter VIEW [Количество кафедр] 
--as select FACULTY.FACULTY_NAME [Факультет]
--from dbo.FACULTY join dbo.PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;
--drop view [Количество кафедр]