# 🛰️ Claude Code Status Line — 72 themes, configurable blocks, CLI

> Drop-in replacement for the **Claude Code** default status line: live **context window** usage with a smooth progress bar, **session cost** in USD, **5h / 7d rate-limit** warnings, **git branch** with dirty / ahead / behind counts, **time-on-task tracking**, and the active **model name** (with `(1M)` indicator for 1M-context variants) — all in one colorful Bash line. Ships with **72 ready-made themes** — top picks (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), classics (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), auto brands (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), more scientists (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), more anime (onepiece, ghibli), more Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), and OS themes (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos) and an **18-block library** to compose your own. Includes an all-in-one CLI configurator and a `/statusline` slash command for Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 144](https://img.shields.io/badge/variants-144-brightgreen.svg)](#-144-ready-made-variants--pick-one-and-go)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** English · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

> 💡 **Pro tip — Context control**: The fuller your context window, the **less effective** your conversation with Claude becomes — and the **faster** you burn through your 5h/7d limits. Clear or `/compact` whenever you cross **60%** to keep working efficiently.

## ⚡ Quick start

The fastest path — bundled all-in-one script with built-in CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

Then add to `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Restart Claude Code (or run `/config` reload). Done.

### or vibe-chill method · let Claude do it

Why touch a terminal when you have Claude Code? Paste this single prompt into your Claude Code session — Claude handles every step and asks before each command.

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>" }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> Just say `y` (yes) at every permission prompt. Done.


## Why a custom status line / status bar for Claude Code?

Claude Code's default status line is sparse. This drop-in replacement turns the bottom status bar into an **at-a-glance dashboard** for every session:

- 🔋 How much context have I burned? (smooth 1.25% fractional bars)
- 💰 What is this session costing me?
- 🚦 How close am I to my rate limits?
- 🧠 What thinking level / model am I on?
- 🌿 Which git branch am I on?

All in **one line**, color-coded, with smart icons that signal urgency.

## ✨ Features

- 🪐 **Live context bar** — 10-cell progress bar with sub-cell precision (quadrant or vertical fractional glyphs)
- 🧠 **Model name** — with `(1M)` indicator for 1M-context variants
- 💸 **Session cost** in USD, updated every render
- ⬆️⬇️ **Per-message token counters** (input / output)
- 🚦 **Rate limits** — 5h / 7d with ⚠️ warning when > 50%
- 🔄 **API-mode fallback** — when no rate limits are piped, shows total session tokens (`tokens: NNN K`) with thin-space thousand separators
- 🚀 **Smart status icon** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% context fill
- 🎨 **256-color ANSI** — bright, distinct color per segment
- 🧩 **Pluggable bar styles** — pick `quadrant` (▖▄▙█) or `vertical` (▏▎▍▌▋▊▉█), or roll your own in 10 lines of bash
- ⚡ **Lightweight** — pure `bash` + `jq`. No Node, no Python, no daemon, no telemetry

## 🎨 144 ready-made variants — pick one and go

Each theme ships in **two variants**:

- **Detailed** — full feature set (model, context bar, cost, tokens, git, time, mood icon, …)
- **Compact** — `model · context % + bar · branch` only

Apply with `~/.claude/status-line.sh use <name>` (append `-compact` for the compact variant).

### 🔝 Top picks (10) — most asked-for, cross-cultural

| Theme | Vibe |
|---|---|
| `cyberpunk`  | neon dystopia · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | phosphor-green Matrix terminal · `[SYS] :: ROOT@matrix#` |
| `dragonball` | Goku scaling: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | Konoha leaf orange · chakra meter · 🌀 rasengan |
| `pokemon`    | Pikachu yellow + pokeball red · HP bar |
| `ironman`    | 🦾 Stark red + arc-reactor gold |
| `spiderman`  | 🕷 webhead red + blue · with great context comes great cost |
| `einstein`   | chalkboard greens · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ electric purple + lightning yellow · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + Modena yellow |

### 🛠 Practical / Classic (19 themes)

| Theme | File / Apply |
|---|---|
| 🛠 minimal       | [`statusline-minimal.sh`](examples/statusline-minimal.sh) · `use minimal` |
| 🛠 developer     | [`statusline-developer.sh`](examples/statusline-developer.sh) · `use developer` |
| 🛠 time          | [`statusline-time.sh`](examples/statusline-time.sh) · `use time` |
| 🛠 zen           | [`statusline-zen.sh`](examples/statusline-zen.sh) · `use zen` |
| 🌈 rainbow       | [`statusline-rainbow.sh`](examples/statusline-rainbow.sh) · `use rainbow` |
| ✨ anime         | [`statusline-anime.sh`](examples/statusline-anime.sh) · `use anime` |
| 💖 love          | [`statusline-love.sh`](examples/statusline-love.sh) · `use love` |
| 🐱 cat           | [`statusline-cat.sh`](examples/statusline-cat.sh) · `use cat` |
| 🎄 christmas     | [`statusline-christmas.sh`](examples/statusline-christmas.sh) · `use christmas` |
| 🚀 space         | [`statusline-space.sh`](examples/statusline-space.sh) · `use space` |
| 🕹 retro         | [`statusline-retro.sh`](examples/statusline-retro.sh) · `use retro` |
| 🔥 fire          | [`statusline-fire.sh`](examples/statusline-fire.sh) · `use fire` |
| 🌊 ocean         | [`statusline-ocean.sh`](examples/statusline-ocean.sh) · `use ocean` |
| ☀ weather        | [`statusline-weather.sh`](examples/statusline-weather.sh) · `use weather` |
| ☕ coffee        | [`statusline-coffee.sh`](examples/statusline-coffee.sh) · `use coffee` |
| 🎵 music         | [`statusline-music.sh`](examples/statusline-music.sh) · `use music` |
| ⚔ game           | [`statusline-game.sh`](examples/statusline-game.sh) · `use game` |
| 🏴‍☠️ pirate       | [`statusline-pirate.sh`](examples/statusline-pirate.sh) · `use pirate` |

> Note: `cyberpunk` and `hacker` live in **Top picks** above — they're in the
> `examples/` folder too if you want a single-theme install.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Auto brands (15 more, top picks include `ferrari`)

Ship in `statusline-bundle.sh` only — pick any with `~/.claude/status-line.sh use <name>`.

| Region | Themes |
|---|---|
| 🇪🇺 Europe  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 America | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japan   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 Great scientists (8 more, top picks include `einstein` & `tesla`)

| Theme | Vibe |
|---|---|
| `newton`   | parchment ink, `🍎`, `F=ma` |
| `curie`    | radium green, `☢`, half-life meter |
| `darwin`   | naturalist green, `🐢`, HMS Beagle |
| `hawking`  | deep space violet, `🌌`, `t → ∞` |
| `galileo`  | sun gold, `🔭`, *eppur si muove* |
| `feynman`  | chalk-on-green, `〰`, `ψ → ψ'` |
| `turing`   | terminal green, `Ⓣ`, halting bar `1/0` |
| `davinci`  | sepia codex, `✎`, *Vitruvian* |

### ✨ Anime (3 more, top picks include `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 Marvel superheroes (8 more, top picks include `ironman` & `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Operating systems (10 themes)

| Theme | Vibe |
|---|---|
| `macos`   | 🍎 six-color Apple rainbow on chrome-grey |
| `windows` | ⊞ Fluent four-color tile + WINDOWS 11 cyan |
| `linux`   | 🐧 Tux black + orange beak |
| `ubuntu`  | ⊕ friend circle — orange + aubergine purple |
| `arch`    | ▲ pacman cyan · btw, I use arch |
| `debian`  | 🌀 red swirl · stable / sid / testing |
| `fedora`  | 🎩 Fedora hat blue · freedom + features |
| `kali`    | 🐉 Kali blue + offsec red · pwn-mode |
| `mint`    | 🌿 cinnamon mint green · the friendliest shell |
| `nixos`   | ❄ Nix blue snowflake · declarative, reproducible |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 72 themes works
```

**Browse them all in your terminal first** — every variant has a
pre-rendered preview in [`screenshots/`](screenshots/):

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (144 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

See [`examples/README.md`](examples/README.md) for the full table with
descriptions, and [`screenshots/README.md`](screenshots/README.md) for
how the previews are generated.

## 🧱 Build your own from blocks

Don't want to use a preset? Compose a custom status line from a library
of named blocks — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

See [**BLOCKS.md**](BLOCKS.md) for:

- the **catalog of blocks** (each one is a copy-pasteable bash snippet)
- the **style packs** (color palettes & separators from `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- a **3-step recipe** to build your own line: pick a style → list blocks
  → paste

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 All-in-one bundle (`statusline-bundle.sh`)

If you don't want to manage 40+ files, grab the **single bundled
script** [`statusline-bundle.sh`](statusline-bundle.sh) — it contains
every theme + every block + a CLI configurator in one file.

```bash
cp statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh

~/.claude/status-line.sh use cyberpunk            # switch theme
~/.claude/status-line.sh use cyberpunk-compact    # use compact variant
~/.claude/status-line.sh custom model context-bar git cost  # compose from blocks
~/.claude/status-line.sh list                     # list themes
~/.claude/status-line.sh list blocks              # list blocks
~/.claude/status-line.sh preview anime            # preview without saving
~/.claude/status-line.sh show                     # show current config
~/.claude/status-line.sh reset                    # reset to default
```

Configuration is saved to `~/.claude/statusline.conf` and persists
across restarts. The same file acts as both **the renderer** (when
called by Claude Code with JSON on stdin) and **the configurator**
(when you call it with arguments).

### `/statusline` slash command

Drop [`commands/statusline.md`](commands/statusline.md) into
`~/.claude/commands/` to enable a `/statusline` slash command inside
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Then in any Claude Code session you can type:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude will run the bundle CLI for you, report the result, and remind
you to reload.

### Optional shell alias

```bash
alias statusline='~/.claude/status-line.sh'
```

Then `statusline cyberpunk` works from any terminal.

## 🚀 Install

### Manual install (3 steps)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Then add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Restart Claude Code (or run `/config` reload).

### Install via Claude Code agent (with automatic backup)

Want Claude Code to install it safely for you? Paste this prompt:

> "Install the status line from this repo as my Claude Code status line:
> 1. If `~/.claude/status-line.sh` already exists, back it up to
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (pick a free `-N`
>    suffix if a backup with that name already exists).
> 2. Copy `statusline.sh` from this repo to `~/.claude/status-line.sh` and `chmod +x`.
> 3. Read `~/.claude/settings.json`. If it has no `statusLine` key, add a
>    `statusLine` block pointing to the absolute path of the script. If
>    `statusLine` already exists and points elsewhere, back up
>    `settings.json` to `.bak.<timestamp>` first.
> 4. Smoke-test the script:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Tell me to restart Claude Code and report the backups created."

### Updating to the latest version

```bash
~/.claude/status-line.sh update
```

Fetches the latest bundle from GitHub, creates a timestamped backup
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), and preserves your
theme config (`~/.claude/statusline.conf`). Restart Claude Code afterwards.

