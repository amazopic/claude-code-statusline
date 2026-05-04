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
#
#  Config is stored at: ~/.claude/statusline.conf
#
#  ─────────────────────────  THEMES  ──────────────────────────
#
#    minimal · developer · time · zen · rainbow · anime · love
#    cat · christmas · hacker · cyberpunk · space · retro · fire
#    ocean · weather · coffee · music · game · pirate
#
#  Append "-compact" to any name for the compact variant
#  (model · context · branch only).
#
#  ─────────────────────────  BLOCKS  ──────────────────────────
#
#    model · context · context-pct · context-bar · cost · folder
#    git · git-branch · tokens-msg · tokens-session · limits
#    thinking · time-active · time-wall · turns · host · cups
#    level · mood-icon
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

# ─────────────────────────  CONFIG  ───────────────────────────────────
CONFIG_FILE="${HOME}/.claude/statusline.conf"
DEFAULT_THEME="minimal"
THEME=""
BLOCKS=""
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE" 2>/dev/null
[[ -z "$THEME" ]] && THEME="$DEFAULT_THEME"

# ─────────────────────────  ALL THEMES  ───────────────────────────────
THEMES=(minimal developer time zen rainbow anime love cat christmas hacker
        cyberpunk space retro fire ocean weather coffee music game pirate)

# ─────────────────────────  ALL BLOCKS  ───────────────────────────────
BLOCKS_LIST=(model context context-pct context-bar cost folder
             git git-branch tokens-msg tokens-session limits thinking
             time-active time-wall turns host cups level mood-icon)

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

EXAMPLES
  statusline use cyberpunk
  statusline use cyberpunk-compact
  statusline custom model context-bar git cost
  statusline preview anime

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

render_with_fixture() {
  local fixture
  fixture='{"model":{"display_name":"Opus 4.7 (1M context)","id":"claude-opus-4-7[1m]"},"workspace":{"current_dir":"'"$PWD"'"},"cost":{"total_cost_usd":0.42},"transcript_path":""}'
  printf '%s' "$fixture" | render_main
}

