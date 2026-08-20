#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-love.sh — for those who love their AI ❤️
#
# Preview:
#   💖 Opus 4.7 ❤ love-meter ▰▰▰▰▰▱▱▱▱▱ 12% · spent 0.42$ on us · 💕
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[1;38;5;197m♥\e[0m \e[1;38;5;211m5h{1h 6m}:\e[0m \e[1;38;5;196m15%\e[0m \e[1;38;5;197m♥\e[0m \e[1;38;5;211m7d{1d 2h}:\e[0m \e[1;38;5;196m5%\e[0m'

R=$'\e[1;38;5;196m'
P=$'\e[1;38;5;213m'
PD=$'\e[38;5;218m'
DR=$'\e[38;5;160m'
W=$'\e[1;38;5;231m'
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_love() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${R}▰"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${PD}▱"; done
  s+="${N}"
  printf '%s' "$s"
}

heart_for() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '💕'
  elif (( pct < 60 )); then printf '💖'
  elif (( pct < 85 )); then printf '❤️'
  else                      printf '💔'
  fi
}

model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"
cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')
transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')
[[ "$model_id" == *"[1m]"* || "$model_disp" == *"1M"* || "$exceeds_200k" == "true" ]] && ctx_max=1000000 || ctx_max=200000

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

line="💖 ${P}${model_name}${N} ❤"
line+=" ${PD}love-meter${N} $(bar_love "$ctx_pct") ${R}${ctx_pct}${PD}%${N}"
line+=" ${D}·${N} ${PD}spent${N} ${R}${cost_fmt}${DR}\$${N} ${PD}on us${N}"
line+=" ${D}·${N} $(heart_for "$ctx_pct")"

line+="$LIM"
printf '%s\n' "$line"
