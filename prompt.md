# MASTER-PROMPT: Mainsail-Marlin
## Recherche, Entwicklung, API-Kompatibilität, automatisierte Tests und vollständige Installation

Du agierst als Senior Software Engineer, Systemarchitekt, Reverse Engineer, Linux-Administrator, Test Engineer und DevOps Engineer.

Deine Aufgabe ist es, ein möglichst vollständiges und zuverlässig funktionierendes Projekt namens **Mainsail-Marlin** zu entwickeln.

Das Projekt soll die originale Mainsail-Weboberfläche möglichst vollständig mit einem 3D-Drucker verwenden können, auf dem Marlin statt Klipper läuft.

Du sollst die relevanten Originalprojekte untersuchen, eine fundierte technische Architektur entwickeln, vorhandenen Code sinnvoll weiterverwenden, fehlende Funktionen implementieren, automatisierte Tests erstellen und eine einfache Installation auf dem Raspberry Pi ermöglichen.

**Wichtig: Du bist nicht nur für eine Analyse verantwortlich. Du sollst die Analyse durchführen, anschließend die erforderlichen Änderungen umsetzen, die Ergebnisse überprüfen und verbleibende Einschränkungen transparent dokumentieren.**

Arbeite selbstständig, nachvollziehbar und in logisch abgeschlossenen Entwicklungsschritten. Stelle keine Rückfragen, wenn du anhand des vorhandenen Codes, der Dokumentation und einer vernünftigen technischen Entscheidung weiterarbeiten kannst.

Wenn eine Funktion aufgrund fehlender Hardware, nicht verfügbarer Informationen oder technischer Einschränkungen nicht vollständig getestet werden kann, implementiere und teste so viel wie sicher möglich und kennzeichne die verbleibende Unsicherheit ausdrücklich.

---

# 1. Projektvision und verbindliches Endziel

Das Endprodukt heißt:

**Mainsail-Marlin**

Es soll ein eigenständiges, öffentlich veröffentlichbares und wartbares Projekt werden.

Der Benutzer soll später möglichst einfach einen Raspberry Pi einrichten, Mainsail-Marlin installieren, seinen Marlin-Drucker anschließen und den Drucker über eine Weboberfläche bedienen können.

Die originale Mainsail-Oberfläche soll optisch und funktional möglichst unverändert erhalten bleiben.

Marlin bleibt die Firmware des Druckers. Es darf nicht erforderlich sein, den Drucker auf Klipper umzustellen.

## Verbindliche Projektziele

1. Die Anforderungen des originalen Mainsail-Frontends vollständig untersuchen.
2. Die tatsächliche Implementierung der von Mainsail verwendeten Moonraker-APIs analysieren.
3. Die vorhandene Marlinraker-Implementierung prüfen und nach Möglichkeit weiterentwickeln.
4. Die fehlenden API-Funktionen, Datenfelder, Events und Statusmechanismen identifizieren.
5. Eine zuverlässige Moonraker-kompatible Schicht für Marlin bereitstellen.
6. Mainsail bei Bedarf als eigenen Fork unter dem Namen Mainsail-Marlin weiterentwickeln.
7. Die benötigten Kernfunktionen implementieren und automatisiert testen.
8. Eine automatische Installation, Aktualisierung, Diagnose und Deinstallation entwickeln.
9. Eine mögliche Integration in KIAUH untersuchen und bei sinnvoller technischer Grundlage umsetzen.
10. Eine spätere Bereitstellung als vorinstalliertes Raspberry-Pi-Image vorbereiten, ohne diese zusätzliche Komplexität unnötig vor der stabilen Basis zu implementieren.
11. Installation und Bedienung für Benutzer mit grundlegenden Linux-Kenntnissen verständlich dokumentieren.
12. Eine belastbare Liste aller unterstützten, teilweise unterstützten und nicht verfügbaren Funktionen bereitstellen.

Ein erfolgreicher Build allein gilt ausdrücklich nicht als Projekterfolg.

---

# 2. Ausgangsprojekte und Recherche

Untersuche die folgenden Projekte:

Mainsail:
https://github.com/mainsail-crew/mainsail

Moonraker:
https://github.com/Arksine/moonraker

Marlinraker:
https://github.com/phm07/marlinraker

Marlin-Firmware:
https://github.com/MarlinFirmware/Marlin

KIAUH:
https://github.com/dw-0/kiauh

Diese Links sind Rechercheausgangspunkte und keine Garantie dafür, dass jedes Projekt aktuell gepflegt wird, die benötigte Funktionalität besitzt oder ohne Änderungen verwendbar ist.

## Aktuelle Recherche durchführen

Recherchiere vor größeren Architekturentscheidungen den aktuellen Zustand der Projekte.

Untersuche insbesondere:

- aktuelle Repository-Struktur;
- relevante Branches und Releases;
- letzte sinnvolle Änderungen;
- tatsächliche Commit-IDs;
- verwendete Programmiersprachen und Frameworks;
- offizielle API-Dokumentationen;
- bestehende Testabdeckung;
- bekannte Probleme und offene Fehler;
- Lizenzbedingungen;
- Installationsanforderungen;
- unterstützte Betriebssysteme;
- Kompatibilität der jeweiligen Versionen;
- vorhandene Installations- und Aktualisierungsmechanismen;
- Sicherheitsprobleme und veraltete Abhängigkeiten.

Verwende aktuelle offizielle Quellen und prüfe relevante Behauptungen möglichst anhand des tatsächlichen Quellcodes.

Verlasse dich nicht ausschließlich auf README-Dateien, Projektbeschreibungen, fremde Blogbeiträge oder KI-generierte Zusammenfassungen.

Wenn Informationen voneinander abweichen, dokumentiere die Abweichung und erkläre, welche Quelle für die technische Entscheidung maßgeblich ist.

Erstelle `docs/research.md`.

Diese Datei muss enthalten:

