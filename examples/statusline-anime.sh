#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-anime.sh — kawaii (◕‿◕) Claude Code status line
#
# Preview:
#   ✨ Opus 4.7 ✨ 🌸 12% ♡♡♡♡♡♥♥♥♥♥ 🌸 0.42$ uwu (◕‿◕)
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' \e[1;38;5;200m✨\e[0m \e[1;38;5;213m5h:\e[0m \e[1;38;5;200m15%\e[0m \e[1;38;5;199m✨\e[0m \e[1;38;5;213m7d:\e[0m \e[1;38;5;200m5%\e[0m'

P=$'\e[1;38;5;213m'    # bright pink
PD=$'\e[38;5;218m'     # dim pink
M=$'\e[1;38;5;201m'    # magenta
V=$'\e[1;38;5;177m'    # violet
W=$'\e[1;38;5;231m'    # white
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Heart bar — empty hearts ♡, filled hearts ♥
bar_anime() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${M}♥"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${PD}♡"; done
  s+="${N}"
  printf '%s' "$s"
}

face() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '(◕‿◕)'
  elif (( pct < 60 )); then printf '(´｡• ω •｡`)'
  elif (( pct < 85 )); then printf '(>﹏<)'
  else                      printf '(╥﹏╥)'
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

line="${P}✨ ${V}${model_name} ${P}✨${N}"
line+=" ${M}🌸 ${P}${ctx_pct}${PD}% $(bar_anime "$ctx_pct") ${M}🌸${N}"
line+=" ${V}${cost_fmt}${PD}\$${N}"
line+=" ${P}uwu ${M}$(face "$ctx_pct")${N}"

line+="$LIM"
printf '%s\n' "$line"
