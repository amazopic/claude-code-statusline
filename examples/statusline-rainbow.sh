#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-rainbow.sh — joyful rainbow progress bar for Claude Code
#
# Preview:
#   Opus 4.7 · 🌈 ▮▮▮▮▮▮▮▮▯▯ · 0.42$
#
# Each filled cell of the progress bar uses a different color from a
# fixed 10-step gradient (red → orange → yellow → green → cyan → blue →
# violet → pink). Empty cells are dim gray.
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C

input=$(cat)
LIM=$' \e[1;38;5;196m5\e[1;38;5;208mh{1.1h}\e[1;38;5;226m:\e[0m \e[1;38;5;46m1\e[1;38;5;51m5\e[1;38;5;201m%\e[0m \e[38;5;240m·\e[0m \e[1;38;5;226m7\e[1;38;5;46md{1.1d}\e[1;38;5;51m:\e[0m \e[1;38;5;201m5\e[1;38;5;196m%\e[0m'

G=$'\e[1;38;5;220m'
GD=$'\e[38;5;178m'
D=$'\e[38;5;238m'
DG=$'\e[38;5;244m'
N=$'\e[0m'

# 10-step gradient for the bar (256-color codes).
GRADIENT=(196 202 208 220 226 154 46 51 39 129)

SEP=" ${DG}·${N} "

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_rainbow() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  (( pct < 0 ))   && pct=0
  local cells=$(( (pct + 5) / 10 ))   # nearest 10%
  local s="" i
  for (( i=0; i<cells; i++ )); do
    s+=$'\e[1;38;5;'"${GRADIENT[$i]}"'m▮'
  done
  for (( i=cells; i<10; i++ )); do
    s+="${D}▯"
  done
  s+="${N}"
  printf '%s' "$s"
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

line="${G}${model_name}${N}"
line+="${SEP}🌈 $(bar_rainbow "$ctx_pct")${DG} ${ctx_pct}%${N}"
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"

line+="$LIM"
printf '%s\n' "$line"
