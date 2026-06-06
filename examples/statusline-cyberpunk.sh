#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-cyberpunk.sh — neon-soaked dystopia for Claude Code
#
# Preview:
#   ▌▌▌ OPUS-4.7 ▐▐▐ //CTX:12% ▰▰▱▱▱▱▱▱▱▱ //₵RED:0.42 ▐ JACK-IN
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[38;5;163m//\e[1;38;5;201m5H{1.1h}\e[38;5;163m:\e[1;38;5;51m15%\e[0m \e[38;5;163m//\e[1;38;5;201m7D{1.1d}\e[38;5;163m:\e[1;38;5;51m5%\e[0m'

P=$'\e[1;38;5;201m'    # neon pink
PD=$'\e[38;5;163m'
C=$'\e[1;38;5;51m'     # neon cyan
CD=$'\e[38;5;38m'
Y=$'\e[1;38;5;227m'    # neon yellow
W=$'\e[1;38;5;231m'
D=$'\e[38;5;238m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_neon() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${P}▰"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${D}▱"; done
  s+="${N}"
  printf '%s' "$s"
}

# Uppercase model name with hyphen separator for chrome aesthetic
to_chrome() {
  printf '%s' "$1" | tr '[:lower:] ' '[:upper:]-'
}

model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"
chrome=$(to_chrome "$model_name")
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

line="${P}▌▌▌${N} ${C}${chrome}${N} ${P}▐▐▐${N}"
line+=" ${PD}//${C}CTX${PD}:${C}${ctx_pct}%${N} $(bar_neon "$ctx_pct")"
line+=" ${PD}//${Y}₵RED${PD}:${Y}${cost_fmt}${N}"
line+=" ${P}▐${N} ${C}JACK-IN${N}"

line+="$LIM"
printf '%s\n' "$line"
