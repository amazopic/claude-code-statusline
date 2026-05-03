# Compose your own status line — block library

This is a catalog of **blocks** (segments) you can mix and match to build
your own custom Claude Code status line. Pick a style pack, list the
blocks you want, paste them into a script — done.

> Author: **Yevgeniy Achin** · ✉ amazopic@gmail.com
> License: **Source-Available** ([LICENSE](LICENSE)) — reuse only with
> the author's prior permission.

> 💡 **Don't want to assemble blocks by hand?** Use the all-in-one
> [`statusline-bundle.sh`](statusline-bundle.sh) and run
> `~/.claude/status-line.sh custom model context-bar git cost` — same
> blocks, no copy-paste. See the bundle section in the [main
> README](README.md#-all-in-one-bundle-statusline-bundlesh).

---

## How to compose

```
┌────────────────┬──────────────────────────────────────────┐
│ Step 1 — pick a STYLE pack       (colors, separator, vibe)│
│ Step 2 — pick the BLOCKS you want (in order)              │
│ Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER     │
└───────────────────────────────────────────────────────────┘
```

Every statusline script in this repo follows the same pattern:

```bash
#!/usr/bin/env bash
[ STYLE — colors and SEP ]
[ HEADER — input parsing helpers, shared variables ]
[ BLOCK 1 ]   →   appends to $line
[ BLOCK 2 ]   →   appends to $line
[ BLOCK N ]   →   appends to $line
[ FOOTER — printf '%s\n' "$line" ]
```

You can grab the header + footer from any example script (they are
identical) and only swap the middle.

---

## Step 1 — style packs

Each style pack defines: separator (`SEP`), color palette, and
optional accent glyphs. Drop the pack near the top of your script.

### `classic` — gold / green / cyan, vertical bar separator

```bash
G=$'\e[1;38;5;220m';  GD=$'\e[38;5;178m'
GR=$'\e[1;38;5;46m';  GRD=$'\e[38;5;34m'
Y=$'\e[1;38;5;226m';  YD=$'\e[38;5;184m'
R=$'\e[1;38;5;196m';  RU=$'\e[38;5;160m'
B=$'\e[1;38;5;39m';   C=$'\e[1;38;5;51m';   CD=$'\e[38;5;38m'
M=$'\e[1;38;5;201m';  W=$'\e[1;38;5;255m'
D=$'\e[38;5;244m';    RD=$'\e[38;5;131m';   N=$'\e[0m'
SEP=" ${D}│${N} "
```

### `compact` — same palette, dot separator

```bash
# (same colors as classic)
SEP=" ${D}·${N} "
```

### `anime` — pink / magenta / violet, 🌸 separator

```bash
P=$'\e[1;38;5;213m';  PD=$'\e[38;5;218m'
M=$'\e[1;38;5;201m';  V=$'\e[1;38;5;177m'
W=$'\e[1;38;5;231m';  D=$'\e[38;5;244m'
N=$'\e[0m'
SEP=" 🌸 "
```

### `hacker` — phosphor green Matrix terminal

```bash
GR=$'\e[1;38;5;46m';   GRD=$'\e[38;5;28m';  GRDD=$'\e[38;5;22m'
W=$'\e[1;38;5;255m';   N=$'\e[0m'
SEP=" ${GRD}::${N} "
```

### `cyberpunk` — neon pink / cyan / yellow

```bash
P=$'\e[1;38;5;201m';   PD=$'\e[38;5;163m'
C=$'\e[1;38;5;51m';    CD=$'\e[38;5;38m'
Y=$'\e[1;38;5;227m';   W=$'\e[1;38;5;231m'
D=$'\e[38;5;238m';     N=$'\e[0m'
SEP=" ${PD}//${N} "
```

### `zen` — no colors, plain ASCII

```bash
SEP="  "
N=""
```

---

## Step 2 — shared HEADER

Paste this once, near the top of your script (after the style pack).
Every block below relies on the variables it sets.

```bash
set -uo pipefail
input=$(cat)
j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }

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

if [[ "$model_id" == *"[1m]"* ]] || [[ "$model_disp" == *"1M"* ]] \
   || [[ "$exceeds_200k" == "true" ]]; then
  ctx_max=1000000
else
  ctx_max=200000
fi

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

line=""
```

---

## Step 3 — block catalog

For every block: a one-line description, a copy-paste snippet that
**appends** to `$line`. The first block in your line should NOT have
a leading `${SEP}` — drop the leading `${SEP}` on whichever block you
choose first.

### `model` — model name with `(1M)` indicator

```bash
line+="${G}${model_name}${N}"
```

### `context` — icon + percent + bar + tokens

```bash
# pct icon
if   (( ctx_pct < 40 )); then ctx_icon="🚀"
elif (( ctx_pct < 50 )); then ctx_icon="🚗"
else                          ctx_icon="⚠️"
fi
# pct color
if   (( ctx_pct < 50 )); then cc_=$GR; cd_=$GRD
elif (( ctx_pct < 70 )); then cc_=$Y;  cd_=$YD
else                          cc_=$R;  cd_=$RU
fi
# bar (8 levels per cell)
eighths=$(( (ctx_pct * 8 + 5) / 10 ))
full=$(( eighths / 8 )); part=$(( eighths % 8 ))
empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
ctx_bar=""
for (( i=0; i<full; i++ )); do ctx_bar+="█"; done
(( part > 0 )) && ctx_bar+="${parts[$part]}"
for (( i=0; i<empty; i++ )); do ctx_bar+="░"; done
ctx_used_k=$(awk -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')
ctx_max_k=$(awk -v v="$ctx_max"  'BEGIN { printf "%d",   v/1000 }')
line+="${SEP}${ctx_icon} ${cc_}${ctx_pct}${cd_}% ${cc_}${ctx_bar} ${ctx_used_k}${cd_}K${D}/${cc_}${ctx_max_k}${cd_}K${N}"
```

### `context-pct` — just the percentage

```bash
line+="${SEP}${GR}${ctx_pct}${GRD}%${N}"
```

### `context-bar` — just the bar (vertical fractional, 8 levels)

```bash
eighths=$(( (ctx_pct * 8 + 5) / 10 ))
full=$(( eighths / 8 )); part=$(( eighths % 8 ))
empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
ctx_bar=""
for (( i=0; i<full; i++ )); do ctx_bar+="█"; done
(( part > 0 )) && ctx_bar+="${parts[$part]}"
for (( i=0; i<empty; i++ )); do ctx_bar+="░"; done
line+="${SEP}${GR}${ctx_bar}${N}"
```

### `context-bar-quadrant` — bar with quadrant glyphs (4 levels = 2.5% step)

```bash
quarters=$(( (ctx_pct * 4 + 5) / 10 ))
full=$(( quarters / 4 )); part=$(( quarters % 4 ))
empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
parts=("" "▖" "▄" "▙")
ctx_bar=""
for (( i=0; i<full; i++ )); do ctx_bar+="█"; done
(( part > 0 )) && ctx_bar+="${parts[$part]}"
for (( i=0; i<empty; i++ )); do ctx_bar+="░"; done
line+="${SEP}${GR}${ctx_bar}${N}"
```

### `cost` — session cost in USD

```bash
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"
```

### `tokens-msg` — last message ↑ output / ↓ input

```bash
out_k=$(awk -v v="$out_tok"  'BEGIN { printf "%.1f", v/1000 }')
in_k=$(awk  -v v="$ctx_used" 'BEGIN { printf "%.1f", v/1000 }')
line+="${SEP}${CD}↑${C}${out_k}${CD}K ${CD}↓${C}${in_k}${CD}K${N}"
```

### `tokens-session` — total session tokens (API-mode fallback)

```bash
sess_total=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  sess_total=$(grep '"usage"' "$transcript" 2>/dev/null \
    | jq -s '[.[] | select(.message.usage) | .message.usage
             | ((.input_tokens // 0) + (.output_tokens // 0)
                + (.cache_creation_input_tokens // 0)
                + (.cache_read_input_tokens // 0))] | add // 0' 2>/dev/null)
fi
sess_k=$(( ${sess_total:-0} / 1000 ))
# thin-space thousand separator
fmt_thin() {
  local n=$1 result="" len i; len=${#n}
  for ((i=0; i<len; i++)); do
    (( i > 0 && (len-i) % 3 == 0 )) && result+=$'\xe2\x80\x89'
    result+="${n:$i:1}"
  done
  printf '%s' "$result"
}
sess_fmt=$(fmt_thin "$sess_k")
line+="${SEP}${GRD}tokens: ${C}${sess_fmt}${CD}K${N}"
```

### `folder` — current directory basename

```bash
folder=$(basename "$cwd")
line+="${SEP}${B}${folder}${N}"
```

### `git-branch` — git branch only

```bash
br=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
       || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  line+="${SEP}${B}⎇ ${br}${N}"
fi
```

### `git` — branch + dirty count + ahead / behind

```bash
git_part=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
       || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  ahead=0; behind=0
  upstream=$(git -C "$cwd" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    counts=$(git -C "$cwd" rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    ahead=${counts%%	*}; behind=${counts##*	}
  fi
  git_part="${B}⎇ ${br}${N}"
  (( dirty  > 0 )) && git_part+=" ${Y}✚${dirty}${N}"
  (( ahead  > 0 )) && git_part+=" ${GR}↑${ahead}${N}"
  (( behind > 0 )) && git_part+=" ${R}↓${behind}${N}"
  line+="${SEP}${git_part}"
fi
```

### `limits` — 5h / 7d rate limits with ⚠️ at > 50 %

```bash
lim5h=$(j '.rate_limits.five_hour.used_percentage // .rate_limits.session.percent_used')
lim7d=$(j '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.percent_used')
if [[ -n "$lim5h" || -n "$lim7d" ]]; then
  l5=${lim5h%.*}; l7=${lim7d%.*}
  w5=""; (( ${l5:-0} > 50 )) && w5="⚠️ "
  w7=""; (( ${l7:-0} > 50 )) && w7="⚠️ "
  line+="${SEP}${GRD}5h:${N} ${w5}${GR}${l5:-—}${GRD}%${N} ${GRD}7d:${N} ${w7}${GR}${l7:-—}${GRD}%${N}"
fi
```

### `thinking` — effort level (with 🤖)

```bash
thinking=$(j '.effort.level // .thinking.level // .thinking // .output_style.name')
[[ -z "$thinking" ]] && thinking="default"
line+="${SEP}🤖 ${C}${thinking}${N}"
```

### `time-active` — sum of inter-message gaps < 5 min ("on keyboard")

```bash
IDLE=300
to_epoch() { local ts="$1"; [[ -z "$ts" ]] && { echo 0; return; }
  [[ "$ts" =~ ^[0-9]+$ ]] && { echo "$ts"; return; }
  local c="${ts%%.*}"; c="${c%Z}"; c="${c//T/ }"
  date -j -f '%Y-%m-%d %H:%M:%S' "$c" +%s 2>/dev/null \
    || date -d "$ts" +%s 2>/dev/null || echo 0; }
fmt_dur() { local s=$1; (( s<0 )) && s=0
  local h=$((s/3600)) m=$(((s%3600)/60))
  if (( h>0 )); then printf '%dh%02dm' $h $m
  elif (( m>0 )); then printf '%dm' $m
  else printf '%ds' $s; fi; }
active_s=0; first=0; last=0; turns=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  prev=0
  while IFS= read -r ts; do
    [[ -z "$ts" ]] && continue
    e=$(to_epoch "$ts"); (( e==0 )) && continue
    (( first==0 )) && first=$e; last=$e
    if (( prev>0 )); then
      gap=$(( e - prev ))
      (( gap > 0 && gap < IDLE )) && active_s=$(( active_s + gap ))
    fi
    prev=$e; turns=$(( turns + 1 ))
  done < <(jq -r '.timestamp // .created_at // .message.created_at // empty' "$transcript" 2>/dev/null)
fi
wall_s=$(( last > 0 && first > 0 ? last - first : 0 ))
line+="${SEP}${C}⏱ active ${fmt_dur $active_s}${N}"
```

### `time-wall` — total session span (first → last message)

```bash
# requires the same setup as time-active above
line+="${SEP}${C}⏱ wall ${fmt_dur $wall_s}${N}"
```

### `turns` — number of message pairs

```bash
# requires turn counting from time-active block
line+="${SEP}${B}${turns}${D} turns${N}"
```

### `host` — short hostname

```bash
host=$(hostname -s 2>/dev/null || echo localhost)
line+="${SEP}${C}${host}${N}"
```

### `cups` — cost-derived "coffee cup" count

```bash
cups=$(awk -v c="$cost" 'BEGIN { printf "%d", c*4 }')   # 1 cup ≈ $0.25
line+="${SEP}☕ ${G}${cups}${N}"
```

### `level` — RPG-style level from cost

```bash
level=$(awk -v c="$cost" 'BEGIN { printf "%d", c+1 }')
line+="${SEP}${M}LV ${level}${N}"
```

### `mood-icon` — emoji that changes with context %

```bash
if   (( ctx_pct < 30 )); then mood="☀"
elif (( ctx_pct < 60 )); then mood="⛅"
elif (( ctx_pct < 80 )); then mood="🌧"
else                          mood="⛈"
fi
line+="${SEP}${mood}"
```

---

## Footer

Always end with:

```bash
printf '%s\n' "$line"
```

---

## Worked example — build a developer-friendly compact line

Goal: `Opus 4.7 · 12% █▌░░░░░░░░ · ⎇ main ✚3 · 0.42$`

1. Style: `compact` (dot separator)
2. Blocks (in order): `model`, `context-pct`, `context-bar`, `git`, `cost`

Final script:

```bash
#!/usr/bin/env bash
# my-statusline.sh — composed from BLOCKS.md
# style: compact; blocks: model · context-pct + context-bar · git · cost

set -uo pipefail
input=$(cat)

# ── style: compact ───────────────────────────────────────────────────
G=$'\e[1;38;5;220m';  GD=$'\e[38;5;178m'
GR=$'\e[1;38;5;46m';  GRD=$'\e[38;5;34m'
Y=$'\e[1;38;5;226m'
R=$'\e[1;38;5;196m'
B=$'\e[1;38;5;39m'
D=$'\e[38;5;244m';    N=$'\e[0m'
SEP=" ${D}·${N} "

# ── header ───────────────────────────────────────────────────────────
j() { jq -r "$1 // empty" 2>/dev/null <<<"$input"; }
model_disp=$(j '.model.display_name'); model_id=$(j '.model.id')
model_name="${model_disp:-${model_id:-Claude}}"; model_name="${model_name// context/}"
cwd=$(j '.workspace.current_dir'); [[ -z "$cwd" ]] && cwd="$PWD"
cost=$(j '.cost.total_cost_usd'); cost=${cost:-0}
cost_fmt=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c+0 }')
transcript=$(j '.transcript_path')
exceeds_200k=$(j '.exceeds_200k_tokens')
[[ "$model_id" == *"[1m]"* || "$model_disp" == *"1M"* || "$exceeds_200k" == "true" ]] \
  && ctx_max=1000000 || ctx_max=200000
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

line=""

# ── block: model ─────────────────────────────────────────────────────
line+="${G}${model_name}${N}"

# ── block: context-pct + context-bar ─────────────────────────────────
eighths=$(( (ctx_pct * 8 + 5) / 10 ))
full=$(( eighths / 8 )); part=$(( eighths % 8 ))
empty=$(( 10 - full - (part > 0 ? 1 : 0) ))
parts=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
ctx_bar=""
for (( i=0; i<full; i++ )); do ctx_bar+="█"; done
(( part > 0 )) && ctx_bar+="${parts[$part]}"
for (( i=0; i<empty; i++ )); do ctx_bar+="░"; done
line+="${SEP}${GR}${ctx_pct}${GRD}% ${GR}${ctx_bar}${N}"

# ── block: git ───────────────────────────────────────────────────────
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  br=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  git_part="${B}⎇ ${br}${N}"
  (( dirty > 0 )) && git_part+=" ${Y}✚${dirty}${N}"
  line+="${SEP}${git_part}"
fi

# ── block: cost ──────────────────────────────────────────────────────
line+="${SEP}${G}${cost_fmt}${GD}\$${N}"

# ── footer ───────────────────────────────────────────────────────────
printf '%s\n' "$line"
```

---

## See also

- [`statusline.sh`](statusline.sh) — full reference implementation
- [`examples/`](examples/) — 40 ready-made variants (20 detailed + 20 compact)
- [`screenshots/`](screenshots/) — pre-rendered ANSI previews
- [`README.md`](README.md) — main project documentation

---

For permission to reuse any of these blocks in another project,
contact: **amazopic@gmail.com**.
