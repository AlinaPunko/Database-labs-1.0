use master;
use PunkoUniver;
create table RESULTS (ID int primary key identity(1,1),Student_name  nvarchar(20) not null, Math int, OOP int, KSIS int, AVERAGE  as (Math+OOP+KSIS)/3);
insert into RESULTS(Student_name, Math, OOP, Ksis)
values ('������',7 , 8, 9 ), ('����', 8, 8 ,7), ('���������', 8,7,7),
		('��������', 4, 8, 7), ('��������', 4, 5, 7), ('�����', 4, 4, 7),
		('��������',7,7,8);