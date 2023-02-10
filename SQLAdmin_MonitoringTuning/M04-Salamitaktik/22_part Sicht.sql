/*
Welche Tabelle wird schneller ein Ergebnis iefern:

TAB A 10000 DS
TAB B 1000000 DS

beide Tabellen sind absolut gleich, sie haben nur versch Anzahl an DS

Die Abfrage bingt immer nur 3 Zeilen zurück

-- kleinere ist schneller.. Indizes

*/

--Idee große Tabelle Umsatz muss schneller werden
--aus Umsatz wird u2021 u2020 u2019 usw...
--Problem: Die Abfrage auf Umsatz geht nicht mehr!!!



create table u2021(id int , jahr int, spx int)
create table u2020(id int , jahr int, spx int)
create table u2019(id int , jahr int, spx int)

--Problem: wo ist mein "UMSATZ"

create view UMSATZ
as
select * from u2021
UNION ALL --keine doppelte Zeilensuche
select * from u2020
UNION ALL
select * from u2019
GO

select * from UMSATZ --Sicht=gemerkte Abfrage

select * from umsatz where jahr = 2020
select * from umsatz where id = 2020


--bisher 0 Optimierung
 select * from UMSATZ where jahr = 2021
  select * from UMSATZ where ID= 2021

--TÜV Siegel
--Garantie

--Problem: bei Insert
--aber dann darf kein identity, PK muss eindeutig über die Sicht (jahr und id)


create table test2 (id int) on HOT


-->Dateigruppe


create table t3 (id int)---> mdf


















--im Plan sieht man, dass er nach den Einschränkungen 
--nur noch die Tabelle verwendet, in der die Daten sein könnten..

select * from UMSATZ where jahr= 2019
select * from UMSATZ where id= 2018

--Aber was ist mit INS UP DEL
--eine Sicht kann INS UP DEL haben

--Aber in unserem Fall: kein Identity
--                      PK muss eindeutig über die Sicht
						--(ID und jahr)

--hmm APP geht nicht mehr

--für Archivierung ok, aber bei INS UP DEL. ziemlich blöd








--bis100  bis200   bis5000 rest


-F(117)-->2

--     100                200
------]-----------------]--------------
   1              2                       3
create partition function fZahl(int)
as
range left for values(100,200)

select $partition.fzahl(117) ---2


--Part Schema
create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
--                            1            2       3


create table ptab (id int identity, nummer int, spx char(4100))
ON schZahl(nummer)


declare @i  as int=1
Begin tran
while @i<=20000
	begin
		insert into ptab (nummer, spx) values (@i,'XY')
		set @i = @i+1
	end
commit

set statistics io , time on

select * from ptab where id = 100

select * from ptab where nummer = 100

select * from ptab where nummer = 3117

--neue Grenze 5000

--100-----200-------------5000---------------------------

--Dateigruppen: weitere Dgruppe
--F()-- neue Grenze
--Scheme:  neue DGruppe bekannt machen
--Tabelle: nie never nö nada rein


alter partition scheme schZahl next used bis5000

select $partition.fzahl(nummer) , min(nummer), max(nummer), count(*)
from ptab
group by $partition.fzahl(nummer)

--------100----------200---------------------5000---------------------------
alter partition function fzahl() split range(5000)


---------100x--------200--------5000---------
--Dateigruppen: nix
--F()-- neue Grenze
--Scheme:  nö
--Tabelle: nie never nö nada rein


alter partition function fzahl()  merge range(100)


USE [Northwind]
GO

/****** Object:  PartitionScheme [schZahl]    Script Date: 09.02.2023 16:20:15 ******/
CREATE PARTITION SCHEME [schZahl] AS 
PARTITION [fZahl] TO ([bis200], [bis5000], [rest])

CREATE PARTITION FUNCTION [fZahl](int) AS 
RANGE LEFT FOR VALUES (200, 5000)
GO

select * from ptab where id = 7000


--Archivieren
--drop table archiv
create table archiv(id int not null, nummer int, spx char(4100))
ON bis200

alter table ptab switch partition 1 to archiv

select * from ptab where nummer = 7000



--100MB/SEK        1000MB 10Sek
--genausolange wie bei 122372376 TB oder 1MB









