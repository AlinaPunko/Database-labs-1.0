use PUNKO_UNIVER
go
select * from faculty;
select TEACHER, PULPIT from teacher;
select TEACHER_NAME from TEACHER where PULPIT='����';
select TEACHER_NAME from TEACHER where (PULPIT='����' or PULPIT='������');
select TEACHER_NAME from TEACHER where (PULPIT='����' and GENDER='�');
select TEACHER_NAME[��� �������������] from TEACHER where (PULPIT='����' and GENDER ='�');
select distinct PULPIT from PULPIT;
select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME,AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY;
select distinct top(2) AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY Desc;
select distinct subject, note from PROGRESS where NOTE between 8 and 10;
select subject, PULPIT,SUBJECT_NAME from subject where pulpit in('�����', '������','��');
/*!*/select PROFESSION_NAME[������������ �������������], QUALIFICATION[������������] from PROFESSION where QUALIFICATION like '%�����%';
--create table #sometable
--(
--��� nvarchar(100),
--���� date
--);
--select Name, BDAY into #sometable(���, ����) from STUDENT;
--select * from #sometable;

create table #sometable1
(
��� nvarchar(100),
���� date
);
select Name, BDAY into #sometable1 from STUDENT;
select * from #sometable1;
