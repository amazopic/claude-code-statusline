#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-cat.sh — 🐱 purr-powered status line
#
# Preview:
#   🐱 Opus 4.7 · purrs ░░░░░░░░░░ 12% · treats: 0.42$ · =^.^=
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' 🐾 \e[1;38;5;215m5h{1.1h}:\e[0m \e[1;38;5;208m15%\e[0m \e[38;5;215m·\e[0m \e[1;38;5;215m7d{1.1d}:\e[0m \e[1;38;5;208m5%\e[0m'

P=$'\e[1;38;5;213m'    # pink nose
O=$'\e[1;38;5;208m'    # orange tabby
W=$'\e[1;38;5;255m'
Y=$'\e[1;38;5;226m'
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Paw prints bar — cells fill with paw print as context grows
bar_paws() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${O}🐾"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${D}··"; done
  s+="${N}"
  printf '%s' "$s"
}

mood() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '%s' "${P}=^.^= purr${N}"
  elif (( pct < 60 )); then printf '%s' "${O}(=ↀωↀ=) chirp${N}"
  elif (( pct < 85 )); then printf '%s' "${Y}(=^◕ᴥ◕^=) meow?${N}"
  else                      printf '%s' "${P}(=ＴェＴ=) HISS${N}"
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

line="🐱 ${W}${model_name}${N}"
line+=" ${D}·${N} ${O}purrs${N} $(bar_paws "$ctx_pct") ${O}${ctx_pct}%${N}"
line+=" ${D}·${N} ${P}treats:${N} ${Y}${cost_fmt}\$${N}"
line+=" ${D}·${N} $(mood "$ctx_pct")"

line+="$LIM"
printf '%s\n' "$line"
