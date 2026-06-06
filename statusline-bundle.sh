#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
#                  CLAUDE CODE STATUS LINE — ALL-IN-ONE BUNDLE
# ─────────────────────────────────────────────────────────────────────────
#
#  Author:  Yevgeniy Achin <amazopic@gmail.com>
#  License: Source-Available (Reuse-by-Permission) — see LICENSE
#
#  ONE FILE — both the renderer (called by Claude Code with JSON on stdin)
#  AND a CLI configurator (called by you with arguments).
#
#  ─────────────────────────  INSTALL  ─────────────────────────
#
#  1. Copy to ~/.claude/status-line.sh:
#        cp statusline-bundle.sh ~/.claude/status-line.sh
#        chmod +x ~/.claude/status-line.sh
#
#  2. Register in ~/.claude/settings.json:
#        { "statusLine": { "type": "command",
#          "command": "/Users/<you>/.claude/status-line.sh" } }
#
#  3. Optional shell alias (so 'statusline' works anywhere):
#        alias statusline='~/.claude/status-line.sh'
#
#  ─────────────────────────  USAGE  ───────────────────────────
#
#  statusline                        # show current config + help
#  statusline list                   # list all themes
#  statusline list compact           # list compact themes
#  statusline list blocks            # list available blocks
#  statusline use cyberpunk          # switch to cyberpunk (detailed)
#  statusline use cyberpunk-compact  # switch to cyberpunk (compact)
#  statusline custom model context-bar git cost   # custom from blocks
#  statusline preview anime          # preview without changing
#  statusline preview-all            # preview every theme
#  statusline show                   # show current config
#  statusline reset                  # reset to default
#  statusline version                # print installed version
#  statusline update                 # fetch latest from GitHub (timestamped backup)
#
#  Config is stored at: ~/.claude/statusline.conf
#
#  ─────────────────────────  THEMES  ──────────────────────────
#
#  Top picks (10) — most asked-for, cross-cultural:
#    cyberpunk · hacker · dragonball · naruto · pokemon
#    ironman · spiderman · einstein · tesla · ferrari
#
#  Classic (19):
#    minimal · developer · time · zen · rainbow · anime · love
#    cat · christmas · space · retro · fire · ocean · weather
#    coffee · music · game · pirate
#
#  Auto brands (15 more):
#    Europe   — porsche · mercedes · bmw · volvo
#    America  — ford · chevy · jeep · cadillac
#    Japan    — toyota · honda · nissan
#    Korea    — hyundai · kia
#    China    — byd · nio · geely
#
#  Great scientists (8 more):
#    newton · curie · darwin · hawking · galileo
#    feynman · turing · davinci
#
#  Anime (3 more):
#    onepiece · ghibli
#
#  Marvel superheroes (8 more):
#    hulk · thor · captain-america · wolverine · deadpool
#    blackwidow · strange · wanda
#
#  Operating systems (10):
#    macos · windows · linux · ubuntu · arch
#    debian · fedora · kali · mint · nixos
#
#  World religions (top 7 by adherents):
#    christianity · islam · hinduism · buddhism
#    judaism · sikhism · shinto
#
#  Append "-compact" to any name for the compact variant
#  (model · context · branch only).
#
#  ─────────────────────────  BLOCKS  ──────────────────────────
#
#  26 blocks total:
#    model · context · context-pct · context-bar · cost · folder
#    git · git-branch · tokens-msg · tokens-session · limits
#    thinking · time-active · time-wall · turns · host · cups
#    level · mood-icon · lines · pr · worktree · vim · agent · repo
#    api-time
#
#  The `limits` block shows the 5h / 7d subscription usage meters. When
#  Claude Code supplies a `resets_at` epoch for a window, a reset countdown
#  is appended to its label as 5h{1.1h}: / 7d{1.1d}: — decimal hours for the
#  5-hour window, decimal days for the 7-day window. With no resets_at the
#  label stays bare (5h:) for backward compatibility.
#
#  The newest blocks read fields Claude Code added to the stdin payload:
#    lines    — .cost.total_lines_added / .total_lines_removed ("+156 −23")
#    pr       — .pr.number + .pr.review_state ("✅ PR #1234 approved")
#    worktree — .worktree.name // .workspace.git_worktree ("⧉ name")
#    vim      — .vim.mode ("-- NORMAL --")
#    agent    — .agent.name ("⚙ name")
#    repo     — .workspace.repo.owner + .name ("owner/name")
#    api-time — .cost.total_api_duration_ms ("⚡ api 1.2s" / "⚡ api 1m20s")
#  Each hides completely when its source data is absent.
#
#  ─────────────────────────  PAYLOAD-FIRST CONTEXT  ───────────
#
#  When Claude Code supplies a `.context_window` object on stdin the renderer
#  trusts it verbatim — context %, window size, and per-message token counts
#  come straight from the payload, so NO transcript file is read (fast even
#  with huge transcripts). Likewise `.context_window.total_input_tokens` +
#  `.total_output_tokens` feed the session-tokens fallback, and
#  `.cost.total_duration_ms` feeds the wall-clock time. Older Claude Code
#  versions that omit these fields fall back to the historical transcript
#  scan + [1m]/1M/exceeds_200k heuristic with no change in behavior.
#
# ─────────────────────────────────────────────────────────────────────────

set -uo pipefail

# ─────────────────────────  PRECHECK: jq  ─────────────────────────────
# jq parses both Claude Code's stdin JSON and the per-message usage in the
# transcript. Without it the line renders empty. Fail loudly with install
# hints rather than silently returning blanks.
if ! command -v jq >/dev/null 2>&1; then
  printf '\e[1;38;5;196mstatus-line: jq not found\e[0m — install it:\n' >&2
  printf '  Ubuntu/Debian:  sudo apt-get install -y jq\n' >&2
  printf '  Fedora/RHEL:    sudo dnf install -y jq\n' >&2
  printf '  Arch:           sudo pacman -S jq\n' >&2
  printf '  macOS (brew):   brew install jq\n' >&2
  printf '  Alpine:         sudo apk add jq\n' >&2
  # Stdout still needs *some* output so Claude Code does not show the raw error.
  if [[ ! -t 0 ]]; then printf 'jq required — see stderr\n'; fi
  exit 0
fi

# Force C numeric formatting (decimal dot in 1.1h / 0.42$ / 87.5K) regardless
# of the user's locale, while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C

# ─────────────────────────  CONFIG  ───────────────────────────────────
# Calendar versioning: YYYY.MM.DD — bump on every release. Compared by
# `statusline update` against the upstream copy on GitHub.
VERSION="2026.06.07"
UPSTREAM_URL="https://raw.githubusercontent.com/amazopic/claude-code-statusline/main/statusline-bundle.sh"

CONFIG_FILE="${HOME}/.claude/statusline.conf"
DEFAULT_THEME="minimal"
THEME=""
BLOCKS=""
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE" 2>/dev/null
[[ -z "$THEME" ]] && THEME="$DEFAULT_THEME"

# ─────────────────────────  ALL THEMES  ───────────────────────────────
THEMES=(
  # — Top picks (cross-cultural recognition) —
  cyberpunk hacker dragonball naruto pokemon ironman spiderman einstein tesla ferrari
  # — Practical / Classic —
  minimal developer time zen rainbow anime love cat christmas
  space retro fire ocean weather coffee music game pirate
  # — Auto: Europe —
  porsche mercedes bmw volvo
  # — Auto: America —
  ford chevy jeep cadillac
  # — Auto: Japan —
  toyota honda nissan
  # — Auto: Korea —
  hyundai kia
  # — Auto: China —
  byd nio geely
  # — Scientists —
  newton curie darwin hawking galileo feynman turing davinci
  # — Anime —
  onepiece ghibli
  # — Marvel —
  hulk thor captain-america wolverine deadpool blackwidow strange wanda
  # — Operating systems —
  macos windows linux ubuntu arch debian fedora kali mint nixos
  # — World religions (top 7 by adherents) —
  christianity islam hinduism buddhism judaism sikhism shinto
)

# ─────────────────────────  ALL BLOCKS  ───────────────────────────────
BLOCKS_LIST=(model context context-pct context-bar cost folder
             git git-branch tokens-msg tokens-session limits thinking
             time-active time-wall turns host cups level mood-icon
             lines pr worktree vim agent repo api-time)

is_known_theme() {
  local t="${1%-compact}"
  for x in "${THEMES[@]}"; do [[ "$x" == "$t" ]] && return 0; done
  return 1
}
is_known_block() {
  for x in "${BLOCKS_LIST[@]}"; do [[ "$x" == "$1" ]] && return 0; done
  return 1
}

# ═════════════════════════════════════════════════════════════════════
#                              CLI  MODE
# ═════════════════════════════════════════════════════════════════════

cli_help() {
  cat <<'HELP'
Claude Code Status Line — bundle CLI

USAGE
  statusline                        show current config + this help
  statusline list                   list all themes
  statusline list compact           list compact theme names
  statusline list blocks            list available blocks
  statusline use <theme>            switch to a theme
                                    (append -compact for the compact variant)
  statusline custom <block...>      compose a custom line from blocks
  statusline preview <theme>        preview a theme without saving
  statusline preview-all            cat-preview every theme
  statusline show                   show current configuration
  statusline reset                  reset to default
  statusline version                print installed version
  statusline update                 fetch latest bundle from GitHub
                                    (timestamped backup, theme config preserved)

EXAMPLES
  statusline use cyberpunk
  statusline use cyberpunk-compact
  statusline custom model context-bar git cost
  statusline preview anime
  statusline update

Author:  Yevgeniy Achin <amazopic@gmail.com>
License: Source-Available — reuse only with prior written permission.
HELP
}

cli_list() {
  local mode="${1:-themes}"
  case "$mode" in
    themes|"")
      echo "Available themes (append '-compact' for the compact variant):"
      printf '  %s\n' "${THEMES[@]}"
      ;;
    compact)
      echo "Compact theme names:"
      for t in "${THEMES[@]}"; do printf '  %s-compact\n' "$t"; done
      ;;
    blocks)
      echo "Available blocks (use with: statusline custom <block> [block ...]):"
      printf '  %s\n' "${BLOCKS_LIST[@]}"
      ;;
    *)
      echo "Unknown list type: $mode"
      echo "Try: statusline list [themes|compact|blocks]"
      return 1
      ;;
  esac
}

cli_use() {
  local theme="${1:-}"
  if [[ -z "$theme" ]]; then echo "Usage: statusline use <theme>"; return 1; fi
  if ! is_known_theme "$theme"; then
    echo "Unknown theme: $theme"
    echo "Run 'statusline list' to see available themes."
    return 1
  fi
  mkdir -p "$(dirname "$CONFIG_FILE")"
  printf 'THEME=%q\nBLOCKS=""\n' "$theme" > "$CONFIG_FILE"
  echo "Theme set to: $theme"
  echo "Config written: $CONFIG_FILE"
  echo "(Restart Claude Code or run /config reload to apply.)"
}

