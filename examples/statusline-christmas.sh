#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-christmas.sh — 🎄 ho ho ho, festive mode
#
# Preview:
#   🎄 Opus 4.7 · 🎁 ❅❅❅❅❅❄❄❄❄❄ 12% · gifts: 0.42$ · 🎅
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[1;38;5;196m❄\e[0m \e[1;38;5;46m5h{1h 6m}:\e[0m \e[1;38;5;46m15%\e[0m \e[38;5;196m·\e[0m \e[1;38;5;46m7d{1d 2h}:\e[0m \e[1;38;5;46m5%\e[0m'

R=$'\e[1;38;5;196m'    # Christmas red
GR=$'\e[1;38;5;46m'    # tree green
GD=$'\e[1;38;5;220m'   # gold star
W=$'\e[1;38;5;255m'    # snow white
WD=$'\e[38;5;250m'
D=$'\e[38;5;238m'
DG=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Snowflakes filled (red ornaments) vs empty (white snowflakes)
bar_xmas() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${R}❅"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${WD}❄"; done
  s+="${N}"
  printf '%s' "$s"
}

icon() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '%s' "${R}🎅 ho ho ho${N}"
  elif (( pct < 60 )); then printf '%s' "${GR}🎁 unwrapping${N}"
  elif (( pct < 85 )); then printf '%s' "${GD}⭐ silent night${N}"
  else                      printf '%s' "${R}🦌 sleigh's full${N}"
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

line="🎄 ${W}${model_name}${N}"
line+=" ${DG}·${N} 🎁 $(bar_xmas "$ctx_pct") ${R}${ctx_pct}%${N}"
line+=" ${DG}·${N} ${GR}gifts:${N} ${GD}${cost_fmt}\$${N}"
line+=" ${DG}·${N} $(icon "$ctx_pct")"

line+="$LIM"
printf '%s\n' "$line"
