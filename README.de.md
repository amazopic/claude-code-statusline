# 🛰️ Claude Code Status Line

> Eine durchdachte, hackbare Statuszeile für Claude Code — Kontextbalken, Rate Limits, Kosten, Modell und mehr — alles in einer schön gefärbten Zeile.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-mitwirken)

**Sprachen:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · Deutsch · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## Warum?

Die Standard-Statuszeile von Claude Code ist sparsam. Dieser Drop-in-Ersatz macht daraus ein **Dashboard auf einen Blick** für jede Session:

- 🔋 Wie viel Kontext habe ich verbraucht? (sanfte Bruchteilbalken in 1,25-%-Schritten)
- 💰 Was kostet mich diese Session?
- 🚦 Wie nah bin ich an meinen Limits?
- 🧠 Welches Thinking-Level / Modell ist aktiv?
- 🌿 Auf welchem Git-Branch bin ich?

Alles in **einer Zeile**, farbcodiert, mit klugen Icons, die Dringlichkeit signalisieren.

## ✨ Funktionen

- 🪐 **Live-Kontextbalken** — 10 Zellen mit Sub-Zellen-Präzision (Quadrant- oder vertikale Bruch-Glyphen)
- 🧠 **Modellname** — mit `(1M)`-Indikator für 1M-Kontext-Varianten
- 💸 **Session-Kosten** in USD, bei jedem Render aktualisiert
- ⬆️⬇️ **Token-Zähler** der letzten Nachricht (Input / Output)
- 🚦 **Rate Limits** — 5h / 7d mit ⚠️-Warnung bei > 50 %
- 🔄 **API-Modus-Fallback** — wenn keine Limits durchgereicht werden, zeigt es die gesamten Session-Tokens (`tokens: NNN K`) mit schmalem Leerzeichen als Tausendertrenner
- 🚀 **Smartes Status-Icon** — 🚀 < 40 %, 🚗 40–49 %, ⚠️ ≥ 50 %
- 🎨 **256-Farben-ANSI** — kräftige, klare Farben pro Segment
- 🧩 **Steckbare Balken-Stile** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), oder eigener in 10 Zeilen Bash
- ⚡ **Leichtgewichtig** — nur `bash` + `jq`. Kein Node, kein Python, kein Daemon, keine Telemetrie

## 🚀 Installation

### Manuell (3 Schritte)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

Dann zu `~/.claude/settings.json` hinzufügen:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<du>/.claude/statusline.sh"
  }
}
```

Claude Code neu starten (oder `/config` reload).

### Installation via Claude Code Agent (mit automatischem Backup)

Claude Code soll es sicher für dich installieren? Diesen Prompt einfügen:

> „Installiere die Statuszeile aus diesem Repo als meine aktive Claude-Code-Statuszeile:
> 1. Falls `~/.claude/statusline.sh` bereits existiert, sichere es nach
>    `~/.claude/statusline.sh.bak.<YYYYMMDD-HHMMSS>` (nutze ein freies
>    `-N`-Suffix, falls ein Backup mit dem Namen existiert).
> 2. Kopiere `statusline.sh` aus dem Repo nach `~/.claude/statusline.sh`
>    und `chmod +x`.
> 3. Lies `~/.claude/settings.json`. Falls kein `statusLine`-Schlüssel
>    existiert, füge einen Block mit dem absoluten Pfad zum Skript hinzu.
>    Falls `statusLine` schon woanders hin zeigt, sichere zuerst
>    `settings.json` nach `.bak.<timestamp>`.
> 4. Smoke-Test:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/statusline.sh`
> 5. Sag mir, ich soll Claude Code neu starten und nenne die erstellten Backups."

### Voraussetzungen

- `bash` 4+ (das Skript nutzt 0-indizierte Arrays — **nicht unter `zsh` ausführen**)
- `jq` für JSON-Parsing
- 256-Farben-Terminal (im Grunde jedes moderne)

## ⚙️ Konfiguration

Konstanten am Anfang von `statusline.sh` bearbeiten:

| Variable / Funktion | Was sie steuert |
|---|---|
| `BAR_STYLE` | `"quadrant"` (Standard, 2,5 % Schritt) oder `"vertical"` (1,25 % Schritt) |
| `pct_icon()` | Schwellen für 🚀 / 🚗 / ⚠️-Icons vor dem Balken |
| `pct_color()` | Farb-Schwellen für Prozent / Balken |
| ANSI-Farb-Konstanten | Jedes Segment einfärben (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Plugin-Methodik — eigener Balkenstil in 10 Zeilen

Jeder Stil ist eine eigenständige Funktion `bar_<name>(pct)`, die einen
String aus genau 10 sichtbaren Zellen zurückgibt:

```bash
bar_dotted() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="●"; done
  for (( i=0; i<10-cells;  i++ )); do s+="·"; done
  printf '%s' "$s"
}
```

Dann im `bar()`-Dispatcher registrieren:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

Das war's. Funktions-Vertrag:

- Eingabe: ganze Zahl `pct` `0..100` (bereits geclampt)
- Ausgabe: genau 10 sichtbare Zellen
- Rundung zum **nächsten** Sub-Schritt (nicht floor), damit der Balken nicht hängenbleibt

PRs mit neuen Stilen sind sehr willkommen.

### Mehr Prompt-Beispiele

<details>
<summary>Prompt-Vorlagen zum Hinzufügen von Stilen, Segmenten und Anpassungen</summary>

#### Stil `shaded` (4 Stufen: `░ ▒ ▓ █`)

> „Füge einen `shaded`-Balkenstil hinzu: 4 Stufen pro Zelle — `░ ▒ ▓ █`
> (light → medium → dark → full), 2,5 % Schritt. Gleiche Rundungsregel
> wie `bar_quadrant`. Aktivierung über `BAR_STYLE=\"shaded\"`."

#### Stil `dotted` als Fallback

> „Füge einen `dotted`-Stil für Terminals ohne Block-Zeichen hinzu:
> 10 Zellen, gefüllt = `●`, leer = `·`, keine Sub-Stufen (10 % Schritt)."

#### Schwellen-Färbung des Balkens

> „In `bar()` nach Generierung des Strings färbe ihn je nach Prozent ein:
> < 50 % grün (`$GR`), 50–69 % gelb (`$Y`), ≥ 70 % rot (`$R`).
> Muss für jeden `BAR_STYLE` funktionieren."

#### Neues Segment: Python virtualenv

> „Füge ein neues Segment vor `${git_part}` hinzu: aktueller Python
> virtualenv-Name aus `$VIRTUAL_ENV` (basename), magenta (`$M`).
> Falls leer, Segment und sein `${SEP}` weglassen."

#### Icon-Schwellen anpassen

> „In `pct_icon` einen vierten Schwellenwert hinzufügen: ≥ 80 % gibt `🔥`
> zurück. Bestehende Icons behalten, neu anordnen: < 40 % 🚀, 40–59 % 🚗,
> 60–79 % ⚠️, ≥ 80 % 🔥."

</details>

## 🤝 Mitwirken

PRs sind sehr willkommen! Besonders:

- 🎨 Neue `bar_<style>`-Varianten (Sparklines, Anzeigen, ASCII-Art…)
- 🧱 Neue Segmente (kubectl-Kontext, Python venv, AWS-Profil, Akku, Wetter…)
- 🌍 Mehr README-Übersetzungen
- 🐛 Bugfixes für Edge Cases (riesige Transkripte, exotische Terminals)

Bei größeren Änderungen vorher ein Issue öffnen.

## 📜 Lizenz

[Source-Available](LICENSE) — mach was du willst, Erwähnung wird geschätzt, ist aber nicht erforderlich.

## ⭐ Nützlich gefunden?

Wenn du stundenlang auf Claude Code starrst, kannst du auch auf eine schöne Statuszeile starren. **Gib dem Repo einen ⭐**, damit andere es finden!

---

Mit ❤️ für die Claude Code Community.

---

## Autor / Lizenz / Kontakt

- **Autor:** Yevgeniy Achin
- **Lizenz:** [Source-Available License](LICENSE) — Source-Available — Wiederverwendung nur mit schriftlicher Genehmigung des Autors
- **Kontakt:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 All-in-one Bundle (`statusline-bundle.sh`)

Sie wollen keine 40+ Dateien verwalten? Nehmen Sie das **einzelne gebündelte Skript** `statusline-bundle.sh` — es enthält alle Themes, alle Blöcke und einen CLI-Konfigurator in einer Datei.

```bash
cp statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

~/.claude/statusline.sh use cyberpunk            # switch theme
~/.claude/statusline.sh use cyberpunk-compact    # compact variant
~/.claude/statusline.sh custom model context-bar git cost
~/.claude/statusline.sh list                     # list themes
~/.claude/statusline.sh list blocks              # list blocks
~/.claude/statusline.sh preview anime            # preview without saving
~/.claude/statusline.sh show                     # show current
~/.claude/statusline.sh reset                    # reset to default
```

Die Konfiguration wird in `~/.claude/statusline.conf` gespeichert und bleibt über Neustarts erhalten. Dieselbe Datei dient sowohl als **Renderer** (wenn Claude Code JSON über stdin sendet) als auch als **Konfigurator** (wenn Sie sie mit Argumenten aufrufen).

### Slash-Befehl `/statusline`

Legen Sie `commands/statusline.md` in `~/.claude/commands/` ab — der Befehl `/statusline` wird in Claude Code verfügbar:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Danach können Sie in jeder Claude Code Session tippen:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Shell-Alias (optional)

```bash
alias statusline='~/.claude/statusline.sh'
```

Dann funktioniert `statusline cyberpunk` von jedem Terminal aus.

---

## ⚡ Schnellstart

Der schnellste Weg — gebündeltes All-in-one-Skript mit eingebautem CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
~/.claude/statusline.sh use cyberpunk          # oder: anime, hacker, minimal, …
```

Dann zu `~/.claude/settings.json` hinzufügen:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<du>/.claude/statusline.sh" } }
```

Claude Code neu starten (oder `/config` reload). Fertig.

## 🆚 Vergleich mit der Standard-Statuszeile von Claude Code

| Funktion | Standard | Dieses Projekt |
|---|---|---|
| Aktiver Modellname | ✅ | ✅ (mit `(1M)`-Markierung für 1M-Kontextvarianten) |
| Kontextfenster: % verbraucht | ❌ | ✅ live, 1,25 % Präzision |
| Kontext-Fortschrittsbalken | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Session-Kosten in USD | ❌ | ✅ bei jedem Render aktualisiert |
| Token-Zähler Eingabe/Ausgabe | ❌ | ✅ |
| Gesamt-Session-Tokens (API-Modus-Fallback) | ❌ | ✅ |
| Rate-Limit-Indikatoren 5h / 7d mit ⚠️ bei > 50 % | ❌ | ✅ |
| Git-Branch + dirty + ahead/behind | ❌ | ✅ |
| Zeit-am-Task (active vs wall) | ❌ | ✅ |
| Thinking / Effort-Level | ❌ | ✅ |
| Vorgefertigte Themes | ❌ | ✅ 20 Themes × 2 Varianten = **40 fertig** |
| Komposition aus benannten Blöcken | ❌ | ✅ 18 Blöcke, siehe [BLOCKS.md](BLOCKS.md) |
| Eingebauter CLI-Konfigurator | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` Slash-Befehl | ❌ | ✅ optional, siehe [`commands/`](commands/) |
| Abhängigkeiten | — | `bash` 4+ und `jq` (kein Node, Python, Daemon) |

## 💡 Anwendungsfälle

- **„Wie viel meines 1-M-Kontexts habe ich verbraucht?"** — Live-Prozent + Balken vor jedem Prompt.
- **„Was kostet mich diese Claude-Code-Session?"** — laufende USD-Summe, bei jedem Render aktualisiert.
- **„Werde ich heute ein Rate-Limit erreichen?"** — 5h / 7d-Indikatoren mit ⚠️ bei > 50 %.
- **„Bin ich auf dem richtigen Branch?"** — Git-Branch + dirty + ahead/behind in der Statuszeile.
- **„Wie viele tatsächliche Stunden habe ich an diesem Feature gearbeitet?"** — Zeittracker (`active` vs `wall`).
- **„Ich will ein lustiges Terminal."** — Anime, Cyberpunk, Hacker, Retro, Weather, Ocean, Fire-Themes.
- **„Ich brauche eine minimale ASCII-Statuszeile für Bildschirmaufnahmen."** — Theme `zen`.

## ❓ Häufig gestellte Fragen (FAQ)

### Was ist Claude Code Status Line?

Ein bash-basierter Ersatz für die Standard-Statuszeile in [Claude Code](https://claude.com/claude-code) (Anthropics CLI). Macht aus der unteren Zeile ein echtes Dashboard: Modell, Kontext %, Fortschrittsbalken, Session-Kosten, Limits, Git, Zeit und mehr.

### Wie wird es installiert?

`statusline-bundle.sh` nach `~/.claude/statusline.sh` kopieren, `chmod +x`, dann den `statusLine.command` in `~/.claude/settings.json` auf diesen Pfad setzen.

### Unterstützt es 1-M-Kontextmodelle?

Ja. Das Skript erkennt `[1m]` in der model id und `1M` im display name, passt den Nenner auf 1 000 000 Tokens an.

### Mit welchen Modellen funktioniert es?

Mit jedem von Claude Code unterstützten Modell — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 usw.

### Kann ich Farben, Themes anpassen oder eigene hinzufügen?

Ja, auf drei Arten: (1) eines der **40 fertigen Varianten** in [`examples/`](examples/) wählen, (2) eigene aus benannten Blöcken zusammenbauen — siehe [BLOCKS.md](BLOCKS.md), (3) Farbkonstanten in `statusline.sh` direkt ändern.

### Wird Claude Code langsamer?

Nein. Typischer Render ≤ 50 ms.

### Funktioniert es ohne `jq`?

`jq` ist erforderlich. Installation: `brew install jq` (macOS) oder `apt install jq` (Debian/Ubuntu).

### Funktioniert es unter Windows / macOS / Linux?

Ja auf allen. Unter Windows — über Git Bash, WSL, MSYS2 oder Cygwin.

### Kann ich es mit der reinen Anthropic-API verwenden?

Teilweise. Limits-Indikatoren wechseln automatisch zur Gesamt-Session-Token-Anzeige (`tokens: NNN K`).

### Wo wird die Konfiguration gespeichert?

`~/.claude/statusline.conf` — kleine Shell-Source-Datei. Bleibt über Neustarts erhalten.

### Ist es kostenlos? Kann ich es kommerziell nutzen?

Persönliche lokale Nutzung ist kostenlos (siehe [Source-Available License](LICENSE)). Jede Wiederverwendung erfordert die **vorherige schriftliche Genehmigung** des Autors (amazopic@gmail.com).

### Wie kehre ich zur Standard-Statuszeile zurück?

`statusLine`-Block aus `~/.claude/settings.json` entfernen oder `~/.claude/statusline.sh reset` ausführen.

## 🏷️ Empfohlene GitHub Topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
