# Marlinraker-Analyse

Quelle: Marlinraker Commit `68d35be4e4a10c98e1f3255d9d83c40e04e0ed6c`.

## Bestand

- `src/Server.ts`: Express-App, WebSocket-Server auf `/websocket`,
  Konfiguration und statische Auslieferung.
- `src/api/SocketHandler.ts`: JSON-RPC-Dispatcher und Notifications.
- `src/api/HttpHandler.ts`: HTTP-Methoden und Datei-Handler.
- `src/printer/SerialGcodeDevice.ts`: serielle Verbindung, eine aktive
  Kommandoanfrage, Warteschlange, Timeout der Verbindungsinitialisierung.
- `src/printer/ParserUtil.ts`: Marlin-Antwort- und G-Code-Parser.
- `src/printer/Printer.ts`: Watcher, Zustandsänderungen, Handshake und
  Klipper-Kompatibilitätsobjekte.

## Festgestellte Risiken

Der serielle Abschluss wird über `ok` erkannt; Firmwaremeldungen während einer
Anfrage müssen korrekt vom Antwortpuffer getrennt werden. Der Upstream setzt
außerdem ein vorhandenes serielles Gerät voraus und besitzt im betrachteten
Stand kein ausführbares Unit-Test-Setup. Diese Arbeit ergänzt deshalb
hardwarefreie Parser-Regressionstests, ohne die serielle Initialisierung im
Standardtest zu öffnen.

Die vorhandenen HTTP- und WebSocket-Executoren werden nicht pauschal als
semantisch korrekt markiert. Die Matrix unterscheidet implementiert,
ungetestet und nur teilweise übertragbar.
