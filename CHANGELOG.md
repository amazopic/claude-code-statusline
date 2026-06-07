# Changelog

All notable changes to **claude-code-statusline**.

**Versioning policy — CalVer `YYYY.MM.DD`.** The version lives in `VERSION=` inside
`statusline-bundle.sh` and is what `~/.claude/status-line.sh update` compares against
upstream; the date instantly tells you how stale an install is. A second release on
the same day appends a micro suffix: `YYYY.MM.DD.1`, `.2`, …
Docs-/site-only changes do not bump the bundle version. Every release is also a git
tag `vYYYY.MM.DD` and a [GitHub Release](https://github.com/amazopic/claude-code-statusline/releases).

---

## [2026.06.07] — 2026-06-07

### Added
- **Payload-first context engine**: context %, window size and token usage now read
  the official `context_window.*` object Claude Code pipes on stdin (single `jq`
  call); the transcript scan remains as a fallback for older Claude Code versions.
  Session tokens and wall-time are payload-first too (`cost.total_duration_ms`).
- **7 new blocks** (26 total): `lines` (+156 −23 session diff), `pr` (number +
  review state), `worktree`, `vim` (mode), `agent` (subagent name), `repo`
  (owner/name), `api-time`. All hide silently when the payload lacks their data.
- **4 new languages** — ไทย (th), עברית (he, RTL), বাংলা (bn), اردو (ur, RTL) —
  **23 languages total**, full README mirrors included.
- **Lazy i18n**: the 352 KB all-locales dictionary was split into a 20 KB core
  (English fallback inline) + 22 per-locale chunks fetched on demand via dynamic
  import. Initial dictionary payload dropped ~94 %.
- `statusLine.refreshInterval: 30` documented across all install snippets, Claude
  prompts and FAQ — keeps the reset countdown ticking while the session is idle.

### Fixed
- Practical/Classic category header said 19; the group has 18 themes (all docs).
- llms pairs: stale version string and an incorrect “158 standalone variants”
  claim for `examples/` (the folder ships 40 standalone scripts for the 20 classic
  themes; the other 59 themes live in the bundle).

### Performance
- Rendering with a 50 000-line transcript: **~91 s → ~0.09 s** on modern payloads
  (the transcript is no longer read when `context_window` is present).

## [2026.06.06] — 2026-06-07

### Added
- **Reset countdown** — the headline feature: `5h{1.1h}: 1% 7d{1.1d}: 0%` shows a
  live countdown to each rate-limit window reset, read from
  `rate_limits.*.resets_at`; gracefully falls back to plain `5h: 1%` when absent.
  Predictability of work — distribute your productivity.
- **7 new languages** — Português (pt-BR), Türkçe, Bahasa Indonesia, Tiếng Việt,
  हिन्दी, 繁體中文 (zh-tw), Polski — 19 total at that point.
- Locale guard (`unset LC_ALL; export LC_NUMERIC=C`) in every renderer and example:
  decimal dot guaranteed under comma-decimal locales (de_DE, ru_RU, …).

### Fixed
- Repo-wide stale-count sweep: 18→19 blocks narrative, 40/72→79 themes leftovers,
  canonical install path `~/.claude/status-line.sh`, og-image social card
  (40→79 themes, OPEN SOURCE→SOURCE-AVAILABLE), dead `specimenCaptions` export,
  `/statusline` cheat-sheet expanded from 20 to all 79 themes.

## [2026.05.09] — 2026-05-09 … 2026-05-10

### Added
- **CalVer + in-place self-update**: `~/.claude/status-line.sh update` fetches the
  upstream bundle, validates it, keeps a timestamped backup and preserves the theme
  config (introduced in the run-up, 2026-05-04).
- **+59 themes** (79 total / 158 variants): 16 auto brands, 8 scientists, more
  anime, 8 Marvel, 10 operating systems, 7 world religions.
- **Arabic (RTL)** — 12th language; full RTL handling on the landing page.
- Unified info tail (`_ext_tail`): every theme shows the same tokens/folder/git/
  limits/thinking dashboard after its branded intro.
- `jq` precheck with install hints; correct API-mode fallback (session tokens when
  the payload carries no subscription limits).
- Vibe-chill install (single Claude Code prompt), hero limits panel, GA4.

### Fixed
- Lighthouse accessibility pass (contrast/aria/headings/touch targets, A11y 85→96).
- Stale numbers swept across SEO, localized READMEs and JSON-LD.

## [2026.05.02] — Initial release

- Status line engine: context bar with fractional cells, session cost, per-message
  tokens, git branch + dirty/ahead/behind, time-on-task, model name with `(1M)`
  indicator, 5h/7d limit slots.
- 20 themes × 2 variants (40), 18-block compose-your-own guide (BLOCKS.md),
  standalone example scripts + pre-rendered ANSI previews.
- Editorial-style landing page (GitHub Pages) in 11 languages with live specimens.

[2026.06.07]: https://github.com/amazopic/claude-code-statusline/releases/tag/v2026.06.07
[2026.06.06]: https://github.com/amazopic/claude-code-statusline/compare/v2026.05.09...v2026.06.06
[2026.05.09]: https://github.com/amazopic/claude-code-statusline/compare/v2026.05.02...v2026.05.09
[2026.05.02]: https://github.com/amazopic/claude-code-statusline/releases/tag/v2026.05.02
