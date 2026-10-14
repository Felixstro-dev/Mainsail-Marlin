# Fehlerdiagnose

1. `./scripts/diagnose.sh --prefix /opt/mainsail-marlin` ausführen.
2. Prüfen, ob der Adapter-Port erreichbar ist und `/server/info` antwortet.
3. Serielle Geräte und Berechtigungen mit `ls -l /dev/serial/by-id` prüfen.
4. Adapterlogs ohne Tokens oder private Konfigurationswerte weitergeben.
5. Bei Firmwarefehlern die konkrete Marlin-Version und die aktivierten
   Features aus `M115` und `Configuration.h` erfassen.

Ein Statusfeld darf nicht durch einen erfundenen Default als funktionsfähig
gemeldet werden. Fehlende Felder sind als Einschränkung zu behandeln.
