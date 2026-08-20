#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-game.sh — RPG party HUD for Claude Code
#
# Preview:
#   ⚔ Opus 4.7 · HP ████████░░ 88/100 · MP ██░░░░░░░░ 12% · gold 0.42$ · LV 4
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C
input=$(cat)
LIM=$' \e[38;5;240m⚔\e[0m \e[1;38;5;196m5h{1h 6m}:\e[0m \e[1;38;5;220m15%\e[0m \e[38;5;240m⚔\e[0m \e[1;38;5;196m7d{1d 2h}:\e[0m \e[1;38;5;220m5%\e[0m'

R=$'\e[1;38;5;196m'    # HP red
RD=$'\e[38;5;88m'
B=$'\e[1;38;5;39m'     # MP blue
BD=$'\e[38;5;24m'
GD=$'\e[1;38;5;220m'   # gold
W=$'\e[1;38;5;255m'
P=$'\e[1;38;5;201m'    # XP magenta
D=$'\e[38;5;244m'
N=$'\e[0m'

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

bar_color() {
  local pct=$1 col=$2 dim=$3
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="${col}█"; done
  for (( i=0; i<10-cells;  i++ )); do s+="${dim}░"; done
  s+="${N}"
  printf '%s' "$s"
}

model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"
cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')
transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')
[[ "$model_id" == *"[1m]"* || "$model_disp" == *"1M"* || "$exceeds_200k" == "true" ]] && ctx_max=1000000 || ctx_max=200000

in_tok=0; out_tok=0; cr=0; cc=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  last=$(grep '"usage"' "$transcript" 2>/dev/null | tail -1)
  if [[ -n "$last" ]]; then
    in_tok=$(jq  -r '.message.usage.input_tokens // 0'                <<<"$last" 2>/dev/null || echo 0)
    out_tok=$(jq -r '.message.usage.output_tokens // 0'               <<<"$last" 2>/dev/null || echo 0)
    cr=$(jq      -r '.message.usage.cache_read_input_tokens // 0'     <<<"$last" 2>/dev/null || echo 0)
    cc=$(jq      -r '.message.usage.cache_creation_input_tokens // 0' <<<"$last" 2>/dev/null || echo 0)
  fi
fi
ctx_used=$(( in_tok + cr + cc ))
ctx_pct=$(awk -v u="$ctx_used" -v m="$ctx_max" 'BEGIN { if (m>0) printf "%d", u*100/m; else print 0 }')
hp=$(( 100 - ctx_pct ))    # HP drains as context fills
mp_pct=$ctx_pct            # MP shows context used ("mana spent")
# Level = floor(cost) + 1 (1 gold per level)
level=$(awk -v c="$cost" 'BEGIN { printf "%d", c+1 }')

line="⚔ ${W}${model_name}${N}"
line+=" ${D}·${N} ${R}HP${N} $(bar_color "$hp" "$R" "$RD") ${R}${hp}${RD}/100${N}"
line+=" ${D}·${N} ${B}MP${N} $(bar_color "$mp_pct" "$B" "$BD") ${B}${mp_pct}${BD}%${N}"
line+=" ${D}·${N} ${GD}gold${N} ${GD}${cost_fmt}\$${N}"
line+=" ${D}·${N} ${P}LV ${level}${N}"

line+="$LIM"
printf '%s\n' "$line"