cli_dispatch() {
  case "${1:-show}" in
    help|-h|--help) cli_help ;;
    list)           shift; cli_list "$@" ;;
    use)            shift; cli_use "$@" ;;
    custom)         shift; cli_custom "$@" ;;
    preview)        shift; cli_preview "$@" ;;
    preview-all)    cli_preview_all ;;
    show)           cli_show ;;
    reset)          cli_reset ;;
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
  if [[ "$model_id" == *"[1m]"* || "$model_disp" == *"1M"* || "$exceeds_200k" == "true" ]]; then
    ctx_max=1000000
  else
    ctx_max=200000
  fi

  in_tok=0; out_tok=0; cr=0; cc=0
  if [[ -n "$transcript" && -f "$transcript" ]]; then
    last=$(grep '"usage"' "$transcript" 2>/dev/null | tail -1)
    if [[ -n "$last" ]]; then
      in_tok=$(jq  -r '.message.usage.input_tokens // 0'                <<<"$last" 2>/dev/null || echo 0)
      out_tok=$(jq -r '.message.usage.output_tokens // 0'               <<<"$last" 2>/dev/null || echo 0)
      cr=$(jq      -r '.message.usage.cache_read_input_tokens // 0'     <<<"$last" 2>/dev/null || echo 0)
      cc=$(jq      -r '.message.usage.cache_creation_input_tokens // 0' <<<"$last" 2>/dev/null || echo 0)
    fi
  fi
  ctx_used=$(( in_tok + cr + cc ))
  ctx_pct=$(awk -v u="$ctx_used" -v m="$ctx_max" 'BEGIN { if (m>0) printf "%d", u*100/m; else print 0 }')
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
block_tokens_session() {
  local total=0
  if [[ -n "$transcript" && -f "$transcript" ]]; then
    total=$(grep '"usage"' "$transcript" 2>/dev/null \
      | jq -s '[.[] | select(.message.usage) | .message.usage
               | ((.input_tokens // 0) + (.output_tokens // 0)
                  + (.cache_creation_input_tokens // 0)
                  + (.cache_read_input_tokens // 0))] | add // 0' 2>/dev/null)
  fi
  local k=$(( ${total:-0} / 1000 ))
  line+="${GRD}tokens: ${C}$(fmt_thin "$k")${CD}K${N}"
}
block_limits()      {
  local l5 l7 w5 w7
  l5=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used'); l5=${l5%.*}
  l7=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used'); l7=${l7%.*}
  if [[ -z "$l5" && -z "$l7" ]]; then
    # API mode — payload carries no subscription limits; fall back to tokens.
    block_tokens_session
    return
  fi
  w5=""; (( ${l5:-0} > 50 )) && w5="⚠️ "
  w7=""; (( ${l7:-0} > 50 )) && w7="⚠️ "
  line+="${GRD}5h:${N} ${w5}${GR}${l5:-—}${GRD}%${N} ${GRD}7d:${N} ${w7}${GR}${l7:-—}${GRD}%${N}"
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

# Time-tracking blocks (computed lazily)
_TIME_COMPUTED=0
_compute_time() {
  (( _TIME_COMPUTED == 1 )) && return
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
  wall_s=$(( last > 0 && first > 0 ? last - first : 0 ))
  _TIME_COMPUTED=1
}
block_time_active() { _compute_time; line+="${C}⏱ active $(format_duration "$active_s")${N}"; }
block_time_wall()   { _compute_time; line+="${C}⏱ wall $(format_duration "$wall_s")${N}"; }
block_turns()       { _compute_time; line+="${B}${turns}${D} turns${N}"; }

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
_lim_default() {
  local l5 l7 w5 w7
  l5=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used'); l5=${l5%.*}
  l7=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used'); l7=${l7%.*}
  if [[ -z "$l5" && -z "$l7" ]]; then
    # API mode (no subscription limits in payload) — show session tokens
    local total=0
    if [[ -n "${transcript:-}" && -f "$transcript" ]]; then
      total=$(grep '"usage"' "$transcript" 2>/dev/null \
        | jq -s '[.[] | select(.message.usage) | .message.usage
                 | ((.input_tokens // 0) + (.output_tokens // 0)
                    + (.cache_creation_input_tokens // 0)
                    + (.cache_read_input_tokens // 0))] | add // 0' 2>/dev/null)
    fi
    local k=$(( ${total:-0} / 1000 ))
    line+="${SEP}${GRD}tokens: ${GR}$(fmt_thin "$k")${GRD}K${N}"
    return
  fi
  w5=""; (( ${l5:-0} > 50 )) && w5="⚠️ "
  w7=""; (( ${l7:-0} > 50 )) && w7="⚠️ "
  line+="${SEP}${GRD}5h:${N} ${w5}${GR}${l5:-—}${GRD}%${N} ${GRD}7d:${N} ${w7}${GR}${l7:-—}${GRD}%${N}"
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
  _lim_default
}

render_zen() {
  local name=$(printf '%s' "$model_name" | tr '[:upper:]' '[:lower:]')
  line="${name}  ${ctx_pct}%  $(bar_ascii "$ctx_pct")  \$${cost_fmt}"
  [[ -n "$br" ]] && line+="  ${br}"
  _lim_default
}

render_rainbow() {
  line="${G}${model_name}${N} ${D}·${N} 🌈 $(bar_rainbow "$ctx_pct")${D} ${ctx_pct}%${N} ${D}·${N} ${G}${cost_fmt}${GD}\$${N}"
  _lim_default
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
  _lim_default
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
  _lim_default
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
  _lim_default
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
  _lim_default
}

render_hacker() {
  local host=$(hostname -s 2>/dev/null || echo matrix)
  line="${GRDD}[${GR}SYS${GRDD}]${N} ${W}${model_name}${N}"
  line+=" ${GRDD}::${N} ${GR}CTX${GRDD}=${GR}${ctx_pct}%${N} $(bar_hacker "$ctx_pct")"
  line+=" ${GRDD}::${N} ${GR}\$${cost_fmt}${N}"
  line+=" ${GRDD}::${N} ${GR}ROOT${GRDD}@${GR}${host}${GRDD}#${N}"
  _lim_default
}

render_cyberpunk() {
  local chrome=$(to_chrome "$model_name")
  line="${M}▌▌▌${N} ${C}${chrome}${N} ${M}▐▐▐${N}"
  line+=" ${MD}//${C}CTX${MD}:${C}${ctx_pct}%${N} $(bar_simple "$ctx_pct" "$M" "$D2" "▰" "▱")"
  line+=" ${MD}//${Y2}₵RED${MD}:${Y2}${cost_fmt}${N}"
  line+=" ${M}▐${N} ${C}JACK-IN${N}"
  _lim_default
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
  _lim_default
}

render_retro() {
  local chrome=$(to_chrome "$model_name") hp=$(( 100 - ctx_pct ))
  local score=$(awk -v c="$cost" 'BEGIN { printf "%04d", c*100 }')
  line="${O}▀▄▀▄${N} ${W}${chrome}${N} ${O}▄▀▄▀${N}"
  line+=" ${R}HP:${hp}${N} $(bar_simple "$hp" "$GR" "$D2" "▰" "▱")"
  line+=" ${B}MP:${ctx_pct}${N} ${O}SCORE:${score}${N}"
  _lim_default
}

render_fire() {
  local intensity
  if   (( ctx_pct < 30 )); then intensity="${Y}🕯 ember${N}"
  elif (( ctx_pct < 60 )); then intensity="${O}🔥 burning${N}"
  elif (( ctx_pct < 85 )); then intensity="${R}🔥 INFERNO${N}"
  else                          intensity="${R}🌋 LAVA${N}"
  fi
  line="🔥 ${W}${model_name}${N} ${D}·${N} ${intensity} $(bar_fire "$ctx_pct") ${R}${ctx_pct}%${N} ${D}·${N} ${DR}ash${N} ${O}${cost_fmt}\$${N}"
  _lim_default
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
  _lim_default
}

render_weather() {
  local icn
  if   (( ctx_pct < 30 )); then icn="${Y}☀${N} ${WD}clear skies${N}"
  elif (( ctx_pct < 60 )); then icn="${WD}⛅ partly cloudy${N}"
  elif (( ctx_pct < 80 )); then icn="${B}🌧 rain incoming${N}"
  else                          icn="${PR}⛈ STORM — compact soon${N}"
  fi
  line="${W}${model_name}${N} ${D}·${N} ${icn} ${D}·${N} ${ctx_pct}% $(bar_sparks "$ctx_pct") ${D}·${N} ${cost_fmt}\$"
  _lim_default
}

render_coffee() {
  local left=$(( 100 - ctx_pct ))
  local cups=$(awk -v c="$cost" 'BEGIN { printf "%d", c*4 }')
  line="☕ ${W}${model_name}${N} ${D}·${N} ${BG}brew level${N} $(bar_simple "$left" "$BR" "$BRD" "█" "░") ${BR}${left}${BRD}%${N}"
  line+=" ${D}·${N} ${BG}cups:${N} ${BR}${cups}${N} ${D}·${N} ${G}${cost_fmt}${BRD}\$${N}"
  _lim_default
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
  _lim_default
}

render_game() {
  local hp=$(( 100 - ctx_pct ))
  local level=$(awk -v c="$cost" 'BEGIN { printf "%d", c+1 }')
  line="⚔ ${W}${model_name}${N} ${D}·${N} ${R}HP${N} $(bar_simple "$hp" "$R" "$RD2" "█" "░") ${R}${hp}${RD2}/100${N}"
  line+=" ${D}·${N} ${B}MP${N} $(bar_simple "$ctx_pct" "$B" "$BD" "█" "░") ${B}${ctx_pct}${BD}%${N}"
  line+=" ${D}·${N} ${G}gold ${cost_fmt}\$${N} ${D}·${N} ${M}LV ${level}${N}"
  _lim_default
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
  _lim_default
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
