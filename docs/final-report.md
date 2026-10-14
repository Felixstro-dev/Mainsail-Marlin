# Abschlussbericht

Dieser Bericht wird erst nach den letzten Build-, Lint- und Testläufen als
vollständiger Abschluss aktualisiert. Der aktuelle Stand ist ein überprüfbarer
Entwicklungsstand, keine Aussage vollständiger Hardwarekompatibilität.

## Untersucht

Mainsail, Moonraker, Marlinraker, Marlin und KIAUH wurden aus den in
`docs/initial-inventory.md` genannten Commits lokal untersucht. Die Architektur
und die Kern-API-Aufrufe sind in den Analyse-Dokumenten festgehalten.

## Umgesetzt

- getrennte Mainsail- und Marlinraker-Arbeitskopien;
- API-Anforderungsdatei und Kompatibilitätsmatrix;
- Architektur-, Installations-, Sicherheits- und Testdokumentation;
- hardwarefreie Parser-Tests (4/4), Mainsail-Unit-Tests (46/46), Frontend- und
  Backend-Builds, Frontend-Linting, JSON-Validierung sowie Skript-Dry-Runs.
- Parserfehler bei gemischten `M115`-Feldnamen und `ok`-präfixierten `M105`-
  Antworten behoben.
- Idempotenzorientierte Installations-, Update-, Deinstallations- und
  Diagnose-Skripte sowie systemd-/Nginx-Vorlagen.

## Noch offen

- saubere Raspberry-Pi-Installation;
- echte Board-/Firmwaretests;
- vollständige Druckzustandssemantik für Pause/Resume/Cancel;
- vollständige Semantik der optionalen Klipper-Funktionen;
- belastbare KIAUH-Erweiterung erst nach API-Test gegen die Zielversion.

## Tatsächliche Prüfergebnisse

Frontend und Backend bauen erfolgreich. Das Mainsail-Frontend wurde in dieser
Umgebung gegen einen laufenden Marlinraker-Fake-Transport verbunden. HTTP,
JSON-RPC-WebSocket, Upload und Cypress-Browserintegration bestanden. Die
Installation wurde nicht auf einem sauberen Raspberry Pi oder virtuellen
System ausgeführt. npm-Audit meldete im Backend 1 kritische, 6 hohe, 1
moderate und 3 niedrige Produktionsmeldungen sowie im Frontend 1 hohe, 2
moderate und 6 niedrige; diese bleiben offene Release-Risiken.

Die Mainsail-Initialisierung benötigte `server.webcams.list`; der Adapter
liefert nun eine leere Liste, wenn kein Webcam-Dienst vorhanden ist.
Zusätzlich behandelt die Dateiliste fehlende optionale Verzeichnisse sicher
als leer, sodass der Browserlauf auch ohne Theme-Fixtures bestanden hat.

## Installations- und Umgebungsgrenzen

`systemd-analyze verify deploy/mainsail-marlin.service` bestand. nginx war
nicht installiert und konnte deshalb nicht mit `nginx -t` geprüft werden.
Die Diagnose lief mit einem Testprefix; `diagnose.sh` hat keinen Dry-Run-
Schalter. Es wurden keine echten Heiz-, Bewegungs- oder Not-Aus-Befehle an
Hardware gesendet.

## Transparenz

Implementiert bedeutet hier Quellcode vorhanden; getestet bedeutet nur ein
konkret ausgeführter und protokollierter Test. Hardwarekompatibilität wird
nicht aus einem erfolgreichen TypeScript-Build abgeleitet.
