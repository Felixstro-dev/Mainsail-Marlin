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

## NPM-Audit am 2026-10-14

`npm audit --omit=dev --json` wurde für beide Teilprojekte vollständig
ausgeführt. Es wurden keine pauschalen `npm audit fix --force`- oder
Framework-Major-Upgrades vorgenommen.

| Projekt | Produktionsmeldungen | Direkte Pakete | Wesentliche transitive Pfade | Entscheidung |
|---|---:|---|---|---|
| Marlinraker `v0.2.3-alpha` | 11: 1 kritisch, 6 hoch, 1 moderat, 3 niedrig | `express@^4.18.2`, `ws@^8.12.1` | `proxy-addr`, `body-parser`, `brace-expansion`, `minimatch`, `path-to-regexp`, `qs`, `send`, `serve-static` | offen; Updates verfügbar, aber Express-/ws-Kompatibilität und vollständige Regressionstests erforderlich |
| Mainsail `2.19.0` | 9: 1 hoch, 2 moderat, 6 niedrig | `echarts@^5.5.0`, `overlayscrollbars-vue`, `vue@^2.7.10`, `vuetify@^2.7.2`, `vuex` u.a. | über Vue und `vue-echarts` | offen; verfügbare Fixes sind überwiegend Major-Upgrades auf Vue 3/Vuetify 3/4 oder ECharts 6 |

Die kritischste Backend-Meldung betrifft `proxy-addr` (IP-Spoofing,
CVSS 9.1), die hoch eingestuften direkten Pfade betreffen außerdem `ws` und
Express-abhängige DoS-/ReDoS-Ketten. Die Frontend-Hochmeldung betrifft
`vuetify`-Prototype-Pollution; der kompatible Fix ist kein kleiner
Versionssprung. Der native `diskusage`-Baustein wurde dagegen entfernt, weil
er unter Node.js 25 nicht baubar war; `fs.promises.statfs` benötigt keine
native Kompilierung.
Die bestätigte HIGH-Dateipfad-Schwachstelle wurde behoben: Dateioperationen
kanonisieren Clientpfade und erlauben nur Ziele unter `rootDir/gcodes` oder
`rootDir/config`; absolute Pfade und `..`-Traversal werden abgewiesen.

Die verbleibenden Audit-Meldungen wurden nicht automatisch mit
Major-Upgrades verändert. Ihre Behebung erfordert weiterhin kontrollierte
Express-/ws- beziehungsweise Vue-/Vuetify-Upgrades mit separater
Kompatibilitätsprüfung.
