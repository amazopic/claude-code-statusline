# Examples — 20 classic themes as standalone scripts

This folder holds **standalone scripts for the 20 classic themes** —
ready to read, copy, and hack on. Each theme ships in **two variants**
(20 × 2 = **40 scripts**):

- **Detailed** — full feature set (model, context, cost, tokens, git, time, theme accents, …)
- **Compact** — minimal three-segment layout: `model · context % + bar · git branch`

Both are **standalone** — copy any one to `~/.claude/status-line.sh`,
`chmod +x`, and you're done. These are kept as plain, self-contained
files so you can study or fork a single theme without the bundle.

> 💡 **Want all 79 themes?** The other 59 themes live in the all-in-one
> [`../statusline-bundle.sh`](../statusline-bundle.sh) (79 themes ×
> detailed/compact = 158 variants) — preview any of them with
> `~/.claude/status-line.sh preview <theme>`, or browse the full gallery
> on the project site. The bundle also adds all blocks and a CLI
> configurator (`use`, `custom`, `preview`, `list`). Pair with
> [`../commands/statusline.md`](../commands/statusline.md) for a
> `/statusline` Claude Code slash command.

> Want to see them in your terminal first? Browse [`../screenshots/`](../screenshots/).
> Want to assemble your own from scratch? See [`../BLOCKS.md`](../BLOCKS.md).

## 🛠 Practical

| Theme | Detailed | Compact |
|---|---|---|
| minimal | [`statusline-minimal.sh`](statusline-minimal.sh) | [`statusline-minimal-compact.sh`](statusline-minimal-compact.sh) |
| developer (git-aware) | [`statusline-developer.sh`](statusline-developer.sh) | [`statusline-developer-compact.sh`](statusline-developer-compact.sh) |
| **time** (human-hours tracker) | [`statusline-time.sh`](statusline-time.sh) | [`statusline-time-compact.sh`](statusline-time-compact.sh) |
| zen (mono-ASCII, no emojis) | [`statusline-zen.sh`](statusline-zen.sh) | [`statusline-zen-compact.sh`](statusline-zen-compact.sh) |

## 🎨 Themed

| Theme | Detailed | Compact |
|---|---|---|
| rainbow | [`statusline-rainbow.sh`](statusline-rainbow.sh) | [`statusline-rainbow-compact.sh`](statusline-rainbow-compact.sh) |
| anime ✨🌸 | [`statusline-anime.sh`](statusline-anime.sh) | [`statusline-anime-compact.sh`](statusline-anime-compact.sh) |
| love 💖 | [`statusline-love.sh`](statusline-love.sh) | [`statusline-love-compact.sh`](statusline-love-compact.sh) |
| cat 🐱 | [`statusline-cat.sh`](statusline-cat.sh) | [`statusline-cat-compact.sh`](statusline-cat-compact.sh) |
| christmas 🎄 | [`statusline-christmas.sh`](statusline-christmas.sh) | [`statusline-christmas-compact.sh`](statusline-christmas-compact.sh) |

## 💻 Hacker / Sci-fi

| Theme | Detailed | Compact |
|---|---|---|
| hacker (Matrix) | [`statusline-hacker.sh`](statusline-hacker.sh) | [`statusline-hacker-compact.sh`](statusline-hacker-compact.sh) |
| cyberpunk (neon) | [`statusline-cyberpunk.sh`](statusline-cyberpunk.sh) | [`statusline-cyberpunk-compact.sh`](statusline-cyberpunk-compact.sh) |
| space 🚀 | [`statusline-space.sh`](statusline-space.sh) | [`statusline-space-compact.sh`](statusline-space-compact.sh) |
| retro (8-bit) | [`statusline-retro.sh`](statusline-retro.sh) | [`statusline-retro-compact.sh`](statusline-retro-compact.sh) |

## 🌍 Elemental / Mood

| Theme | Detailed | Compact |
|---|---|---|
| fire 🔥 | [`statusline-fire.sh`](statusline-fire.sh) | [`statusline-fire-compact.sh`](statusline-fire-compact.sh) |
| ocean 🌊 | [`statusline-ocean.sh`](statusline-ocean.sh) | [`statusline-ocean-compact.sh`](statusline-ocean-compact.sh) |
| weather ☀⛅🌧 | [`statusline-weather.sh`](statusline-weather.sh) | [`statusline-weather-compact.sh`](statusline-weather-compact.sh) |
| coffee ☕ | [`statusline-coffee.sh`](statusline-coffee.sh) | [`statusline-coffee-compact.sh`](statusline-coffee-compact.sh) |
| music 🎵 | [`statusline-music.sh`](statusline-music.sh) | [`statusline-music-compact.sh`](statusline-music-compact.sh) |

## 🎮 Gamified

| Theme | Detailed | Compact |
|---|---|---|
| game (RPG HUD) | [`statusline-game.sh`](statusline-game.sh) | [`statusline-game-compact.sh`](statusline-game-compact.sh) |
| pirate 🏴‍☠️ | [`statusline-pirate.sh`](statusline-pirate.sh) | [`statusline-pirate-compact.sh`](statusline-pirate-compact.sh) |

## Try one

```bash
# pick a variant — detailed or compact
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Then make sure `~/.claude/settings.json` points to it:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Restart Claude Code (or `/config` reload).

## See them all in your terminal

The `../screenshots/` folder has pre-rendered ANSI captures of the
classic-theme variants shown here (20 themes × 2 = 40 specimens + the
main reference). For the full 79-theme gallery, use
`~/.claude/status-line.sh preview <theme>` or the project site. To browse
the captures in this repo:

```bash
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Each `.ansi` file contains the literal terminal output (with ANSI color
codes), so `cat` displays it exactly as it would appear in your
status line.

## Build your own from blocks

Don't see a layout you want? See [`../BLOCKS.md`](../BLOCKS.md) — a
catalog of 19 named blocks (model, context-bar, cost, tokens, git,
time, thinking, …), plus 1 context-bar style variant
(context-bar-quadrant), that you can paste into a script in any order to
build a custom line.

## About `statusline-time.sh` (human-hours tracker)

Detailed variant computes:

- **Active time** — sum of inter-message intervals **shorter than 5 min**
  (treats longer gaps as "away from keyboard"). The closest
  approximation to actual time-on-task.
- **Wall time** — total span from the first to the last message.
- **Turns** — number of user/assistant message pairs.

Timestamps are pulled from the JSONL transcript via `jq`, trying
`.timestamp`, `.created_at`, and `.message.created_at` in that order.
If none are present, falls back to file `mtime - ctime` for wall time.

The 5-minute idle threshold is configurable — change `IDLE_THRESHOLD`
near the top of the script.

The compact variant (`statusline-time-compact.sh`) shows just
`active` time alongside model + context + branch.

---

> Author: **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)
> License: **Source-Available** ([../LICENSE](../LICENSE)) — reuse only
> with the author's prior permission.
