# 🛰️ Claude Code Status Line

> Una status line raffinata e personalizzabile per Claude Code — barra del contesto, limiti, costi, modello e altro — tutto in una singola riga colorata.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-contribuire)

**Lingue:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · Italiano · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## Perché?

La status line predefinita di Claude Code è essenziale. Questa sostituzione la trasforma in una **dashboard a colpo d'occhio** per ogni sessione:

- 🔋 Quanto contesto ho consumato? (barre frazionarie fluide a passo 1,25%)
- 💰 Quanto mi sta costando questa sessione?
- 🚦 Quanto sono vicino ai miei limiti?
- 🧠 Quale livello di thinking / modello è attivo?
- 🌿 Su quale branch git mi trovo?

Tutto in **una sola riga**, color-coded, con icone intelligenti che segnalano l'urgenza.

## ✨ Funzionalità

- 🪐 **Barra contesto live** — barra di 10 celle con precisione sub-cella (glifi quadranti o verticali frazionari)
- 🧠 **Nome modello** — con indicatore `(1M)` per le varianti a contesto 1M
- 💸 **Costo sessione** in USD, aggiornato a ogni rendering
- ⬆️⬇️ **Contatori token** dell'ultimo messaggio (input / output)
- 🚦 **Limiti rate** — 5h / 7d con avviso ⚠️ oltre il 50%
- 🔄 **Fallback in modalità API** — quando i limiti non vengono trasmessi, mostra i token totali della sessione (`tokens: NNN K`) con spazio sottile come separatore delle migliaia
- 🚀 **Icona di stato intelligente** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50%
- 🎨 **ANSI a 256 colori** — colori vivaci e distinti per ogni segmento
- 🧩 **Stili di barra a plugin** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), o crea il tuo in 10 righe di bash
- ⚡ **Leggero** — puro `bash` + `jq`. Niente Node, niente Python, niente daemon, niente telemetria

## 🚀 Installazione

### Manuale (3 passaggi)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

Poi aggiungi a `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<tu>/.claude/statusline.sh"
  }
}
```

Riavvia Claude Code (o esegui `/config` reload).

### Installazione tramite agente Claude Code (con backup automatico)

Vuoi che Claude Code lo installi in sicurezza? Incolla questo prompt:

