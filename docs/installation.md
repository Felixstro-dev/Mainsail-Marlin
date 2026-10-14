# Installation

Die Installationsskripte sind für eine Debian-/Raspberry-Pi-ähnliche Umgebung
vorgesehen, aber noch nicht als vollständige Distribution-Matrix freigegeben.
Sie benötigen einen normalen Benutzer, Node.js gemäß den Mainsail-
Anforderungen, npm, Python 3 sowie systemd/nginx für eine echte Dienst-
Installation.

```sh
sudo ./scripts/install.sh --prefix /opt/mainsail-marlin
```

Das Skript legt vor Änderungen Sicherungen an, ist wiederholbar und verweigert
standardmäßig unsichere Pfade. Mit `--dry-run` können Voraussetzungen ohne
Änderung geprüft werden. Eine serielle Schnittstelle wird nur konfiguriert,
wenn sie ausdrücklich angegeben wird.

Die reale Raspberry-Pi-Unterstützung ist noch `UNTESTED`; es wurde kein Image
und keine saubere Pi-Installation erzeugt.

Marlinraker verwendet aktuell nicht mehr das native Paket `diskusage`. Die
Laufzeitabfrage des Dateisystems nutzt `fs.promises.statfs`, wodurch
`npm ci --ignore-scripts` und der Build auch unter der hier verwendeten
Node.js-Version 25 funktionieren. Für den hardwarefreien Integrationslauf kann der Adapter mit
`MARLINRAKER_FAKE_SERIAL=1 npm run dev.fake` gestartet werden. Fehlende
optionale Theme-Verzeichnisse werden als leere Verzeichnisse behandelt; es
sind keine erfundenen Produktions-Theme-Dateien erforderlich.

Nachgewiesen sind Syntaxprüfungen, Dry-Runs, die Servicevorlagenvalidierung
mit `systemd-analyze` und ein echter lokaler Adapterstart. nginx war in der
Testumgebung nicht installiert (`nginx -t` daher nicht ausführbar). Eine
saubere Linux-Neuinstallation, ein realer systemd-Dienststart und ein
Raspberry-Pi-Test bleiben offen.
