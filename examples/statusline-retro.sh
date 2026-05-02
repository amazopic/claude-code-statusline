#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-retro.sh — 8-bit pixel art aesthetic
#
# Preview:
#   ▀▄▀▄ OPUS-4.7 ▄▀▄▀ HP:88 ▰▰▰▰▰▰▰▰▱▱ MP:12 SCORE:0042
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' \e[38;5;46m█\e[0m \e[38;5;46m5h:\e[0m \e[1;38;5;226m15%\e[0m \e[38;5;46m█\e[0m \e[38;5;46m7d:\e[0m \e[1;38;5;226m5%\e[0m'

GR=$'\e[1;38;5;46m'    # phosphor green
GRD=$'\e[38;5;28m'
A=$'\e[1;38;5;208m'    # amber
W=$'\e[1;38;5;255m'
B=$'\e[1;38;5;39m'
R=$'\e[1;38;5;196m'
D=$'\e[38;5;238m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_pixel() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${GR}▰"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${D}▱"; done
  s+="${N}"
  printf '%s' "$s"
}

to_chrome() { printf '%s' "$1" | tr '[:lower:] ' '[:upper:]-'; }

model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"
chrome=$(to_chrome "$model_name")
cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
score=$(awk -v c="$cost" 'BEGIN { printf "%04d", c*100 }')
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
hp=$(( 100 - ctx_pct ))

line="${A}▀▄▀▄${N} ${W}${chrome}${N} ${A}▄▀▄▀${N}"
line+=" ${R}HP:${hp}${N} $(bar_pixel "$hp")"
line+=" ${B}MP:${ctx_pct}${N}"
line+=" ${A}SCORE:${score}${N}"

line+="$LIM"
printf '%s\n' "$line"
