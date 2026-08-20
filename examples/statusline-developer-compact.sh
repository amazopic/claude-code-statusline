#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-developer-compact.sh — compact developer variant (model · ctx · branch)
# Author: Yevgeniy Achin <amazopic@gmail.com>
# Preview: Opus 4.7 · 12% · ⎇ main ✚3
# ─────────────────────────────────────────────────────────────────────────
G=$'\e[1;38;5;220m'; GR=$'\e[1;38;5;46m'; Y=$'\e[1;38;5;226m'; B=$'\e[1;38;5;39m'; D=$'\e[38;5;244m'

set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[38;5;244m·\e[0m \e[38;5;244m5h{1h 6m}:\e[0m \e[1;38;5;46m15%\e[0m \e[38;5;244m·\e[0m \e[38;5;244m7d{1d 2h}:\e[0m \e[1;38;5;46m5%\e[0m'
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



line="${G}${model_name}${N} ${D}·${N} ${GR}${ctx_pct}%${N}"
if [[ -n "$br" ]]; then
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d " ")
  gp="${B}⎇ ${br}${N}"
  (( dirty > 0 )) && gp+=" ${Y}✚${dirty}${N}"
  line+=" ${D}·${N} ${gp}"
fi

line+="$LIM"
printf '%s\n' "$line"
