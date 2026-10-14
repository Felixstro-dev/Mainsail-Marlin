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
| `MARLINRAKER_FAKE_SERIAL=1 npm run dev.fake` | BESTANDEN, Adapter auf 127.0.0.1:7125 |
| HTTP `GET /server/info` | BESTANDEN, `type: marlinraker`, `klippy_state: ready` |
| JSON-RPC-WebSocket-Kernabläufe | BESTANDEN: identify, info, objects, subscribe, query, G-Code und Fehlerantwort |
| Multipart-Upload `demo.gcode` | BESTANDEN |
| Cypress Dashboard-Smoke-Test | BESTANDEN |
| Cypress Marlinraker-Integration | BESTANDEN: UI, Temperaturdaten, Datei, Konsole und WS-URL |
| `systemd-analyze verify deploy/mainsail-marlin.service` | BESTANDEN |
| `scripts/diagnose.sh --prefix /tmp/mainsail-marlin-test` | BESTANDEN |

Der Fake-Transport unterstützt zusätzlich `MARLINRAKER_FAKE_FRAGMENT=1`,
`MARLINRAKER_FAKE_DELAY=<ms>`, `MARLINRAKER_FAKE_TIMEOUT=1`,
`MARLINRAKER_FAKE_OPEN_ERROR=1` und
`MARLINRAKER_FAKE_DISCONNECT_AFTER=<ms>`. Diese Schalter erlauben
deterministische Fragmentierungs-, Timeout-, Open-Fehler- und
Verbindungsabbruchtests, ohne Hardware anzusprechen.

`npm ci --ignore-scripts` war in beiden Projekten erfolgreich. npm meldete
bekannte transitive Schwachstellen: Marlinraker 1 kritisch, 6 hoch, 1
moderat, 3 niedrig; Mainsail 1 hoch, 2 moderat, 6 niedrig. Diese wurden nicht
blind mit `npm audit fix --force` verändert, weil dadurch Upstream-Kompatibilität
brechen kann.

## Nicht ausgeführt

Ein echter Drucker, ein konkretes Mainboard, Raspberry-Pi-Neuinstallation und
`shellcheck` sind nicht ausgeführt. Die Browser-E2E-Prüfung lief dagegen
erfolgreich gegen den laufenden Fake-Adapter. Pause/Resume/Cancel wurden nur
über die vorhandenen JSON-RPC-Antworten geprüft; eine vollständige simulierte
`print_stats`-Zustandsmaschine ist noch offen. nginx konnte nicht validiert
werden, weil das Prüfwerkzeug in der Umgebung fehlt. `diagnose.sh` unterstützt
keinen `--dry-run`-Schalter und wurde daher direkt mit einem nicht vorhandenen
Testprefix ausgeführt.