cli_custom() {
  if (( $# == 0 )); then
    echo "Usage: statusline custom <block1> [block2 ...]"
    echo "Run 'statusline list blocks' to see available blocks."
    return 1
  fi
  local b
  for b in "$@"; do
    if ! is_known_block "$b"; then
      echo "Unknown block: $b"
      echo "Run 'statusline list blocks' to see available blocks."
      return 1
    fi
  done
  mkdir -p "$(dirname "$CONFIG_FILE")"
  printf 'THEME=%q\nBLOCKS=%q\n' "custom" "$*" > "$CONFIG_FILE"
  echo "Custom config saved: $*"
  echo "(Restart Claude Code or run /config reload to apply.)"
}

cli_preview() {
  local theme="${1:-}"
  if [[ -z "$theme" ]]; then echo "Usage: statusline preview <theme>"; return 1; fi
  if ! is_known_theme "$theme"; then
    echo "Unknown theme: $theme"; return 1
  fi
  THEME="$theme" BLOCKS="" render_with_fixture
}

cli_preview_all() {
  for t in "${THEMES[@]}"; do
    printf '\n=== %s ===\n' "$t"
    THEME="$t" BLOCKS="" render_with_fixture
  done
  for t in "${THEMES[@]}"; do
    printf '\n=== %s-compact ===\n' "$t"
    THEME="${t}-compact" BLOCKS="" render_with_fixture
  done
}

cli_show() {
  echo "Current configuration:"
  echo "  Config file: $CONFIG_FILE"
  echo "  Theme:       $THEME"
  echo "  Blocks:      ${BLOCKS:-(default for theme)}"
  echo
  echo "Preview:"
  render_with_fixture
}

cli_reset() {
  rm -f "$CONFIG_FILE"
  echo "Configuration reset (removed $CONFIG_FILE)."
  echo "Default theme is now: $DEFAULT_THEME"
}

cli_version() {
  echo "claude-code-statusline $VERSION"
  echo "  installed: $(self_path)"
  echo "  upstream:  $UPSTREAM_URL"
}

# Resolve the absolute path of the running script. Follows symlinks so an
# install at ~/.claude/status-line.sh that's actually a symlink to the cloned
# repo gets reported as the symlink target where appropriate.
self_path() {
  local p="${BASH_SOURCE[0]:-$0}"
  if command -v readlink >/dev/null 2>&1; then
    # GNU readlink -f and BSD readlink behave differently; fall back gracefully.
    local r
    r=$(readlink -f "$p" 2>/dev/null) || r=""
    [[ -n "$r" ]] && p="$r"
  fi
  printf '%s' "$p"
}

# Pull the VERSION="..." line out of an arbitrary bundle file.
extract_version() {
  local file="$1" v
  v=$(grep -m1 '^VERSION="' "$file" 2>/dev/null | sed -E 's/^VERSION="([^"]+)".*/\1/')
  printf '%s' "$v"
}

cli_update() {
  local target tmp backup ts new_ver
  target=$(self_path)

  if [[ ! -w "$target" || ! -w "$(dirname "$target")" ]]; then
    echo "Cannot write to $target — try with sudo or fix permissions." >&2
    return 1
  fi

  if ! command -v curl >/dev/null 2>&1; then
    echo "curl not found — install it (apt-get install -y curl / brew install curl) and retry." >&2
    return 1
  fi

  echo "Current version: $VERSION"
  echo "Fetching latest from upstream…"

  tmp=$(mktemp "${TMPDIR:-/tmp}/statusline-bundle.XXXXXX") || {
    echo "mktemp failed" >&2; return 1; }

  if ! curl -fsSL --max-time 30 -o "$tmp" "$UPSTREAM_URL"; then
    echo "Download failed from $UPSTREAM_URL" >&2
    rm -f "$tmp"; return 1
  fi

  # Sanity: must be a non-empty bash script that parses cleanly.
  if [[ ! -s "$tmp" ]] || ! bash -n "$tmp" 2>/dev/null; then
    echo "Downloaded file is empty or has syntax errors — refusing to install." >&2
    rm -f "$tmp"; return 1
  fi

  new_ver=$(extract_version "$tmp")
  if [[ -z "$new_ver" ]]; then
    echo "Could not read VERSION from downloaded bundle — refusing to install." >&2
    rm -f "$tmp"; return 1
  fi

  if [[ "$new_ver" == "$VERSION" ]]; then
    echo "Already up to date ($VERSION)."
    rm -f "$tmp"; return 0
  fi

  ts=$(date +%Y%m%d-%H%M%S)
  backup="${target}.bak.${ts}"
  if ! cp -p "$target" "$backup"; then
    echo "Backup to $backup failed — aborting." >&2
    rm -f "$tmp"; return 1
  fi
  echo "Backed up current to: $backup"

  if ! mv "$tmp" "$target"; then
    echo "Replace failed — restoring from backup." >&2
    cp -p "$backup" "$target"
    rm -f "$tmp"
    return 1
  fi
  chmod +x "$target"

  echo "Updated: $VERSION → $new_ver"
  echo "Theme config preserved: $CONFIG_FILE"
  echo "Restart Claude Code to pick up the new bundle."
}

render_with_fixture() {
  local fixture now r5 r7
  now=$(date +%s)
  r5=$(( now + 3960 ))    # +1.1h → preview shows 5h{1.1h}
  r7=$(( now + 95040 ))   # +1.1d → preview shows 7d{1.1d}
  fixture='{"model":{"display_name":"Opus 4.7 (1M context)","id":"claude-opus-4-7[1m]"},"workspace":{"current_dir":"'"$PWD"'"},"cost":{"total_cost_usd":0.42},"transcript_path":"","context_window":{"used_percentage":12,"context_window_size":1000000,"current_usage":{"input_tokens":8400,"output_tokens":1200,"cache_read_input_tokens":96000,"cache_creation_input_tokens":17000}},"rate_limits":{"five_hour":{"used_percentage":15,"resets_at":'"$r5"'},"seven_day":{"used_percentage":4,"resets_at":'"$r7"'}}}'
  printf '%s' "$fixture" | render_main
}

cli_dispatch() {
  case "${1:-show}" in
    help|-h|--help)        cli_help ;;
    version|-v|--version)  cli_version ;;
    update|upgrade)        cli_update ;;
    list)                  shift; cli_list "$@" ;;
    use)                   shift; cli_use "$@" ;;
    custom)                shift; cli_custom "$@" ;;
    preview)               shift; cli_preview "$@" ;;
    preview-all)           cli_preview_all ;;
    show)                  cli_show ;;
    reset)                 cli_reset ;;
    *)
      if is_known_theme "$1"; then
        cli_use "$1"
      else
        echo "Unknown command: $1"
        cli_help
        return 1
      fi
      ;;
  esac
}

# ═════════════════════════════════════════════════════════════════════
#                          SHARED RENDER CORE
# ═════════════════════════════════════════════════════════════════════

# ─── ANSI palette ────────────────────────────────────────────────────
G=$'\e[1;38;5;220m';   GD=$'\e[38;5;178m'
GR=$'\e[1;38;5;46m';   GRD=$'\e[38;5;34m';   GRDD=$'\e[38;5;28m';   GRDDD=$'\e[38;5;22m'
Y=$'\e[1;38;5;226m';   YD=$'\e[38;5;184m';   Y2=$'\e[1;38;5;227m'
R=$'\e[1;38;5;196m';   RU=$'\e[38;5;160m';   RD=$'\e[38;5;131m';    RD2=$'\e[38;5;88m';    DR=$'\e[38;5;52m'
B=$'\e[1;38;5;39m';    BD=$'\e[38;5;24m';    DB=$'\e[38;5;17m'
C=$'\e[1;38;5;51m';    CD=$'\e[38;5;38m'
M=$'\e[1;38;5;201m';   MD=$'\e[38;5;163m';   V=$'\e[1;38;5;177m';   V2=$'\e[1;38;5;99m'
P=$'\e[1;38;5;213m';   PD=$'\e[38;5;218m'
PR=$'\e[1;38;5;55m'
O=$'\e[1;38;5;208m'
W=$'\e[1;38;5;255m';   W2=$'\e[1;38;5;231m';  WD=$'\e[38;5;250m'
BR=$'\e[1;38;5;94m';   BRD=$'\e[38;5;58m';   BG=$'\e[38;5;130m'
D=$'\e[38;5;244m';     D2=$'\e[38;5;238m'
N=$'\e[0m'

# ─── Helpers ─────────────────────────────────────────────────────────
j() { jq -r "$1 // empty" 2>/dev/null <<<"$_INPUT"; }

fmt_thin() {
  local n=$1 result="" len i
  len=${#n}
  for ((i=0; i<len; i++)); do
    (( i > 0 && (len-i) % 3 == 0 )) && result+=$'\xe2\x80\x89'
    result+="${n:$i:1}"
  done
  printf '%s' "$result"
}

to_chrome() { printf '%s' "$1" | tr '[:lower:] ' '[:upper:]-'; }

to_epoch() {
  local ts="$1"
  [[ -z "$ts" ]] && { echo 0; return; }
  [[ "$ts" =~ ^[0-9]+$ ]] && { echo "$ts"; return; }
  local c="${ts%%.*}"; c="${c%Z}"; c="${c//T/ }"
  date -j -f '%Y-%m-%d %H:%M:%S' "$c" +%s 2>/dev/null \
    || date -d "$ts" +%s 2>/dev/null || echo 0
}

format_duration() {
  local s=$1
  (( s < 0 )) && s=0
  local h=$(( s / 3600 ))  m=$(( (s % 3600) / 60 ))
  if   (( h > 0 )); then printf '%dh%02dm' "$h" "$m"
  elif (( m > 0 )); then printf '%dm' "$m"
  else                   printf '%ds' "$s"
  fi
}

# ─── Bar renderers ───────────────────────────────────────────────────
bar_vertical() {  # 8 sub-levels per cell, 1.25% step
  local pct=$1
  local eighths=$(( (pct * 8 + 5) / 10 ))
  local full=$(( eighths / 8 )) part=$(( eighths % 8 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
  local s="" i
  for (( i=0; i<full; i++ )); do s+="█"; done
  (( part > 0 )) && s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

bar_quadrant() {  # 4 sub-levels per cell, 2.5% step
  local pct=$1
  local quarters=$(( (pct * 4 + 5) / 10 ))
  local full=$(( quarters / 4 )) part=$(( quarters % 4 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▖" "▄" "▙")
  local s="" i
  for (( i=0; i<full; i++ )); do s+="█"; done
  (( part > 0 )) && s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

# Theme-specific bars (return strings with embedded ANSI codes)
bar_simple() {
  local pct=$1 fc="$2" ec="$3" ff="$4" ee="$5"
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;       i++ )); do s+="${fc}${ff}"; done
  for (( i=0; i<10-cells;    i++ )); do s+="${ec}${ee}"; done
  printf '%s%s' "$s" "$N"
}

bar_rainbow() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local g=(196 202 208 220 226 154 46 51 39 129)
  local s="" i
  for (( i=0; i<cells; i++ )); do s+=$'\e[1;38;5;'"${g[$i]}"'m▮'; done
  for (( i=cells; i<10; i++ )); do s+="${D2}▯"; done
  printf '%s%s' "$s" "$N"
}

bar_fire() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local s="" i col
  for (( i=0; i<cells; i++ )); do
    if   (( i < 4 )); then col=$Y
    elif (( i < 7 )); then col=$O
    else                   col=$R
    fi
    s+="${col}█"
  done
  for (( i=0; i<10-cells; i++ )); do s+="${DR}▒"; done
  printf '%s%s' "$s" "$N"
}

bar_wave() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local g=("≈" "≈" "≋" "≋" "~" "~" "~" "≋" "≋" "█")
  local s="" i col
  for (( i=0; i<10; i++ )); do
    if (( i < cells )); then
      if   (( i < 4 )); then col=$C
      elif (( i < 8 )); then col=$B
      else                   col=$DB
      fi
      s+="${col}${g[$i]}"
    else
      s+="${BD} "
    fi
  done
  printf '%s%s' "$s" "$N"
}

bar_sparks() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local g=("▁" "▂" "▂" "▃" "▃" "▄" "▅" "▆" "▇" "█")
  local col dim s="" i
  if   (( pct < 30 )); then col=$Y;  dim=$WD
  elif (( pct < 60 )); then col=$WD; dim=$D
  elif (( pct < 80 )); then col=$B;  dim=$D
  else                      col=$PR; dim=$D
  fi
  for (( i=0; i<10; i++ )); do
    if (( i < cells )); then s+="${col}${g[$i]}"
    else                     s+="${dim}${g[$i]}"
    fi
  done
  printf '%s%s' "$s" "$N"
}

bar_notes() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local notes=("♩" "♪" "♫" "♬" "♩" "♪" "♫" "♬" "♩" "♪")
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${M}${notes[$i]}"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${D2}─"; done
  printf '%s%s' "$s" "$N"
}

