# Mainsail-Analyse

Quelle: Mainsail Commit `668f705aaed43d0a69562da3a5c8c96038ae5336`.

## Verbindungsablauf

`src/store/farm/printer/actions.ts` öffnet `/websocket`, sendet bei Öffnung
`server.info`, setzt bei erfolgreicher Antwort den Firmwarestatus und ruft
anschließend `printer.objects.list`, `printer.objects.subscribe`,
`server.files.list` für `config` und `server.database.list` auf.

Die Statusverarbeitung erwartet `notify_status_update` mit einem Statusobjekt
und verarbeitet `notify_klippy_ready` sowie
`notify_klippy_disconnected`. Der Name der Benachrichtigungen bleibt im
Adapter kompatibel, obwohl der Wert nicht aus Klipper stammt.

## Kern-APIs

| API | Transport | Verwendung | Marlin-Einschätzung |
|---|---|---|---|
| `server.info` | JSON-RPC/WebSocket | Verbindung und Serverdaten | sicher implementierbar |
| `printer.objects.list` | JSON-RPC/WebSocket | verfügbare Statusobjekte | Adapterliste |
| `printer.objects.subscribe` | JSON-RPC/WebSocket | Live-Status | Adapterstatus |
| `printer.objects.query` | JSON-RPC/WebSocket | gezielte Statusabfrage | teilweise |
| `printer.gcode.script` | JSON-RPC/WebSocket | G-Code-Konsole und Steuerung | seriell, sicher validieren |
| `server.files.list` | JSON-RPC/HTTP | Dateiansicht | SD-/Host-Dateien abhängig von Marlin |
| `server.files.metadata` | JSON-RPC/HTTP | aktuelle Datei | teilweise/abgeleitet |
| `server.files.upload` | HTTP multipart | Upload | Host-Dateiablage |
| `printer.print.start/pause/resume/cancel` | JSON-RPC | Workflow | G-Code-Makros |
| `server.database.*` | HTTP/JSON-RPC | Mainsail-Persistenz | lokale Datenbank |

Die vollständige maschinenlesbare Liste steht in
`docs/mainsail-api-requirements.json`. Sie enthält nur im Quellcode
beobachtete Kernaufrufe; eine Bibliotheksfunktion ohne Aufrufpfad wurde nicht
als Muss-Anforderung aufgenommen.
