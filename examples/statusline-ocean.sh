#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-ocean.sh — 🌊 calm waves to deep tide
#
# Preview:
#   🌊 Opus 4.7 · tide ≈≈≋≋≋    12% · 0.42$ · 🐠
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' \e[38;5;75m≈\e[0m \e[38;5;51m5h:\e[0m \e[1;38;5;39m15%\e[0m \e[38;5;75m≈\e[0m \e[38;5;51m7d:\e[0m \e[1;38;5;39m5%\e[0m'

C=$'\e[1;38;5;51m'     # bright cyan
CD=$'\e[38;5;38m'      # deep cyan
B=$'\e[1;38;5;39m'     # ocean blue
BD=$'\e[38;5;24m'
DB=$'\e[38;5;17m'      # abyss
W=$'\e[1;38;5;255m'
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Wave bar — gradient from light wave to deep wave
bar_wave() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local glyphs=("≈" "≈" "≋" "≋" "~" "~" "~" "≋" "≋" "█")
  local s="" i col
  for (( i=0; i<cells; i++ )); do
    if   (( i < 4 )); then col=$C
    elif (( i < 8 )); then col=$B
    else                   col=$DB
    fi
    s+="${col}${glyphs[$i]}"
  done
  for (( i=cells; i<10; i++ )); do s+="${BD} "; done
  s+="${N}"
  printf '%s' "$s"
}

depth() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '%s' "${C}🐠 surface"
  elif (( pct < 60 )); then printf '%s' "${B}🐟 shallow"
  elif (( pct < 85 )); then printf '%s' "${BD}🦑 deep"
  else                      printf '%s' "${DB}🐋 abyss"
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

line="🌊 ${W}${model_name}${N}"
line+=" ${D}·${N} ${C}tide${N} $(bar_wave "$ctx_pct") ${C}${ctx_pct}${CD}%${N}"
line+=" ${D}·${N} ${B}${cost_fmt}\$${N}"
line+=" ${D}·${N} $(depth "$ctx_pct")"

line+="$LIM"
printf '%s\n' "$line"
