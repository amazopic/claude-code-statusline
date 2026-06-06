#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-pirate.sh — Ahoy, matey! Yer Claude Code be ready
#
# Preview:
#   🏴‍☠️ Cap'n Opus 4.7 ⚓ ye plundered 12% [████------] · doubloons: 0.42$ · ☠
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' ⚓ \e[1;38;5;130m5h{1.1h}:\e[0m \e[1;38;5;220m15%\e[0m \e[38;5;215m·\e[0m \e[1;38;5;130m7d{1.1d}:\e[0m \e[1;38;5;220m5%\e[0m'

GD=$'\e[1;38;5;220m'   # gold
GDD=$'\e[38;5;178m'    # dim gold
R=$'\e[1;38;5;196m'    # red flag
W=$'\e[1;38;5;255m'
B=$'\e[38;5;94m'       # brown (wood)
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_pirate() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${GD}█"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${B}-"; done
  s+="${N}"
  printf '%s' "$s"
}

mood() {
  local pct=${1%.*}
  if   (( pct < 40 )); then printf '☠ Yarrr!'
  elif (( pct < 70 )); then printf '🦜 squawk!'
  elif (( pct < 90 )); then printf '⚠ shiver me timbers'
  else                      printf '🌊 ABANDON SHIP'
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

line="🏴‍☠️ ${W}Cap'n ${GD}${model_name}${N} ⚓"
line+=" ${B}ye plundered${N} ${GD}${ctx_pct}%${N} $(bar_pirate "$ctx_pct")"
line+=" ${D}·${N} ${B}doubloons:${N} ${GD}${cost_fmt}${GDD}\$${N}"
line+=" ${D}·${N} ${R}$(mood "$ctx_pct")${N}"

line+="$LIM"
printf '%s\n' "$line"