bar_hacker() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local s="${GRDD}[${GR}" i
  for (( i=0; i<cells; i++ )); do s+="|"; done
  s+="${GRDDD}"
  for (( i=0; i<10-cells; i++ )); do s+="-"; done
  printf '%s%s%s' "$s" "${GRDD}]" "$N"
}

bar_ascii() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local s="[" i
  for (( i=0; i<cells;       i++ )); do s+="#"; done
  for (( i=0; i<10-cells;    i++ )); do s+="-"; done
  printf '%s]' "$s"
}

# ─── Parse input from Claude Code stdin ──────────────────────────────
parse_input() {
  _INPUT="$1"

  model_disp=$(j '.model.display_name')
  model_id=$(j '.model.id')
  model_name="${model_disp:-${model_id:-Claude}}"
  model_name="${model_name// context/}"

  cwd=$(j '.workspace.current_dir')
  [[ -z "$cwd" ]] && cwd=$(j '.cwd')
  [[ -z "$cwd" ]] && cwd="$PWD"

  cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
  cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')

  transcript=$(j '.transcript_path')
  exceeds_200k=$(j '.exceeds_200k_tokens')

  # ── Context window: payload-first ──────────────────────────────────
  # When Claude Code supplies a .context_window object on stdin we trust it
  # verbatim — no transcript scan needed (single jq call pulls all 7 fields
  # via @tsv). Older Claude Code versions omit the object: fall back to the
  # historical heuristic ([1m]/1M/exceeds_200k → ctx_max) + last-usage grep.
  ctx_window_present=$(j 'if .context_window then "1" else "" end')
  in_tok=0; out_tok=0; cr=0; cc=0
  ctx_max=""; ctx_pct=""

  if [[ -n "$ctx_window_present" ]]; then
    local cw_size cw_pct
    IFS=$'\t' read -r cw_size cw_pct in_tok out_tok cr cc < <(
      jq -r '.context_window as $w
             | [ ($w.context_window_size // 0),
                 ($w.used_percentage // 0),
                 ($w.current_usage.input_tokens // 0),
                 ($w.current_usage.output_tokens // 0),
                 ($w.current_usage.cache_read_input_tokens // 0),
                 ($w.current_usage.cache_creation_input_tokens // 0) ]
             | @tsv' 2>/dev/null <<<"$_INPUT")
    in_tok=${in_tok:-0}; out_tok=${out_tok:-0}; cr=${cr:-0}; cc=${cc:-0}
    ctx_max=${cw_size:-0}; (( ctx_max == 0 )) && ctx_max=200000
    # used_percentage may be fractional — keep the integer part only.
    ctx_pct=${cw_pct%%.*}; ctx_pct=${ctx_pct:-0}
  else
    if [[ "$model_id" == *"[1m]"* || "$model_disp" == *"1M"* || "$exceeds_200k" == "true" ]]; then
      ctx_max=1000000
    else
      ctx_max=200000
    fi
    if [[ -n "$transcript" && -f "$transcript" ]]; then
      last=$(grep '"usage"' "$transcript" 2>/dev/null | tail -1)
      if [[ -n "$last" ]]; then
        in_tok=$(jq  -r '.message.usage.input_tokens // 0'                <<<"$last" 2>/dev/null || echo 0)
        out_tok=$(jq -r '.message.usage.output_tokens // 0'               <<<"$last" 2>/dev/null || echo 0)
        cr=$(jq      -r '.message.usage.cache_read_input_tokens // 0'     <<<"$last" 2>/dev/null || echo 0)
        cc=$(jq      -r '.message.usage.cache_creation_input_tokens // 0' <<<"$last" 2>/dev/null || echo 0)
      fi
    fi
  fi

  ctx_used=$(( in_tok + cr + cc ))
  # If the payload didn't carry a percentage, derive it from used/max.
  if [[ -z "$ctx_pct" ]]; then
    ctx_pct=$(awk -v u="$ctx_used" -v m="$ctx_max" 'BEGIN { if (m>0) printf "%d", u*100/m; else print 0 }')
  fi
  ctx_used_k=$(awk -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')
  ctx_max_k=$(awk  -v v="$ctx_max"  'BEGIN { printf "%d",   v/1000 }')

  br=""
  if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
    br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
         || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  fi

  thinking=$(j '.effort.level // .thinking.level // .thinking // .output_style.name')
  [[ -z "$thinking" ]] && thinking="default"
}

# Pct color helpers (used by classic-style themes)
pct_color()     { local p=${1%.*}; [[ -z "$p" ]] && p=0
  if (( p < 50 )); then printf '%s' "$GR"; elif (( p < 70 )); then printf '%s' "$Y"; else printf '%s' "$R"; fi; }
pct_color_dim() { local p=${1%.*}; [[ -z "$p" ]] && p=0
  if (( p < 50 )); then printf '%s' "$GRD"; elif (( p < 70 )); then printf '%s' "$YD"; else printf '%s' "$RU"; fi; }

# ═════════════════════════════════════════════════════════════════════
#                       BLOCK LIBRARY (custom mode)
# ═════════════════════════════════════════════════════════════════════
SEP=" ${D}·${N} "

block_model()       { line+="${G}${model_name}${N}"; }
block_context_pct() { local cc=$(pct_color "$ctx_pct") cd=$(pct_color_dim "$ctx_pct")
                      line+="${cc}${ctx_pct}${cd}%${N}"; }
block_context_bar() { local cc=$(pct_color "$ctx_pct")
                      line+="${cc}$(bar_vertical "$ctx_pct")${N}"; }
block_context()     { local cc=$(pct_color "$ctx_pct") cd=$(pct_color_dim "$ctx_pct")
                      line+="${cc}${ctx_pct}${cd}% ${cc}$(bar_vertical "$ctx_pct") ${ctx_used_k}${cd}K${D}/${cc}${ctx_max_k}${cd}K${N}"; }
block_cost()        { line+="${G}${cost_fmt}${GD}\$${N}"; }
block_folder()      { line+="${B}$(basename "$cwd")${N}"; }
block_git_branch()  { [[ -n "$br" ]] && line+="${B}⎇ ${br}${N}"; }
block_git()         {
  [[ -z "$br" ]] && return
  local dirty ahead=0 behind=0
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  local up
  up=$(git -C "$cwd" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  if [[ -n "$up" ]]; then
    local cnt; cnt=$(git -C "$cwd" rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    ahead=${cnt%%	*}; behind=${cnt##*	}
  fi
  local g="${B}⎇ ${br}${N}"
  (( dirty  > 0 )) && g+=" ${Y}✚${dirty}${N}"
  (( ahead  > 0 )) && g+=" ${GR}↑${ahead}${N}"
  (( behind > 0 )) && g+=" ${R}↓${behind}${N}"
  line+="$g"
}
block_tokens_msg()  { local ok ik
  ok=$(awk -v v="$out_tok" 'BEGIN { printf "%.1f", v/1000 }')
  ik=$(awk -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')
  line+="${CD}↑${C}${ok}${CD}K ${CD}↓${C}${ik}${CD}K${N}"; }
# Session token total — payload-first. When .context_window carries the
# running totals (total_input_tokens / total_output_tokens) we sum those and
# skip the transcript entirely; otherwise we scan the transcript usage lines.
_session_tokens() {
  if [[ -n "${ctx_window_present:-}" ]]; then
    jq -r '(.context_window.total_input_tokens // 0)
           + (.context_window.total_output_tokens // 0)' 2>/dev/null <<<"$_INPUT"
    return
  fi
  local total=0
  if [[ -n "${transcript:-}" && -f "$transcript" ]]; then
    total=$(grep '"usage"' "$transcript" 2>/dev/null \
      | jq -s '[.[] | select(.message.usage) | .message.usage
               | ((.input_tokens // 0) + (.output_tokens // 0)
                  + (.cache_creation_input_tokens // 0)
                  + (.cache_read_input_tokens // 0))] | add // 0' 2>/dev/null)
  fi
  printf '%s' "${total:-0}"
}
block_tokens_session() {
  local total
  total=$(_session_tokens)
  local k=$(( ${total:-0} / 1000 ))
  line+="${GRD}tokens: ${C}$(fmt_thin "$k")${CD}K${N}"
}
block_limits()      {
  local l5 l7 w5 w7 r5 r7 t5 t7 b5 b7
  l5=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used'); l5=${l5%.*}
  l7=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used'); l7=${l7%.*}
  if [[ -z "$l5" && -z "$l7" ]]; then
    # API mode — payload carries no subscription limits; fall back to tokens.
    block_tokens_session
    return
  fi
  r5=$(j '.rate_limits.five_hour.resets_at'); t5=$(_lim_eta "$r5" h); b5=""; [[ -n "$t5" ]] && b5="{$t5}"
  r7=$(j '.rate_limits.seven_day.resets_at'); t7=$(_lim_eta "$r7" d); b7=""; [[ -n "$t7" ]] && b7="{$t7}"
  w5=""; (( ${l5:-0} > 50 )) && w5="⚠️ "
  w7=""; (( ${l7:-0} > 50 )) && w7="⚠️ "
  line+="${GRD}5h${b5}:${N} ${w5}${GR}${l5:-—}${GRD}%${N} ${GRD}7d${b7}:${N} ${w7}${GR}${l7:-—}${GRD}%${N}"
}
block_thinking()    { line+="🤖 ${C}${thinking}${N}"; }
block_host()        { line+="${C}$(hostname -s 2>/dev/null || echo localhost)${N}"; }
block_cups()        { local n; n=$(awk -v c="$cost" 'BEGIN { printf "%d", c*4 }'); line+="☕ ${G}${n}${N}"; }
block_level()       { local l; l=$(awk -v c="$cost" 'BEGIN { printf "%d", c+1 }'); line+="${M}LV ${l}${N}"; }
block_mood_icon()   { local m
  if   (( ctx_pct < 30 )); then m="☀"
  elif (( ctx_pct < 60 )); then m="⛅"
  elif (( ctx_pct < 80 )); then m="🌧"
  else                          m="⛈"
  fi
  line+="$m"; }

# Time-tracking blocks (computed lazily, split so each block only pays for
# the data it needs).
#
# _scan_transcript_time does the expensive line-by-line timestamp walk and is
# the ONLY source of active_s / turns / first / last. It is invoked solely by
# blocks that actually need those numbers (time-active, turns) and by
# _compute_wall when it has to fall back to first→last for the wall clock.
#
# _compute_wall is payload-first and cheap: when .cost.total_duration_ms is in
# the payload it derives wall_s straight from it and NEVER reads the
# transcript — so a huge transcript stays untouched for the common case.
_TIME_SCANNED=0
_WALL_COMPUTED=0
_scan_transcript_time() {
  (( _TIME_SCANNED == 1 )) && return
  active_s=0; first=0; last=0; turns=0
  if [[ -n "$transcript" && -f "$transcript" ]]; then
    local prev=0 ts e gap
    while IFS= read -r ts; do
      [[ -z "$ts" ]] && continue
      e=$(to_epoch "$ts"); (( e == 0 )) && continue
      (( first == 0 )) && first=$e; last=$e
      if (( prev > 0 )); then
        gap=$(( e - prev ))
        (( gap > 0 && gap < 300 )) && active_s=$(( active_s + gap ))
      fi
      prev=$e; turns=$(( turns + 1 ))
    done < <(jq -r '.timestamp // .created_at // .message.created_at // empty' "$transcript" 2>/dev/null)
  fi
  _TIME_SCANNED=1
}
_compute_wall() {
  (( _WALL_COMPUTED == 1 )) && return
  local dur_ms; dur_ms=$(j '.cost.total_duration_ms')
  if [[ -n "$dur_ms" && "$dur_ms" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    wall_s=$(awk -v m="$dur_ms" 'BEGIN { printf "%d", m/1000 }')
  else
    _scan_transcript_time
    wall_s=$(( last > 0 && first > 0 ? last - first : 0 ))
  fi
  _WALL_COMPUTED=1
}
# Combined entry point for the detailed themes that print active+wall+turns
# together (render_time, etc.). Keeps wall_s payload-first.
_compute_time() { _scan_transcript_time; _compute_wall; }
block_time_active() { _scan_transcript_time; line+="${C}⏱ active $(format_duration "$active_s")${N}"; }
block_time_wall()   { _compute_wall;         line+="${C}⏱ wall $(format_duration "$wall_s")${N}"; }
block_turns()       { _scan_transcript_time; line+="${B}${turns}${D} turns${N}"; }

# ── New payload-driven blocks (all hide-when-absent) ─────────────────
# Each leaves $line untouched when its source data is missing so render_custom
# never joins an empty slot (no stray separators). Dispatched automatically:
# "api-time" → block_api_time, "tokens-session" → block_tokens_session, etc.

# lines — diff churn from .cost.total_lines_added / .total_lines_removed.
# "+156 −23" with the plus green and the minus red. Hidden when both are
# absent or both zero.
block_lines()       {
  local add rem
  add=$(j '.cost.total_lines_added'); rem=$(j '.cost.total_lines_removed')
  add=${add%.*}; rem=${rem%.*}; add=${add:-0}; rem=${rem:-0}
  (( add == 0 && rem == 0 )) && return
  line+="${GR}+${add}${N} ${R}−${rem}${N}"
}
# pr — .pr.number + .pr.review_state → "PR #1234 <state>". Icon by state:
# approved → ✅, changes_requested → ❌, anything else → ⏳. Number bright,
# state muted. Hidden when there's no PR number.
block_pr()          {
  local num st icon
  num=$(j '.pr.number'); [[ -z "$num" ]] && return
  st=$(j '.pr.review_state')
  case "$st" in
    approved)          icon="✅" ;;
    changes_requested) icon="❌" ;;
    *)                 icon="⏳" ;;
  esac
  line+="${icon} ${B}PR #${num}${N}"
  [[ -n "$st" ]] && line+=" ${D}${st}${N}"
}
# worktree — .worktree.name (falls back to .workspace.git_worktree) → "⧉ <name>".
block_worktree()    {
  local wt
  wt=$(j '.worktree.name // .workspace.git_worktree')
  [[ -z "$wt" ]] && return
  line+="${B}⧉ ${wt}${N}"
}
# vim — .vim.mode → "-- NORMAL --" vim-style, yellow.
block_vim()         {
  local m
  m=$(j '.vim.mode'); [[ -z "$m" ]] && return
  local up; up=$(printf '%s' "$m" | tr '[:lower:]' '[:upper:]')
  line+="${Y}-- ${up} --${N}"
}
# agent — .agent.name → "⚙ <name>", magenta.
block_agent()       {
  local a
  a=$(j '.agent.name'); [[ -z "$a" ]] && return
  line+="${M}⚙ ${a}${N}"
}
# repo — .workspace.repo.owner + .name → "owner/name". Owner muted, name bright.
block_repo()        {
  local owner name
  owner=$(j '.workspace.repo.owner'); name=$(j '.workspace.repo.name')
  [[ -z "$owner" && -z "$name" ]] && return
  if [[ -n "$owner" && -n "$name" ]]; then
    line+="${D}${owner}${N}${D}/${N}${B}${name}${N}"
  elif [[ -n "$name" ]]; then
    line+="${B}${name}${N}"
  else
    line+="${D}${owner}${N}"
  fi
}
# api-time — .cost.total_api_duration_ms → "⚡ api <dur>". Under 60s shows
# "X.Xs" (awk %.1f, LC_NUMERIC=C already set globally); ≥ 60s uses
# format_duration on whole seconds.
block_api_time()    {
  local ms
  ms=$(j '.cost.total_api_duration_ms')
  [[ -z "$ms" || ! "$ms" =~ ^[0-9]+([.][0-9]+)?$ ]] && return
  local dur
  if awk -v m="$ms" 'BEGIN { exit !(m < 60000) }'; then
    dur=$(awk -v m="$ms" 'BEGIN { printf "%.1fs", m/1000 }')
  else
    local s; s=$(awk -v m="$ms" 'BEGIN { printf "%d", m/1000 }')
    dur=$(format_duration "$s")
  fi
  line+="${C}⚡ api ${dur}${N}"
}

# Block dispatcher (turns "context-bar" into block_context_bar)
call_block() {
  local b="block_${1//-/_}"
  if declare -F "$b" >/dev/null; then "$b"; fi
}

render_custom() {
  # Builds each block into a temp slot; only non-empty slots get joined with SEP.
  # This way a missing git/limits/etc. block doesn't leave a stray "  ·  ·  " gap.
  line=""
  local saved b out
  for b in $BLOCKS; do
    saved="$line"
    line=""
    call_block "$b"
    out="$line"
    line="$saved"
    if [[ -n "$out" ]]; then
      [[ -n "$line" ]] && line+="${SEP}"
      line+="$out"
    fi
  done
}

# ═════════════════════════════════════════════════════════════════════
#                       DETAILED THEME RENDERERS
# ═════════════════════════════════════════════════════════════════════

# Themed limits suffix — used by every render_* function so the 5h/7d
# meters always appear (even when the theme builds its own line manually).
# Each theme overrides via _lim_<theme> if it wants a custom palette;
# otherwise the default green/dim styling matches the bundle's base palette.
# Reset-window countdown — turns a resets_at epoch into "1.1h" / "1.1d".
#   $1 = resets_at (unix epoch seconds, possibly empty/null/0/fractional)
#   $2 = unit: h → decimal hours (rem/3600), d → decimal days (rem/86400)
# Prints nothing when there's no usable resets_at (back-compat: no {} shown).
_lim_eta() {
  local r="${1%.*}"
  [[ -z "$r" || "$r" == "null" || "$r" == 0 ]] && return
  local rem=$(( r - $(date +%s) ))
  (( rem < 0 )) && rem=0
  case "$2" in
    h) LC_ALL=C awk -v s="$rem" 'BEGIN { printf "%.1fh", s/3600 }' ;;
    d) LC_ALL=C awk -v s="$rem" 'BEGIN { printf "%.1fd", s/86400 }' ;;
  esac
}

_lim_default() {
  local l5 l7 w5 w7 r5 r7 t5 t7 b5 b7
  l5=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used'); l5=${l5%.*}
  l7=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used'); l7=${l7%.*}
  if [[ -z "$l5" && -z "$l7" ]]; then
    # API mode (no subscription limits in payload) — show session tokens.
    # _session_tokens is payload-first (.context_window totals) with a
    # transcript-scan fallback for older Claude Code versions.
    local total
    total=$(_session_tokens)
    local k=$(( ${total:-0} / 1000 ))
    line+="${SEP}${GRD}tokens: ${GR}$(fmt_thin "$k")${GRD}K${N}"
    return
  fi
  r5=$(j '.rate_limits.five_hour.resets_at'); t5=$(_lim_eta "$r5" h); b5=""; [[ -n "$t5" ]] && b5="{$t5}"
  r7=$(j '.rate_limits.seven_day.resets_at'); t7=$(_lim_eta "$r7" d); b7=""; [[ -n "$t7" ]] && b7="{$t7}"
  w5=""; (( ${l5:-0} > 50 )) && w5="⚠️ "
  w7=""; (( ${l7:-0} > 50 )) && w7="⚠️ "
  line+="${SEP}${GRD}5h${b5}:${N} ${w5}${GR}${l5:-—}${GRD}%${N} ${GRD}7d${b7}:${N} ${w7}${GR}${l7:-—}${GRD}%${N}"
}

# Extended tail — used by every detailed theme except `minimal`. Renders the
# standard developer-style segment list after the theme's own intro:
#   tokens-msg · folder · git (or "no git") · 5h/7d limits · thinking.
# Themes keep their branded model + context + cost rendering; this just
# guarantees the same INFO blocks appear in every theme so users get a
# consistent dashboard regardless of which theme they pick.
_ext_tail() {
  line+="${SEP}"; block_tokens_msg
  line+="${SEP}${B}$(basename "$cwd")${N}"
  line+="${SEP}"; if [[ -n "$br" ]]; then block_git; else line+="${RD}no git${N}"; fi
  _lim_default
  line+="${SEP}"; block_thinking
}

render_minimal() {
  local cc=$(pct_color "$ctx_pct") cd=$(pct_color_dim "$ctx_pct")
  line="${G}${model_name}${N}${SEP}${cc}${ctx_pct}${cd}% ${cc}$(bar_vertical "$ctx_pct")${N}${SEP}${G}${cost_fmt}${GD}\$${N}"
  _lim_default
}

render_developer() {
  # Full developer dashboard: model · ctx-icon + % + bar + tokens · cost ·
  # tokens-msg · folder · git · 5h/7d limits · thinking
  local cc=$(pct_color "$ctx_pct") cd=$(pct_color_dim "$ctx_pct")
  local icn
  if   (( ctx_pct < 40 )); then icn="🚀"
  elif (( ctx_pct < 50 )); then icn="🚗"
  elif (( ctx_pct < 70 )); then icn="⚠️"
  else                          icn="🔥"
  fi
  line="${G}${model_name}${N}"
  line+="${SEP}${icn} ${cc}${ctx_pct}${cd}% ${cc}$(bar_vertical "$ctx_pct") ${ctx_used_k}${cd}K${D}/${cc}${ctx_max_k}${cd}K${N}"
  line+="${SEP}${G}${cost_fmt}${GD}\$${N}"
  line+="${SEP}"; block_tokens_msg
  line+="${SEP}${B}$(basename "$cwd")${N}"
  line+="${SEP}"; if [[ -n "$br" ]]; then block_git; else line+="${RD}no git${N}"; fi
  _lim_default
  line+="${SEP}"; block_thinking
}

render_time() {
  _compute_time
  local cc=$(pct_color "$ctx_pct")
  line="${G}${model_name}${N}${SEP}${cc}${ctx_pct}%${N} ${cc}$(bar_vertical "$ctx_pct")${N}"
  line+="${SEP}${C}⏱ ${M}active ${C}$(format_duration "$active_s")${D}/${M}wall ${C}$(format_duration "$wall_s")${N}"
  line+="${SEP}${B}${turns}${D} turns${N}${SEP}${G}${cost_fmt}${GD}\$${N}"
  _ext_tail
}

render_zen() {
  local name=$(printf '%s' "$model_name" | tr '[:upper:]' '[:lower:]')
  line="${name}  ${ctx_pct}%  $(bar_ascii "$ctx_pct")  \$${cost_fmt}"
  _ext_tail
}

render_rainbow() {
  line="${G}${model_name}${N} ${D}·${N} 🌈 $(bar_rainbow "$ctx_pct")${D} ${ctx_pct}%${N} ${D}·${N} ${G}${cost_fmt}${GD}\$${N}"
  _ext_tail
}

render_anime() {
  local face
  if   (( ctx_pct < 30 )); then face='(◕‿◕)'
  elif (( ctx_pct < 60 )); then face='(´｡• ω •｡`)'
  elif (( ctx_pct < 85 )); then face='(>﹏<)'
  else                          face='(╥﹏╥)'
  fi
  line="${P}✨ ${V}${model_name} ${P}✨${N}"
  line+=" ${M}🌸 ${P}${ctx_pct}${PD}% $(bar_simple "$ctx_pct" "$M" "$PD" "♥" "♡") ${M}🌸${N}"
  line+=" ${V}${cost_fmt}${PD}\$${N} ${P}uwu ${M}${face}${N}"
  _ext_tail
}

render_love() {
  local heart
  if   (( ctx_pct < 30 )); then heart='💕'
  elif (( ctx_pct < 60 )); then heart='💖'
  elif (( ctx_pct < 85 )); then heart='❤️'
  else                          heart='💔'
  fi
  line="💖 ${P}${model_name}${N} ❤ ${PD}love-meter${N} $(bar_simple "$ctx_pct" "$R" "$PD" "▰" "▱") ${R}${ctx_pct}${PD}%${N}"
  line+=" ${D}·${N} ${PD}spent${N} ${R}${cost_fmt}${RU}\$${N} ${PD}on us${N} ${D}·${N} ${heart}"
  _ext_tail
}

render_cat() {
  local mood
  if   (( ctx_pct < 30 )); then mood="${P}=^.^= purr${N}"
  elif (( ctx_pct < 60 )); then mood="${O}(=ↀωↀ=) chirp${N}"
  elif (( ctx_pct < 85 )); then mood="${Y}(=^◕ᴥ◕^=) meow?${N}"
  else                          mood="${P}(=ＴェＴ=) HISS${N}"
  fi
  local b="" i cells=$(( (ctx_pct + 5) / 10 ))
  for (( i=0; i<cells;     i++ )); do b+="${O}🐾"; done
  for (( i=0; i<10-cells;  i++ )); do b+="${D}··"; done
  line="🐱 ${W}${model_name}${N} ${D}·${N} ${O}purrs${N} ${b}${N} ${O}${ctx_pct}%${N}"
  line+=" ${D}·${N} ${P}treats:${N} ${Y}${cost_fmt}\$${N} ${D}·${N} ${mood}"
  _ext_tail
}

render_christmas() {
  local icn
  if   (( ctx_pct < 30 )); then icn="${R}🎅 ho ho ho${N}"
  elif (( ctx_pct < 60 )); then icn="${GR}🎁 unwrapping${N}"
  elif (( ctx_pct < 85 )); then icn="${G}⭐ silent night${N}"
  else                          icn="${R}🦌 sleigh's full${N}"
  fi
  line="🎄 ${W}${model_name}${N} ${D}·${N} 🎁 $(bar_simple "$ctx_pct" "$R" "$WD" "❅" "❄") ${R}${ctx_pct}%${N}"
  line+=" ${D}·${N} ${GR}gifts:${N} ${G}${cost_fmt}\$${N} ${D}·${N} ${icn}"
  _ext_tail
}

render_hacker() {
  local host=$(hostname -s 2>/dev/null || echo matrix)
  line="${GRDD}[${GR}SYS${GRDD}]${N} ${W}${model_name}${N}"
  line+=" ${GRDD}::${N} ${GR}CTX${GRDD}=${GR}${ctx_pct}%${N} $(bar_hacker "$ctx_pct")"
  line+=" ${GRDD}::${N} ${GR}\$${cost_fmt}${N}"
  line+=" ${GRDD}::${N} ${GR}ROOT${GRDD}@${GR}${host}${GRDD}#${N}"
  _ext_tail
}

render_cyberpunk() {
  local chrome=$(to_chrome "$model_name")
  line="${M}▌▌▌${N} ${C}${chrome}${N} ${M}▐▐▐${N}"
  line+=" ${MD}//${C}CTX${MD}:${C}${ctx_pct}%${N} $(bar_simple "$ctx_pct" "$M" "$D2" "▰" "▱")"
  line+=" ${MD}//${Y2}₵RED${MD}:${Y2}${cost_fmt}${N}"
  line+=" ${M}▐${N} ${C}JACK-IN${N}"
  _ext_tail
}

render_space() {
  local mission
  if   (( ctx_pct < 40 )); then mission="${GR}🌌 nominal${N}"
  elif (( ctx_pct < 70 )); then mission="${Y}☄ caution${N}"
  elif (( ctx_pct < 90 )); then mission="${R}🛸 warning${N}"
  else                          mission="${R}🔥 MAYDAY${N}"
  fi
  line="🚀 ${W}${model_name}${N} ${D}·${N} ${C}O₂${N} $(bar_simple "$ctx_pct" "$C" "$D2" "▰" "▱") ${C}${ctx_pct}${CD}%${N}"
  line+=" ${D}·${N} ${V2}fuel${N} ${B}${cost_fmt}${CD}\$${N} ${D}·${N} ${mission}"
  _ext_tail
}

render_retro() {
  local chrome=$(to_chrome "$model_name") hp=$(( 100 - ctx_pct ))
  local score=$(awk -v c="$cost" 'BEGIN { printf "%04d", c*100 }')
  line="${O}▀▄▀▄${N} ${W}${chrome}${N} ${O}▄▀▄▀${N}"
  line+=" ${R}HP:${hp}${N} $(bar_simple "$hp" "$GR" "$D2" "▰" "▱")"
  line+=" ${B}MP:${ctx_pct}${N} ${O}SCORE:${score}${N}"
  _ext_tail
}

render_fire() {
  local intensity
  if   (( ctx_pct < 30 )); then intensity="${Y}🕯 ember${N}"
  elif (( ctx_pct < 60 )); then intensity="${O}🔥 burning${N}"
  elif (( ctx_pct < 85 )); then intensity="${R}🔥 INFERNO${N}"
  else                          intensity="${R}🌋 LAVA${N}"
  fi
  line="🔥 ${W}${model_name}${N} ${D}·${N} ${intensity} $(bar_fire "$ctx_pct") ${R}${ctx_pct}%${N} ${D}·${N} ${DR}ash${N} ${O}${cost_fmt}\$${N}"
  _ext_tail
}

render_ocean() {
  local depth
  if   (( ctx_pct < 30 )); then depth="${C}🐠 surface${N}"
  elif (( ctx_pct < 60 )); then depth="${B}🐟 shallow${N}"
  elif (( ctx_pct < 85 )); then depth="${BD}🦑 deep${N}"
  else                          depth="${DB}🐋 abyss${N}"
  fi
  line="🌊 ${W}${model_name}${N} ${D}·${N} ${C}tide${N} $(bar_wave "$ctx_pct") ${C}${ctx_pct}${CD}%${N}"
  line+=" ${D}·${N} ${B}${cost_fmt}\$${N} ${D}·${N} ${depth}"
  _ext_tail
}

render_weather() {
  local icn
  if   (( ctx_pct < 30 )); then icn="${Y}☀${N} ${WD}clear skies${N}"
  elif (( ctx_pct < 60 )); then icn="${WD}⛅ partly cloudy${N}"
  elif (( ctx_pct < 80 )); then icn="${B}🌧 rain incoming${N}"
  else                          icn="${PR}⛈ STORM — compact soon${N}"
  fi
  line="${W}${model_name}${N} ${D}·${N} ${icn} ${D}·${N} ${ctx_pct}% $(bar_sparks "$ctx_pct") ${D}·${N} ${cost_fmt}\$"
  _ext_tail
}

render_coffee() {
  local left=$(( 100 - ctx_pct ))
  local cups=$(awk -v c="$cost" 'BEGIN { printf "%d", c*4 }')
  line="☕ ${W}${model_name}${N} ${D}·${N} ${BG}brew level${N} $(bar_simple "$left" "$BR" "$BRD" "█" "░") ${BR}${left}${BRD}%${N}"
  line+=" ${D}·${N} ${BG}cups:${N} ${BR}${cups}${N} ${D}·${N} ${G}${cost_fmt}${BRD}\$${N}"
  _ext_tail
}

render_music() {
  local tempo
  if   (( ctx_pct < 30 )); then tempo="${V2}🎼 largo${N}"
  elif (( ctx_pct < 60 )); then tempo="${V2}🎶 andante${N}"
  elif (( ctx_pct < 85 )); then tempo="${V2}🎵 allegro${N}"
  else                          tempo="${M}🎤 presto!${N}"
  fi
  line="🎵 ${W}${model_name}${N} ${D}·${N} $(bar_notes "$ctx_pct") ${M}${ctx_pct}%${N}"
  line+=" ${D}·${N} ${G}♩ ${cost_fmt}\$${N} ${D}·${N} ${tempo}"
  _ext_tail
}

render_game() {
  local hp=$(( 100 - ctx_pct ))
  local level=$(awk -v c="$cost" 'BEGIN { printf "%d", c+1 }')
  line="⚔ ${W}${model_name}${N} ${D}·${N} ${R}HP${N} $(bar_simple "$hp" "$R" "$RD2" "█" "░") ${R}${hp}${RD2}/100${N}"
  line+=" ${D}·${N} ${B}MP${N} $(bar_simple "$ctx_pct" "$B" "$BD" "█" "░") ${B}${ctx_pct}${BD}%${N}"
  line+=" ${D}·${N} ${G}gold ${cost_fmt}\$${N} ${D}·${N} ${M}LV ${level}${N}"
  _ext_tail
}

render_pirate() {
  local mood
  if   (( ctx_pct < 40 )); then mood='☠ Yarrr!'
  elif (( ctx_pct < 70 )); then mood='🦜 squawk!'
  elif (( ctx_pct < 90 )); then mood='⚠ shiver me timbers'
  else                          mood='🌊 ABANDON SHIP'
  fi
  line="🏴‍☠️ ${W}Cap'n ${G}${model_name}${N} ⚓"
  line+=" ${BR}ye plundered${N} ${G}${ctx_pct}%${N} $(bar_simple "$ctx_pct" "$G" "$BR" "█" "-")"
  line+=" ${D}·${N} ${BR}doubloons:${N} ${G}${cost_fmt}${GD}\$${N} ${D}·${N} ${R}${mood}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                   AUTOMOTIVE BRAND THEMES (17)
# ═════════════════════════════════════════════════════════════════════

# ── Europe ───────────────────────────────────────────────────────────
render_porsche() {
  line="${R}● ${W}PORSCHE${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${R}${ctx_pct}${RD2}%${N} $(bar_simple "$ctx_pct" "$R" "$RD2" "▰" "▱")"
  line+="${SEP}${WD}€${G}${cost_fmt}${N}"
  _ext_tail
}

render_mercedes() {
  line="${WD}✦ ${W}MERCEDES-BENZ${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$WD" "$D2" "▰" "▱")"
  line+="${SEP}${WD}€${B}${cost_fmt}${N}"
  _ext_tail
}

render_bmw() {
  line="${B}M${W}//${B}BMW${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$W" "▰" "▱")${N}"
  line+="${SEP}${BD}€${B}${cost_fmt}${N}"
  _ext_tail
}

render_ferrari() {
  line="${R}🐎 FERRARI${N} ${YD}·${N} ${W}rosso · ${model_name}${N}"
  line+="${SEP}${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$Y" "▰" "▱")"
  line+="${SEP}${Y}€${R}${cost_fmt}${N}"
  _ext_tail
}

render_volvo() {
  line="${WD}♂ ${B}VOLVO${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${WD}safe ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$D2" "█" "░")"
  line+="${SEP}${B}kr ${WD}${cost_fmt}${N}"
  _ext_tail
}

# ── America ──────────────────────────────────────────────────────────
render_ford() {
  line="${B}⊰${W}FORD${B}⊱${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${B}built ${C}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")${N}"
  line+="${SEP}${WD}\$${B}${cost_fmt}${N}"
  _ext_tail
}

render_chevy() {
  line="${Y}⋈ ${B}CHEVROLET${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${Y}SS ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$Y" "$BD" "▰" "▱")"
  line+="${SEP}${Y}\$${B}${cost_fmt}${N}"
  _ext_tail
}

render_jeep() {
  line="${BR}⊞⊞⊞⊞⊞⊞⊞${N} ${W}JEEP${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${BR}trail ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$BR" "$BRD" "▰" "▱")${N}"
  line+="${SEP}${BR}\$${G}${cost_fmt}${N}"
  _ext_tail
}

render_cadillac() {
  line="${WD}✧ ${W}CADILLAC${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${R}prestige ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$WD" "$D2" "█" "░")${N}"
  line+="${SEP}${WD}\$${R}${cost_fmt}${N}"
  _ext_tail
}

# ── Japan ────────────────────────────────────────────────────────────
render_toyota() {
  line="${R}⊝ ${W}TOYOTA${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${R}drive ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")${N}"
  line+="${SEP}${R}¥${W}${cost_fmt}${N}"
  _ext_tail
}

render_honda() {
  line="${R}Ⓗ ${W}HONDA${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${R}vtec ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$R" "$D2" "█" "░")${N}"
  line+="${SEP}${R}¥${W}${cost_fmt}${N}"
  _ext_tail
}

render_nissan() {
  line="${R}Ⓝ ${W}NISSAN${N} ${D}·${N} ${WD}GT-R · ${W}${model_name}${N}"
  line+="${SEP}${R}rpm ${C}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")${N}"
  line+="${SEP}${R}¥${W}${cost_fmt}${N}"
  _ext_tail
}

# ── Korea ────────────────────────────────────────────────────────────
render_hyundai() {
  line="${B}Ⓗ ${W}HYUNDAI${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${B}new ${C}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")${N}"
  line+="${SEP}${B}₩${W}${cost_fmt}${N}"
  _ext_tail
}

render_kia() {
  line="${R}Ⓚ ${W}KIA${N} ${D}·${N} ${W}${model_name}${N} ${D}·${N} ${WD}EV9${N}"
  line+="${SEP}${R}charge ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")${N}"
  line+="${SEP}${R}₩${W}${cost_fmt}${N}"
  _ext_tail
}

# ── China ────────────────────────────────────────────────────────────
render_byd() {
  line="${GR}⚡ ${W}BYD${N} ${D}·${N} ${WD}build-your-dream · ${W}${model_name}${N}"
  line+="${SEP}${GR}🔋 ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$GR" "$D2" "▰" "▱")${N}"
  line+="${SEP}${GR}¥${W}${cost_fmt}${N}"
  _ext_tail
}

render_nio() {
  line="${C}◐ ${W}NIO${N} ${D}·${N} ${W}${model_name}${N} ${D}·${N} ${WD}ET7${N}"
  line+="${SEP}${C}drive ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$C" "$D2" "▰" "▱")${N}"
  line+="${SEP}${C}¥${W}${cost_fmt}${N}"
  _ext_tail
}

render_geely() {
  line="${B}◆ ${W}GEELY${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${B}global ${C}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")${N}"
  line+="${SEP}${B}¥${W}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                    GREAT SCIENTIST THEMES (10)
# ═════════════════════════════════════════════════════════════════════

render_einstein() {
  line="${WD}Ψ ${W}Einstein${N} ${D}·${N} ${G}E=mc²${N}"
  line+="${SEP}${G}c ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$G" "$D2" "█" "░")${N}"
  line+="${SEP}${WD}ε ${G}${cost_fmt}${N}"
  _ext_tail
}

render_newton() {
  line="${R}🍎 ${W}Newton${N} ${D}·${N} ${BR}F = ma${N}"
  line+="${SEP}${BR}gravity ${R}${ctx_pct}${RU}% $(bar_simple "$ctx_pct" "$R" "$BRD" "█" "░")${N}"
  line+="${SEP}${BR}£${R}${cost_fmt}${N}"
  _ext_tail
}

render_curie() {
  line="${GR}☢ ${W}Curie${N} ${D}·${N} ${GR}Ra · Po${N}"
  line+="${SEP}${GR}half-life ${C}${ctx_pct}${GRD}% $(bar_simple "$ctx_pct" "$GR" "$GRDD" "▰" "▱")${N}"
  line+="${SEP}${GR}⚛ ${C}${cost_fmt}${N}"
  _ext_tail
}

render_tesla() {
  line="${V}⚡ ${W}Tesla${N} ${D}·${N} ${Y}AC ~${N}"
  line+="${SEP}${V}coil ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$Y" "$V2" "▰" "▱")${N}"
  line+="${SEP}${V}⚡ ${Y}${cost_fmt}${N}"
  _ext_tail
}

