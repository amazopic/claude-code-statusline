#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-zen.sh — monochrome, ASCII-only, no emojis
#
# Preview:
#   opus 4.7  12%  [###-------]  $0.42  main
#
# Quiet, distraction-free, screen-reader friendly. No colors, no Unicode
# block characters, no emojis. Pure ASCII over single dim separator.
# Useful in low-color terminals, screen recordings, and copy-paste contexts.
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

input=$(cat)
LIM=$'  \e[38;5;245m· 5h: 15% · 7d: 5%\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_ascii() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  (( pct < 0 ))   && pct=0
  local cells=$(( (pct + 5) / 10 ))
  local s="["
  local i
  for (( i=0; i<cells;       i++ )); do s+="#"; done
  for (( i=0; i<10-cells;    i++ )); do s+="-"; done
  s+="]"
  printf '%s' "$s"
}

model_disp=$(j '.model.display_name')
model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"
# lowercase for zen vibe
model_name=$(printf '%s' "$model_name" | tr '[:upper:]' '[:lower:]')

cwd=$(j '.workspace.current_dir'); [[ -z "$cwd" ]] && cwd=$(j '.cwd')
[[ -z "$cwd" ]] && cwd="$PWD"

cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')

transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')
if [[ "$model_id" == *"[1m]"* ]] || [[ "$model_disp" == *"1M"* ]] || [[ "$exceeds_200k" == "true" ]]; then
  ctx_max=1000000
else
  ctx_max=200000
fi

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

br=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
       || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

line="${model_name}  ${ctx_pct}%  $(bar_ascii "$ctx_pct")  \$${cost_fmt}"
[[ -n "$br" ]] && line+="  ${br}"

line+="$LIM"
printf '%s\n' "$line"
