# Recherche

Stand: 2026-10-14. Recherchequellen wurden am selben Datum abgerufen.

## Projekte und technische Ergebnisse

### Mainsail

Quelle: https://github.com/mainsail-crew/mainsail, Commit
`668f705aaed43d0a69562da3a5c8c96038ae5336`, Arbeitskopie
`mainsail-marlin/`.

Die Anwendung ist eine Vue-2.7-/Vuetify-2-/Vuex-3-/TypeScript-/Vite-Anwendung.
`src/store/farm/printer/actions.ts` öffnet einen JSON-RPC-WebSocket, ruft
`server.info`, `printer.objects.list`, `printer.objects.subscribe` und
`server.files.list` auf und verarbeitet `notify_status_update`,
`notify_klippy_ready` und `notify_klippy_disconnected`. Uploads verwenden
`POST /server/files/upload`. Build- und Testskripte sind in
`mainsail-marlin/package.json` dokumentiert.

Lizenz: GPLv3 (`mainsail-marlin/LICENSE`).

### Moonraker

Quelle: https://github.com/Arksine/moonraker, Commit
`9e676eba6b02661a4dfa3ec6e7ac3f3504498e6d`, Arbeitskopie `upstream/moonraker/`.

Moonraker ist Python 3 mit Tornado. Routen und JSON-RPC-Methoden werden aus
Komponenten registriert. `moonraker/components/klippy_connection.py` und
`moonraker/components/klippy_apis.py` bilden die Klipper-Grenze. Datei-,
Datenbank-, Historien-, Maschinen- und Update-Funktionen sind getrennte
Komponenten. Die vorhandenen pytest-Tests testen Moonraker selbst, nicht
Marlinraker.

Lizenz: GPLv3 (`upstream/moonraker/LICENSE`).

### Marlinraker

Quelle: https://github.com/phm07/marlinraker, Commit
`68d35be4e4a10c98e1f3255d9d83c40e04e0ed6c`, Arbeitskopie
`marlinraker-marlin/`.

Der Adapter ist TypeScript 4.9 mit Express, `ws` und `serialport`. HTTP- und
WebSocket-Methoden werden in `src/api/HttpHandler.ts` und
`src/api/SocketHandler.ts` registriert. `src/printer/SerialGcodeDevice.ts`
serialisiert G-Code über eine einzelne aktive Anfrage und wertet `ok` als
Abschlussmarke aus. `src/printer/ParserUtil.ts` normalisiert Antworten von
`M115`, `M105`, `M114`, `M20`, `M119`, `M503` und verschiedene G-Code-Befehle.

Lizenz: GPLv3 (`marlinraker-marlin/LICENSE`). Der Upstream enthält zum
ausgewerteten Commit kein ausführbares Unit-Test-Setup; `npm test` ist dort
nur ein ESLint-Aufruf.

### Marlin

Quelle: https://github.com/MarlinFirmware/Marlin, Commit
`564f26cdc06203362935704f9487b270f11b8234`, Arbeitskopie `upstream/marlin/`.

Marlin ist Firmware-C/C++ mit board- und konfigurationsabhängigem PlatformIO-
Build. Die serielle Protokolloberfläche ist nicht über alle Boards und
Konfigurationen identisch. Informationen wie Temperatur und Position können
abgefragt werden; Druckfortschritt, Historie und Dateimetadaten sind ohne
zusätzliche Firmware-/Host-Unterstützung nicht vollständig garantiert.

Lizenz: GPLv3 (`upstream/marlin/LICENSE`).

### KIAUH

Quelle: https://github.com/dw-0/kiauh, Commit
`d3e538de7b3163abe27fdf8116a60716d4db31ce`, Arbeitskopie `upstream/kiauh/`.

Die Erweiterungsschnittstelle ist in
`kiauh/extensions/base_extension.py` definiert. Installieren und Entfernen
sind abstrakte Methoden; Aktualisieren ist optional. Die vorhandenen
Erweiterungen und `metadata.json`-Dateien sind die maßgebliche Referenz.

Lizenz: GPLv3 (`upstream/kiauh/LICENSE`).

## Architekturentscheidung

Die vorhandene Marlinraker-Basis wird modernisiert und getestet, nicht durch
Moonraker oder einen zweiten Klipper-Dienst ersetzt. Mainsail bleibt möglichst
unverändert. Nicht zuverlässig aus Marlin ableitbare Klipper-Daten werden nicht
als erfolgreich simuliert.

## Offene Annahmen

- Die dokumentierten Commits sind bewegliche Entwicklungsstände, keine
  zugesicherten Releases.
- Ohne konkretes Board und konkrete `Configuration.h` kann keine vollständige
  Hardwarekompatibilität zugesagt werden.
- Webcam, Timelapse, Klipper-Makros, Update Manager und viele Sensorobjekte
  bleiben optional oder teilweise kompatibel.
