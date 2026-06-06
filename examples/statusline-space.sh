#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-space.sh — 🚀 Houston, we have status
#
# Preview:
#   🚀 Opus 4.7 · O₂ ▰▰▰▰▰▱▱▱▱▱ 12% · fuel 0.42$ · 🌌 nominal
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[38;5;240m▸\e[0m \e[38;5;75m5h{1.1h}:\e[0m \e[1;38;5;39m15%\e[0m \e[38;5;240m▸\e[0m \e[38;5;75m7d{1.1d}:\e[0m \e[1;38;5;39m5%\e[0m'

C=$'\e[1;38;5;51m'      # cyan (oxygen)
CD=$'\e[38;5;38m'
B=$'\e[1;38;5;39m'      # blue
V=$'\e[1;38;5;99m'      # space violet
W=$'\e[1;38;5;255m'
Y=$'\e[1;38;5;226m'
R=$'\e[1;38;5;196m'
GR=$'\e[1;38;5;46m'
D=$'\e[38;5;238m'
DG=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_o2() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${C}▰"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${D}▱"; done
  s+="${N}"
  printf '%s' "$s"
}

mission_status() {
  local pct=${1%.*}
  if   (( pct < 40 )); then printf '%s' "${GR}🌌 nominal"
  elif (( pct < 70 )); then printf '%s' "${Y}☄ caution"
  elif (( pct < 90 )); then printf '%s' "${R}🛸 warning"
  else                      printf '%s' "${R}🔥 MAYDAY"
  fi
  printf '%s' "${N}"
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

line="🚀 ${W}${model_name}${N}"
line+=" ${DG}·${N} ${C}O₂${N} $(bar_o2 "$ctx_pct") ${C}${ctx_pct}${CD}%${N}"
line+=" ${DG}·${N} ${V}fuel${N} ${B}${cost_fmt}${CD}\$${N}"
line+=" ${DG}·${N} $(mission_status "$ctx_pct")"

line+="$LIM"
printf '%s\n' "$line"
