
DROP database IF EXISTS oldstyle;
DROP database IF EXISTS NewStyle;



CREATE DATABASE OldStyle;
GO
CREATE DATABASE NewStyle;
ALTER  DATABASE NewStyle SET ACCELERATED_DATABASE_RECOVERY = ON;
GO


--https://docs.microsoft.com/de-de/sql/relational-databases/accelerated-database-recovery-concepts?view=sql-server-ver15