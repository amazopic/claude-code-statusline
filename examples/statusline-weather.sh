#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-weather.sh — context as weather forecast
#
# Preview:
#   ☀ Opus 4.7 · clear skies · 12% ▁▂▂▃▃▄▅▆▇█ · 0.42$
#
# Mood by context %:
#   <30%  ☀  clear skies         (sunny)
#   <60%  ⛅ partly cloudy        (warming up)
#   <80%  🌧 rain incoming        (slowing down)
#   ≥80%  ⛈ severe storm warning (compact soon!)
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail
input=$(cat)
LIM=$' ☀ \e[1;38;5;220m5h:\e[0m \e[1;38;5;39m15%\e[0m \e[38;5;245m·\e[0m \e[1;38;5;220m7d:\e[0m \e[1;38;5;39m5%\e[0m'

Y=$'\e[1;38;5;226m'    # sun
WD=$'\e[38;5;250m'     # cloud gray
B=$'\e[1;38;5;39m'     # rain blue
PR=$'\e[1;38;5;55m'    # storm purple
W=$'\e[1;38;5;255m'
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

# Sparkline-style bar — fixed sequence ▁▂▃▄▅▆▇█, only first N chars colored
bar_sparks() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  local cells=$(( (pct + 5) / 10 ))
  local glyphs=("▁" "▂" "▂" "▃" "▃" "▄" "▅" "▆" "▇" "█")
  local s="" i col dim
  if   (( pct < 30 )); then col=$Y;  dim=$WD
  elif (( pct < 60 )); then col=$WD; dim=$D
  elif (( pct < 80 )); then col=$B;  dim=$D
  else                      col=$PR; dim=$D
  fi
  for (( i=0; i<10; i++ )); do
    if (( i < cells )); then s+="${col}${glyphs[$i]}"
    else                     s+="${dim}${glyphs[$i]}"
    fi
  done
  s+="${N}"
  printf '%s' "$s"
}

icon_and_label() {
  local pct=${1%.*}
  if   (( pct < 30 )); then printf '%s' "${Y}☀${N} ${WD}clear skies${N}"
  elif (( pct < 60 )); then printf '%s' "${WD}⛅ partly cloudy${N}"
  elif (( pct < 80 )); then printf '%s' "${B}🌧 rain incoming${N}"
  else                      printf '%s' "${PR}⛈ STORM — compact soon${N}"
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

line="${W}${model_name}${N}"
line+=" ${D}·${N} $(icon_and_label "$ctx_pct")"
line+=" ${D}·${N} ${ctx_pct}% $(bar_sparks "$ctx_pct")"
line+=" ${D}·${N} ${cost_fmt}\$"

line+="$LIM"
printf '%s\n' "$line"
