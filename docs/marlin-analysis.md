# Marlin-Analyse

Quelle: Marlin Commit `564f26cdc06203362935704f9487b270f11b8234`,
Branch `bugfix-2.1.x`.

Marlin ist eine konfigurationsabhängige C/C++-Firmware. Der Quellbaum enthält
PlatformIO-Konfigurationen für viele Boards, `Configuration.h` und
`Configuration_adv.h` als zentrale Feature-Schalter sowie serielle
Dokumentation unter `docs/Serial.md`.

## Adapterrelevante Befehle

| Befehl | Zweck | Verlässlichkeit |
|---|---|---|
| `M115` | Firmwarekennung und Capabilities | gut, wenn aktiviert |
| `M105` | Temperaturen und Targets | gut, Antwortformat kann variieren |
| `M114` | Position | firmware-/Konfigurationsabhängig |
| `M119` | Endstopstatus | verfügbar, wenn Endstopabfrage aktiv |
| `M20` | SD-Dateiliste | nur bei aktivierter SD-Unterstützung |
| `M73` | Fortschritt | nicht auf allen Konfigurationen aktiv |
| `M112` | Not-Aus | sicherheitskritisch, nicht im Standardtest |

Temperatur, Position und Dateiliste werden in Marlinraker über Parser und
Watcher normalisiert. Druckhistorie und Dateimetadaten sind keine garantiert
von Marlin gelieferten Informationen.

## Hardwaregrenze

Ohne Board, `Configuration.h`, angeschlossene Peripherie und reale Firmware
wurde keine Hardwarebehauptung verifiziert. Jeder Hardwaretest muss ein
separates Profil verwenden und darf nicht Teil des Standard-CI-Laufs sein.
