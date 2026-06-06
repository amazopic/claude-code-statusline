#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-time.sh — human-hours tracker for Claude Code
#
# Preview:
#   Opus 4.7 · 12% █▌░░░░░░░░ · ⏱ active 1h23m / wall 2h45m · 47 turns · 0.42$
#
# Tracks how much actual time you've spent on a session:
#   • active — sum of inter-message gaps shorter than 5 min ("on keyboard")
#   • wall   — total span from first to last message
#   • turns  — number of user/assistant message pairs
#
# Timestamps are pulled from the JSONL transcript via jq, trying
# .timestamp, .created_at, and .message.created_at in that order. If
# none are present, falls back to file mtime - ctime for wall time.
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C

input=$(cat)
LIM=$' \e[38;5;240m·\e[0m \e[38;5;75m5h{1.1h}:\e[0m \e[1;38;5;226m15%\e[0m \e[38;5;240m·\e[0m \e[38;5;75m7d{1.1d}:\e[0m \e[1;38;5;226m5%\e[0m'

G=$'\e[1;38;5;220m'
GR=$'\e[1;38;5;46m'
GRD=$'\e[38;5;34m'
Y=$'\e[1;38;5;226m'
YD=$'\e[38;5;184m'
R=$'\e[1;38;5;196m'
RU=$'\e[38;5;160m'
GD=$'\e[38;5;178m'
B=$'\e[1;38;5;39m'
C=$'\e[1;38;5;51m'
CD=$'\e[38;5;38m'
M=$'\e[1;38;5;201m'
D=$'\e[38;5;244m'
N=$'\e[0m'

SEP=" ${D}·${N} "

# Idle threshold (seconds): gaps larger than this don't count as "active".
IDLE_THRESHOLD=300

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  (( pct < 0 ))   && pct=0
  local eighths=$(( (pct * 8 + 5) / 10 ))
  local full=$(( eighths / 8 ))
  local part=$(( eighths % 8 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
  local s="" i
  for (( i=0; i<full; i++ )); do s+="█"; done
  (( part > 0 )) && s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

pct_color() {
  local p=${1%.*}; [[ -z "$p" ]] && p=0
  if   (( p < 50 )); then printf '%s' "$GR"
  elif (( p < 70 )); then printf '%s' "$Y"
  else                    printf '%s' "$R"
  fi
}

# Convert ISO-8601 / RFC3339 / epoch-string to epoch seconds.
# macOS BSD date and GNU date have different syntaxes — try both.
to_epoch() {
  local ts="$1"
  [[ -z "$ts" ]] && { echo 0; return; }
  # already epoch?
  if [[ "$ts" =~ ^[0-9]+$ ]]; then echo "$ts"; return; fi
  # strip fractional seconds and timezone Z for portability
  local clean="${ts%%.*}"
  clean="${clean%Z}"
  clean="${clean//T/ }"
  # macOS BSD date
  local out
  out=$(date -j -f '%Y-%m-%d %H:%M:%S' "$clean" +%s 2>/dev/null) && { echo "$out"; return; }
  # GNU date
  out=$(date -d "$ts" +%s 2>/dev/null) && { echo "$out"; return; }
  echo 0
}

format_duration() {
  local s=$1
  (( s < 0 )) && s=0
  local h=$(( s / 3600 ))
  local m=$(( (s % 3600) / 60 ))
  if   (( h > 0 )); then printf '%dh%02dm' "$h" "$m"
  elif (( m > 0 )); then printf '%dm' "$m"
  else                   printf '%ds' "$s"
  fi
}

model_disp=$(j '.model.display_name')
model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"

cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')

transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')
if [[ "$model_id" == *"[1m]"* ]] || [[ "$model_disp" == *"1M"* ]] || [[ "$exceeds_200k" == "true" ]]; then
  ctx_max=1000000
else
  ctx_max=200000
fi

# Latest usage for context %
in_tok=0; cr=0; cc=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  last=$(grep '"usage"' "$transcript" 2>/dev/null | tail -1)
  if [[ -n "$last" ]]; then
    in_tok=$(jq -r '.message.usage.input_tokens // 0'                <<<"$last" 2>/dev/null || echo 0)
    cr=$(jq     -r '.message.usage.cache_read_input_tokens // 0'     <<<"$last" 2>/dev/null || echo 0)
    cc=$(jq     -r '.message.usage.cache_creation_input_tokens // 0' <<<"$last" 2>/dev/null || echo 0)
  fi
fi
ctx_used=$(( in_tok + cr + cc ))
ctx_pct=$(awk -v u="$ctx_used" -v m="$ctx_max" 'BEGIN { if (m>0) printf "%d", u*100/m; else print 0 }')
ctx_color=$(pct_color "$ctx_pct")

# ── Time tracking ────────────────────────────────────────────────────
active_s=0; wall_s=0; turns=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  # Extract per-line timestamps as epoch seconds (one per line, 0 if missing).
  ts_list=$(jq -r '.timestamp // .created_at // .message.created_at // empty' "$transcript" 2>/dev/null)
  prev=0; first=0; last=0
  while IFS= read -r ts; do
    [[ -z "$ts" ]] && continue
    e=$(to_epoch "$ts")
    (( e == 0 )) && continue
    (( first == 0 )) && first=$e
    last=$e
    if (( prev > 0 )); then
      gap=$(( e - prev ))
      (( gap > 0 && gap < IDLE_THRESHOLD )) && active_s=$(( active_s + gap ))
    fi
    prev=$e
    turns=$(( turns + 1 ))
  done <<< "$ts_list"
  if (( first > 0 && last > 0 )); then
    wall_s=$(( last - first ))
  else
    # fallback: file mtime - ctime
    mt=$(stat -f %m "$transcript" 2>/dev/null || stat -c %Y "$transcript" 2>/dev/null)
    ct=$(stat -f %B "$transcript" 2>/dev/null || stat -c %W "$transcript" 2>/dev/null)
    [[ -n "$mt" && -n "$ct" && "$ct" != "-" && "$ct" != "0" ]] && wall_s=$(( mt - ct ))
  fi
fi

active_str=$(format_duration "$active_s")
wall_str=$(format_duration "$wall_s")

# ── Compose ──────────────────────────────────────────────────────────
line="${G}${model_name}${N}"
line+="${SEP}${ctx_color}${ctx_pct}%${N} ${ctx_color}$(bar "$ctx_pct")${N}"
line+="${SEP}${C}⏱ ${M}active ${C}${active_str}${D}/${M}wall ${C}${wall_str}${N}"
line+="${SEP}${B}${turns}${D} turns${N}"
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"

line+="$LIM"
printf '%s\n' "$line"
