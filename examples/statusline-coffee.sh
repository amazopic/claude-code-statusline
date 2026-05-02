#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-coffee.sh — ☕ For developers who run on caffeine
#
# Preview:
#   ☕ Opus 4.7 · brew level ████████░░ 88% · cups: 4 · 0.42$
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' \e[38;5;94m·\e[0m \e[38;5;130m5h:\e[0m \e[1;38;5;220m15%\e[0m \e[38;5;94m·\e[0m \e[38;5;130m7d:\e[0m \e[1;38;5;220m5%\e[0m'

BR=$'\e[1;38;5;94m'    # brown coffee
BRD=$'\e[38;5;58m'     # dim brown
BG=$'\e[38;5;130m'     # bronze
W=$'\e[1;38;5;255m'
GD=$'\e[1;38;5;220m'
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Brew level: inverse — full bar = full mug = 100% remaining
bar_brew() {
  local pct=${1%.*}        # context used
  [[ -z "$pct" ]] && pct=0
  local left=$(( 100 - pct ))   # mug remaining
  local cells=$(( (left + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${BR}█"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${BRD}░"; done
  s+="${N}"
  printf '%s' "$s"
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
brew_left=$(( 100 - ctx_pct ))
# 1 cup ≈ each 25% of cost (so $1 ≈ 4 cups)
cups=$(awk -v c="$cost" 'BEGIN { printf "%d", c*4 }')

line="☕ ${W}${model_name}${N}"
line+=" ${D}·${N} ${BG}brew level${N} $(bar_brew "$ctx_pct") ${BR}${brew_left}${BRD}%${N}"
line+=" ${D}·${N} ${BG}cups:${N} ${BR}${cups}${N}"
line+=" ${D}·${N} ${GD}${cost_fmt}${BRD}\$${N}"

line+="$LIM"
printf '%s\n' "$line"
