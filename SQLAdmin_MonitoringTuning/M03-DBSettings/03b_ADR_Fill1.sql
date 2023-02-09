WAITFOR TIME '18:47:00';
USE NewStyle;
GO

ALTER DATABASE NewStyle SET ACCELERATED_DATABASE_RECOVERY = ON;

use NewStyle;


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

---erst später
rollback

select * from sys.dm_tran_persistent_version_store

select * from sys.dm_os_performance_counters where counter_name like '%trans%'
select * from sys.dm_tran_persistent_version_store_stats where database_id = DB_ID()
select * from sys.dm_tran_top_version_generators
select * from sys.dm_tran_version_store where database_id = DB_ID()
select * from sys.dm_tran_version_store_space_usage where database_id = DB_ID()
select * from sys.dm_db_index_physical_stats(db_id(), object_id('test1'), NULL, NULL, 'detailed')

rollback