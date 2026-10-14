# Moonraker-Analyse

Quelle: Moonraker Commit `9e676eba6b02661a4dfa3ec6e7ac3f3504498e6d`.

Moonraker registriert HTTP-Endpunkte und JSON-RPC-Methoden komponentenweise.
Die Kernverbindung zu Klipper liegt in
`moonraker/components/klippy_connection.py`; die Klipper-API wird in
`moonraker/components/klippy_apis.py` gekapselt. Datei- und Metadatenzugriff
liegen in `components/file_manager/`, Historie in `components/history.py`,
Datenbank in `components/database.py`.

## Relevante Verträge

- WebSocket: JSON-RPC 2.0 mit numerischer ID, `result`/`error` und
  serverseitigen Notifications.
- `server.info`: Server-/Klippy-Verbindungszustand.
- `printer.objects.*`: Klipper-Objektliste, Subscription und Query.
- `printer.gcode.script`: Weitergabe von G-Code an Klipper.
- `server.files.*`: Host-Dateien, Metadaten, Upload, Verschieben und Löschen.
- `server.database.*`: persistente Namespaces für Mainsail.
- `server.history.*`: historische Druckdaten.

## Klipper-Abhängigkeit

Moonraker selbst kann HTTP, WebSocket, Datenbank und Host-Dateien bereitstellen.
Druckerobjekte, G-Code-Abarbeitung, Temperatur- und Toolheadstatus werden
jedoch in der Standardarchitektur von Klipper geliefert. Diese Trennung ist
für Mainsail-Marlin entscheidend: Der Adapter darf nur Statusfelder liefern,
die aus Marlin-Antworten, Host-Tracking oder Konfiguration sicher stammen.

## Fehlerformat

Moonraker antwortet bei JSON-RPC-Fehlern mit einem Fehlerobjekt. HTTP-Routen
verwenden statusabhängige Antworten. Der bestehende Marlinraker verwendet
Moonraker-artige Fehlerantworten, muss aber weiterhin Parameterprüfung und
Pfadvalidierung gegen reale Uploads testen.
