#!/usr/bin/env bash
set -uo pipefail

# ─── PRECHECK: jq ─────────────────────────────────────────────────────
# jq parses Claude Code's stdin JSON and the per-message usage in the
# transcript. Without it the line renders empty. Fail loudly with install
# hints rather than silently returning blanks.
if ! command -v jq >/dev/null 2>&1; then
  printf '\e[1;38;5;196mstatus-line: jq not found\e[0m — install it:\n' >&2
  printf '  Ubuntu/Debian:  sudo apt-get install -y jq\n' >&2
  printf '  Fedora/RHEL:    sudo dnf install -y jq\n' >&2
  printf '  Arch:           sudo pacman -S jq\n' >&2
  printf '  macOS (brew):   brew install jq\n' >&2
  printf '  Alpine:         sudo apk add jq\n' >&2
  printf 'jq required — see stderr\n'
  exit 0
fi

# Force C numeric formatting (decimal dot in 1.1h / 0.42$ / 87.5K) regardless
# of the user's locale, while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C

input=$(cat)

# Bright ANSI 256-colors
G=$'\e[1;38;5;220m'   # gold (bright, for digits)
GD=$'\e[38;5;178m'    # gold (dim, for $ sign)
GR=$'\e[1;38;5;46m'   # green (bright, digits)
GRD=$'\e[38;5;34m'    # green (dim, units/labels)
Y=$'\e[1;38;5;226m'   # yellow (bright, digits)
YD=$'\e[38;5;184m'    # yellow (dim, units)
R=$'\e[1;38;5;196m'   # red (bright, digits)
RU=$'\e[38;5;160m'    # red (dim, units)
RD=$'\e[38;5;131m'    # red (very dim, for "git init...")
B=$'\e[1;38;5;39m'    # blue (bright, for git branch)
C=$'\e[1;38;5;51m'    # cyan (bright, digits)
CD=$'\e[38;5;38m'     # cyan (dim, units/arrows)
M=$'\e[1;38;5;201m'   # magenta (bright)
W=$'\e[1;38;5;255m'   # white
D=$'\e[38;5;244m'     # gray separator
N=$'\e[0m'            # reset

SEP=" ${D}│${N} "

# Bar style: "vertical" (▏▎▍▌▋▊▉█, 8 levels = 1.25% step)
#            "quadrant" (▖▄▙█,    4 levels = 2.5% step)
BAR_STYLE="quadrant"

pct_color() {
  local p=${1%.*}
  [[ -z "$p" ]] && p=0
  if   (( p < 50 )); then printf '%s' "$GR"
  elif (( p < 70 )); then printf '%s' "$Y"
  else                    printf '%s' "$R"
  fi
}

pct_icon() {
  local p=${1%.*}
  [[ -z "$p" ]] && p=0
  if   (( p < 40 )); then printf '🚀'
  elif (( p < 50 )); then printf '🚗'
  else                    printf '⚠️'
  fi
}

pct_color_dim() {
  local p=${1%.*}
  [[ -z "$p" ]] && p=0
  if   (( p < 50 )); then printf '%s' "$GRD"
  elif (( p < 70 )); then printf '%s' "$YD"
  else                    printf '%s' "$RU"
  fi
}