render_darwin() {
  line="${G}🐢 ${W}Darwin${N} ${D}·${N} ${G}HMS Beagle${N}"
  line+="${SEP}${G}adapt ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$G" "$D2" "▰" "▱")${N}"
  line+="${SEP}${BR}£${G}${cost_fmt}${N}"
  _ext_tail
}

render_hawking() {
  line="${V}🌌 ${W}Hawking${N} ${D}·${N} ${V2}t → ∞${N}"
  line+="${SEP}${V}horizon ${C}${ctx_pct}${V2}% $(bar_simple "$ctx_pct" "$V" "$D2" "▰" "▱")${N}"
  line+="${SEP}${V}⌬ ${W}${cost_fmt}${N}"
  _ext_tail
}

render_galileo() {
  line="${Y}🔭 ${W}Galileo${N} ${D}·${N} ${Y}☉ → eppur si muove${N}"
  line+="${SEP}${Y}orbits ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$Y" "$BD" "▰" "▱")${N}"
  line+="${SEP}${Y}✦ ${W}${cost_fmt}${N}"
  _ext_tail
}

render_feynman() {
  line="${G}〰 ${W}Feynman${N} ${D}·${N} ${G}ψ → ψ'${N}"
  line+="${SEP}${G}qed ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$G" "$WD" "═" "─")${N}"
  line+="${SEP}${G}⊳ ${W}${cost_fmt}${N}"
  _ext_tail
}

