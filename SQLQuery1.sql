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
create table Заказы_рекламы(Название nvarchar(20) primary key, Банковские_реквизиты int, Телефон int, Контактное_лицо nvarchar(20)) on G1;
insert into Заказы_рекламы (Название, Банковские_реквизиты, Телефон, Контактное_лицо)
    values ('Луч', 46545634,375296396, 'Иванов В.В.'),
                ('Адвест', 65546453,375447265, 'Петров К. Л.'),
                ('Голубой экран', 5756767, 374297105,'Сидоров П.П.'),
                ('Zte', 35687976, 37522520,'Марченко О.В.')
create table Передачи(Название nvarchar(20) primary key, Рейтинг real, Стоимость_минуты int)
insert into Передачи (Название , Рейтинг , Стоимость_минуты )
values ('Доброе утро',	7,	110),
('КВН',	6.5,	100),
('Новости',	9,	150),
('Новости спорта',	6.5,	100),
('Пусть говорят',	7,	130),
('Сериал',	5,	80),
('Фильм',	6,	90);
create table Реклама (Номер int primary key, Передача nvarchar(20) foreign key references Передачи(Название), Заказчик nvarchar(20) foreign key references Заказы_рекламы(Название), Дата date, Длительность_в_минутах int, Тип_рекламы nvarchar(20));
insert into Реклама (Номер, Передача , Заказчик , Дата , Длительность_в_минутах , Тип_рекламы )
values (1,	'Новости',	'Луч'	,2018-05-14, 2	,'Ролик'),
(2	,'Новости спорта',	'Адвест'	,2018-05-14,	3	,'Бегущая строка'),
(3,	'Фильм',	'Луч',	2018-05-26,	1	,'Баннер'),
(4,	'Сериал'	,'ZTE'	,2018-05-31	,2	,'Бегущая строка'),
(5,	'Новости'	,'Адвест',	2018-04-20	,3	,'Ролик'),
(6,	'КВН'	,'Голубой экран'	,2018-06-27	,1,	'Ролик');
