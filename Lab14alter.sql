USE [PUNKO_UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 25.05.2019 11:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PSUBJECT] @p varchar(20) = NULL--, @c int output 
as
begin
--print 'параметры: @p = '+ @p + ' @c = '+ cast (@c as varchar(2));
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT where PULPIT=@p;
--set @c = @@ROWCOUNT;
return @k;
end;