render_turing() {
  line="${GR}Ⓣ ${W}Turing${N} ${D}·${N} ${GR}h(p) ↻${N}"
  line+="${SEP}${GR}halt? ${R}${ctx_pct}${RU}% $(bar_simple "$ctx_pct" "$GR" "$GRDD" "1" "0")${N}"
  line+="${SEP}${GR}0x${R}${cost_fmt}${N}"
  _ext_tail
}

render_davinci() {
  line="${BR}✎ ${W}da Vinci${N} ${D}·${N} ${BR}Vitruvian${N}"
  line+="${SEP}${BR}sketch ${Y}${ctx_pct}${BRD}% $(bar_simple "$ctx_pct" "$BR" "$BRD" "▰" "▱")${N}"
  line+="${SEP}${BR}ƒ ${Y}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                          TOP 5 ANIME (5)
# ═════════════════════════════════════════════════════════════════════

render_dragonball() {
  local kai
  if   (( ctx_pct < 30 )); then kai="${O}🐉 base${N}"
  elif (( ctx_pct < 60 )); then kai="${Y}⚡ super saiyan${N}"
  elif (( ctx_pct < 85 )); then kai="${B}💧 ssj blue${N}"
  else                          kai="${V}🟣 ultra instinct${N}"
  fi
  line="${O}🐉 ${Y}DRAGON BALL${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${Y}KI ${O}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$O" "$Y" "▰" "▱")${N}"
  line+="${SEP}${Y}zeni ${O}${cost_fmt}${N} ${D}·${N} ${kai}"
  _ext_tail
}

