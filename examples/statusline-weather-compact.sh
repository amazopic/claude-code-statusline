#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-weather-compact.sh — compact weather variant (model · ctx · branch)
# Author: Yevgeniy Achin <amazopic@gmail.com>
# Preview: ☀ Opus 4.7 · 12% ▁▂▃▄░░░░░░ · main
# ─────────────────────────────────────────────────────────────────────────
Y=$'\e[1;38;5;226m'; WD=$'\e[38;5;250m'; B=$'\e[1;38;5;39m'; PR=$'\e[1;38;5;55m'; W=$'\e[1;38;5;255m'; D=$'\e[38;5;244m'

set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' ☀ \e[1;38;5;220m5h{1h 6m}:\e[0m \e[1;38;5;39m15%\e[0m \e[38;5;245m·\e[0m \e[1;38;5;220m7d{1d 2h}:\e[0m \e[1;38;5;39m5%\e[0m'
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

bar_w(){ local pct=$1 col dim glyphs=("▁" "▂" "▂" "▃" "▃" "▄" "▅" "▆" "▇" "█"); local c=$(( (pct+5)/10 )); if (( pct<30 )); then col=$Y; dim=$WD; elif (( pct<60 )); then col=$WD; dim=$D; elif (( pct<80 )); then col=$B; dim=$D; else col=$PR; dim=$D; fi; local s="" i; for ((i=0;i<10;i++));do if (( i<c ));then s+="${col}${glyphs[$i]}";else s+="${dim}${glyphs[$i]}";fi;done; printf "%s%s" "$s" "$N"; }
icn(){ local p=$1; if (( p<30 ));then printf "${Y}☀${N}"; elif (( p<60 ));then printf "${WD}⛅${N}"; elif (( p<80 ));then printf "${B}🌧${N}"; else printf "${PR}⛈${N}"; fi; }

line="$(icn $ctx_pct) ${W}${model_name}${N} ${D}·${N} ${ctx_pct}% $(bar_w $ctx_pct)"
[[ -n "$br" ]] && line+=" ${D}·${N} ${B}${br}${N}"

line+="$LIM"
printf '%s\n' "$line"
