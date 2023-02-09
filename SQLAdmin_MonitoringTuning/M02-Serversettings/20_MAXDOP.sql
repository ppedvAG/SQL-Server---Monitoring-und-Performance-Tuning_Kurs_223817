/*

MAXDOP 

Abfragen können eine oder mehr CPUs verwenden

Wird eine Abfrage schneller fertig sein, wenn mehr CPUs sie verarbeiten?
Normalerweise schon .. macht Sinn!

SQL verwendet allerdings keine variable Anzah an Kernen. (Erst SQL 2022 ist dazu lernfähig)
SQL verwendet 1 oder alle Kerne bzw das was in MAXDOP angegeben ist.

Seit SQL 2016: Standardwert statt 0 nun Anzagh der Kerne , aber max 8



*/


set statistics io, time on


select shipcountry, shipcity, SUM(freight) from KU  --62000 Seiten
group by shipcountry, shipcity
option  (maxdop 6)
--mit 8 Kernen: 950ms


--MAXDOP = 0 = alle
--MAXDOP Server = 8 
--MAXDOP DB = 4
--MAXDOP ABfrage = 1 

-- CPU-Zeit = 374 ms, verstrichene Zeit = 52 ms.
--nur ein Grund dafür.. mehr CPUs haben was getan.. 
--scheint Sinn gemacht zu haben

select * from sys.dm_os_wait_stats		   
where wait_type like 'CX%'


select country, city, SUM(freight) from ku  --62000 Seiten
group by country, city  option (maxdop 8)

--Fakt: Am Ende zählt der MAXDOP, der näher an der Abfrage dran ist
-- Server(4)-->DB(6)--Abfrage(8)-- es zählt 8


--Was sollte man einstellen: 
-- der Kostenschwellwert sollte bei 25 sein.. und dann experimentieren
--bei Datawarehouse kann die Zahl abweichen

--SQL 2012: 5 und 0 (alle CPUs)

--im Plan Doppelpfeil

--Dass SQL Server paralelisiert müssen 2 Bedingungen erfüllt sein
-- Bed 1: wenn der Kostenschwellwert überschritten wurde: default bei 5
--       dann werden rigoros alle CPUs verwendet

-- Seit SQL 2019 (Setup) wird folgendes vorgeschlagen: alle Prozessoren ,
---aber nicht mehr als 8 

--Wären nicht weniger besser gewesen?

--Tatsächlich ist es eher pro Abfrage zu entscheiden, was besser ist.
--Fakt: meist kommt man mit weniger CPUs gleich schnell weg und spart 
--zeitgleich CPU Leistung
--Taskmanager sollte eine Reduzierung der Prozesssorzeit zeigen

--Siet SQL 2016 läßt dich der MAXDOP auch pro DB einstellen

USE [master]
GO

GO
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;
GO
