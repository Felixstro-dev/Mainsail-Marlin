# Initial inventory

Stand: 2026-10-14

## Ausgangslage

Das Arbeitsverzeichnis enthielt zu Beginn nur `prompt.md` und keine Git-Arbeitskopie,
keine Abhängigkeiten und keinen ausführbaren Projektcode. Es wurden daher fünf
getrennte, flache Upstream-Kopien unter `upstream/` erstellt und daraus die beiden
Arbeitskopien `mainsail-marlin/` und `marlinraker-marlin/` ohne deren `.git`-Verzeichnisse
abgeleitet.

## Werkzeuge

- Node.js: `v25.2.1` (lokal vorhanden; Mainsail fordert `^20.19.0 || >=22.12.0`)
- npm: lokal vorhanden
- Python 3: lokal vorhanden
- `shellcheck`: nicht vorhanden
- `jq`: nicht vorhanden
- Keine reale Druckerhardware angeschlossen oder verwendet

## Upstream-Stände

| Projekt | URL | Branch | Commit |
|---|---|---|---|
| Mainsail | https://github.com/mainsail-crew/mainsail | `develop` | `668f705aaed43d0a69562da3a5c8c96038ae5336` |
| Moonraker | https://github.com/Arksine/moonraker | `master` | `9e676eba6b02661a4dfa3ec6e7ac3f3504498e6d` |
| Marlinraker | https://github.com/phm07/marlinraker | `master` | `68d35be4e4a10c98e1f3255d9d83c40e04e0ed6c` |
| Marlin | https://github.com/MarlinFirmware/Marlin | `bugfix-2.1.x` | `564f26cdc06203362935704f9487b270f11b8234` |
| KIAUH | https://github.com/dw-0/kiauh | `master` | `d3e538de7b3163abe27fdf8116a60716d4db31ce` |

Die Commits stammen aus `git ls-remote` und wurden anschließend als flache
Arbeitskopien abgerufen. Tags wurden nicht als Zielversion angenommen, weil die
Anforderung ausdrücklich den aktuellen Projektstand verlangt.

## Erste Architekturbeobachtungen

- Mainsail 2.19.0 ist Vue 2.7 + Vuetify 2 + Vuex 3 + TypeScript + Vite.
- Mainsail initialisiert `server.info`, `printer.objects.list` und
  `printer.objects.subscribe` über JSON-RPC-WebSocket.
- Kernfunktionen nutzen zusätzlich HTTP für Uploads, Dateien, Metadaten,
  Datenbank und Historie.
- Moonraker ist ein Python-3/Tornado-Dienst, dessen Druckerkommunikation über
  eine Klipper-Verbindung erfolgt; viele Statusobjekte sind Klipper-spezifisch.
- Marlinraker ist ein eigenständiger TypeScript/Express/`ws`-Adapter. Er
  implementiert bereits zahlreiche Moonraker-Namen, übersetzt sie aber auf eine
  serielle Marlin-Verbindung.
- KIAUH besitzt eine Python-Erweiterungsbasis mit `install_extension`,
  `update_extension` und `remove_extension`; das System ist primär auf Klipper
  ausgerichtet und eine Mainsail-Marlin-Erweiterung ist daher erst nach einer
  Kompatibilitätsprüfung sinnvoll.

## Risiken

Die Upstream-Kopien sind keine vollständige Release-Pin-Strategie. Für eine
öffentliche Veröffentlichung müssen kompatible Mainsail-/Marlinraker-Releases
und reproduzierbare Lockfiles festgelegt werden. Ein echter Drucker, konkrete
Boards, Baudraten und Marlin-Konfigurationen wurden nicht verifiziert.
