--WAITFOR TIME '18:47:00';
USE OldStyle;


--Test2
use oldstyle;
drop table if exists test1;
GO
create table test1(id int, spx char(50), nummer int, Datum datetime);
GO
create index nix on test1(id asc);
GO

Begin tran

declare @i as int= 1
while @i< 1000000
	begin
		insert into test1 
		select @i,'XY', @i, GETDATE()
		set @i+=1
	end

update test1 set nummer = 100000, Datum= GETDATE()

delete from test1
--erst später
rollback