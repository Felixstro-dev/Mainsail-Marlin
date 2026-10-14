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

- Browser-Integration gegen einen laufenden Simulator;
- saubere Raspberry-Pi-Installation;
- echte Board-/Firmwaretests;
- vollständige Semantik der optionalen Klipper-Funktionen;
- belastbare KIAUH-Erweiterung erst nach API-Test gegen die Zielversion.

## Tatsächliche Prüfergebnisse

Frontend und Backend bauen erfolgreich. Das Mainsail-Frontend wurde in dieser
Umgebung jedoch noch nicht gegen einen laufenden Marlinraker-WebSocket
verbunden. Die Installation wurde nicht auf einem sauberen Raspberry Pi oder
virtuellen System ausgeführt. npm-Audit meldete im Backend 1 kritische und 6
hohe transitive Schwachstellen sowie im Frontend 1 hohe Schwachstelle; diese
bleiben offene Release-Risiken.

## Transparenz

Implementiert bedeutet hier Quellcode vorhanden; getestet bedeutet nur ein
konkret ausgeführter und protokollierter Test. Hardwarekompatibilität wird
nicht aus einem erfolgreichen TypeScript-Build abgeleitet.
