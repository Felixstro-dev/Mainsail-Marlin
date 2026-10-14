# Installation

Das Installationsskript ist für Debian-/Ubuntu-Systeme einschließlich
Raspberry Pi OS vorgesehen. Es installiert fehlende Systemabhängigkeiten
automatisch über `apt-get`, einschließlich nginx, Python 3, Build-Werkzeugen
und `libudev-dev`. Wenn kein kompatibles Node.js vorhanden ist, wird Node.js
22 über das NodeSource-Repository eingerichtet. Für diesen Schritt werden
Internetzugriff und root-Rechte benötigt.

Die empfohlene Installation direkt von GitHub ist:

```sh
curl -fsSL https://raw.githubusercontent.com/Felixstro-dev/Mainsail-Marlin/master/scripts/install-online.sh | bash
```

Der One-Liner lädt den aktuellen `master`-Stand in ein temporäres Verzeichnis
und führt danach den Installer aus. Die temporären Dateien werden nach dem
Installationslauf entfernt; fehlende root-Rechte werden über `sudo` angefordert.
Für einen Probelauf oder abweichende Optionen
können Argumente an `bash` übergeben werden:

```sh
curl -fsSL https://raw.githubusercontent.com/Felixstro-dev/Mainsail-Marlin/master/scripts/install-online.sh \
  | bash -s -- --dry-run
curl -fsSL https://raw.githubusercontent.com/Felixstro-dev/Mainsail-Marlin/master/scripts/install-online.sh \
  | bash -s -- --serial-group dialout
```

Der Installer verwendet standardmäßig den Branch `master`. Ein anderer Branch
kann über `MAINSAIL_MARLIN_REF` gewählt werden.

```sh
sudo ./scripts/install.sh --prefix /opt/mainsail-marlin --serial-group dialout
```

Vor der Installation kann der geplante Ablauf ohne Änderungen geprüft werden:

```sh
sudo ./scripts/install.sh --dry-run
```

Das Skript legt vor Änderungen Sicherungen an, ist wiederholbar und verweigert
standardmäßig unsichere Pfade. `dialout` wird automatisch verwendet, sofern
die Gruppe auf dem Zielsystem vorhanden ist. Mit `--serial-group GROUP` kann
eine andere serielle Gruppe gewählt werden; die passende Gruppe kann mit
`stat -c '%G' /dev/serial/by-id/*` ermittelt werden. Wenn keine serielle
Gruppe angegeben oder automatisch gefunden wird, wird keine serielle
Berechtigung eingerichtet.

Der Dienst und nginx werden installiert, aktiviert und nach erfolgreichem Build
automatisch gestartet. Der Installer sendet dabei keine Druck- oder
Heizbefehle; er startet nur den Adapter und dessen Weboberfläche.

```sh
sudo systemctl status mainsail-marlin.service
sudo systemctl status nginx
```

Ein Update des installierten Systems ist mit einem Befehl möglich:

```sh
curl -fsSL https://raw.githubusercontent.com/Felixstro-dev/Mainsail-Marlin/master/scripts/update-online.sh | bash
```

Das Update lädt den aktuellen Branch, erstellt ein Backup, stoppt den Adapter,
installiert Abhängigkeiten neu, baut Frontend und Backend, validiert nginx und
startet die Dienste wieder. Ein Probelauf ist ebenfalls möglich:

```sh
curl -fsSL https://raw.githubusercontent.com/Felixstro-dev/Mainsail-Marlin/master/scripts/update-online.sh \
  | bash -s -- --dry-run
```

Die reale Raspberry-Pi-Unterstützung ist noch `UNTESTED`; es wurde kein Image
und keine saubere Pi-Installation erzeugt. Der automatisierte Ablauf ist für
Debian/Ubuntu mit systemd, nginx und apt-get vorgesehen.

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
