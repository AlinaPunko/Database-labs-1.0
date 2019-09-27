use master;
use PUNKO_UNIVER;
select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM inner join 
AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE;

select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM inner join 
AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%���������%';

select AUDITORIUM_TYPE.AUDITORIUM_TYPE,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM from AUDITORIUM, 
AUDITORIUM_TYPE ;


select T2.AUDITORIUM_TYPE,T2.AUDITORIUM_TYPENAME, T1.AUDITORIUM from AUDITORIUM as T1, 
AUDITORIUM_TYPE as T2 where T1.AUDITORIUM_TYPE=T2.AUDITORIUM_TYPE and T2.AUDITORIUM_TYPENAME Like '%���������%';

select  FACULTY.FACULTY_NAME as [���������] , 
		PULPIT.PULPIT_NAME as [�������],
		GROUPS.PROFESSION as [�������������],
		SUBJECT.SUBJECT_NAME as [����������],
		STUDENT.NAME as [���],
   Case 
   when ( PROGRESS.NOTE=6) then '�����'
   when ( PROGRESS.NOTE=7) then '����'
   when ( PROGRESS.NOTE=8) then '������'
    end     [������]  
FROM    FACULTY  join GROUPS  on FACULTY.FACULTY =GROUPS.FACULTY 
				  join STUDENT  on STUDENT.IDGROUP=GROUPS.IDGROUP
				  join PROGRESS  on PROGRESS.idstudent=STUDENT.IDSTUDENT
				  join SUBJECT  on SUBJECT.[SUBJECT]=Progress.SUBJECT
				  join PULPIT on PULPIT.PULPIT=Subject.Pulpit
where 	PROGRESS.NOTE between 6 and 8
order by  FACULTY.FACULTY asc 


select  FACULTY.FACULTY_NAME as [���������] , 
		PULPIT.PULPIT_NAME as [�������],
		GROUPS.PROFESSION as [�������������],
		SUBJECT.SUBJECT_NAME as [����������],
		STUDENT.NAME as [���],
   Case 
   when ( PROGRESS.NOTE=6) then '�����'
   when ( PROGRESS.NOTE=7) then '����'
   when ( PROGRESS.NOTE=8) then '������'
    end     [������]  
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

select  PULPIT.PULPIT_NAME[�������], isnull(TEACHER.TEACHER_NAME,'***')[�������������]from PULPIT left outer join TEACHER 
 on TEACHER.PULPIT=PULPIT.PULPIT;

 select  PULPIT.PULPIT_NAME[�������], isnull(TEACHER.TEACHER_NAME,'***')[�������������]from  TEACHER left outer join PULPIT
 on TEACHER.PULPIT=PULPIT.PULPIT;

 select  PULPIT.PULPIT_NAME[�������], isnull(TEACHER.TEACHER_NAME,'***')[�������������]from  TEACHER right outer join  PULPIT
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
SELECT * from ������� FULL OUTER JOIN ��������
on �������.�������� = ��������.��������
Order by �������.��������;
-- ���������������
SELECT * from ������� FULL OUTER JOIN ��������
on ��������.�������� = �������.��������
Order by �������.��������;
-- ���������� left � right outer join'��
SELECT * from ������� left OUTER JOIN ��������
on ��������.�������� = �������.�������� union
SELECT * from ������� right OUTER JOIN ��������
on ��������.�������� = �������.��������
Order by �������.��������;
-- �������� inner join ���� ������
SELECT * from ������� inner JOIN ��������
on ��������.�������� = �������.��������
Order by �������.��������

SELECT * FROM ������� left outer join �������� on ��������.�������� = �������.�������� union select * from ������� 
					  right outer join �������� on ��������.�������� = �������.�������� except select * from ������� 
					  full outer join �������� on ��������.�������� = �������.��������
Order by  �������.��������
--10-- is null / is not null

SELECT * from ������� inner JOIN ��������
on ��������.�������� = �������.��������
where �������.������������_�_������� is null;

SELECT * from ������� inner JOIN ��������
on ��������.�������� = �������.��������
where �������.������������_�_������� is not null;

