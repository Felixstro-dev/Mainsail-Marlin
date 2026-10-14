# Sicherheit

- Standardtests verwenden keinen seriellen Anschluss.
- Heiz-, Bewegungs- und Not-Aus-Befehle werden nicht automatisiert gesendet.
- Uploadpfade müssen relativ zum konfigurierten Root bleiben.
- Installationsskripte löschen keine variablen oder ungeprüften Pfade rekursiv.
- Tokens, Passwörter und private Konfigurationen werden nicht in Diagnose-
  ausgaben aufgenommen.
- Der Adapter sollte nicht als root laufen; der Upstream verweigert dies
  bereits in `marlinraker-marlin/src/Server.ts`.
- Eine echte Installation muss Authentifizierung, Netzwerkbindung, systemd-
  Benutzer und serielle Gruppen explizit konfigurieren.

Offen bleiben ein vollständiger Upload-Fuzztest, ein Netzwerk-Härtungstest und
eine Board-spezifische Prüfung der Not-Aus-/Reconnect-Semantik.