Check what you have installed: `~/.claude/status-line.sh version`.

### Requirements

- `bash` 4+ (script uses 0-indexed arrays — **do not run under `zsh`**)
- `jq` for JSON parsing — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (only needed for `statusline update`; preinstalled on most systems)
- A 256-color terminal (basically every modern one)

## ⚙️ Configuration

Edit constants near the top of `statusline.sh`:

| Variable / function | What it controls |
|---|---|
| `BAR_STYLE` | `"quadrant"` (default, 2.5% step) or `"vertical"` (1.25% step) |
| `pct_icon()` | Thresholds for 🚀 / 🚗 / ⚠️ icons before the bar |
| `pct_color()` | Color thresholds for percentage / bar |
| ANSI color constants | Recolor any segment (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 vs the default Claude Code status line

| Capability | Default | This project |
|---|---|---|
| Active **model name** | ✅ | ✅ (with `(1M)` flag for 1M-context variants) |
| **Context window** % used | ❌ | ✅ live, 1.25 % precision |
| **Progress bar** for context | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **Session cost** in USD | ❌ | ✅ updated every render |
| **Per-message** input/output token counters | ❌ | ✅ |
| **Total session tokens** (API mode fallback) | ❌ | ✅ |
| **5h / 7d rate-limit** indicators with ⚠️ at > 50 % | ❌ | ✅ |
| **Git branch** + dirty + ahead/behind | ❌ | ✅ |
| **Time-on-task** (active vs wall clock) | ❌ | ✅ |
| **Thinking / effort level** display | ❌ | ✅ |
| Themed presets | ❌ | ✅ 72 themes × 2 variants = **144 ready-made** |
| Compose from named blocks | ❌ | ✅ 18 blocks, see [BLOCKS.md](BLOCKS.md) |
| Built-in CLI configurator | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` slash command | ❌ | ✅ optional, see [`commands/`](commands/) |
| External dependencies | — | `bash` 4+ and `jq` (no Node, no Python, no daemon) |
| License | — | Source-Available (reuse-by-permission) |

## 💡 Use cases

Concrete scenarios where this project pays for itself:

- **"How much of my 1 M context have I burned?"** — see a live percent + bar before every prompt.
- **"What is this Claude Code session costing me?"** — running USD total, updated every render.
- **"Will I hit a rate limit today?"** — 5 h / 7 d indicators with ⚠️ when > 50 %.
- **"Am I on the right branch?"** — git branch + dirty + ahead/behind in your status line.
- **"How many actual hours did I spend on this feature?"** — time-on-task tracker (`active` vs `wall`).
- **"I want my terminal to be fun."** — anime, cyberpunk, hacker, retro, weather, ocean, fire and other themes.
- **"I want a minimal, ASCII-only status line for screen recordings."** — `zen` theme.
- **"I want to ship a status line my whole team uses."** — single bundled script + CLI configurator + slash command.

## ❓ FAQ

### What is "Claude Code Status Line"?

A bash-based replacement for the default status line in [Claude Code](https://claude.com/claude-code) (Anthropic's CLI). It turns the bottom-of-screen line into a real dashboard: model, context %, progress bar, session cost, rate limits, git status, time-on-task, and more.

### How is it installed?

Copy `statusline-bundle.sh` to `~/.claude/status-line.sh`, `chmod +x`, then point Claude Code's `~/.claude/settings.json` `statusLine.command` at that path. Full instructions in the [Quick start](#-quick-start) and [Install](#-install) sections.

### Does it support the 1 M context window models?

Yes. The script detects `[1m]` in the model id and `1M` in the display name and adjusts the bar's denominator to 1 000 000 tokens. You'll see `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### What models does it work with?

Any model Claude Code supports — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, etc. The script reads `model.display_name` and `model.id` from the stdin JSON Claude Code provides; it doesn't hardcode model names.

### Can I customize colors, themes, or add my own?

Yes — three ways:

1. Pick one of the **72 themes** (144 variants total) — use `~/.claude/status-line.sh use <name>` or browse [`examples/`](examples/) for the standalone scripts.
2. Compose your own from **named blocks** — see [BLOCKS.md](BLOCKS.md).
3. Edit color constants and bar style in `statusline.sh` directly.

### Will it slow down Claude Code?

No. Each render runs once per status redraw, parses the piped JSON with `jq`, optionally `grep`s the latest line of the transcript, and prints. Typical render is ≤ 50 ms even with the time-tracker enabled.

### Does it work without `jq`?

`jq` is required — it parses the JSON Claude Code sends on stdin. Install it via `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), or `choco install jq` (Windows).

### Does it work on Windows?

Yes, in any environment that runs `bash` 4+ and `jq` — Git Bash, WSL, MSYS2, Cygwin. Pure CMD/PowerShell aren't supported.

### Does it work on Linux / macOS?

Yes on both. macOS uses BSD `date`, Linux uses GNU `date` — the time-tracker handles both transparently.

### Can I use this with the raw Anthropic API instead of Claude Code?

Partially. The status line is designed for Claude Code's stdin JSON format. For raw API usage, the rate-limit indicators auto-fall back to a **total session tokens** display (`tokens: NNN K`).

### Where is the configuration stored?

`~/.claude/statusline.conf` — a tiny shell-sourced file written by the bundle's CLI (`statusline.sh use <theme>` etc.). Persists across restarts.

### How do I revert to the default Claude Code status line?

Either remove the `statusLine` block from `~/.claude/settings.json`, or run `~/.claude/status-line.sh reset` and switch to a `minimal` theme that closely matches the default.

### Is it free? Can I use it commercially?

Personal, local use is free — see the [Source-Available License](LICENSE). Any reuse, redistribution, fork, or inclusion in another project requires **prior written permission** from the author (Yevgeniy Achin · amazopic@gmail.com). Reasonable requests are typically granted.

### How does the "human-hours" tracker work?

The `time` theme reads timestamps from the JSONL transcript and reports two durations: **active** (sum of inter-message gaps shorter than 5 minutes) and **wall** (total span from first to last message). The 5-minute idle threshold is configurable.

## 🏷️ Suggested GitHub topics

When you publish this repo, add these topics to maximize discoverability:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Contributing

Issues and PRs are welcome — but note the license:

- **Reading, opening issues, submitting PRs**: free.
- **Forking, copying into another project, redistributing**: requires
  prior written permission from the author.

To request reuse permission, contact:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Reasonable requests for personal, educational, and non-commercial use
are typically granted free of charge.

## 📜 License

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

This project's source is publicly available for reading, study, and
personal use on your own machine. Any reuse — copying, redistributing,
modifying, or including in another project — requires **prior written
permission** from the author (Yevgeniy Achin · amazopic@gmail.com).

This is **not** an OSI-approved open-source license. It is a deliberate
choice to keep distribution and derivative works under the author's
control while allowing the community to read, study, and contribute.

## ⭐ Found it useful?

If you spend hours staring at Claude Code, you might as well stare at a beautiful status line. **Give the repo a ⭐** to help others discover it!

---

Made by **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · for the Claude Code community.
