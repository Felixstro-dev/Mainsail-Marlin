# Mainsail-Marlin – Arbeitsfortschritt

Stand: 2026-10-14

## Verbindlicher Arbeitsplan

1. **Bestandsaufnahme und Recherche**
   - Arbeitsverzeichnis, vorhandene Änderungen und verfügbare Werkzeuge prüfen.
   - Mainsail, Moonraker, Marlinraker, Marlin und KIAUH aus offiziellen Quellen untersuchen.
   - Versionen, Commit-IDs, Lizenzen, Build- und Testverfahren erfassen.
2. **Architektur und Spezifikation**
   - Mainsail-Aufrufe und benötigte Moonraker-Verträge aus dem tatsächlichen Code ableiten.
   - Moonraker-/Klipper-Abhängigkeiten von Marlin-Fähigkeiten trennen.
   - Kompatibilitätsmatrix, Zielarchitektur und priorisierte Umsetzung dokumentieren.
3. **Backend-Grundlage**
   - Eine testbare Moonraker-kompatible Adapterbasis mit simuliertem seriellen Transport erstellen.
   - Parser, Statusnormalisierung, Datei-/Drucksteuerung, Fehler und Wiederverbindung implementieren.
4. **Frontend- und API-Kompatibilität**
   - Mainsail gegen den Adapter prüfen.
   - Nur zwingend notwendige Frontend-Anpassungen vornehmen.
5. **Tests und Qualität**
   - Unit-, API-, Workflow-, Schema-, JSON- und Shell-Tests ohne reale Hardware ausführen.
   - Fehlgeschlagene oder nicht mögliche Prüfungen ausdrücklich dokumentieren.
6. **Installation und Betrieb**
   - Idempotente Installations-, Update-, Deinstallations- und Diagnose-Skripte sowie Servicevorlagen erstellen.
   - Sicherheits- und Persistenzverhalten prüfen.
7. **KIAUH und Abschluss**
   - KIAUH-Erweiterbarkeit anhand des Quellcodes bewerten.
   - Dokumentation, Matrix und Abschlussbericht mit tatsächlichen Ergebnissen aktualisieren.

## Erledigt

- [x] Auftrag aus `prompt.md` vollständig gelesen.
- [x] Arbeitsverzeichnis geprüft: zunächst nur `prompt.md` vorhanden.
- [x] Impeccable-Kontext versucht; Launcher war in diesem Repository nicht vorhanden. Bestehende `PRODUCT.md`/`DESIGN.md` wurden nicht gefunden.
- [x] Ausgangslage und verbindlicher Arbeitsplan angelegt.
- [x] Upstream-Projekte getrennt geklont und Commit-Stände dokumentiert.
- [x] Mainsail-, Moonraker-, Marlin- und Marlinraker-Architektur sowie Kern-API-Verträge analysiert.
- [x] Mainsail-/Moonraker-Anforderungen, Architektur und Kompatibilitätsmatrix dokumentiert.
- [x] Mainsail- und Marlinraker-Arbeitskopien angelegt.
- [x] Marlinraker-Parser korrigiert: gemischte `M115`-Feldnamen und `ok`-präfixierte `M105`-Antworten.
- [x] Hardwarefreie Backend-Parser-Tests, CI-Grundlage, Installations-/Update-/Deinstallations-/Diagnoseskripte und Servicevorlagen ergänzt.
- [x] Frontend-Unit-Tests, Lint und Build ausgeführt: bestanden.
- [x] Backend-Unit-Tests und Build ausgeführt: bestanden.
- [x] JSON-, Shell-Syntax- und Skript-Dry-Run-Prüfungen ausgeführt: bestanden.
- [x] Deterministischer `FakeMarlinTransport` mit Fragmentierung, Verzögerung,
  Timeout-, Open-Fehler- und konfigurierbarem Disconnect-Modus ergänzt.
- [x] Native `diskusage`-Abhängigkeit wegen Inkompatibilität mit Node.js 25
  durch `fs.promises.statfs` ersetzt; Lockfile und Build aktualisiert.
- [x] Adapter im Fake-Modus tatsächlich auf Port 7125 gestartet und per HTTP
  sowie JSON-RPC-WebSocket geprüft.
- [x] Multipart-Upload, Dateiliste über `server.files.list`, Statusmeldungen,
  G-Code-Erfolg und kontrollierte Fehlerantworten live geprüft.
- [x] Mainsail mit laufendem Adapter verbunden. Fehlende
  `server.webcams.list`-Kompatibilität behoben; fehlende optionale
  Verzeichnisse werden ohne Theme-Fixtures sicher als leer behandelt.
- [x] Cypress-Browserintegration ergänzt: Dashboard, Druckerdaten,
  G-Code-Datei, Temperaturbereich, Konsole und Adapter-WebSocket werden
  geprüft.
- [x] NPM-Audits mit vollständigem JSON-Ergebnis untersucht; keine pauschalen
  Breaking Updates durchgeführt.

## Offene Punkte

- Pause/Resume/Cancel ändern im Fake-Workflow noch nicht belastbar
  `print_stats`/`virtual_sdcard`; die Methoden liefern aktuell nur die
  vorhandene kontrollierte Adapterantwort.
- Raspberry-Pi-Neuinstallation, echter Hardwarebetrieb und `shellcheck` sind
  nicht ausgeführt.
- KIAUH-Erweiterung ist wegen der Klipper-zentrierten Zielarchitektur noch nicht implementiert.
- npm-Audit meldet weiterhin offene Backend- und Frontend-Schwachstellen; vor
  einem Release ist eine kontrollierte Dependency-Überarbeitung erforderlich.
- Echte Board-/Marlin-Konfigurationen, Baudraten und Druckabläufe sind ungetestet.

## Testergebnisse

- Backend: 4/4 Parser-Unit-Tests bestanden; Build mit ESLint, TypeScript und
  esbuild bestanden.
- Frontend: 46/46 Unit-Tests, Lint und Produktionsbuild bestanden.
- API-JSON validiert; Shell-Syntax und Installations-Dry-Runs bestanden.
- Fake-Adapter: Start, HTTP, WebSocket und Mainsail-Browserintegration live
  bestanden; keine Hardwaretests und kein echter Installations-/Diensttest.
- `systemd-analyze verify deploy/mainsail-marlin.service`: bestanden.
- `nginx -t`: nicht ausführbar, da nginx in der Umgebung fehlt.
- Skript-Dry-Run: Install/Update/Uninstall bestanden; `diagnose.sh` kennt
  bewusst kein `--dry-run`, wurde stattdessen direkt mit Testprefix ausgeführt.
- Backend-Audit: 11 Produktionsschwachstellen (1 kritisch, 6 hoch,
  1 moderat, 3 niedrig). Frontend-Audit: 9 (1 hoch, 2 moderat, 6 niedrig).

## Nächster konkreter Schritt

Als nächstes die Fake-Druckzustandsmaschine für Datei-Druck, Pause, Fortsetzen
und Abbruch ergänzen und danach die vollständigen Installations- und
Wiederherstellungsfälle in einer frischen Linux-Umgebung ausführen.