- recherchierte Projekte und URLs;
- Abrufdatum der Recherche;
- untersuchte Versionen und Commit-IDs;
- wichtige technische Erkenntnisse;
- verwertbare bestehende Implementierungen;
- erkennbare Risiken;
- Lizenzhinweise;
- getroffene Architekturentscheidungen;
- offene Fragen und noch nicht verifizierte Annahmen.

Verwende Git-Commit-IDs für technische Referenzen, damit die Analyse später nachvollziehbar bleibt.

---

# 3. Git, Repositorys und Versionsverwaltung

Prüfe zunächst das aktuelle Arbeitsverzeichnis.

Stelle fest, ob bereits eines der genannten Projekte vorhanden ist und ob uncommittete Änderungen existieren.

Überschreibe oder lösche niemals ungeprüft bestehende Dateien oder Änderungen.

Falls keine passende Arbeitskopie vorhanden ist, klone die notwendigen Originalprojekte in getrennte Verzeichnisse.

Empfohlene Projektaufteilung:

- `mainsail-marlin`: Frontend-Fork von Mainsail.
- `marlinraker-marlin`: Backend-Fork auf Basis von Marlinraker.

Nutze möglichst wenig eigene Änderungen im Frontend. Entwickle notwendige Marlin-API-Funktionalität vorzugsweise im Backend.

Wenn sich herausstellt, dass Marlinraker als Grundlage ungeeignet ist, liefere einen technischen Nachweis und einen alternativen Vorschlag. Beginne nicht ohne Grund mit einer vollständigen Neuentwicklung.

Behalte die Original-Repositories als Upstream-Quellen, damit spätere Bugfixes und Updates kontrolliert übernommen werden können.

Erstelle nachvollziehbare Commits für logisch zusammengehörige Änderungen, sofern Git und die Arbeitsumgebung dies erlauben.

Verwende keine persönlichen Zugangsdaten oder privaten Tokens in Commits, Konfigurationen oder Tests.

---

# 4. Analyse des Mainsail-Frontends

Untersuche den tatsächlichen Mainsail-Code systematisch.

Ziel ist, jede relevante Abhängigkeit von Moonraker, Klipper und optionalen Diensten zu identifizieren.

Untersuche mindestens:

## API und Verbindung

- HTTP-Aufrufe;
- WebSocket-Verbindungen;
- JSON-RPC-Nachrichten;
- API-Initialisierung;
- Server- und Firmwareerkennung;
- Verbindungsaufbau und Wiederverbindung;
- Statusabfragen und Subscriptions;
- Eventverarbeitung;
- Fehlerbehandlung und Timeout-Verhalten.

## Benutzeroberfläche

- Dashboard;
- Druckerstatus;
- Temperaturanzeigen;
- Temperaturdiagramme;
- Druckfortschritt;
- Druckinformationen;
- G-Code-Konsole;
- Dateiverwaltung;
- Drucksteuerung;
- Konfigurationsseiten;
- Makros;
- Sensoren;
- Lüfter;
- weitere Hardwareanzeigen;
- optionale Integrationen;
- Einstellungen und Persistenz.

## Technische Analyse

Finde sämtliche relevanten:

- Endpunkte;
- API-Methoden;
- Eventnamen;
- Statusfelder;
- Datenstrukturen;
- Request- und Response-Schemata;
- erwarteten Fehlercodes;
- Berechtigungen;
- Abhängigkeiten von Klipper;
- optionalen Komponenten und Erweiterungen.

Verfolge API-Aufrufe vom Frontend bis zu den zugehörigen Funktionen.

Unterscheide zwischen direkt erforderlichen Funktionen und optionalen Integrationen.

Eine ungenutzte API in einer Bibliothek darf nicht automatisch als zwingende Voraussetzung für Mainsail gelten. Überprüfe, ob sie im tatsächlichen Programmablauf verwendet wird.

Erstelle:

`docs/mainsail-analysis.md`

Erstelle zusätzlich:

`docs/mainsail-api-requirements.json`

Die JSON-Datei soll pro relevantem API-Aufruf mindestens enthalten:

- Methode oder Endpunkt;
- HTTP oder WebSocket;
- aufrufende Komponente;
- benötigte Parameter;
- erwartete Antwort;
- benötigte Statusfelder;
- Verwendung;
- Priorität;
- Klipper-Abhängigkeit;
- Referenz auf Quelldatei und Funktion.

Erzeuge ausschließlich gültiges JSON und prüfe es mit einem Parser.

---

# 5. Moonraker vollständig analysieren

Analysiere die zu Mainsail passende Moonraker-Version.

Prüfe die tatsächliche Implementierung der verwendeten Endpunkte und Ereignisse anhand des Quellcodes.

Untersuche insbesondere:

- HTTP-Routen;
- WebSocket-API;
- JSON-RPC-Protokoll;
- Authentifizierung;
- Berechtigungen;
- Statusabfragen;
- Status-Subscriptions;
- Event-Benachrichtigungen;
- Fehlerformate;
- Dateiverwaltung;
- Metadaten;
- G-Code-Kommandos;
- Drucksteuerung;
- Druckfortschritt;
- Serverinformationen;
- Systeminformationen;
- Komponentenregistrierung;
- Konfigurationsverwaltung;
- optionale Integrationen;
- Verbindung zu Klipper;
- Erweiterungsmechanismen.

Ermittle, welche Funktionen Moonraker selbst implementiert und welche aus Klipper, anderen Diensten oder zusätzlichen Komponenten stammen.

Diese Trennung ist eine Kernanforderung.

Mainsail verwendet teilweise Funktionalität, deren eigentliche Daten oder Ausführung nicht von Moonraker allein stammen. Solche Funktionen müssen gesondert betrachtet werden.

Für jede relevante API dokumentiere:

- tatsächlichen Endpoint;
- Eingabeparameter;
- erfolgreiche Response;
- Fehlerantworten;
- Rückgabedatentypen;
- Eventformat;
- Statusfelder;
- notwendige Berechtigungen;
- Quelldateien und zuständige Funktionen;
- Abhängigkeit von Klipper;
- mögliche Entsprechung unter Marlin.

Erstelle:

`docs/moonraker-analysis.md`

Vergleiche diese Analyse anschließend mit der Mainsail-Anforderungsdatei.

---

# 6. Marlin und Marlinraker untersuchen

Untersuche die reale Implementierung der Marlin-Firmware und die vorhandene Marlinraker-Codebasis.

Prüfe zuerst den aktuellen Stand von Marlinraker. Überprüfe ausdrücklich, ob vorhandene Implementierungen aktuell lauffähig sind und mit der untersuchten Mainsail-Version zusammenarbeiten.

Untersuche:

- serielle Kommunikation;
- Druckererkennung;
- Baudrate;
- G-Code-Kommandos;
- Antwortverarbeitung;
- Empfangsbuffer;
- Befehlswarteschlangen;
- Timeouts;
- Fehlerantworten;
- Verbindungsabbrüche;
- Temperaturabfragen;
- Positionsdaten;
- Lüfter;
- Sensoren;
- Druckstatus;
- Druckfortschritt;
- Dateien und Speicher;
- Druckstart;
- Pause;
- Fortsetzen;
- Abbruch;
- Makros;
- firmwareabhängige Optionen.

Ermittle, welche Informationen Marlin tatsächlich bereitstellt und welche nur durch Näherungen berechnet werden können.

Unterscheide klar zwischen:

- direkt von Marlin gelieferter Information;
- aus G-Code oder Metadaten abgeleiteter Information;
- lokal berechnetem Zustand;
- nicht zuverlässig ermittelbarer Information.

Erfinde keine Druckerzustände.

Prüfe außerdem:

- verwendete Node.js-Version;
- TypeScript-Version;
- verwendete Bibliotheken;
- Build-Prozess;
- Testsystem;
- veraltete APIs;
- Sicherheitsprobleme;
- offene Issues;
- bekannte Einschränkungen.

Erstelle:

- `docs/marlin-analysis.md`
- `docs/marlinraker-analysis.md`

---

# 7. Kompatibilitätsmatrix erstellen

Führe die Ergebnisse zusammen.

Erstelle:

`docs/compatibility-matrix.md`

Die Matrix muss zwischen Mainsail-Anforderungen, Moonraker-Verhalten und Marlin-Fähigkeiten unterscheiden.

Verwende für jeden Eintrag einen der folgenden Statuswerte:

- `IMPLEMENTED`: vorhanden und nachweislich korrekt;
- `PARTIAL`: teilweise implementiert;
- `MISSING`: fehlt;
- `KLIPPER_DEPENDENT`: setzt Klipper-spezifische Funktionalität voraus;
- `MARLIN_DEPENDENT`: benötigt bestimmte Marlin-Versionen oder Konfigurationen;
- `OPTIONAL`: optionale Funktion;
- `UNTESTED`: implementiert, aber noch nicht ausreichend geprüft;
- `NOT_APPLICABLE`: technisch nicht sinnvoll auf Marlin übertragbar.

Die Matrix soll mindestens diese Spalten enthalten:

| Funktion | Mainsail-Anforderung | Moonraker-Verhalten | Marlin-Fähigkeit | Backend-Status | Frontend-Status | Teststatus | Priorität |
|---|---|---|---|---|---|---|---|

Erfasse Endpunkte, Events und wichtige Statusfelder möglichst einzeln.

Leite aus dieser Matrix eine priorisierte To-do-Liste ab.

Implementiere zunächst die Funktionen, die für eine nutzbare Weboberfläche zwingend erforderlich sind.

Vermeide unnötige Frontendänderungen, wenn der Backend-Adapter die benötigte Kompatibilität bereitstellen kann.

---

# 8. Zielarchitektur entwickeln

Verwende als Grundarchitektur:

Browser
→ Mainsail-Marlin
→ Moonraker-kompatible API
→ Marlin-Adapter
→ serielle Verbindung
→ Marlin-Firmware.

Das Frontend und Backend müssen voneinander getrennt bleiben.

## Frontend

`mainsail-marlin` ist ein Fork von Mainsail.

Ziele:

- originales Layout erhalten;
- vorhandene Komponenten wiederverwenden;
- möglichst wenig zusätzlichen Frontendcode;
- korrekte Darstellung fehlender oder nicht unterstützter Funktionen;
- optional eigene Marlin-spezifische Einstellungen;
- klare Versionsverwaltung;
- kontrollierte Übernahme von Upstream-Änderungen.

## Backend

`marlinraker-marlin` ist ein Fork der vorhandenen Marlinraker-Implementierung, sofern sich diese als geeignete Grundlage bestätigt.

Ziele:

- Moonraker-kompatible HTTP-API;
- kompatible WebSocket-Kommunikation;
- passende Statusfelder und Events;
- zuverlässige serielle Kommunikation;
- kontrollierte G-Code-Ausführung;
- Druckverwaltung;
- Datei- und Metadatenverwaltung;
- robuste Fehlerbehandlung;
- klare Modulgrenzen;
- nachvollziehbare Konfiguration.

## Verantwortlichkeiten

Das Backend muss die Unterschiede zwischen Moonraker und Marlin so weit abstrahieren, dass das Frontend möglichst wenig über die konkrete Firmware wissen muss.

Nicht unterstützte Funktionen müssen aber klar gekennzeichnet werden.

Vermeide vorgetäuschte Ergebnisse und künstliche Kompatibilität, bei der Datenfelder formal existieren, aber falsche Informationen liefern.

Erstelle:

`docs/architecture.md`

Dokumentiere dort auch Alternativen, verworfene Ansätze und deren Gründe.

---

# 9. Backend implementieren

Arbeite die Kompatibilitätsmatrix systematisch ab.

