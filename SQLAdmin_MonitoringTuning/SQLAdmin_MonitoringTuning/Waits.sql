WAITS

aktuelles Warten
SELECT *
FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_sql_text (sql_handle)


 SOS_SCHEDULER_YIELD #Quantum
 Wartezeiten, die ich sehe, sind Abfragen, 
 die Scans von Seiten durchführen, die sich im Speicher befinden 
 und sich nicht ändern, daher gibt es keine Konkurrenz für den Seitenzugriff 
 und der Scan-Thread kann ausgeführt werden, bis er sein Thread-Quantum erschöpft hat. 
 Dies kann daran liegen, dass ein Abfrageplan fälschlicherweise einen Tabellenscan 
 durchführt, oder es könnte ein normaler Teil Ihrer Arbeitslast sein. 
 Genau wie CXPACKET- Wartezeiten sollten Sie nicht zu dem Schluss kommen, 
 dass SOS_SCHEDULER_YIELD- Wartezeiten schlecht sind.
 FIFO-- Quantum erschöpft-- Wartenschlange (vs Ressoucensteurung)


 SOS_SCHEDULER_DISPATCHER #nichtschlecht
 Bei diesem Wartetyp wartet ein Thread in SQLOS auf etwas zu tun. 
 Dieses Warten beginnt, wenn der Thread in den Ruhezustand übergeht, 
 und endet, wenn dem Thread etwas zu tun gegeben wird.


 THREADPOOLS
 Tritt auf, wenn eine Aufgabe darauf wartet, 
 dass ein Worker ausgeführt wird. Dies kann darauf hinweisen, 
 dass die maximale Worker-Einstellung zu niedrig ist oder 
 dass Batchausführungen ungewöhnlich lange dauern, 
 wodurch die Anzahl der verfügbaren Worker verringert wird, 
 um andere Batches zu befriedigen 

