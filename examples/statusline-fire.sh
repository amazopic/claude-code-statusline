#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-fire.sh — 🔥 the more context, the hotter
#
# Preview:
#   🔥 Opus 4.7 · INFERNO ████████░░ 88% · ash 0.42$ · 🌋
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' 🔥 \e[1;38;5;220m5h:\e[0m \e[1;38;5;196m15%\e[0m \e[38;5;220m·\e[0m \e[1;38;5;220m7d:\e[0m \e[1;38;5;196m5%\e[0m'

R=$'\e[1;38;5;196m'
O=$'\e[1;38;5;208m'
Y=$'\e[1;38;5;226m'
DR=$'\e[38;5;52m'
W=$'\e[1;38;5;255m'
D=$'\e[38;5;238m'
DG=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Fire bar — gradient yellow→orange→red as cells fill
bar_fire() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
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
  s+="${N}"
  printf '%s' "$s"
}

intensity() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '%s' "${Y}🕯 ember"
  elif (( pct < 60 )); then printf '%s' "${O}🔥 burning"
  elif (( pct < 85 )); then printf '%s' "${R}🔥 INFERNO"
  else                      printf '%s' "${R}🌋 LAVA"
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

line="🔥 ${W}${model_name}${N}"
line+=" ${DG}·${N} $(intensity "$ctx_pct") $(bar_fire "$ctx_pct") ${R}${ctx_pct}%${N}"
line+=" ${DG}·${N} ${DR}ash${N} ${O}${cost_fmt}\$${N}"

line+="$LIM"
printf '%s\n' "$line"