Implementiere notwendige Änderungen im Backend, sobald Analyse und technische Grundlage ausreichend klar sind.

Bevorzuge einzelne, überprüfbare Änderungen gegenüber großen unübersichtlichen Umbauten.

## Priorität 1: Minimale nutzbare Druckeroberfläche

Implementiere und teste:

- API-Verbindung;
- WebSocket-Verbindung;
- initiale Druckererkennung;
- Server- und Firmwareinformationen;
- aktuelle Temperaturen;
- regelmäßige Statusaktualisierung;
- G-Code-Konsole;
- Dateiübersicht;
- Datei-Upload;
- Datei-Metadaten, soweit erforderlich;
- Druckstart;
- Pause;
- Fortsetzen;
- Druckabbruch;
- Druckstatus;
- Fortschritt;
- grundlegende Fehlerbehandlung;
- Wiederverbindung.

## Priorität 2: Zusätzliche Funktionen

Prüfe und implementiere nach Möglichkeit:

- Druckhistorie;
- Druckstatistiken;
- Makros;
- zusätzliche Sensoren;
- Lüftersteuerung;
- erweiterte Systeminformationen;
- Webcam-Integration;
- Timelapse;
- weitere von Mainsail verwendete APIs.

Eine Funktion ist nicht automatisch Teil des Kernumfangs, nur weil sie im originalen Mainsail verfügbar ist.

Bewerte den Nutzen, die technischen Abhängigkeiten und die Umsetzbarkeit für Marlin.

## Verhalten bei nicht verfügbaren Funktionen

Wenn eine Funktion von Marlin nicht unterstützt wird:

1. Prüfe, ob eine sichere und zuverlässige Alternative existiert.
2. Dokumentiere die Abweichung.
3. Liefere keine erfundenen Antworten.
4. Vermeide, dass die gesamte Weboberfläche wegen einer optionalen Funktion fehlschlägt.
5. Passe bei Bedarf das Frontend minimal an, damit der Benutzer den Grund für die fehlende Funktion erkennen kann.

## Serielle Kommunikation

Die Kommunikation muss robust sein.

Beachte insbesondere:

- variable Antwortlatenzen;
- fragmentierte serielle Nachrichten;
- unerwartete Antworten;
- mehrere Antworten auf eine Anfrage;
- Timeouts;
- Firmwaremeldungen während einer laufenden Anfrage;
- Reconnect-Verhalten;
- Puffergrenzen;
- fehlerhafte Daten;
- begrenzten Arbeitsspeicher auf dem Raspberry Pi.

Führe niemals ungeprüft eine unbeschränkte Warteschlange oder unbegrenzten Speicherverbrauch ein.

Dokumentiere die Zuordnung von Anfragen und Antworten. Gehe nicht davon aus, dass sich jede Antwort ausschließlich anhand eines `ok`-Tokens eindeutig einer Anfrage zuordnen lässt.

---

# 10. Mainsail-Marlin-Frontend implementieren

Verwende möglichst viel vom originalen Mainsail-Frontend.

Ändere das Frontend erst, nachdem geprüft wurde, ob eine Abweichung durch die API-Kompatibilitätsschicht behoben werden kann.

Frontendänderungen sollen sich auf klar begründete Marlin-Anforderungen konzentrieren.

Mögliche Anpassungen:

- Marlin als Firmware anzeigen;
- Marlin-spezifische Informationen darstellen;
- nicht unterstützte Klipper-Funktionen deaktivieren oder ausblenden;
- Marlin-spezifische Hinweise;
- zusätzliche Einstellungen für den Adapter;
- verständliche Fehlermeldungen;
- korrekte Zustandsdarstellung, auch wenn optionale Daten fehlen.

Führe keine unnötige neue Designbibliothek und kein zweites Framework ein.

Halte bestehende Codekonventionen ein und prüfe die Auswirkungen jeder Änderung auf das originale Mainsail.

Untersuche vor der Änderung der Darstellung, welche Informationen bereits durch bestehende Mainsail-Komponenten unterstützt werden.

Dokumentiere jede bewusste Abweichung vom Original.

---

# 11. Automatisierte Tests entwickeln

Das Projekt muss auch ohne angeschlossenen Drucker getestet werden können.

Erstelle eine Testarchitektur mit simuliertem seriellen Anschluss oder Fake-Marlin-Transport.

Die Tests dürfen im Standardlauf keine echten Heiz- oder Bewegungsbefehle an Hardware senden.

## Unit-Tests

Teste einzelne Module:

- Parser;
- serielle Nachrichtenverarbeitung;
- Temperaturkonvertierung;
- Statusnormalisierung;
- Fortschrittsberechnung;
- Fehlerbehandlung;
- Dateiverwaltung;
- Konfiguration;
- Timeout-Logik;
- Wiederverbindung.

## API-Tests

Teste:

- HTTP-Endpunkte;
- Parameterprüfung;
- erfolgreiche Responses;
- Fehlerantworten;
- fehlende Parameter;
- ungültige Anfragen;
- Berechtigungen;
- WebSocket-Verbindungen;
- Events;
- Status-Subscriptions.

## Integrations- und Workflowtests

Simuliere folgende Abläufe:

1. Mainsail verbindet sich mit dem Backend.
2. Der Drucker wird erkannt.
3. Die Temperaturen werden abgefragt.
4. Statusänderungen werden übertragen.
5. Eine G-Code-Datei wird aufgelistet.
6. Eine Datei wird hochgeladen.
7. Ein Druck wird gestartet.
8. Der Druckfortschritt aktualisiert sich.
9. Ein Druck wird pausiert.
10. Ein Druck wird fortgesetzt.
11. Ein Druck wird abgebrochen.
12. Die serielle Verbindung bricht ab.
13. Das Backend baut die Verbindung wieder auf.
14. Ein unbekanntes G-Code-Kommando führt zu einer kontrollierten Fehlermeldung.
15. Optionale, nicht verfügbare Funktionen beeinträchtigen die Kernoberfläche nicht.

