# Teststrategie und Ergebnisse

## Hardwarefreie Tests

Der Standardtest darf keine serielle Verbindung öffnen und keine Heiz-,
Bewegungs- oder Not-Aus-Befehle an Hardware senden. Parser- und
Vertragsprüfungen verwenden statische Marlin-Antworten.

## Ausgeführte Prüfungen

Am 2026-10-14 wurden folgende hardwarefreie Prüfungen ausgeführt:

| Prüfung | Ergebnis |
|---|---|
| `marlinraker-marlin/npm run test:unit` | BESTANDEN, 4/4 Tests |
| `marlinraker-marlin/npm run build` | BESTANDEN: ESLint, TypeScript, esbuild und Paketkopie |
| `mainsail-marlin/npm run test:unit` | BESTANDEN, 46/46 Tests |
| `mainsail-marlin/npm run lint` | BESTANDEN |
| `mainsail-marlin/npm run build` | BESTANDEN |
| `python3 -m json.tool docs/mainsail-api-requirements.json` | BESTANDEN |
| `bash -n scripts/*.sh` und Dry-Run-Prüfung | BESTANDEN |

`npm ci --ignore-scripts` war in beiden Projekten erfolgreich. npm meldete
bekannte transitive Schwachstellen: Marlinraker 1 kritisch, 6 hoch, 1
moderat, 3 niedrig; Mainsail 1 hoch, 2 moderat, 6 niedrig. Diese wurden nicht
blind mit `npm audit fix --force` verändert, weil dadurch Upstream-Kompatibilität
brechen kann.

## Nicht ausgeführt

Ein echter Drucker, ein konkretes Mainboard, Browser-E2E gegen einen laufenden
Adapter, Raspberry-Pi-Neuinstallation und `shellcheck` sind in der aktuellen
Umgebung nicht verfügbar bzw. nicht ausgeführt. Diese Punkte werden nicht als
bestanden behauptet. Die Installationsskripte wurden nur syntaktisch und im
`--dry-run` geprüft; ein echter Dienststart wurde nicht durchgeführt.
