--Indexarten

/*

CLUST IX gruppierte IX
= Tabelle in sortierter Form  nur 1mal pro Tabelle
PK meist  als Gr IX angelegt -- oft Verschwendung

NON CL IX
man kann pro Tabelle ca 1000
Kopie der Daten
meist nur sinnvoll, wenn rel weniger Ergebniszeilen rauskommen
das Nachschlage ist sehr ineffizient (Lookup)
----------------------------------
eindeutiger IX
abdeckender IX	 ideale IX reine SEEK

part IX


IX mit eingeschlossenen Spalten
am Ende des Baumes mehrere Infos ca 1023 Spalten möglich

zusammengesetzte IX
wenn die Spalten im Where vorkommen
meist sind max 4 Spalten notwendig
max sind nur 16 Spalten oder 900bytes


ind Sicht


gefilterter IX


realer hypothetischer IX 

Columnstore IX
*/
 --Orderdate soll GR IX haben
use northwind
set statistics io, time on--off
select id from kundeumsatz where id = 100
--Plan:   T SCAN
--Seiten:  46000

--NIX_ID
select id from kundeumsatz where id = 100
--Seiten: 	3  0 sec

--City nicht im IX, daher Lookup
select id, city from kundeumsatz where id =100
--4 Seiten 0 Sec

 --ab ca 12000 T SCAN
select id, city from kundeumsatz where id <900000

 --NIX_ID_CI  kein Lookup mehr
 --statt 10000 nur noch 64 Seiten

  --Wieder lookup
 select id, city, country from kundeumsatz where id <13000


  select id, city, country, lastname, firstname
  from kundeumsatz where id <13000

  select country, city, sum(unitprice*quantity)
  from kundeumsatz
	 where freight < 2 or Employeeid = 1
	group by country, city

--kein Vorschlag von SQL bei OR
--

select * from 
orders where 
		freight < 1 or employeeid = 2 and Shipcountry = 'Berlin'

select * from 
orders where 
		(freight < 1 or employeeid = 2) and Shipcountry = 'Berlin'



--ind Sicht

select country, count(*) from kundeumsatz
group by country


create or alter view view1
as
select country, count(*) as Anzahl from kundeumsatz
group by country

select * from view1

select country, count(*) from kundeumsatz
group by country
--kein UNterschied


create or alter view view1	with schemabinding
as
select country, count_big(*) as Anzahl from dbo.kundeumsatz
group by country


--Abfrage auf Kundeumsatz: where agg 

-- Wert des Lagerbestands pro Land , die wo Productid 50

select country, sum(unitsinstock*Unitprice) as Summe from kundeumsatz
where productid = 50
group by	country

--NIX_PID_incl_CYusup

select * into kundeumsatz2 from kundeumsatz


 --Columnstore Index
 --bester IX: NIX_EID_inkl_CYUPQU
select country, sum(unitsinstock*Unitprice) as Summe from kundeumsatz
where employeeid = 3
group by	country

--gruppierzter Columnstore ..verlangt nichts
select country, sum(unitsinstock*Unitprice) as Summe from kundeumsatz2
where employeeid = 3
group by	country


--Trick: extrem hohe Kompression durch spaltenweises Ablegen der DAten
--CPU schonende Verarbeitung
--Segmente des CStore auch 1:1 im RAM
;)

-- Problem..:
--Heap .. neueste Daten und geänderte Daten kommen in Heap
-- Heap wird erst ab ca 1 MIO Datensätze in CStore übergeführt
--Del.. es wird nichts gelöscht bis Rebuild oder 1 MIO zu Stande kommen

--Daher das Problem: genau die akt Daten sind die , die im HEAP 
--(Delta Store) liegen