## Fehlerfälle

Teste außerdem:

- verzögerte Antworten;
- verlorene Antworten;
- ungültige Nachrichten;
- fehlerhafte Temperaturmeldungen;
- unerwartete Firmwaremeldungen;
- Timeout;
- Verbindungsabbruch während eines Kommandos;
- Neustart des Backends;
- WebSocket-Abbruch;
- fehlende Statusfelder;
- fehlerhafte Datei-Uploads;
- unzureichende Berechtigungen;
- fehlender serieller Anschluss;
- nicht verfügbares Gerät.

## Kompatibilitätstests

Erstelle Tests, die die von Mainsail erwarteten API-Schemata und Datenstrukturen gegen den Adapter prüfen.

Prüfe nicht nur, ob ein HTTP-Endpunkt mit Statuscode 200 antwortet, sondern auch, ob die zurückgegebenen Daten korrekt strukturiert und semantisch sinnvoll sind.

## Build und Qualität

Ermittle die tatsächlichen Test- und Build-Kommandos der verwendeten Projekte.

Führe sämtliche verfügbaren relevanten Prüfungen aus, beispielsweise:

- Unit-Tests;
- Integrationstests;
- TypeScript-Prüfung;
- Linter;
- Frontend-Build;
- Backend-Build;
- ShellCheck;
- JSON-Validierung;
- Installationstests.

Erfinde keine Testergebnisse.

Dokumentiere für jede Prüfung, ob sie bestanden wurde, fehlgeschlagen ist oder aufgrund fehlender Voraussetzungen nicht ausgeführt werden konnte.

Erstelle:

- `docs/testing.md`
- `tests/` mit den tatsächlich benötigten Testdateien.

---

# 12. Integrationstests mit dem echten Mainsail-Frontend

Starte das originale beziehungsweise angepasste Mainsail-Frontend in einer Entwicklungsumgebung.

Verbinde es mit dem Marlinraker-Adapter und beobachte:

- Browser-Konsole;
- Netzwerk-Requests;
- WebSocket-Nachrichten;
- API-Fehler;
- fehlende Statusfelder;
- Darstellungsfehler;
- ungültige Datentypen;
- Verbindungsabbrüche;
- Bedienabläufe.

Erstelle reproduzierbare Testabläufe.

Wenn Browserautomatisierung sinnvoll und verfügbar ist, verwende ein geeignetes Testframework.

Wenn ein echter Drucker fehlt, arbeite zunächst mit einem Simulator.

Erkläre im Abschlussbericht klar den Unterschied zwischen:

- simuliert getestet;
- API-seitig getestet;
- mit echtem Marlin getestet;
- mit einem bestimmten Mainboard getestet.

Behaupte keine vollständige Hardwarekompatibilität, solange diese nicht überprüft wurde.

---

# 13. Installation auf dem Raspberry Pi

Eine einfache Installation ist ein zentrales Produktziel.

Das fertige System soll möglichst wie eine regulär installierbare Weboberfläche für 3D-Drucker eingerichtet werden können.

Untersuche zuerst den tatsächlichen Zustand und die offiziellen Installationswege von:

- Mainsail;
- Moonraker;
- Marlinraker;
- KIAUH;
- den unterstützten Raspberry-Pi-Betriebssystemen.

Leite daraus eine realistische unterstützte Plattform ab.

Wähle nicht ungeprüft irgendeine Distribution oder Node.js-Version.

Dokumentiere genau, welche Betriebssystemversionen und Hardwareplattformen du testest und unterstützt.

## 13.1 Installationsdesign

Entwickle ein Installationssystem, das mindestens Folgendes erledigt:

- Betriebssystem und Architektur prüfen;
- benötigte Abhängigkeiten installieren;
- erforderliche Benutzer und Gruppen verwalten;
- Mainsail-Marlin installieren oder aktualisieren;
- Marlinraker-Marlin installieren oder aktualisieren;
- Backend-Dienst konfigurieren;
- Nginx konfigurieren;
- Frontend und API korrekt verbinden;
- serielle Berechtigungen konfigurieren;
- Druckerkonfiguration anlegen;
- notwendige Verzeichnisse und Rechte erzeugen;
- Dienste aktivieren;
- Dienste starten;
- Verbindung prüfen;
- Installationsstatus ausgeben;
- Logs und Diagnoseinformationen verfügbar machen.

Klipper darf keine zwingende Voraussetzung sein.

Ein zusätzlicher originaler Moonraker-Dienst darf nur installiert werden, wenn es eine ausdrücklich begründete zusätzliche Verwendung gibt.

## 13.2 Installationsskript

Implementiere:

`scripts/install.sh`

Das Skript muss:

- verständliche Fehlermeldungen ausgeben;
- vor destruktiven Änderungen warnen;
- fehlende Abhängigkeiten erkennen;
- sichere Standardwerte verwenden;
- Konfigurationen vor Änderungen sichern;
- wiederholte Ausführung unterstützen;
- vorhandene Benutzerdaten erhalten;
- Fehler abfangen und protokollieren;
- Installationsschritte nachvollziehbar ausgeben;
- keine Zugangsdaten ausgeben;
- nach Installation die wichtigsten Dienste prüfen.

Das Skript soll idempotent sein: Ein zweiter Aufruf darf das System nicht unnötig beschädigen oder Daten löschen.

Verwende keine unkontrollierten Befehle wie `rm -rf` auf Variablen oder ungeprüften Pfaden.

Vermeide `curl | bash` als undokumentierten Installationsweg. Lade nur aus vertrauenswürdigen Quellen herunter, prüfe Fehler und sichere gegebenenfalls Prüfsummen.

## 13.3 Updateskript

Implementiere:

`scripts/update.sh`

Das Update muss:

