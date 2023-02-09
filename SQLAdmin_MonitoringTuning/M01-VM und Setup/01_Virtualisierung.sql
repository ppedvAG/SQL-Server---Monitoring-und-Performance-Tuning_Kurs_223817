/*
Ziel Nr 1		 

HDD!!!!!!

IO reduzieren!!!
IO schneller machen

IO-->RAM
IO-->CPU

Virtualisierung--> Konsolodierung--> genug HDD Power?

Goldene Regel:

Trenne Log von Daten physikalisch!


CPU

! Bilde in der VM die reale Umgebung ab..

NUMA: jeder Sockel hat seine pers. Speicherslots...
      jede Anfrage an den andereren Sockel wg RAM kostet mehr CPU Aufwand..
	  was, wenn die VM nur einen Sockel zeigt mit 4 Kernen, die aber zu zwei versch Sockets gehören??


RAMVERTEILUNG bei VMs
Beachte immer das OS!

16 GB RAM
1 Socket 2 Kerne 4 log Prozessoren

Für das vorreservieren: 4 GB

16-4GB= 12GB


HV-DC:   dynamischer Speicher 1024 als Startwert bis max 2048 MB  2 CPU

12GB-2GB= 10GB

HV-SQL1: fixer Speicher im Fall von SQL Server 6 GB  4 CPUs

10-6=4GB

HV-SQL2: fixer Speicher 4 GB    4 CPUs


NUMA Zuweisung beachten


*/