bar_vertical() {
  # 10 cells, 8 sub-levels per cell (1.25% per eighth).
  local pct=$1
  local eighths=$(( (pct * 8 + 5) / 10 ))
  local full=$(( eighths / 8 ))
  local part=$(( eighths % 8 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
  local s="" i
  for (( i=0; i<full;  i++ )); do s+="█"; done
  (( part > 0 )) &&                    s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

bar_quadrant() {
  # 10 cells, 4 sub-levels per cell (2.5% per quarter); diagonal corner fill.
  local pct=$1
  local quarters=$(( (pct * 4 + 5) / 10 ))
  local full=$(( quarters / 4 ))
  local part=$(( quarters % 4 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▖" "▄" "▙")
  local s="" i
  for (( i=0; i<full;  i++ )); do s+="█"; done
  (( part > 0 )) &&                    s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

bar() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  (( pct < 0   )) && pct=0
  case "$BAR_STYLE" in
    vertical) bar_vertical "$pct" ;;
    *)        bar_quadrant "$pct" ;;
  esac
}

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

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

model_disp=$(j '.model.display_name')
model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"

cwd=$(j '.workspace.current_dir')
[[ -z "$cwd" ]] && cwd=$(j '.cwd')
[[ -z "$cwd" ]] && cwd="$PWD"

cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')

# Rate limits — Claude Code does NOT pipe 5h / 7d limits into the statusline JSON
# and does not cache them on disk; they're only fetched live by /usage.
# Left as best-effort lookups in case a future version exposes them.
lim5h=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used // .rate_limits.session.percent // .rate_limits["5h"].percent // .rate_limits.short.percent')
lim7d=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used  // .rate_limits.weekly.percent  // .rate_limits["7d"].percent // .rate_limits.long.percent')
lim5h_reset=$(j '.rate_limits.five_hour.resets_at')
lim7d_reset=$(j '.rate_limits.seven_day.resets_at')

# Thinking / effort level (Claude Code stdin field is .effort.level)
thinking=$(j '.effort.level // .thinking.level // .thinking // .model.thinking_level // .output_style.name')
[[ -z "$thinking" ]] && thinking="default"

# Context window — payload-first.
# When Claude Code supplies a .context_window object on stdin we trust it
# verbatim (one jq call → all 6 fields via @tsv) and skip the transcript scan.
# Older Claude Code versions omit it: fall back to the historical heuristic
# ([1m]/1M/exceeds_200k → ctx_max) plus a last-usage grep of the transcript.
ctx_window_present=$(j 'if .context_window then "1" else "" end')
in_tok=0; out_tok=0; cr=0; cc=0
ctx_max=""; ctx_pct=""

if [[ -n "$ctx_window_present" ]]; then
  IFS=$'\t' read -r cw_size cw_pct in_tok out_tok cr cc < <(
    jq -r '.context_window as $w
           | [ ($w.context_window_size // 0),
               ($w.used_percentage // 0),
               ($w.current_usage.input_tokens // 0),
               ($w.current_usage.output_tokens // 0),
               ($w.current_usage.cache_read_input_tokens // 0),
               ($w.current_usage.cache_creation_input_tokens // 0) ]
           | @tsv' 2>/dev/null <<<"$input")
  in_tok=${in_tok:-0}; out_tok=${out_tok:-0}; cr=${cr:-0}; cc=${cc:-0}
  ctx_max=${cw_size:-0}; (( ctx_max == 0 )) && ctx_max=200000
  ctx_pct=${cw_pct%%.*}; ctx_pct=${ctx_pct:-0}
else
  if [[ "$model_id" == *"[1m]"* ]] || [[ "$model_disp" == *"1M"* ]] || [[ "$model_disp" == *"1m"* ]] || [[ "$exceeds_200k" == "true" ]]; then
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
if [[ -z "$ctx_pct" ]]; then
  ctx_pct=$(awk -v u="$ctx_used" -v m="$ctx_max" 'BEGIN { if (m>0) printf "%d", u*100/m; else print 0 }')
fi
ctx_used_k=$(awk -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')
ctx_max_k=$(awk  -v v="$ctx_max"  'BEGIN { printf "%d",   v/1000 }')

out_k=$(awk -v v="$out_tok"  'BEGIN { printf "%.1f", v/1000 }')
in_k=$(awk  -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')

cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')

folder=$(basename "$cwd")

# Git
git_part="${RD}git init...${N}"
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  git_part="${B}⎇ ${br}${N}"
fi

ctx_color=$(pct_color "$ctx_pct")
ctx_color_dim=$(pct_color_dim "$ctx_pct")
ctx_bar=$(bar "$ctx_pct")

fmt_thin() {
  local n=$1 result="" len i
  len=${#n}
  for ((i=0; i<len; i++)); do
    (( i > 0 && (len-i) % 3 == 0 )) && result+=$'\xe2\x80\x89'
    result+="${n:$i:1}"
  done
  printf '%s' "$result"
}

if [[ -z "$lim5h" && -z "$lim7d" ]]; then
  # API mode (no 5h/7d limits) — show total spent tokens for the session.
  # Payload-first: when .context_window carries running totals, sum those and
  # skip the transcript; otherwise scan the transcript usage lines as before.
  sess_total=0
  if [[ -n "$ctx_window_present" ]]; then
    sess_total=$(jq -r '(.context_window.total_input_tokens // 0)
                        + (.context_window.total_output_tokens // 0)' <<<"$input" 2>/dev/null)
    [[ -z "$sess_total" ]] && sess_total=0
  elif [[ -n "$transcript" && -f "$transcript" ]]; then
    sess_total=$(grep '"usage"' "$transcript" 2>/dev/null \
      | jq -s '[.[] | select(.message.usage) | .message.usage
               | ((.input_tokens // 0) + (.output_tokens // 0)
                  + (.cache_creation_input_tokens // 0)
                  + (.cache_read_input_tokens // 0))] | add // 0' 2>/dev/null)
    [[ -z "$sess_total" ]] && sess_total=0
  fi
  sess_k=$(( sess_total / 1000 ))
  sess_fmt=$(fmt_thin "$sess_k")
  limits_part="${GRD}tokens: ${C}${sess_fmt}${CD}K${N}"
else
  t5=$(_lim_eta "$lim5h_reset" h); b5=""; [[ -n "$t5" ]] && b5="{$t5}"
  t7=$(_lim_eta "$lim7d_reset" d); b7=""; [[ -n "$t7" ]] && b7="{$t7}"
  if [[ -n "$lim5h" ]]; then
    l5=${lim5h%.*}
    warn5=""; (( l5 > 50 )) && warn5="⚠️ "
    lim5_str="${warn5}$(pct_color "$l5")${l5}$(pct_color_dim "$l5")%${N}"
  else
    lim5_str="${D}—${N}"
  fi
  if [[ -n "$lim7d" ]]; then
    l7=${lim7d%.*}
    warn7=""; (( l7 > 50 )) && warn7="⚠️ "
    lim7_str="${warn7}$(pct_color "$l7")${l7}$(pct_color_dim "$l7")%${N}"
  else
    lim7_str="${D}—${N}"
  fi
  limits_part="${GRD}5h${b5}: ${N}${lim5_str} ${GRD}7d${b7}: ${N}${lim7_str}"
fi

# Compose
line="${G}${model_name}${N}"
line+="${SEP}$(pct_icon "$ctx_pct") ${ctx_color}${ctx_pct}${ctx_color_dim}% ${ctx_color}${ctx_bar} ${ctx_used_k}${ctx_color_dim}K${D}/${ctx_color}${ctx_max_k}${ctx_color_dim}K${N}"
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"
line+="${SEP}${CD}↑${C}${out_k}${CD}K ${CD}↓${C}${in_k}${CD}K${N}"
line+="${SEP}${B}${folder}${N}"
line+="${SEP}${git_part}"
line+="${SEP}${limits_part}"
line+="${SEP}🤖 ${C}${thinking}${N}"

printf '%s\n' "$line"