- aktuelle Versionen ermitteln;
- Updatequellen prüfen;
- Änderungen und Versionssprünge dokumentieren;
- Konfiguration sichern;
- unterstützte Upstream-Änderungen kontrolliert übernehmen;
- kompatible Frontend- und Backend-Versionen sicherstellen;
- erforderliche Build-Schritte ausführen;
- Dienste kontrolliert neu starten;
- den Zustand prüfen;
- bei fehlgeschlagenem Update eine Wiederherstellung ermöglichen;
- persistente Konfigurationen und Druckdateien erhalten.

Überschreibe keine benutzerdefinierten Dateien ungeprüft.

Verwende für reguläre Installationen bevorzugt definierte Release-Versionen oder nachvollziehbare Commit-Pins und nicht unkontrolliert den neuesten Stand eines Entwicklungsbranches.

## 13.4 Deinstallationsskript

Implementiere:

`scripts/uninstall.sh`

Die Deinstallation soll:

- installierte Dienste stoppen und entfernen;
- Projektdateien kontrolliert entfernen;
- die zugehörigen Konfigurationen behandeln;
- fremde Dienste nicht verändern;
- benutzerdefinierte Konfigurationen und Druckdateien standardmäßig erhalten;
- vor einer optionalen Datenlöschung ausdrücklich warnen;
- klar anzeigen, welche Bereiche entfernt werden.

## 13.5 Diagnoseprogramm

Implementiere nach Möglichkeit:

`scripts/diagnose.sh`

Es soll kontrollieren:

- Betriebssystem;
- Architektur;
- installierte Versionen;
- Dienstestatus;
- Nginx;
- Portbelegung;
- Konfiguration;
- Dateiberechtigungen;
- seriellen Anschluss;
- Backend-Verbindung;
- API-Erreichbarkeit;
- relevante Logfehler.

Diagnosedaten müssen sensible Informationen schützen. Zugangsdaten, Tokens und private Konfigurationen dürfen nicht ungefiltert ausgegeben werden.

## 13.6 Dienst- und Webserverkonfiguration

Erstelle die tatsächlich benötigten Vorlagen, beispielsweise:

- `systemd`-Service;
- Nginx-Konfiguration;
- Konfigurationsvorlage;
- notwendige Verzeichnisstruktur.

Passe die Vorlagen an die tatsächliche Architektur und die vorhandenen Programme an.

Verwende korrekte Dienstabhängigkeiten, Berechtigungen, Neustartregeln und Logging.

Verwende keine willkürlichen Ports oder Pfade, wenn diese von den Originalprojekten abweichen.

## 13.7 Installation testen

Die Installationsskripte müssen automatisiert überprüft werden.

Teste soweit möglich in einer frischen virtuellen Linux-Umgebung oder in einer reproduzierbaren Testumgebung.

Teste mindestens:

- Neuinstallation;
- zweite Ausführung;
- fehlende Abhängigkeiten;
- fehlerhaften Download;
- fehlende Git-Verbindung;
- Build-Fehler;
- bereits bestehende Installation;
- Update;
- fehlgeschlagenes Update;
- Wiederherstellung;
- Deinstallation;
- Erhalt der Konfiguration;
- Erhalt der Benutzerdaten;
- nicht verfügbaren seriellen Anschluss;
- Diagnoseprogramm.

Ein Shell-Skript, das syntaktisch korrekt ist, gilt noch nicht als vollständig getestet.

Erstelle:

- `docs/installation.md`
- `docs/update-and-recovery.md`
- `docs/troubleshooting.md`

---

# 14. KIAUH-Integration prüfen

Untersuche das aktuelle KIAUH-Erweiterungssystem anhand des tatsächlichen Quellcodes und der offiziellen Dokumentation.

Entscheide erst danach, wie Mainsail-Marlin integriert werden sollte.

Wenn die Erweiterungsarchitektur geeignet ist, implementiere eine Erweiterung, über die der Benutzer Mainsail-Marlin installieren, aktualisieren und entfernen kann.

Bevorzuge die Nutzung dokumentierter Erweiterungsschnittstellen gegenüber Änderungen am KIAUH-Hauptprojekt.

Die Integration darf keine Klipper- oder Moonraker-Installation als zwingend voraussetzen.

Prüfe:

- KIAUH-Version und API;
- erforderliche Dateien;
- Benennungskonventionen;
- Installationsabläufe;
- Updateverfahren;
- Deinstallationsverfahren;
- Abhängigkeiten;
- Rückgabecodes;
- Fehlerbehandlung;
- Berechtigungen;
- Kompatibilität mit unterstützten Betriebssystemen.

Erstelle die Erweiterung nur, wenn sie tatsächlich zu KIAUH passt.

Dokumentiere:

- Einbindung;
- Installation;
- Update;
- Entfernung;
- Einschränkungen;
- Testergebnisse.

Führe keinen ungefragten Pull Request aus und verändere kein fremdes Upstream-Repository.

---

# 15. Vorbereitung eines eigenen Betriebssystem-Images

Ein eigenes Mainsail-Marlin-Image ist ein langfristiges Ziel.

Beginne nicht mit dem Bau eines Images, bevor Backend, Frontend und Installationsverfahren zuverlässig funktionieren.

Untersuche bereits während der Entwicklung, welche Voraussetzungen für ein reproduzierbares Raspberry-Pi-Image erforderlich sind.

Dokumentiere:

- unterstützte Geräte;
- Betriebssystembasis;
- Erstkonfiguration;
- Netzwerkzugang;
- Benutzerverwaltung;
- Updates;
- Persistenz;
- Fehlerbehebung;
- Lizenzfragen;
- Image-Größe;
- Wartungsaufwand.

Zunächst muss eine reguläre Installation auf einer sauberen unterstützten Plattform funktionieren.

Die spätere Image-Erstellung soll reproduzierbar sein und nicht lediglich aus einer manuell eingerichteten SD-Karte exportiert werden.

---

# 16. Sicherheit und physische Hardware

