/*

Idee : Prinzip der part Sicht auf rein physikalischer Ebene nachbilden
--Vorteil: Anwendungen funktionieren nahtlos weiter...


f(117)--> 2


(int) ------100]-----------200]----------------5000]-----
		1          2               3                   4

--> 4 Dgruppen

bis100
bis200
bis5000
rest




*/

---Part Funktion
--Achtung: Grenzwerte sind harte Werte , kein A%


create partition function fName(datentyp)
as
RANGE LEFT|RIGHT FOR VALUES (Grenzwert1, Grenzwert2)


------------100]-------200]--------
--   1            2        3
--Grenzen sind inklusive

create partition function fZahl(int)	   --alles möglich was sortierbar ist
as
RANGE LEFT FOR VALUES(100,200)

select $partition.fzahl(117) --2


--Schema

create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
--                     1.    2.     3.


create table ptab (id int identity not null, nummer int, spx char(4100))
		ON schZahl(nummer) 




set statistics io, time off --soll es schnell sein? Dann schalte auch noch den tats Plan aus 


declare @i as int = 1
begin tran
while @i<=20000
 begin 
 insert into ptab select @i, 'XY'
 set @i+=1 
 end
commit 


set statistics io, time on
--Plan-- Table Scan (HEAP)... alles durchsuchen
select * from ptab where nummer = 1170

--Table Scan
select * from ptab where id = 117


--Manipulieren
--Neue Grenze bei 5000

---------100-------200-----------------5000------------
-- 1            2          3                   4

--Tab, Dgruppen, F(), schema

--Tab never 
--neue Dgruppe ist notwendig (bis5000)
--zuerst schema

alter partition scheme schZahl next used bis5000

--keine Änderung bisher
select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab 
group by $partition.fzahl(nummer)


alter partition function fzahl() split range(5000)


---------100----200-------------5000--------------
select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab 
group by $partition.fzahl(nummer)

select * from ptab where nummer = 3170 --statt 19800 nur 4800

---Grenze entfernen

------x100x---------200-------------------5000-------

--Tab, DGruppen, F(), schema
--Tab never
--DGr.. wir haben genug
--schema..
--nur F() anpassen

alter partition function fzahl() merge range (100)


select * from ptab	  where id = 117
select * from ptab	  where nummer = 117

-- Eine Partition läßt sich auch part


--Das Gegenteil von SCAN = SEEK!!!



--Archivierung
--1:1 Abbild Archiv von parttab

create table archiv
	(id int not null, nummer int, spx char(4100))
	ON bis200

alter table ptab switch partition 1 to archiv

select * from archiv

--100MB/Sek ---> 100000000000000000000000000000MB			ca nicht messbar

select * from ptab where id = 203

--Dauer ist bei 200Ds ca 1 ms...
--und das wäre auch bei 3 Trd DS so

--Trick

--wie stell ich fest , wie die Part gerade läuft..:

--Bestlldatum (datetime)
create partition function fZahl(datetime)--ms
as
RANGE LEFT FOR VALUES('31.12.2020 00:00:00.000',--falsch
					'31.12.2020 23.59:59.997', --richtig
					'','','','')

					--A-M  N-R  S-Z

					-------N]-----------------------------
create partition function fZahl(varchar(50))--ms
as
RANGE LEFT FOR VALUES('N','S')

---------------M]maier-------------x----------------------


create partition scheme schZahl
as
partition fzahl all to ([PRIMARY])

--Gehts?.. Macht das sinn? bzw gehts dir gut??
--Ja   --           macht sinn... es ist einfach alles etwas kleiner

