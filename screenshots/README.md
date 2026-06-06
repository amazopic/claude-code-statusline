# Screenshots — pre-rendered ANSI previews

Each `*.ansi` file contains the literal terminal output (with ANSI color
codes preserved) of the matching example script. To preview any variant
in your terminal — no install needed:

```bash
cat screenshots/statusline-cyberpunk.ansi
```

> 💡 If you've installed [`../statusline-bundle.sh`](../statusline-bundle.sh)
> as `~/.claude/statusline.sh`, you can also generate previews live with
> `~/.claude/statusline.sh preview <theme>` or
> `~/.claude/statusline.sh preview-all`.

## Browse the whole gallery (40 + 1)

```bash
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

## Detailed vs Compact

For every theme there are two screenshots:

- `statusline-<name>.ansi` — the detailed variant
- `statusline-<name>-compact.ansi` — the compact variant (just model · context · branch)

To compare them side by side:

```bash
diff <(cat screenshots/statusline-cyberpunk.ansi) <(cat screenshots/statusline-cyberpunk-compact.ansi)
```

Or just open both:

```bash
cat screenshots/statusline-cyberpunk.ansi
cat screenshots/statusline-cyberpunk-compact.ansi
```

## File index

The 41 files are named after their source scripts. See
[`../examples/README.md`](../examples/README.md) for the complete table
of themes.

- `statusline.ansi` → [`../statusline.sh`](../statusline.sh) — main reference
- `statusline-<name>.ansi` → [`../examples/statusline-<name>.sh`](../examples/) — detailed
- `statusline-<name>-compact.ansi` → [`../examples/statusline-<name>-compact.sh`](../examples/) — compact

## Fixture data

`fixture.jsonl` is a tiny mock Claude Code transcript used to render
these previews. It contains 7 message-usage entries totaling ~120K
input/cache tokens (≈ 12 % of a 1M context window) and timestamps spanning
35 minutes — enough to drive the time tracker, the % bar, the cost
display, and the per-segment color thresholds.

## Regenerate after editing a script

The `INPUT` now carries `rate_limits` with `resets_at` epochs so the
`limits` block renders its reset countdown (`5h{1.1h}:` / `7d{1.1d}:`).
The two offsets are picked to land on round previews:
`NOW+3960` → `3960/3600 = 1.1h`, `NOW+95040` → `95040/86400 = 1.1d`.

```bash
cd <repo-root>
NOW=$(date +%s); R5=$((NOW+3960)); R7=$((NOW+95040))   # → exactly {1.1h} and {1.1d}
FIXTURE="$(pwd)/screenshots/fixture.jsonl"
INPUT='{"model":{"display_name":"Opus 4.7 (1M context)","id":"claude-opus-4-7[1m]"},"workspace":{"current_dir":"'"$(pwd)"'"},"cost":{"total_cost_usd":0.42},"transcript_path":"'"$FIXTURE"'","rate_limits":{"five_hour":{"used_percentage":15,"resets_at":'$R5'},"seven_day":{"used_percentage":4,"resets_at":'$R7'}}}'

for f in examples/*.sh; do
  name=$(basename "$f" .sh)
  echo "$INPUT" | bash "$f" > "screenshots/${name}.ansi"
done
echo "$INPUT" | bash statusline.sh > screenshots/statusline.ansi
```

---

> Author: **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)
> License: **Source-Available** ([../LICENSE](../LICENSE))