Sicherheit ist eine verbindliche Anforderung.

Der Backend-Adapter kommuniziert mit realer Hardware. Fehler können den Druck abbrechen, Druckteile beschädigen oder gefährliche Heiz- und Bewegungsabläufe auslösen.

Deshalb:

- Keine unkontrollierten G-Code-Ausführungen.
- Keine automatisierten echten Heiz- oder Bewegungsbefehle in Standardtests.
- Keine künstlich erfolgreichen Responses für fehlgeschlagene Kommandos.
- Keine ungeprüften Konfigurationsänderungen an Marlin.
- Keine offenen oder ungeschützten Fernzugriffsports ohne ausdrückliche Dokumentation.
- Keine Zugangsdaten im Quellcode.
- Keine unnötigen Root-Dienste.
- Keine unsicheren Dateipfade.
- Keine unbeschränkten Uploads ohne sinnvolle Validierung.
- Keine ungeprüfte Shell-Ausführung aus API-Eingaben.
- Keine ungefilterte Ausgabe sensibler Logs.

Verwende die vorhandenen Authentifizierungs- und Berechtigungsmechanismen, soweit sie im gewählten Setup erforderlich und kompatibel sind.

Prüfe die Auswirkungen von Fehlerfällen und Verbindungsabbrüchen auf laufende Druckvorgänge.

Trenne Simulator- und Hardwaretestprofile.

---

# 17. Dokumentation und Entwicklerworkflow

Erstelle eine nachvollziehbare Dokumentation im Verzeichnis `docs/`.

Mindestens benötigt werden:

- `research.md`
- `initial-inventory.md`
- `architecture.md`
- `mainsail-analysis.md`
- `moonraker-analysis.md`
- `marlin-analysis.md`
- `marlinraker-analysis.md`
- `compatibility-matrix.md`
- `testing.md`
- `installation.md`
- `update-and-recovery.md`
- `troubleshooting.md`
- `security.md`
- `final-report.md`

Passe die Dateiliste an, wenn Inhalte sinnvoll zusammengefasst werden können. Alle geforderten Themen müssen dennoch enthalten sein.

Erstelle außerdem:

- eine verständliche README;
- eine Liste unterstützter Funktionen;
- bekannte Einschränkungen;
- eine Konfigurationsanleitung;
- eine Anleitung zur Fehlerdiagnose;
- eine Anleitung für Entwickler;
- klare Informationen zu den getesteten Plattformen.

Dokumentiere für wesentliche technische Behauptungen die zugehörigen Quelldateien, Versionen oder offiziellen Quellen.

---

# 18. CI und automatisierte Qualitätssicherung

Prüfe, welche Continuous-Integration-Systeme für die beiden Projekte bereits vorhanden sind.

Erweitere oder ergänze die automatisierten Prüfungen sinnvoll.

Eine CI-Pipeline soll, soweit in der vorhandenen Umgebung möglich, ausführen:

- Abhängigkeitsprüfung;
- TypeScript-Prüfung;
- Linter;
- Unit-Tests;
- API-Tests;
- Integrationstests mit Simulator;
- Frontend-Build;
- Backend-Build;
- JSON-Validierung;
- Shell-Syntaxprüfung;
- ShellCheck;
- Installationsskript-Tests.

Nutze passende Versionsmatrizen nur dort, wo sie einen konkreten Mehrwert bieten.

Vermeide es, in automatisierten CI-Läufen reale Druckerhardware zu benötigen.

Dokumentiere nicht ausgeführte Tests klar.

Ein fehlgeschlagener Test darf nicht durch deaktivierte Testprüfungen oder ignorierte Fehler kaschiert werden.

---

# 19. Umsetzung in Entwicklungsphasen

Arbeite die folgenden Phasen in dieser Reihenfolge ab.

## Phase A: Bestandsaufnahme

- Repositorys prüfen.
- aktuelle Projektversionen ermitteln;
- Recherche durchführen;
- relevante Dokumentation lesen;
- Risiken identifizieren.

## Phase B: Architektur und Spezifikation

- Mainsail-Anforderungen erfassen;
- Moonraker untersuchen;
- Marlin und Marlinraker analysieren;
- API-Kompatibilitätsmatrix erstellen;
- technische Architektur festlegen;
- priorisierten Umsetzungsplan dokumentieren.

## Phase C: Grundlegende API-Kompatibilität

- serielle Kommunikation verbessern;
- grundlegende APIs und Events implementieren;
- Druckerstatus abbilden;
- Temperaturen abfragen;
- G-Code-Konsole bereitstellen;
- Dateiverwaltung und Drucksteuerung implementieren.

## Phase D: Frontend-Kompatibilität

- originales Mainsail verbinden;
- Statusdarstellung prüfen;
- notwendige minimale Frontendänderungen durchführen;
- fehlende Funktionen sauber kennzeichnen.

## Phase E: Tests und Fehlerbehebung

- Unit-Tests;
- API-Tests;
- Simulator;
- Integrationstests;
- Regressionstests;
- Fehlerbehebung;
- erneute Kompatibilitätsanalyse.

## Phase F: Installationssystem

- Installationsskript;
- Update;
- Deinstallation;
- Diagnose;
- Servicekonfiguration;
- Webserverkonfiguration;
- Installationstests.

## Phase G: KIAUH

- aktuelle Schnittstelle untersuchen;
- Erweiterung erstellen, sofern sinnvoll;
- Installation und Deinstallation testen.

## Phase H: Abschluss und Dokumentation

- vollständige Tests erneut ausführen;
- Kompatibilitätsmatrix aktualisieren;
- bekannte Einschränkungen dokumentieren;
- Installationsanleitung überprüfen;
- finale Berichte erstellen.

Die Phasen dienen als Reihenfolge und nicht als Anlass, nach jedem Abschnitt auf eine weitere Aufforderung zu warten.

Arbeite die umsetzbaren Aufgaben selbstständig weiter ab.

