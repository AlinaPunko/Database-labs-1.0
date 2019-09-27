use PUNKO_UNIVER

select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME, FACULTY.FACULTY_NAME from FACULTY, PULPIT, PROFESSION
where PROFESSION.FACULTY = PULPIT.FACULTY and FACULTY.FACULTY in (
select PROFESSION.FACULTY from PROFESSION where (PROFESSION.PROFESSION_NAME like '%технология%') or 
												(PROFESSION.PROFESSION_NAME like '%технологии%'))

select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME, FACULTY.FACULTY_NAME from Pulpit inner join Profession 
on PROFESSION.FACULTY = PULPIT.FACULTY inner join Faculty on FACULTY.FACULTY in (
select PROFESSION.FACULTY from PROFESSION where (PROFESSION.PROFESSION_NAME like '%технология%') 
											 or (PROFESSION.PROFESSION_NAME like '%технологии%'));


SELECT  PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME, PROFESSION.PROFESSION_NAME 
		FROM PROFESSION, PULPIT inner join FACULTY
 on PULPIT.FACULTY = FACULTY.FACULTY 
	where PROFESSION.PROFESSION_NAME In (Select PROFESSION_NAME  FROM  PROFESSION  
        Where (PROFESSION_NAME Like '%технология%') or (PROFESSION_NAME like '%технологии%'))  

select Auditorium, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE from AUDITORIUM a where Auditorium_capacity = (select top (1)
 Auditorium_capacity from Auditorium aa  where aa.AUDITORIUM_type=a.AUDITORIUM_type
order by Auditorium_capacity desc);

select faculty_name from faculty where exists (select * from pulpit where FACULTY.FACULTY_NAME=Pulpit.faculty)
--select * from student;
--select * from (select * from STUDENT where NAME like 'Екатерина') p1, (select * from STUDENT where STAMP like '%D%') p2 ;
--select * from STUDENT where (NAME like '%Екатерина%');
--select * from STUDENT where (IDGROUP like '%1%');

select top 1
(select avg(note) from progress where subject like 'БД')[БД],
(select avg(note) from progress where subject like 'ОАИП')[ОАИП],
(select avg(note) from progress where subject like 'СУБД')[СУБД]
 from progress;

 SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM 
		where AUDITORIUM.AUDITORIUM LIKE '%2%';

 SELECT * FROM AUDITORIUM
	where AUDITORIUM.AUDITORIUM_CAPACITY>=ALL(SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM 
		where AUDITORIUM.AUDITORIUM LIKE '%2%')

SELECT * FROM AUDITORIUM
	where AUDITORIUM.AUDITORIUM_CAPACITY>ANY(SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM 
		where AUDITORIUM.AUDITORIUM LIKE '%2%')

select IDstudent, Subject,Note from Progress where Note >= All( Select Note from Progress) ;

select Auditorium_typename from Auditorium_type at where  50 >= Any( Select Auditorium_capacity from Auditorium aa where 
aa.AUDITORIUM_TYPE=at.AUDITORIUM_TYPE)

select * from student a inner join student aa on (a.BDAY=aa.BDAY and a.idstudent != aa.idstudent);
select * from student p1, student p2 where (p1.bday=p2.bday and p1.idstudent != p2.idstudent);
