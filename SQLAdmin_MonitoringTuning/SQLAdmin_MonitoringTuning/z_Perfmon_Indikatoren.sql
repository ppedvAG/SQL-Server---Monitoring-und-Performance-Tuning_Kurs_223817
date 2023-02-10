
Prozessor: Prozessorzeit
Diese sollte natürlich nicht auf Dauer allzu hoch sein. Messunen über 50% bis 60%, sollten abgeklärt werden (Auslagerungen, Kompilierungen etc)
PhysicalDisk: AverageDiskQueueLength
Dieser Wert sollten nicht über 2 sein. Der Wert gibt nämlich an, ob Der physik. Datenträger Daten schnell genug wegschreiben kann.
Speicher: Seiten/sec
Seiten, die entweder vom Speicher auf den Datenträger geschrieben werden oder davon gelesen und in den Sepicher geschrieben werden. Der Wert sollte auf Dauer kleiner als 20 sein.
BufferManager: BufferCacheHitRatio
Die %-Quote gibt an, wieviel der angefragten Daten (Seiten) aus dem Speichercahce geholt werden können. Der Wert sollte größer 90% sein. Dadurch, dass der SQL Server jede Menge ´Read Ahead Vorgänge erzeugt, ist der Wert nicht allzuaussagekräftig. Bereits nach Start des SQL Dienstes weist er einen Wert von kanpp unter 100% aus… obwohl noch keine Daten abgefragt wurden??!!
Plan Cache: Trefferquote
Jede Frage benötigt einen Ausführungsplan. Im günstigsten Fall liegt dieser bereits vor. Falls nicht, muss ein neuer Plan erstellt und kompiliert werden. Das kostet Prozessorzeit.
Falls also die Prozessorleistung sehr hoch ist, sollten sie diesen Wert und Transactions / sec untersuchen. Die Trefferquote sollte so hoch wie möglich sein.
GenerelStatitics: User Connections
Anzahl der Benutzerverbindungen
Puffer Manager: Page Life Expectancy  mind 300ssek lt MS
Seiten werden in den Speicher geladen, um die Requests der Clients schnell bedienen zu können. Die gecachten Seiten können aufgrund von zu wenig Platz zugunsten anderer Seiten aus dem Cache entfernt werden. Der Wert sollte nicht unter 300 liegen. Sonst haben Sie zu wenig Hauptspeicher
SQL Statistics: Kompilierungen /sec
Ausführungspläne bedürfen einer kompilierung und evtl auch einer Recompilierung. Diese führt zu einer höheren CPU Last. Sollte dieser Wert sich erhöhen, können Sie evtl durch paramtriesierung ihrer Abfragen eine Verbesserung erreichen.
SQL Statistics: Recompilierungen /sec
Dieser Wert steigt, sobald kompilierte Pläne durch verschiedene SET Einstellungen erneut kompiliert werden müssen.
SQL Benutzerdefinierbar: User Counter 1 (bis 10)
Ein Indikator der mir persönlich sehr gut gefällt. Übergibt man der sp_Usercounter1 eine ganze Zahl  so wird diese sofort im Systemmonitor dargestellt. SO ließe sich z.B. der Tagesumsatz im Verhältnis zur CPU oder Speicher darstellen. In Worten: Ab einem bestimmten  Umsatz proTag braucht man eine besser CPU. 
SQL Locks: durschnittliche Wartezeit (ms)