render_naruto() {
  line="${O}🍃 ${Y}NARUTO${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${O}chakra ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$O" "$G" "▰" "▱")${N}"
  line+="${SEP}${O}🌀 rasengan ${cost_fmt}${N}"
  _ext_tail
}

render_onepiece() {
  line="${R}🏴‍☠️ ${Y}ONE PIECE${N} ${D}·${N} ${W}Mugiwara · ${model_name}${N}"
  line+="${SEP}${R}gum-gum ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$R" "$Y" "▰" "▱")${N}"
  line+="${SEP}${Y}berry ${R}${cost_fmt}${N}"
  _ext_tail
}

render_pokemon() {
  line="${Y}⚡ ${R}POKÉMON${N} ${D}·${N} ${Y}Pikachu · ${W}${model_name}${N}"
  line+="${SEP}${R}HP ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$Y" "$R" "█" "░")${N}"
  line+="${SEP}${R}⚪ poké ${Y}${cost_fmt}${N}"
  _ext_tail
}

render_ghibli() {
  line="${G}🌳 ${W}Ghibli${N} ${D}·${N} ${WD}Totoro · ${model_name}${N}"
  line+="${SEP}${G}leaves ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$G" "$WD" "✿" "·")${N}"
  line+="${SEP}${G}🌱 ${C}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                       MARVEL SUPERHEROES (10)
# ═════════════════════════════════════════════════════════════════════

render_ironman() {
  line="${R}🦾 ${Y}IRON MAN${N} ${D}·${N} ${W}Stark · ${model_name}${N}"
  line+="${SEP}${R}arc ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$Y" "$R" "▰" "▱")${N}"
  line+="${SEP}${Y}\$${R}${cost_fmt}${N}"
  _ext_tail
}

render_spiderman() {
  line="${R}🕷 ${B}SPIDER-MAN${N} ${D}·${N} ${W}Parker · ${model_name}${N}"
  line+="${SEP}${R}web ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$R" "$B" "▰" "▱")${N}"
  line+="${SEP}${R}\$${B}${cost_fmt}${N}"
  _ext_tail
}

render_hulk() {
  local mood
  if   (( ctx_pct < 50 )); then mood="${G}calm Banner${N}"
  elif (( ctx_pct < 80 )); then mood="${G}HULK angry${N}"
  else                          mood="${G}HULK SMASH${N}"
  fi
  line="${G}🟢 ${W}HULK${N} ${D}·${N} ${V}${model_name}${N}"
  line+="${SEP}${G}rage ${V}${ctx_pct}${V2}% $(bar_simple "$ctx_pct" "$G" "$D2" "█" "░")${N}"
  line+="${SEP}${G}\$${V}${cost_fmt}${N} ${D}·${N} ${mood}"
  _ext_tail
}

render_thor() {
  line="${Y}⚡ ${R}THOR${N} ${D}·${N} ${WD}Mjölnir · ${W}${model_name}${N}"
  line+="${SEP}${Y}storm ${R}${ctx_pct}${RU}% $(bar_simple "$ctx_pct" "$Y" "$R" "▰" "▱")${N}"
  line+="${SEP}${Y}⚒ ${R}${cost_fmt}${N}"
  _ext_tail
}

render_captain_america() {
  line="${R}🛡 ${B}CAPTAIN AMERICA${N} ${D}·${N} ${W}Rogers · ${model_name}${N}"
  line+="${SEP}${B}duty ${R}${ctx_pct}${RU}% $(bar_simple "$ctx_pct" "$R" "$B" "█" "░")${N}"
  line+="${SEP}${R}\$${B}${cost_fmt}${N}"
  _ext_tail
}