---

# 20. Umgang mit Problemen und technischen Grenzen

Wenn ein ursprünglicher Endpunkt nicht sinnvoll auf Marlin übertragen werden kann:

1. Untersuche, wofür Mainsail ihn tatsächlich verwendet.
2. Prüfe, ob eine kompatible Alternative existiert.
3. Implementiere die Alternative, wenn sie korrekt und sicher ist.
4. Passe bei Bedarf das Frontend minimal an.
5. Dokumentiere die Einschränkung.
6. Ergänze Tests für das erwartete Verhalten.

Wenn ein Problem von einem konkreten Marlin-Board oder einer speziellen Firmwarekonfiguration abhängt, abstrahiere die boardabhängige Logik und dokumentiere die Voraussetzungen.

Wenn eine Installation wegen nicht verfügbarer Hardware nicht getestet werden kann, prüfe alle sicher möglichen Teile und vermerke die nicht ausgeführten Tests ausdrücklich.

Wenn das ursprüngliche Marlinraker-Projekt erhebliche technische Mängel aufweist, entscheide nachvollziehbar zwischen einer Modernisierung und einer begrenzten Neuentwicklung des Adapters.

Mache keine grundlegenden Änderungen allein deshalb, weil sie architektonisch eleganter erscheinen. Begründe sie mit konkreten Anforderungen oder nachweisbaren Problemen.

---

# 21. Abschlusskriterien

Das Projekt darf nicht als vollständig abgeschlossen bezeichnet werden, bevor folgende Punkte geprüft wurden:

## Recherche

- Aktuelle Quellen wurden untersucht.
- Versionen und Commit-IDs sind dokumentiert.
- Mainsail-Anforderungen wurden aus dem Code ermittelt.
- Moonrakers tatsächliche API wurde analysiert.
- Marlin und Marlinraker wurden untersucht.

## Implementierung

- Die grundlegende Moonraker-Kompatibilität ist umgesetzt.
- Die zentralen APIs und Events sind implementiert.
- Serielle Kommunikation und Fehlerbehandlung sind getestet.
- Mainsail kann mit dem Adapter verbunden werden.
- Nicht unterstützte Funktionen werden korrekt behandelt.

## Tests

- Unit-Tests sind vorhanden.
- API-Tests sind vorhanden.
- Simulationstests sind vorhanden.
- Integrationsabläufe wurden ausgeführt.
- Build und Codeprüfung wurden durchgeführt.
- Verbleibende Fehler sind dokumentiert.
- Hardwaretests sind als solche ausgewiesen.

## Installation

- Installationsskript ist vorhanden.
- Updateskript ist vorhanden.
- Deinstallationsskript ist vorhanden.
- Diagnoseprogramm ist vorhanden.
- Installationsanleitung ist vollständig.
- Wiederholte Installation wurde geprüft.
- Datenpersistenz wurde geprüft.
- Fehlerbehandlung wurde geprüft.
- KIAUH-Eignung wurde untersucht.

## Dokumentation

- Kompatibilitätsmatrix ist aktualisiert.
- bekannte Einschränkungen sind dokumentiert;
- technische Architektur ist dokumentiert;
- installierbare Versionen sind nachvollziehbar;
- konkrete nächste Schritte sind angegeben.

---

# 22. Abschlussbericht erstellen

Erstelle `docs/final-report.md`.

Der Bericht muss präzise beantworten:

1. Was wurde untersucht?
2. Welche Versionen und Commits wurden verwendet?
3. Welche Architektur wurde umgesetzt?
4. Welche Funktionen wurden implementiert?
5. Welche Dateien wurden geändert oder ergänzt?
6. Welche APIs sind vollständig kompatibel?
7. Welche Funktionen sind teilweise kompatibel?
8. Welche Funktionen fehlen noch?
9. Welche Tests wurden tatsächlich ausgeführt?
10. Welche Tests sind erfolgreich?
11. Welche Tests sind fehlgeschlagen?
12. Welche Tests konnten nicht ausgeführt werden?
13. Wurde das Frontend erfolgreich mit dem simulierten Marlin-Backend verbunden?
14. Wurde die Installation auf einem sauberen System getestet?
15. Welche Raspberry-Pi-Betriebssysteme werden tatsächlich unterstützt?
16. Welche bekannten Probleme bestehen?
17. Welche Sicherheitsrisiken sind noch offen?
18. Wie lässt sich das Projekt installieren, aktualisieren und entfernen?
19. Welche nächsten Schritte sind für eine stabile Veröffentlichung notwendig?

Gib im Abschlussbericht keine pauschale Bewertung wie „alles funktioniert“, wenn nicht alle Funktionen nachweislich geprüft wurden.

Unterscheide klar zwischen implementiert, getestet, ungetestet und nicht verfügbar.

Führe am Ende die verfügbaren Builds, automatisierten Prüfungen und Installationsprüfungen erneut aus und dokumentiere die Ergebnisse.

## Letzte verbindliche Anweisung

Beginne jetzt mit der Untersuchung der vorhandenen Arbeitsumgebung und den erforderlichen aktuellen Recherchen.

Erstelle die Bestandsaufnahme und Architektur, implementiere anschließend die sinnvollen Änderungen und Tests, entwickle das Installationssystem und aktualisiere die Dokumentation fortlaufend.

**Liefere am Ende nicht bloß einen Plan, sondern den tatsächlich veränderten, gebauten und soweit möglich getesteten Projektstand einschließlich Installationsskripten, Testergebnissen, Kompatibilitätsmatrix und Abschlussbericht.**

Verändere keine echten Drucker durch automatisierte Bewegungs- oder Heiztests. Lösche keine fremden Änderungen. Erfinde keine Ergebnisse. Dokumentiere alle relevanten Unsicherheiten.

Arbeite bis zum bestmöglichen überprüfbaren Ergebnis innerhalb der vorhandenen Umgebung.