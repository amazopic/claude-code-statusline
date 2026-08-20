#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# statusline-developer.sh — git-aware Claude Code status line
#
# Preview:
#   Opus 4.7 · 12% █▌░░░░░░░░ · ⎇ main ✚3 ↑1 ↓0 · 0.42$ · /repo
#
# Shows: model · context · git branch with uncommitted/ahead/behind ·
# session cost · folder. Built for active development.
# ─────────────────────────────────────────────────────────────────────────
set -uo pipefail

# Force C numeric formatting (decimal dot) regardless of the user's locale,
# while keeping UTF-8 character handling for glyphs.
# LC_ALL would override LC_NUMERIC, so it must be unset first.
unset LC_ALL
export LC_NUMERIC=C

input=$(cat)
LIM=$' \e[38;5;244m·\e[0m \e[38;5;244m5h{1h 6m}:\e[0m \e[1;38;5;46m15%\e[0m \e[38;5;244m·\e[0m \e[38;5;244m7d{1d 2h}:\e[0m \e[1;38;5;46m5%\e[0m'

G=$'\e[1;38;5;220m'
GR=$'\e[1;38;5;46m'
GRD=$'\e[38;5;34m'
Y=$'\e[1;38;5;226m'
YD=$'\e[38;5;184m'
R=$'\e[1;38;5;196m'
RU=$'\e[38;5;160m'
GD=$'\e[38;5;178m'
B=$'\e[1;38;5;39m'
C=$'\e[1;38;5;51m'
CD=$'\e[38;5;38m'
M=$'\e[1;38;5;201m'
D=$'\e[38;5;244m'
RD=$'\e[38;5;131m'
N=$'\e[0m'

SEP=" ${D}·${N} "

j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

pct_color() {
  local p=${1%.*}; [[ -z "$p" ]] && p=0
  if   (( p < 50 )); then printf '%s' "$GR"
  elif (( p < 70 )); then printf '%s' "$Y"
  else                    printf '%s' "$R"
  fi
}
pct_color_dim() {
  local p=${1%.*}; [[ -z "$p" ]] && p=0
  if   (( p < 50 )); then printf '%s' "$GRD"
  elif (( p < 70 )); then printf '%s' "$YD"
  else                    printf '%s' "$RU"
  fi
}

bar() {
  local pct=${1%.*}
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  (( pct < 0 ))   && pct=0
  local eighths=$(( (pct * 8 + 5) / 10 ))
  local full=$(( eighths / 8 ))
  local part=$(( eighths % 8 ))
  local empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
  local parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
  local s="" i
  for (( i=0; i<full; i++ )); do s+="█"; done
  (( part > 0 )) && s+="${parts[$part]}"
  for (( i=0; i<empty; i++ )); do s+="░"; done
  printf '%s' "$s"
}

model_disp=$(j '.model.display_name')
model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"
model_name="${model_name// context/}"

cwd=$(j '.workspace.current_dir')
[[ -z "$cwd" ]] && cwd=$(j '.cwd')
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

ctx_color=$(pct_color "$ctx_pct")
ctx_color_dim=$(pct_color_dim "$ctx_pct")

# Git: branch + dirty count + ahead/behind
git_part="${RD}no git${N}"
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
       || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  ahead=0; behind=0
  upstream=$(git -C "$cwd" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    counts=$(git -C "$cwd" rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    ahead=${counts%%	*}
    behind=${counts##*	}
  fi
  git_part="${B}⎇ ${br}${N}"
  (( dirty > 0 ))  && git_part+=" ${Y}✚${dirty}${N}"
  (( ahead > 0 ))  && git_part+=" ${GR}↑${ahead}${N}"
  (( behind > 0 )) && git_part+=" ${R}↓${behind}${N}"
fi

folder=$(basename "$cwd")

line="${G}${model_name}${N}"
line+="${SEP}${ctx_color}${ctx_pct}${ctx_color_dim}% ${ctx_color}$(bar "$ctx_pct")${N}"
line+="${SEP}${git_part}"
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"
line+="${SEP}${B}${folder}${N}"

line+="$LIM"
printf '%s\n' "$line"