render_wolverine() {
  line="${Y}🗡 ${B}WOLVERINE${N} ${D}·${N} ${W}Logan · ${model_name}${N}"
  line+="${SEP}${Y}snikt ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$Y" "$B" "▰" "▱")${N}"
  line+="${SEP}${Y}\$${B}${cost_fmt}${N}"
  _ext_tail
}

render_deadpool() {
  line="${R}🌮 ${W}DEADPOOL${N} ${D}·${N} ${WD}Wade · ${model_name}${N}"
  line+="${SEP}${R}max-effort ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")${N}"
  line+="${SEP}${R}\$${WD}${cost_fmt}${N}"
  _ext_tail
}

render_blackwidow() {
  line="${R}🕸 ${W}BLACK WIDOW${N} ${D}·${N} ${WD}Romanoff · ${model_name}${N}"
  line+="${SEP}${R}ops ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")${N}"
  line+="${SEP}${R}\$${WD}${cost_fmt}${N}"
  _ext_tail
}

render_strange() {
  line="${V}🔮 ${R}DR. STRANGE${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${V}mystic ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$V" "$Y" "✦" "·")${N}"
  line+="${SEP}${V}⌬ ${Y}${cost_fmt}${N}"
  _ext_tail
}

render_wanda() {
  line="${R}🌹 ${V}SCARLET WITCH${N} ${D}·${N} ${W}Wanda · ${model_name}${N}"
  line+="${SEP}${R}chaos ${V}${ctx_pct}${V2}% $(bar_simple "$ctx_pct" "$R" "$V" "▰" "▱")${N}"
  line+="${SEP}${R}🪄 ${V}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                      OPERATING SYSTEM THEMES (10)
# ═════════════════════════════════════════════════════════════════════

render_macos() {
  # Six-color rainbow on the brand mark, then chrome-grey body
  line="${G}🍎${R} m${O}a${Y}c${GR}O${B}S${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$WD" "$D2" "█" "░")${N}"
  line+="${SEP}${WD}\$${G}${cost_fmt}${N}"
  _ext_tail
}

render_windows() {
  # Fluent 11: four-color tile + cyan body
  line="${R}⊞${GR}⊞${B}⊞${Y}⊞${N} ${C}WINDOWS 11${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$C" "$BD" "█" "░")${N}"
  line+="${SEP}${C}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_linux() {
  line="${O}🐧 ${W}GNU/Linux${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${O}tux ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$O" "$D2" "█" "░")${N}"
  line+="${SEP}${O}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_ubuntu() {
  line="${O}⊕ ${W}UBUNTU${N} ${D}·${N} ${V}${model_name}${N}"
  line+="${SEP}${O}friend ${V}${ctx_pct}${V2}% $(bar_simple "$ctx_pct" "$O" "$V2" "▰" "▱")${N}"
  line+="${SEP}${O}\$${V}${cost_fmt}${N}"
  _ext_tail
}

render_arch() {
  line="${C}▲ ${W}ARCH${N} ${D}·${N} ${WD}btw · ${W}${model_name}${N}"
  line+="${SEP}${C}pacman ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$C" "$BD" "█" "░")${N}"
  line+="${SEP}${C}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_debian() {
  line="${R}🌀 ${W}DEBIAN${N} ${D}·${N} ${WD}sid · ${W}${model_name}${N}"
  line+="${SEP}${R}stable ${WD}${ctx_pct}${D}% $(bar_simple "$ctx_pct" "$R" "$D2" "█" "░")${N}"
  line+="${SEP}${R}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_fedora() {
  line="${B}🎩 ${W}FEDORA${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${B}freedom ${C}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$BD" "█" "░")${N}"
  line+="${SEP}${B}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_kali() {
  line="${B}🐉 ${W}KALI${N} ${D}·${N} ${R}offsec · ${WD}${model_name}${N}"
  line+="${SEP}${R}pwn ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$B" "$D2" "▰" "▱")${N}"
  line+="${SEP}${B}\$${R}${cost_fmt}${N}"
  _ext_tail
}

render_mint() {
  line="${GR}🌿 ${W}MINT${N} ${D}·${N} ${WD}cinnamon · ${W}${model_name}${N}"
  line+="${SEP}${GR}fresh ${C}${ctx_pct}${CD}% $(bar_simple "$ctx_pct" "$GR" "$D2" "▰" "▱")${N}"
  line+="${SEP}${GR}\$${W}${cost_fmt}${N}"
  _ext_tail
}

render_nixos() {
  line="${C}❄ ${W}NIXOS${N} ${D}·${N} ${WD}declarative · ${W}${model_name}${N}"
  line+="${SEP}${C}reproducible ${B}${ctx_pct}${BD}% $(bar_simple "$ctx_pct" "$C" "$B" "▰" "▱")${N}"
  line+="${SEP}${C}\$${W}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                  WORLD RELIGION THEMES (top 7 by adherents)
#
#  Symbols used are universally accepted religious-identity glyphs
#  (✝ ☪ 🕉 ☸ ✡ ☬ ⛩). Currency choices reflect majority-adherent
#  countries: € (Vatican), ﷼ (SAR), ₹ (India), ฿ (Thailand),
#  ₪ (Israel), ₹ (Sikh-majority Punjab), ¥ (Japan).
# ═════════════════════════════════════════════════════════════════════

render_christianity() {
  # Wine-red + Marian blue + papal gold on cream
  line="${R}✝ ${W}CHRISTIANITY${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${R}faith ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$R" "$G" "▰" "▱")${N}"
  line+="${SEP}${R}€${G}${cost_fmt}${N}"
  _ext_tail
}

render_islam() {
  # Islamic green + white + gold for calligraphy
  line="${GR}☪ ${W}ISLAM${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${GR}taqwa ${W}${ctx_pct}${WD}% $(bar_simple "$ctx_pct" "$GR" "$WD" "▰" "▱")${N}"
  line+="${SEP}${GR}﷼ ${W}${cost_fmt}${N}"
  _ext_tail
}

render_hinduism() {
  # Saffron + marigold yellow + vermilion
  line="${O}🕉 ${Y}HINDUISM${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${O}dharma ${Y}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$O" "$Y" "▰" "▱")${N}"
  line+="${SEP}${O}seva ${Y}₹${O}${cost_fmt}${N}"
  _ext_tail
}

render_buddhism() {
  # Monk saffron + gold + maroon (Tibetan tradition)
  line="${O}☸ ${G}BUDDHISM${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${O}karma ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$O" "$G" "▰" "▱")${N}"
  line+="${SEP}${O}dāna ${G}฿${O}${cost_fmt}${N}"
  _ext_tail
}

render_judaism() {
  # Tallit blue + white + menorah gold
  line="${B}✡ ${W}JUDAISM${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${B}mitzvah ${G}${ctx_pct}${GD}% $(bar_simple "$ctx_pct" "$B" "$WD" "▰" "▱")${N}"
  line+="${SEP}${B}tzedakah ${G}₪${B}${cost_fmt}${N}"
  _ext_tail
}

render_sikhism() {
  # Khalsa deep blue + saffron + white (Nishan Sahib)
  line="${B}☬ ${O}SIKHISM${N} ${D}·${N} ${W}${model_name}${N}"
  line+="${SEP}${B}sewa ${O}${ctx_pct}${YD}% $(bar_simple "$ctx_pct" "$B" "$O" "▰" "▱")${N}"
  line+="${SEP}${O}daswandh ${B}₹${O}${cost_fmt}${N}"
  _ext_tail
}

render_shinto() {
  # Vermilion torii red + shrine white + gold
  line="${R}⛩ ${W}SHINTO${N} ${D}·${N} ${WD}${model_name}${N}"
  line+="${SEP}${R}kami ${W}${ctx_pct}${WD}% $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")${N}"
  line+="${SEP}${R}saisen ${W}¥${R}${cost_fmt}${N}"
  _ext_tail
}

# ═════════════════════════════════════════════════════════════════════
#                       COMPACT THEME RENDERER
#                  (model · context % + bar · branch)
# ═════════════════════════════════════════════════════════════════════

