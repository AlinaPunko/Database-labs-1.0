--1
use PUNKO_UNIVER
go
select PULPIT.FACULTY[факультет/@код], TEACHER.PULPIT[факультет/кафедра/@код], 
    TEACHER.TEACHER_NAME[факультет/кафедра/преподаватель/@код]
	    from TEACHER inner join PULPIT
		    on TEACHER.PULPIT = PULPIT.PULPIT
			   where TEACHER.PULPIT = 'ИСИТ' for xml path, root('Список_преподавателей_кафедры_ИСИТ');


--2
go
select AUDITORIUM.AUDITORIUM [Аудитория],
           AUDITORIUM.AUDITORIUM_TYPE [Тип_аудитории],
		   AUDITORIUM.AUDITORIUM_CAPACITY [Вместимость] 
		   from AUDITORIUM join AUDITORIUM_TYPE
		     on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК' for xml AUTO, root('Список_аудиторий'), elements;

	--3
go
declare @h int = 0,
@sbj varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <дисциплины>
					     <дисциплина код="КГиГ" название="Компьютерная геометрия и графика" кафедра="ИСиТ" />
						 <дисциплина код="ОЗИ" название="Основы защиты информации" кафедра="ИСиТ" />
						 <дисциплина код="МП" название="Математическое программирование" кафедра="ИСиТ" />
					  </дисциплины>';
exec sp_xml_preparedocument @h output, @sbj;
insert SUBJECT select[код], [название], [кафедра] from openxml(@h, '/дисциплины/дисциплина',0)
    with([код] char(10), [название] varchar(100), [кафедра] char(20));


--4
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, 'Пунько А.А.', '23.05.2000',
                                                          '<студент>
														     <паспорт серия="МС" номер="1234567" дата="01.05.2013" />
															 <телефон>+375291802623</телефон>
															 <адрес>
															    <страна>Беларусь</страна>
																<город>Минск</город>
																<улица>Полоцкой</улица>
																<дом>1</дом>
																<квартира>68</квартира>
															 </адрес>
														  </студент>');
select * from STUDENT where NAME = 'Пунько А.А.';
update STUDENT set INFO = '<студент>
					           <паспорт серия="МС" номер="1234567" дата="01.05.2013" />
						       <телефон>+375291802623</телефон>
							   <адрес>
								  <страна>Беларусь</страна>
								  <город>Минск</город>
								  <улица>Полоцкой</улица>
	         					  <дом>1</дом>
								  <квартира>69</квартира>
								</адрес>
							 </студент>'
where NAME = 'Пунько А.А.';
select NAME[Имя],INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
		from  STUDENT
			where NAME = 'Пунько А.А.';       

--5
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" ></xs:attribute>
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"></xs:attribute>
    <xs:attribute name="дата"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"></xs:pattern>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"></xs:element>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" ></xs:element>
   <xs:element name="город" type="xs:string" ></xs:element>
   <xs:element name="улица" type="xs:string" ></xs:element>
   <xs:element name="дом" type="xs:string" ></xs:element>
   <xs:element name="квартира" type="xs:string" ></xs:element>
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

drop table STUDENT;
go
create table STUDENT 
(    IDSTUDENT integer  identity(1000,1)  primary key,
      IDGROUP integer  foreign key  references GROUPS(IDGROUP),        
      NAME nvarchar(100), 
      BDAY  date,
      STAMP timestamp,
      INFO   xml(STUDENT),    -- типизированный столбец XML-типа
      FOTO  varbinary
  );


select Name, INFO from STUDENT where NAME='Пунько А.А.'