use PUNKO_UNIVER
go
select * from faculty;
select TEACHER, PULPIT from teacher;
select TEACHER_NAME from TEACHER where PULPIT='ИСиТ';
select TEACHER_NAME from TEACHER where (PULPIT='ИСиТ' or PULPIT='ПОиСОИ');
select TEACHER_NAME from TEACHER where (PULPIT='ИСиТ' and GENDER='ж');
select TEACHER_NAME[Имя преподавателя] from TEACHER where (PULPIT='ИСиТ' and GENDER ='ж');
select distinct PULPIT from PULPIT;
select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME,AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct top(2) AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY Desc;
select distinct subject, note from PROGRESS where NOTE between 8 and 10;
select subject, PULPIT,SUBJECT_NAME from subject where pulpit in('ЛЗиДВ', 'ПОиСОИ','ОВ');
/*!*/select PROFESSION_NAME[Наименование специальности], QUALIFICATION[Квалификация] from PROFESSION where QUALIFICATION like '%химик%';
--create table #sometable
--(
--ФИО nvarchar(100),
--Дата date
--);
--select Name, BDAY into #sometable(ФИО, Дата) from STUDENT;
--select * from #sometable;

create table #sometable1
(
ФИО nvarchar(100),
Дата date
);
select Name, BDAY into #sometable1 from STUDENT;
select * from #sometable1;