> «Installa la status line da questo repo come mia status line attiva di Claude Code:
> 1. Se `~/.claude/statusline.sh` esiste già, fai un backup in
>    `~/.claude/statusline.sh.bak.<YYYYMMDD-HHMMSS>` (usa un suffisso
>    `-N` libero se un backup con quel nome esiste già).
> 2. Copia `statusline.sh` dal repo in `~/.claude/statusline.sh` e `chmod +x`.
> 3. Leggi `~/.claude/settings.json`. Se non c'è la chiave `statusLine`,
>    aggiungi un blocco `statusLine` che punta al percorso assoluto dello
>    script. Se `statusLine` esiste ma punta altrove, fai prima il backup
>    di `settings.json` in `.bak.<timestamp>`.
> 4. Smoke test:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/statusline.sh`
> 5. Dimmi di riavviare Claude Code e segnala i backup creati.»

### Requisiti

- `bash` 4+ (lo script usa array indicizzati a 0 — **non eseguire sotto `zsh`**)
- `jq` per il parsing JSON
- Un terminale a 256 colori (praticamente qualsiasi terminale moderno)

## ⚙️ Configurazione

Modifica le costanti in cima a `statusline.sh`:

| Variabile / funzione | Cosa controlla |
|---|---|
| `BAR_STYLE` | `"quadrant"` (default, passo 2,5%) o `"vertical"` (passo 1,25%) |
| `pct_icon()` | Soglie per le icone 🚀 / 🚗 / ⚠️ prima della barra |
| `pct_color()` | Soglie di colore per percentuale / barra |
| Costanti colore ANSI | Ricolorare qualsiasi segmento (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Metodologia plugin — il tuo stile di barra in 10 righe

Ogni stile è una funzione autonoma `bar_<nome>(pct)` che ritorna una
stringa di esattamente 10 celle visibili:

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

Poi registralo nel dispatcher `bar()`:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

Tutto qui. Contratto della funzione:

- Input: intero `pct` `0..100` (già clampato)
- Output: esattamente 10 celle visibili
- Arrotondamento al sotto-passo **più vicino** (non floor) per evitare che la barra si blocchi

PR con nuovi stili sono molto graditi.

### Altri esempi di prompt

<details>
<summary>Template di prompt per aggiungere stili, segmenti e ritocchi</summary>

#### Stile `shaded` (4 livelli: `░ ▒ ▓ █`)

> «Aggiungi uno stile di barra `shaded`: 4 livelli per cella — `░ ▒ ▓ █`
> (light → medium → dark → full), passo 2,5%. Stessa regola di
> arrotondamento di `bar_quadrant`. Attivazione tramite `BAR_STYLE="shaded"`.»

#### Stile `dotted` di fallback

> «Aggiungi uno stile `dotted` per terminali senza supporto ai blocchi:
> 10 celle, piena = `●`, vuota = `·`, senza sotto-livelli (passo 10%).»

#### Colorazione barra per soglie

> «In `bar()`, dopo aver generato la stringa, avvolgila in un colore
> in base alla percentuale: < 50% verde (`$GR`), 50–69% giallo (`$Y`),
> ≥ 70% rosso (`$R`). Deve funzionare per qualsiasi `BAR_STYLE`.»

#### Nuovo segmento: virtualenv Python

> «Aggiungi un segmento prima di `${git_part}`: nome del virtualenv
> Python corrente da `$VIRTUAL_ENV` (basename), colore magenta (`$M`).
> Se vuoto, ometti il segmento e il suo `${SEP}`.»

#### Aggiusta soglie icona

> «In `pct_icon` aggiungi una quarta soglia: ≥ 80% ritorna `🔥`.
> Mantieni le icone esistenti, riorganizza: < 40% 🚀, 40–59% 🚗,
> 60–79% ⚠️, ≥ 80% 🔥.»

</details>

## 🤝 Contribuire

Le PR sono molto benvenute! Specialmente:

- 🎨 Nuove varianti `bar_<style>` (sparklines, indicatori, ASCII art…)
- 🧱 Nuovi segmenti (contesto kubectl, virtualenv Python, profilo AWS, batteria, meteo…)
- 🌍 Più traduzioni del README
- 🐛 Bugfix per casi limite (transcript enormi, terminali esotici)

Per modifiche grandi apri prima un issue.

## 📜 Licenza

[Source-Available](LICENSE) — fai quello che vuoi, attribuzione gradita ma non richiesta.

## ⭐ Ti è piaciuto?

Se passi ore a fissare Claude Code, tanto vale fissare una bella status line. **Lascia una ⭐** al repo per aiutare gli altri a trovarlo!

---

Fatto con ❤️ per la community Claude Code.

---

## Autore / Licenza / Contatti

- **Autore:** Yevgeniy Achin
- **Licenza:** [Source-Available License](LICENSE) — Source-Available — riuso solo con autorizzazione scritta dell'autore
- **Contatti:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 Bundle all-in-one (`statusline-bundle.sh`)

Non vuoi gestire 40+ file? Prendi lo **script bundle singolo** `statusline-bundle.sh` — contiene tutti i temi, tutti i blocchi e un configuratore CLI in un solo file.

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

La configurazione è salvata in `~/.claude/statusline.conf` e persiste tra i riavvii. Lo stesso file funge sia da **renderer** (quando Claude Code gli passa JSON via stdin) sia da **configuratore** (quando lo chiami con argomenti).

### Comando slash `/statusline`

Metti `commands/statusline.md` in `~/.claude/commands/` — il comando `/statusline` sarà disponibile in Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Poi in qualsiasi sessione di Claude Code puoi digitare:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Alias di shell (opzionale)

```bash
alias statusline='~/.claude/statusline.sh'
```

Poi `statusline cyberpunk` funziona da qualsiasi terminale.

---

## ⚡ Avvio rapido

Il percorso più veloce — script bundle all-in-one con CLI integrato:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
~/.claude/statusline.sh use cyberpunk          # o: anime, hacker, minimal, …
```

Poi aggiungi a `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<tu>/.claude/statusline.sh" } }
```

Riavvia Claude Code (o `/config` reload). Fatto.

## 🆚 Confronto con la status line predefinita di Claude Code

