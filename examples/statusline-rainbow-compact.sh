#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-rainbow-compact.sh — compact rainbow variant (model · ctx · branch)
# Author: Yevgeniy Achin <amazopic@gmail.com>
# Preview: Opus 4.7 · 🌈 ▮▱▱▱▱▱▱▱▱▱ 12% · main
# ─────────────────────────────────────────────────────────────────────────
G=$'\e[1;38;5;220m'; B=$'\e[1;38;5;39m'; D=$'\e[38;5;238m'; DG=$'\e[38;5;244m'
GRADIENT=(196 202 208 220 226 154 46 51 39 129)

set -uo pipefail
input=$(cat)
LIM=$' \e[1;38;5;196m5\e[1;38;5;208mh\e[1;38;5;226m:\e[0m \e[1;38;5;46m1\e[1;38;5;51m5\e[1;38;5;201m%\e[0m \e[38;5;240m·\e[0m \e[1;38;5;226m7\e[1;38;5;46md\e[1;38;5;51m:\e[0m \e[1;38;5;201m5\e[1;38;5;196m%\e[0m'
N=$'\e[0m'
j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }
model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"; model_name="${model_name// context/}"
cwd=$(j '.workspace.current_dir'); [[ -z "$cwd" ]] && cwd="$PWD"
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
br=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi
ctx_max_k=$(awk -v v="$ctx_max" 'BEGIN { printf "%d", v/1000 }')

bar_rb(){ local c=$(( ($1+5)/10 )); local s="" i; for ((i=0;i<c;i++)); do s+=$'\e[1;38;5;'"${GRADIENT[$i]}"'m▮'; done; for ((i=c;i<10;i++)); do s+="${D}▯"; done; s+="${N}"; printf "%s" "$s"; }

line="${G}${model_name}${N} ${DG}·${N} 🌈 $(bar_rb $ctx_pct) ${ctx_pct}%"
[[ -n "$br" ]] && line+=" ${DG}·${N} ${B}${br}${N}"

line+="$LIM"
printf '%s\n' "$line"
