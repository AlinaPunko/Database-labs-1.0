use master;
use PunkoUniver;
--create database PunkoUniver;
create table STUDENTES (�����_������� int primary key,�������_��������  nvarchar(20) not null,����_�������� date,
						��� nchar(1) default '�' check (��� in ('�', '�')), ����_����������� date);
insert into STUDENTES (�����_�������, �������_��������, ����_��������, ���, ����_�����������)
values (732846782, '������', '23.5.2000', '�', '1.7.2017'), (47835634, '����', '9.1.1999', '�', '1.7.2017'), (347563847, '���������', '1.5.1999', '�', '1.7.2017'),
(437856348, '��������', '20.9.1999', '�', '1.7.2017'), (849753498, '��������', '16.6.1998', '�', '1.7.2017'), (439753489, '�����', '1.10.1999','�', '1.7.2017'), (374683242,
 '��������', '14.4.2000', '�', '1.7.2017');
select �����_�������, �������_��������, ����_��������, ��� from STUDENTES
where Dateadd(year, 18, ����_��������)<����_����������� AND (���='�');