| Capacità | Predefinito | Questo progetto |
|---|---|---|
| Nome del modello attivo | ✅ | ✅ (con marker `(1M)` per varianti 1M) |
| Finestra contesto: % usato | ❌ | ✅ live, precisione 1,25 % |
| Barra di progresso del contesto | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Costo della sessione in USD | ❌ | ✅ aggiornato a ogni rendering |
| Contatori token input/output | ❌ | ✅ |
| Token totali della sessione (fallback API) | ❌ | ✅ |
| Indicatori limiti 5h / 7d con ⚠️ a > 50 % | ❌ | ✅ |
| Branch git + dirty + ahead/behind | ❌ | ✅ |
| Tempo sull'attività (active vs wall) | ❌ | ✅ |
| Livello thinking / effort | ❌ | ✅ |
| Temi predefiniti | ❌ | ✅ 20 temi × 2 varianti = **40 pronti** |
| Composizione da blocchi nominati | ❌ | ✅ 18 blocchi, vedi [BLOCKS.md](BLOCKS.md) |
| Configuratore CLI integrato | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Comando slash `/statusline` Claude Code | ❌ | ✅ opzionale, vedi [`commands/`](commands/) |
| Dipendenze | — | `bash` 4+ e `jq` (no Node, Python, daemon) |

## 💡 Casi d'uso

- **«Quanto del mio contesto 1 M ho consumato?»** — percentuale e barra live prima di ogni prompt.
- **«Quanto mi sta costando questa sessione di Claude Code?»** — totale USD aggiornato a ogni rendering.
- **«Sto per raggiungere un limite oggi?»** — indicatori 5h / 7d con ⚠️ a > 50 %.
- **«Sono sul branch giusto?»** — branch git + dirty + ahead/behind nella status line.
- **«Quante ore reali ho passato su questa feature?»** — tracker tempo (`active` vs `wall`).
- **«Voglio un terminale divertente.»** — temi anime, cyberpunk, hacker, retro, weather, ocean, fire.
- **«Mi serve una status line ASCII minimale per le registrazioni.»** — tema `zen`.

## ❓ Domande frequenti (FAQ)

### Cos'è Claude Code Status Line?

Un sostituto bash della status line predefinita in [Claude Code](https://claude.com/claude-code) (CLI di Anthropic). Trasforma la linea in basso in una vera dashboard: modello, contesto %, barra di progresso, costo sessione, limiti, git, tempo e altro.

### Come si installa?

Copiare `statusline-bundle.sh` in `~/.claude/statusline.sh`, fare `chmod +x`, puntare `~/.claude/settings.json` → `statusLine.command` a quel percorso.

### Supporta i modelli con contesto 1 M?

Sì. Lo script rileva `[1m]` nel model id e `1M` nel display name, regola il denominatore a 1 000 000 token.

### Con quali modelli funziona?

Con qualsiasi modello supportato da Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, ecc.

### Posso personalizzare colori, temi o aggiungere i miei?

Sì, in tre modi: (1) scegliere tra **40 varianti pronte** in [`examples/`](examples/), (2) comporre la propria da blocchi nominati — vedi [BLOCKS.md](BLOCKS.md), (3) modificare le costanti di colore in `statusline.sh` direttamente.

### Rallenterà Claude Code?

No. Rendering tipico ≤ 50 ms.

### Funziona senza `jq`?

`jq` è richiesto. Installare: `brew install jq` (macOS) o `apt install jq` (Debian/Ubuntu).

### Funziona su Windows / macOS / Linux?

Sì su tutti. Su Windows — via Git Bash, WSL, MSYS2 o Cygwin.

### Posso usarlo con l'API Anthropic diretta?

Parzialmente. Gli indicatori di limiti passano automaticamente al display dei token totali di sessione (`tokens: NNN K`).

### Dove viene salvata la configurazione?

`~/.claude/statusline.conf` — piccolo file shell-source. Persiste tra i riavvii.

### È gratuito? Posso usarlo commercialmente?

Uso personale locale è gratuito (vedi [Source-Available License](LICENSE)). Qualsiasi riuso richiede **autorizzazione scritta preventiva** dell'autore (amazopic@gmail.com).

### Come torno alla status line predefinita di Claude Code?

Rimuovere il blocco `statusLine` da `~/.claude/settings.json` o eseguire `~/.claude/statusline.sh reset`.

## 🏷️ Topic GitHub consigliati

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
