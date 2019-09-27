USE Master
CREATE database Punko_MyBase1 
on primary
(name =N'PUNKO_MyBase_mdf', filename=N'D:\BD\PUNKO_MyBase_mdf.mdf',
size = 5120Kb, maxsize=10240Kb,filegrowth=1024Kb),
(name =N'PUNKO_MyBase_ndf', filename=N'D:\BD\PUNKO_MyBase_ndf.ndf',
size = 5120Kb, maxsize=10240Kb,filegrowth=10%),
filegroup G1
(name =N'PUNKO_MyBase11_ndf', filename=N'D:\BD\PUNKO_MyBase11_ndf.ndf',
size = 10240Kb, maxsize=15Mb,filegrowth=1024Kb),
(name =N'PUNKO_MyBase12_ndf', filename=N'D:\BD\PUNKO_MyBase12_ndf.ndf',
size = 2Mb, maxsize=5Mb,filegrowth=1024Kb);
USE Punko_MyBase1;
GO
create table ������_�������(�������� nvarchar(20) primary key, ����������_��������� int, ������� int, ����������_���� nvarchar(20)) on G1;
insert into ������_������� (��������, ����������_���������, �������, ����������_����)
    values ('���', 46545634,375296396, '������ �.�.'),
                ('������', 65546453,375447265, '������ �. �.'),
                ('������� �����', 5756767, 374297105,'������� �.�.'),
                ('Zte', 35687976, 37522520,'�������� �.�.')
create table ��������(�������� nvarchar(20) primary key, ������� real, ���������_������ int)
insert into �������� (�������� , ������� , ���������_������ )
values ('������ ����',	7,	110),
('���',	6.5,	100),
('�������',	9,	150),
('������� ������',	6.5,	100),
('����� �������',	7,	130),
('������',	5,	80),
('�����',	6,	90);
create table ������� (����� int primary key, �������� nvarchar(20) foreign key references ��������(��������), �������� nvarchar(20) foreign key references ������_�������(��������), ���� date, ������������_�_������� int, ���_������� nvarchar(20));
insert into ������� (�����, �������� , �������� , ���� , ������������_�_������� , ���_������� )
values (1,	'�������',	'���'	,2018-05-14, 2	,'�����'),
(2	,'������� ������',	'������'	,2018-05-14,	3	,'������� ������'),
(3,	'�����',	'���',	2018-05-26,	1	,'������'),
(4,	'������'	,'ZTE'	,2018-05-31	,2	,'������� ������'),
(5,	'�������'	,'������',	2018-04-20	,3	,'�����'),
(6,	'���'	,'������� �����'	,2018-06-27	,1,	'�����');
