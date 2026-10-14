# Kompatibilitätsmatrix

Statuswerte: `IMPLEMENTED`, `PARTIAL`, `MISSING`, `KLIPPER_DEPENDENT`,
`MARLIN_DEPENDENT`, `OPTIONAL`, `UNTESTED`, `NOT_APPLICABLE`.

| Funktion | Mainsail-Anforderung | Moonraker-Verhalten | Marlin-Fähigkeit | Backend-Status | Frontend-Status | Teststatus | Priorität |
|---|---|---|---|---|---|---|---|
| JSON-RPC-WebSocket | `/websocket`, JSON-RPC 2.0 | Tornado-WebSocket | Host-seitig möglich | IMPLEMENTED | IMPLEMENTED | LIVE bestanden, Cypress bestanden | P1 |
| `server.info` | initiale Erkennung | Klippy-/Serverdaten | Adapterzustand | IMPLEMENTED | IMPLEMENTED | LIVE bestanden | P1 |
| `printer.objects.list` | Statusobjekte entdecken | Klipper-Objekte | begrenzte Adapterobjekte | IMPLEMENTED | IMPLEMENTED | LIVE bestanden | P1 |
| Status-Subscription | `notify_status_update` | Klipper-Status | Watcher/Normalisierung | PARTIAL | IMPLEMENTED | LIVE teilweise bestanden | P1 |
| Temperatur | Heater-Objekte | Klipper-Heater | `M105` | MARLIN_DEPENDENT | IMPLEMENTED | Parser, WS und Browser LIVE bestanden | P1 |
| Position | Toolhead/G-Code-Position | Klipper-Toolhead | `M114`, Tracking | PARTIAL | PARTIAL | Parser abgedeckt | P1 |
| G-Code-Konsole | `printer.gcode.script` | an Klipper weiterleiten | serielle Warteschlange | PARTIAL | IMPLEMENTED | LIVE mit Fake-Transport bestanden | P1 |
| Dateiliste | `server.files.list` | Host-Dateien | SD/Host abhängig | PARTIAL | IMPLEMENTED | JSON-RPC und Browser LIVE bestanden | P1 |
| Upload | `server.files.upload` | multipart + Metadaten | Host-Dateiablage | IMPLEMENTED | IMPLEMENTED | Multipart LIVE bestanden | P1 |
| Druckstart/Pause/Resume/Cancel | RPC-Methoden | Klipper-Kommandos | Makro/G-Code | PARTIAL | IMPLEMENTED | nicht hardwareseitig | P1 |
| Fortschritt | `print_stats`/`virtual_sdcard` | Klipper liefert Status | M73/Host-Tracking | PARTIAL | PARTIAL | nicht live | P1 |
| Historie | `server.history.*` | Moonraker-Datenbank | Host-seitig | IMPLEMENTED | IMPLEMENTED | Initialisierung LIVE bestanden | P2 |
| Makros | `gcode_macro` | Klipper-Makros | konfigurierte Adapter-Makros | PARTIAL | PARTIAL | UNTESTED | P2 |
| Bed mesh | `bed_mesh` | Klipper-Objekt | nicht generisch garantiert | NOT_APPLICABLE | OPTIONAL | nicht ausgeführt | P2 |
| Timelapse | optionaler Dienst | separate Integration | kein Marlin-Kernfeature | PARTIAL | IMPLEMENTED | API/Browser-Initialisierung getestet; kein Rendering | P2 |
| Update Manager | Git-/Systemupdates | Moonraker-Komponente | Host-seitig möglich | PARTIAL | OPTIONAL | nicht ausgeführt | P2 |
| Webcam | separater Stream | Moonraker-Konfiguration | unabhängig von Marlin | OPTIONAL | IMPLEMENTED | leere Liste LIVE; kein Stream getestet | P2 |

Diese Matrix ist bewusst konservativ: Ein vorhandener Endpoint ist nicht
automatisch semantisch vollständig kompatibel.

Der Adapter registriert `server.webcams.list` als leere, sichere Liste, damit
Mainsail ohne optionalen Webcam-Dienst initialisieren kann. Druckzustände und
Historiensemantik bleiben gegenüber echter Marlin-Firmware eingeschränkt.
Die Timelapse-Kompatibilität stellt Mainsails Einstellungs- und
`lastframeinfo`-Verträge bereit. Frame-Aufnahme und FFmpeg-Rendering bleiben
bewusst deaktiviert, solange keine Kamera- und Encoderintegration konfiguriert
ist.
