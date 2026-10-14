# Update und Wiederherstellung

`scripts/update.sh` erstellt vor dem Update ein datiertes Backup und aktualisiert
nur die vorgesehenen Arbeitskopien. Benutzerkonfiguration und Druckdateien
bleiben außerhalb der Release-Artefakte. Bei einem fehlgeschlagenen Build wird
der Fehler protokolliert; eine automatische Rollback-Garantie besteht erst,
wenn die Update-Tests auf einem isolierten System ausgeführt wurden.

```sh
sudo ./scripts/update.sh --prefix /opt/mainsail-marlin --dry-run
```
