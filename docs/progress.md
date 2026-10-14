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

## Offene Punkte

- Frontend und Adapter wurden noch nicht gemeinsam gegen einen laufenden Simulator verbunden.
- HTTP-/WebSocket-Vertrags- und Workflowtests gegen einen gestarteten Adapter fehlen.
- Raspberry-Pi-Neuinstallation, echter Dienststart, Browser-E2E und `shellcheck` sind nicht ausgeführt.
- KIAUH-Erweiterung ist wegen der Klipper-zentrierten Zielarchitektur noch nicht implementiert.
- npm-Audit meldet offene transitive Schwachstellen; vor einem Release ist eine
  kontrollierte Dependency-Überarbeitung erforderlich.
- Echte Board-/Marlin-Konfigurationen, Baudraten und Druckabläufe sind ungetestet.

## Testergebnisse

- Backend: 4/4 Parser-Unit-Tests bestanden; Build mit ESLint, TypeScript und
  esbuild bestanden.
- Frontend: 46/46 Unit-Tests, Lint und Produktionsbuild bestanden.
- API-JSON validiert; Shell-Syntax und Installations-Dry-Runs bestanden.
- Keine Hardwaretests und kein echter Installations-/Diensttest.

## Nächster konkreter Schritt

Als nächstes einen vollständig hardwarefreien HTTP-/WebSocket-Simulator für
Marlinraker ergänzen oder die vorhandene Adapterinitialisierung testbar
isolieren, dann Mainsail gegen diesen Simulator verbinden und die Kern-Workflow-
Verträge aus der Matrix ausführen.
