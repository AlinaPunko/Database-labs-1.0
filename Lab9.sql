use PUNKO_UNIVER;
--go
--create view [�������������] 
--as select Teacher[���], TEACHER_NAME[��� �������������], Gender[���],PULPIT[��� �������]
-- from TEACHER;

--CREATE VIEW [���������� ������]
--as select FACULTY.FACULTY_NAME [���������], count(*) [����������]
--from FACULTY join PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;

--create view [���������]
-- as select AUDITORIUM[���], AUDITORIUM_NAME[������������ ���������] from AUDITORIUM where AUDITORIUM_TYPE like ('��%');
--create view [���������� ���������]
-- as select AUDITORIUM[���], AUDITORIUM_NAME[������������ ���������] from AUDITORIUM where AUDITORIUM_TYPE like ('��%') WITH CHECK OPTION;

--insert into [���������� ���������] values ('611-1','611-1');

--create view [����������]
-- as select TOP 150 SUBJECT[���], SUBJECT_NAME[������������ ����������], PULPIT[�������]
--  from SUBJECT order by SUBJECT;

--alter VIEW [���������� ������] WITH SCHEMABINDING
--as select FACULTY.FACULTY_NAME [���������], count(*) [����������]
--from dbo.FACULTY join dbo.PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;
--1-- ������������� ������� TEACHER
go
CREATE VIEW [�������������] 
as select TEACHER [���], TEACHER_NAME [��� �������������], GENDER [���], PULPIT [��� �������] 
from  TEACHER;

select * from �������������

--drop view [�������������];


--2-- ���������� ������ �� ������ ����������
CREATE VIEW [���������� ������]
as select FACULTY.FACULTY_NAME [���������], count(*) [����������]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

CREATE VIEW [�������]
as select FACULTY.FACULTY_NAME [���������], count(*) [����������]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
select * from [�������];

--drop view [���������� ������];


--3-- ��� ���������� ���������
go
CREATE VIEW [���������] (������������_���������, ���_���������)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE  
from AUDITORIUM
where  AUDITORIUM.AUDITORIUM_TYPE like '%��%';        
go
select * from ���������

INSERT [���������] values ('33333322', '��');
INSERT [���������] values ('33999', '��-�');


--drop view [���������]


--4-- �.3 with check option
go
CREATE VIEW [����������_���������] (������������_���������, ���)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE  
from AUDITORIUM
where  AUDITORIUM.AUDITORIUM_TYPE like '%��%'        
WITH CHECK OPTION;
go
select * from ����������_���������

INSERT [����������_���������] values ('3333314213', '��');

--drop view [����������_���������]


--5-- ���������� � ���������� �������
go
create view [����������] (���, ������������_����������, ���_�������) 
as select top 15 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
from SUBJECT 
order by SUBJECT.SUBJECT_NAME;
go
alter view [����������] (���, ������������_����������, ���_�������) WITH SCHEMABINDING
as select top 15 dbo.SUBJECT.SUBJECT, dbo.SUBJECT.SUBJECT_NAME, dbo.SUBJECT.PULPIT
from dbo.SUBJECT 
order by dbo.SUBJECT.SUBJECT_NAME;
drop table dbo.Subject;
go
select * from ����������
go
alter VIEW [�������] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [���������], count(*) [����������]
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;
drop table dbo.Pulpit;
go
--alter VIEW [���������� ������] 
--as select FACULTY.FACULTY_NAME [���������]
--from dbo.FACULTY join dbo.PULPIT
--on FACULTY.FACULTY = PULPIT.FACULTY
--group by FACULTY.FACULTY_NAME;
--drop view [���������� ������]