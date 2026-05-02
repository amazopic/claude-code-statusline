#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-coffee-compact.sh — compact coffee variant (model · ctx · branch)
# Author: Yevgeniy Achin <amazopic@gmail.com>
# Preview: ☕ Opus 4.7 · ████████░░ 88% · main
# ─────────────────────────────────────────────────────────────────────────
BR=$'\e[1;38;5;94m'; BRD=$'\e[38;5;58m'; W=$'\e[1;38;5;255m'; D=$'\e[38;5;244m'

set -uo pipefail
input=$(cat)
LIM=$' \e[38;5;94m·\e[0m \e[38;5;130m5h:\e[0m \e[1;38;5;220m15%\e[0m \e[38;5;94m·\e[0m \e[38;5;130m7d:\e[0m \e[1;38;5;220m5%\e[0m'
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

bar_c(){ local left=$((100-$1)); local c=$(( (left+5)/10 )); local s="" i; for ((i=0;i<c;i++));do s+="${BR}█";done; for ((i=0;i<10-c;i++));do s+="${BRD}░";done; printf "%s%s" "$s" "$N"; }

left=$((100-ctx_pct))
line="☕ ${W}${model_name}${N} ${D}·${N} $(bar_c $ctx_pct) ${BR}${left}${BRD}%${N}"
[[ -n "$br" ]] && line+=" ${D}·${N} ${BR}${br}${N}"

line+="$LIM"
printf '%s\n' "$line"
