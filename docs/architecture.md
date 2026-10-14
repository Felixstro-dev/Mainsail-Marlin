# Architektur

## Ziel

```text
Browser
  -> Mainsail-Marlin (Vue/Vite)
  -> Moonraker-kompatibles HTTP + JSON-RPC-WebSocket
  -> Marlinraker-Marlin (TypeScript/Express/ws)
  -> serielle Marlin-Verbindung
  -> Marlin-Firmware
```

Frontend und Adapter bleiben getrennt deploybar. Das Frontend kennt weiterhin
die Moonraker-Verträge; die Firmwarebesonderheiten liegen im Backend.

## Komponenten

- `mainsail-marlin/`: möglichst unveränderter Mainsail-Fork.
- `marlinraker-marlin/`: vorhandener Marlinraker-Adapter.
- `upstream/`: schreibgeschützte Recherchekopien der Originalprojekte.
- `scripts/`: sichere Betriebs- und Diagnosewerkzeuge.
- `tests/`: projektübergreifende Vertrags- und Skripttests.

## Datenfluss

Mainsail sendet JSON-RPC-Anfragen mit numerischer ID. Der Adapter validiert
JSON-RPC, löst registrierte Executoren auf und antwortet mit `result` oder
Moonraker-artigem `error`. Statusänderungen werden als
`notify_status_update` gesendet. Serielle Antworten werden vom Parser und von
Watchern in normalisierte Druckerobjekte übertragen.

## Bewusste Grenzen

- Ein `ok` von Marlin beendet eine sequenzielle Anfrage; ungeordnete
  Firmwaremeldungen werden als Meldungen behandelt. Eine dauerhafte
  Command-ID-Zuordnung wie bei einem Klipper-RPC ist nicht verfügbar.
- Druckfortschritt kann ohne M73, Dateianalyse oder Host-Tracking nur
  eingeschränkt ermittelt werden.
- Klipper-only-Objekte wie `bed_mesh`, `gcode_move`-Details,
  `exclude_object`, vollständige Makrointrospektion und Update-Manager-
  Repositorystatus sind nicht automatisch verfügbar.
- Heiz- und Bewegungsbefehle werden niemals in Standardtests an Hardware
  gesendet.

## Verworfen

Ein paralleler Moonraker-Dienst wurde verworfen: Moonraker benötigt eine
Klipper-Verbindung und würde die Firmwaregrenze nicht lösen. Ein vollständiger
Frontend-Neubau wurde verworfen, weil Mainsail bereits die gewünschte
Bedienoberfläche und die API-Verträge definiert.