render_compact() {
  local theme="${1#}"
  case "$theme" in
    minimal|developer|time|rainbow)
      line="${G}${model_name}${N} ${D}·${N} ${GR}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    zen)
      local name=$(printf '%s' "$model_name" | tr '[:upper:]' '[:lower:]')
      line="${name}  ${ctx_pct}%"
      [[ -n "$br" ]] && line+="  ${br}"
      _lim_default
      ;;
    anime)
      line="${P}✨ ${V}${model_name}${N} 🌸 ${P}${ctx_pct}${PD}%${N} $(bar_simple "$ctx_pct" "$M" "$PD" "♥" "♡")"
      [[ -n "$br" ]] && line+=" ${M}🌸${N} ${P}${br}${N}"
      _lim_default
      ;;
    love)
      line="💖 ${P}${model_name}${N} ${D}·${N} $(bar_simple "$ctx_pct" "$R" "$PD" "▰" "▱") ${R}${ctx_pct}${PD}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} 💕 ${R}${br}${N}"
      _lim_default
      ;;
    cat)
      local b="" i cells=$(( (ctx_pct + 5) / 10 ))
      for (( i=0; i<cells;     i++ )); do b+="${O}🐾"; done
      for (( i=0; i<10-cells;  i++ )); do b+="${D}··"; done
      line="🐱 ${W}${model_name}${N} ${D}·${N} ${b}${N} ${O}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${P}${br}${N}"
      _lim_default
      ;;
    christmas)
      line="🎄 ${W}${model_name}${N} ${D}·${N} $(bar_simple "$ctx_pct" "$R" "$WD" "❅" "❄") ${R}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${GR}${br}${N}"
      _lim_default
      ;;
    hacker)
      line="${GRDD}[${GR}SYS${GRDD}]${N} ${W}${model_name}${N} ${GRDD}::${N} ${GR}${ctx_pct}%${N} $(bar_hacker "$ctx_pct")"
      [[ -n "$br" ]] && line+=" ${GRDD}::${N} ${GR}${br}${N}"
      _lim_default
      ;;
    cyberpunk)
      local chrome=$(to_chrome "$model_name")
      line="${M}▌${N} ${C}${chrome}${N} ${MD}//${C}CTX${MD}:${C}${ctx_pct}%${N} $(bar_simple "$ctx_pct" "$M" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${MD}//${C}BR${MD}:${C}${br}${N}"
      _lim_default
      ;;
    space)
      line="🚀 ${W}${model_name}${N} ${D}·${N} ${C}O₂${N} $(bar_simple "$ctx_pct" "$C" "$D2" "▰" "▱") ${C}${ctx_pct}${CD}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} 🌌 ${B}${br}${N}"
      _lim_default
      ;;
    retro)
      local chrome=$(to_chrome "$model_name")
      line="${O}▀▄${N} ${W}${chrome}${N} $(bar_simple "$ctx_pct" "$GR" "$D2" "▰" "▱") ${B}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${O}${br}${N}"
      _lim_default
      ;;
    fire)
      line="🔥 ${W}${model_name}${N} ${D}·${N} $(bar_fire "$ctx_pct") ${R}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${O}${br}${N}"
      _lim_default
      ;;
    ocean)
      line="🌊 ${W}${model_name}${N} ${D}·${N} $(bar_wave "$ctx_pct") ${C}${ctx_pct}${CD}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    weather)
      local icn
      if   (( ctx_pct < 30 )); then icn="${Y}☀${N}"
      elif (( ctx_pct < 60 )); then icn="${WD}⛅${N}"
      elif (( ctx_pct < 80 )); then icn="${B}🌧${N}"
      else                          icn="${PR}⛈${N}"
      fi
      line="${icn} ${W}${model_name}${N} ${D}·${N} ${ctx_pct}% $(bar_sparks "$ctx_pct")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    coffee)
      local left=$(( 100 - ctx_pct ))
      line="☕ ${W}${model_name}${N} ${D}·${N} $(bar_simple "$left" "$BR" "$BRD" "█" "░") ${BR}${left}${BRD}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${BR}${br}${N}"
      _lim_default
      ;;
    music)
      line="🎵 ${W}${model_name}${N} ${D}·${N} $(bar_notes "$ctx_pct") ${M}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}♩ ${br}${N}"
      _lim_default
      ;;
    game)
      local hp=$(( 100 - ctx_pct ))
      line="⚔ ${W}${model_name}${N} ${D}·${N} ${R}HP:${hp}${N} $(bar_simple "$hp" "$R" "$RD2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    pirate)
      line="🏴‍☠️ ${W}${model_name}${N} ${D}·${N} ${G}${ctx_pct}%${N} $(bar_simple "$ctx_pct" "$G" "$BR" "█" "-")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ⚓ ${G}${br}${N}"
      _lim_default
      ;;
    porsche)
      line="${R}● ${W}PORSCHE${N} ${D}·${N} ${R}${ctx_pct}${RD2}%${N} $(bar_simple "$ctx_pct" "$R" "$RD2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${WD}🏁 ${br}${N}"
      _lim_default
      ;;
    mercedes)
      line="${WD}✦ ${W}MERCEDES${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$WD" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    bmw)
      line="${B}M${W}//${B}BMW${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$W" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    ferrari)
      line="${R}🐎 FERRARI${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$Y" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${Y}${br}${N}"
      _lim_default
      ;;
    volvo)
      line="${WD}♂ ${B}VOLVO${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    ford)
      line="${B}⊰FORD⊱${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    chevy)
      line="${Y}⋈ ${B}CHEVROLET${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$Y" "$BD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${Y}${br}${N}"
      _lim_default
      ;;
    jeep)
      line="${BR}⊞⊞⊞${N} ${W}JEEP${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$BR" "$BRD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${BR}${br}${N}"
      _lim_default
      ;;
    cadillac)
      line="${WD}✧ ${W}CADILLAC${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$WD" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    toyota)
      line="${R}⊝ ${W}TOYOTA${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}⛩ ${W}${br}${N}"
      _lim_default
      ;;
    honda)
      line="${R}Ⓗ ${W}HONDA${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    nissan)
      line="${R}Ⓝ ${W}NISSAN${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    hyundai)
      line="${B}Ⓗ ${W}HYUNDAI${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    kia)
      line="${R}Ⓚ ${W}KIA${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}${br}${N}"
      _lim_default
      ;;
    byd)
      line="${GR}⚡ ${W}BYD${N} ${D}·${N} ${C}${ctx_pct}${CD}%${N} $(bar_simple "$ctx_pct" "$GR" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${GR}${br}${N}"
      _lim_default
      ;;
    nio)
      line="${C}◐ ${W}NIO${N} ${D}·${N} ${C}${ctx_pct}${CD}%${N} $(bar_simple "$ctx_pct" "$C" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    geely)
      line="${B}◆ ${W}GEELY${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$BD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    einstein)
      line="${WD}Ψ ${W}Einstein${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$G" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}${br}${N}"
      _lim_default
      ;;
    newton)
      line="${R}🍎 ${W}Newton${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$BRD" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${BR}${br}${N}"
      _lim_default
      ;;
    curie)
      line="${GR}☢ ${W}Curie${N} ${D}·${N} ${GR}${ctx_pct}${GRD}%${N} $(bar_simple "$ctx_pct" "$GR" "$GRDD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    tesla)
      line="${V}⚡ ${W}Tesla${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$Y" "$V2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${V}${br}${N}"
      _lim_default
      ;;
    darwin)
      line="${G}🐢 ${W}Darwin${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$G" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}${br}${N}"
      _lim_default
      ;;
    hawking)
      line="${V}🌌 ${W}Hawking${N} ${D}·${N} ${V}${ctx_pct}${V2}%${N} $(bar_simple "$ctx_pct" "$V" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    galileo)
      line="${Y}🔭 ${W}Galileo${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$Y" "$BD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    feynman)
      line="${G}〰 ${W}Feynman${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$G" "$WD" "═" "─")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${WD}${br}${N}"
      _lim_default
      ;;
    turing)
      line="${GR}Ⓣ ${W}Turing${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$GR" "$GRDD" "1" "0")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${GR}${br}${N}"
      _lim_default
      ;;
    davinci)
      line="${BR}✎ ${W}da Vinci${N} ${D}·${N} ${Y}${ctx_pct}${BRD}%${N} $(bar_simple "$ctx_pct" "$BR" "$BRD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${BR}${br}${N}"
      _lim_default
      ;;
    dragonball)
      line="${O}🐉 ${Y}DRAGON BALL${N} ${D}·${N} ${O}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$O" "$Y" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${O}${br}${N}"
      _lim_default
      ;;
    naruto)
      line="${O}🍃 ${Y}NARUTO${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$O" "$G" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}${br}${N}"
      _lim_default
      ;;
    onepiece)
      line="${R}🏴‍☠️ ${Y}ONE PIECE${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$R" "$Y" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    pokemon)
      line="${Y}⚡ ${R}POKÉMON${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$Y" "$R" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${Y}${br}${N}"
      _lim_default
      ;;
    ghibli)
      line="${G}🌳 ${W}Ghibli${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$G" "$WD" "✿" "·")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${G}${br}${N}"
      _lim_default
      ;;
    ironman)
      line="${R}🦾 ${Y}IRON MAN${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$Y" "$R" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${Y}${br}${N}"
      _lim_default
      ;;
    spiderman)
      line="${R}🕷 ${B}SPIDER-MAN${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$R" "$B" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    hulk)
      line="${G}🟢 ${W}HULK${N} ${D}·${N} ${V}${ctx_pct}${V2}%${N} $(bar_simple "$ctx_pct" "$G" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${V}${br}${N}"
      _lim_default
      ;;
    thor)
      line="${Y}⚡ ${R}THOR${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$Y" "$R" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    captain-america)
      line="${R}🛡 ${B}CAP${N} ${D}·${N} ${R}${ctx_pct}${RU}%${N} $(bar_simple "$ctx_pct" "$R" "$B" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    wolverine)
      line="${Y}🗡 ${B}WOLVERINE${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$Y" "$B" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${Y}${br}${N}"
      _lim_default
      ;;
    deadpool)
      line="${R}🌮 ${W}DEADPOOL${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    blackwidow)
      line="${R}🕸 ${W}WIDOW${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$R" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    strange)
      line="${V}🔮 ${R}STRANGE${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$V" "$Y" "✦" "·")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${V}${br}${N}"
      _lim_default
      ;;
    wanda)
      line="${R}🌹 ${V}WANDA${N} ${D}·${N} ${V}${ctx_pct}${V2}%${N} $(bar_simple "$ctx_pct" "$R" "$V" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${V}${br}${N}"
      _lim_default
      ;;
    macos)
      line="${G}🍎${R} m${O}a${Y}c${GR}O${B}S${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$WD" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${WD}${br}${N}"
      _lim_default
      ;;
    windows)
      line="${R}⊞${GR}⊞${B}⊞${Y}⊞${N} ${C}WINDOWS${N} ${D}·${N} ${C}${ctx_pct}${CD}%${N} $(bar_simple "$ctx_pct" "$C" "$BD" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    linux)
      line="${O}🐧 ${W}LINUX${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$O" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${O}${br}${N}"
      _lim_default
      ;;
    ubuntu)
      line="${O}⊕ ${W}UBUNTU${N} ${D}·${N} ${V}${ctx_pct}${V2}%${N} $(bar_simple "$ctx_pct" "$O" "$V2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${V}${br}${N}"
      _lim_default
      ;;
    arch)
      line="${C}▲ ${W}ARCH${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$C" "$BD" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    debian)
      line="${R}🌀 ${W}DEBIAN${N} ${D}·${N} ${WD}${ctx_pct}${D}%${N} $(bar_simple "$ctx_pct" "$R" "$D2" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    fedora)
      line="${B}🎩 ${W}FEDORA${N} ${D}·${N} ${C}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$BD" "█" "░")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    kali)
      line="${B}🐉 ${W}KALI${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$B" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    mint)
      line="${GR}🌿 ${W}MINT${N} ${D}·${N} ${C}${ctx_pct}${CD}%${N} $(bar_simple "$ctx_pct" "$GR" "$D2" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${GR}${br}${N}"
      _lim_default
      ;;
    nixos)
      line="${C}❄ ${W}NIXOS${N} ${D}·${N} ${B}${ctx_pct}${BD}%${N} $(bar_simple "$ctx_pct" "$C" "$B" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${C}${br}${N}"
      _lim_default
      ;;
    christianity)
      line="${R}✝ ${W}CHRISTIANITY${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$R" "$G" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    islam)
      line="${GR}☪ ${W}ISLAM${N} ${D}·${N} ${W}${ctx_pct}${WD}%${N} $(bar_simple "$ctx_pct" "$GR" "$WD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${GR}${br}${N}"
      _lim_default
      ;;
    hinduism)
      line="${O}🕉 ${Y}HINDUISM${N} ${D}·${N} ${Y}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$O" "$Y" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${O}${br}${N}"
      _lim_default
      ;;
    buddhism)
      line="${O}☸ ${G}BUDDHISM${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$O" "$G" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${O}${br}${N}"
      _lim_default
      ;;
    judaism)
      line="${B}✡ ${W}JUDAISM${N} ${D}·${N} ${G}${ctx_pct}${GD}%${N} $(bar_simple "$ctx_pct" "$B" "$WD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    sikhism)
      line="${B}☬ ${O}SIKHISM${N} ${D}·${N} ${O}${ctx_pct}${YD}%${N} $(bar_simple "$ctx_pct" "$B" "$O" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
    shinto)
      line="${R}⛩ ${W}SHINTO${N} ${D}·${N} ${W}${ctx_pct}${WD}%${N} $(bar_simple "$ctx_pct" "$R" "$WD" "▰" "▱")"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${R}${br}${N}"
      _lim_default
      ;;
    *)
      line="${G}${model_name}${N} ${D}·${N} ${GR}${ctx_pct}%${N}"
      [[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"
      _lim_default
      ;;
  esac
}

# ═════════════════════════════════════════════════════════════════════
#                              DISPATCHER
# ═════════════════════════════════════════════════════════════════════

render_main() {
  local input
  input=$(cat)
  parse_input "$input"
  line=""

  if [[ "$THEME" == "custom" ]]; then
    render_custom
  elif [[ "$THEME" == *"-compact" ]]; then
    render_compact "${THEME%-compact}"
  else
    local fn="render_${THEME//-/_}"
    if declare -F "$fn" >/dev/null; then
      "$fn"
    else
      render_minimal
    fi
  fi

  printf '%s\n' "$line"
}

# ── Main entry: detect mode ──────────────────────────────────────────
# • Any args → CLI mode (configurator)
# • No args + stdin is a TTY → CLI mode (show current config + help)
# • No args + stdin is a pipe (Claude Code) → render mode
if (( $# > 0 )); then
  cli_dispatch "$@"
elif [[ -t 0 ]]; then
  cli_dispatch show
else
  render_main
fi
