---
description: Configure your Claude Code status line — pick a theme or compose from blocks
allowed-tools: Bash
argument-hint: <theme> | <theme>-compact | custom <block...> | list | preview <theme> | reset | update | version
---

# /statusline

The user wants to configure their Claude Code status line via the bundled
`statusline-bundle.sh` script (installed at `~/.claude/status-line.sh`).

**User input:** `$ARGUMENTS`

## What to do

Run the bundled CLI with the user's arguments and report the result:

```bash
~/.claude/status-line.sh $ARGUMENTS
```

If `$ARGUMENTS` is empty, run `~/.claude/status-line.sh show` to display
the current configuration.

## Recognized inputs (`$ARGUMENTS`)

- **`<theme>`** — single word that matches a known theme name. Treat as
  `use <theme>`. Examples: `cyberpunk`, `anime`, `minimal`, `pirate`.
- **`<theme>-compact`** — compact variant of a theme. Treat as
  `use <theme>-compact`.
- **`custom <block> [block ...]`** — compose from blocks. Pass through
  unchanged.
- **`list` / `list blocks` / `list compact`** — listing commands.
- **`preview <theme>`** — show preview without saving.
- **`preview-all`** — preview every theme.
- **`show`** — show current config.
- **`reset`** — reset to default.
- **`version`** — print the installed version.
- **`update`** — fetch the latest bundle from GitHub. Creates a timestamped
  backup (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) and preserves
  `~/.claude/statusline.conf`. Requires `curl`.

## After running

1. Show the user the command output (the bundle prints status messages).
2. If the user changed the active theme/blocks, remind them to **restart
   Claude Code** (or run `/config` reload) to apply the change.
3. If the command failed (e.g., unknown theme), suggest running
   `/statusline list` to see available themes.

## Available themes (cheat sheet)

```
minimal · developer · time · zen · rainbow · anime · love
cat · christmas · hacker · cyberpunk · space · retro · fire
ocean · weather · coffee · music · game · pirate
```

Append `-compact` to any name for the compact (model · context · branch) variant.

## Available blocks (cheat sheet)

```
model · context · context-pct · context-bar · cost · folder
git · git-branch · tokens-msg · tokens-session · limits
thinking · time-active · time-wall · turns · host · cups
level · mood-icon
```
