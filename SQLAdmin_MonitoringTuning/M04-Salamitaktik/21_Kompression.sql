/*
Kompressionsarten

Zeilenkompression und Seitenkompression

--Leerstellen bei Char am Ende entfernen ZB.. und mehrere DS in Seiten wieder zusammenfassen

--Seitenkomression macht zuerst die Zeilenkompression + KomprAlgorithmus

--zu erwarten ist: 40 bis 60% 



*/

--Neustart des SQL Server
--Messung: RAM nach Neustart des SQL Server: 219MB

set statistics io, time on

select * from KursDB..t1

--Seiten: 20000   CPU: 296   verstr Zeit: 1806

--RAM danach: ca 400MB  die gesamte Tabelle t1 ist in den RAM geraten 

--Kompression

--Neustart des SQL Server   RAM SQL Server: etwas kleiner oder eher gleich = gleich!!

--wie groß ist die Tabellen nach der Kompression 160MB--> deutlich kleiner= 500kb!!!

set statistics io, time on

select * from KursDB..t1

--Seiten kommen 1:1 in RAM
--Seiten: weniger oder gleich = 33 Seiten !!
--CPU : gleich  oder mehr  Dauer: schneller od länger
--CPU wird im Regelfall mehr werden.. 
--in der Praxis durchaus auch mehr CPU

--je höher die Kompression, desto größer die Ersparnis bei CPU
--bleibt der Aufwand für Entpacken gering--> weniger CPU als vorher
--==> geringe Kompression stellt sich Frage, ob überhaupt Kompression
--Archivtabelle :-)

--APP geht .. die Kompression ist transparent.. also muss die APP auch dekomprimierte Daten bekommen

--die Idee der Kompression... Mehr RAM für andere!!!!

Erwartungshorizont der Kompression in der Praxis: 40 bis 60%.. Text besser als Zahlen komprimierbar

   --Kompression hift: dass andere Tabellen besser Platz im RAM finden


