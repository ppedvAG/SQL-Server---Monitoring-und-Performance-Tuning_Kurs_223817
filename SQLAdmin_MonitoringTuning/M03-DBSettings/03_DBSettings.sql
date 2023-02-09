use [master];
GO

ALTER DATABASE [Northwind] 
	SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = ON)

--update statistics [dbo].[Record] idx_record_name with resample on partitions (1);
--A robust on-demand incremental statistics update process on partitioned tables will boost performance stability, reduce resource consumption (I/O and CPU) and significantly shrink the maintenance window for very large tables.


ALTER DATABASE [Northwind] 
	SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
--Gibt es Abhängigkeiten zwischen Datumsfeldern..?
--Etwa immer 14 nach Termin1 , dann Termin2
--SQL Server kann die Korrelation erkennen und entsprechen 
--mit geeigneten Statistiken die Daten effizienter holen
--da Plan auch exakter wird




GO
ALTER DATABASE [Northwind] 
	SET DELAYED_DURABILITY = ALLOWED WITH NO_WAIT
GO
--Client bekommt Commit, obwohl TX noch nicht in LOG
--festgeschrieben
--verzögert: evtl Datenverlust, aber für den Client schneller
--verzögert: Latenzzeit des Datenträger verringert sich
--da Batchweise zurückgeschrieben wird
--weniger Datenträgerkonflikte bei gleichzeitigen TX
-->Arbeitsauslastungen weisen eine hohe Konfliktrate auf.
-->Bei Schreibvorgängen in das Transaktionsprotokoll treten Engpässe auf.
-->Datenverluste sind in gewissem Umfang vertretbar.
 --Wegschreiben ins Log: EXECUTE sys.sp_flush_log  

 --Ght allerdings nicht überall:
 --

ALTER DATABASE 
	SCOPED CONFIGURATION SET MAXDOP = 4;
GO
ALTER DATABASE 
	SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = On;
--this will work same as enabling the Trace Flag 4199 in your SQL Server.

-----------------------------------------
ALTER DATABASE [Northwind] 
	SET ALLOW_SNAPSHOT_ISOLATION ON
GO

ALTER DATABASE [Northwind] 
	SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT

--Ein Ändern eines Datensatzes hindert nicht mehr den Zugriff der anderen
--aber: es werden Versionen in die tempdb kopiert
--evtl massive Last auf tempdb


ALTER DATABASE SCOPED CONFIGURATION 
CLEAR PROCEDURE_CACHE ;
-- vs dbcc freeproccache leert den gesamten Planspeicher des SQL Server