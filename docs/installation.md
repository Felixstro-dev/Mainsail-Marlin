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
