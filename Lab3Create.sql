use master;
--use PunkoUniver;
create database PunkoUniver;
create table STUDENT (�����_������� int primary key,�������_��������  nvarchar(20) not null,�����_������ int,��� nchar(1) default '�' check (��� in ('�', '�'));
insert into STUDENT (�����_�������, �������_��������, �����_������, ���)
values (732846782, '������', 6, '�'), (47835634, '����', 6, '�'), (347563847, '���������', 5, '�'),
(437856348, '��������', 4, '�'), (849753498, '��������', 4, '�'), (439753489, '�����', 6,'�'), (374683242, '��������', 5, '�');
delete from STUDENT where �����_�������=732846782;