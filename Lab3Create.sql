use master;
--use PunkoUniver;
create database PunkoUniver;
create table STUDENT (Номер_зачетки int primary key,Фамилия_студента  nvarchar(20) not null,Номер_группы int,Пол nchar(1) default 'м' check (Пол in ('м', 'ж'));
insert into STUDENT (Номер_зачетки, Фамилия_студента, Номер_группы, Пол)
values (732846782, 'Пунько', 6, 'ж'), (47835634, 'Реут', 6, 'ж'), (347563847, 'Глушакова', 5, 'ж'),
(437856348, 'Карленок', 4, 'м'), (849753498, 'Астахова', 4, 'ж'), (439753489, 'Петух', 6,'м'), (374683242, 'Бородина', 5, 'м');
delete from STUDENT where Номер_зачетки=732846782;