// ─────────────────────────────────────────────────────────────────────
// i18n — thin core. English dictionary is the permanent inline fallback.
// All other locales are lazy-loaded per-code chunks from ./locales/<code>.js
// ─────────────────────────────────────────────────────────────────────

export const ASSET_V = '26';

export const supportedLocales = [
  { code: 'en',   label: 'English',     native: 'English'    },
  { code: 'ru',   label: 'Russian',     native: 'Русский'    },
  { code: 'fr',   label: 'French',      native: 'Français'   },
  { code: 'de',   label: 'German',      native: 'Deutsch'    },
  { code: 'uk',   label: 'Ukrainian',   native: 'Українська' },
  { code: 'sl',   label: 'Slovenian',   native: 'Slovenščina'},
  { code: 'it',   label: 'Italian',     native: 'Italiano'   },
  { code: 'es',   label: 'Spanish',     native: 'Español'    },
  { code: 'zh',   label: 'Chinese',     native: '中文'        },
  { code: 'ja',   label: 'Japanese',    native: '日本語'      },
  { code: 'ko',   label: 'Korean',      native: '한국어'      },
  { code: 'ar',   label: 'Arabic',      native: 'العربية',     rtl: true },
  { code: 'pt',   label: 'Portuguese',  native: 'Português'  },
  { code: 'tr',   label: 'Turkish',     native: 'Türkçe'     },
  { code: 'id',   label: 'Indonesian',  native: 'Bahasa Indonesia' },
  { code: 'vi',   label: 'Vietnamese',  native: 'Tiếng Việt' },
  { code: 'hi',   label: 'Hindi',       native: 'हिन्दी'       },
  { code: 'zh-tw',label: 'Chinese (Traditional)', native: '繁體中文' },
  { code: 'pl',   label: 'Polish',      native: 'Polski'     },
  { code: 'th',   label: 'Thai',        native: 'ไทย' },
  { code: 'he',   label: 'Hebrew',      native: 'עברית',     rtl: true },
  { code: 'bn',   label: 'Bengali',     native: 'বাংলা' },
  { code: 'ur',   label: 'Urdu',        native: 'اردو',      rtl: true },
];

export const defaultLocale = 'en';

// ─── English dictionary — eternal fallback, always resident ──────────────
const en = {
    "meta.title": "Claude Code Status Line — Limit control · 82 themes · CLI",
    "meta.description": "Drop-in replacement for the Claude Code default status line. Track 5h/7d rate limits in real time, watch context fill, see session cost — never blow past the window. 82 themes, 26 blocks, /statusline slash command.",
    "lang.label": "Language",
    "hero.brand": "Claude Code · Status Line",
    "hero.issue": "Issue 01 · 23 languages · 164 specimens",
    "hero.nameplate.sup": "A catalog of terminal status lines for Claude Code",
    "hero.limits.badge": "★ NEW · The #1 reason people install this",
    "hero.limits.title": "Limit control.<br/>Maximum productivity.<br/><em>Zero surprises.</em>",
    "hero.limits.body": "Bought a Pro plan and now you keep hitting the 5-hour or 7-day cap mid-task? The default status line never warns you. <strong>This one does.</strong> Live 5h / 7d meters, ⚠️ alert above 50 %, baked into every theme.",
    "hero.limits.label5h": "5-hour limit",
    "hero.limits.label7d": "7-day limit",
    "hero.limits.alert": "⚠ Visual alert above 50 % — never hit the wall mid-session.",
    "hero.limits.tagline": "Predictable by design — every meter counts down to its reset, so you pace your work instead of hitting the wall.",
    "hero.context.eyebrow": "Context Control",
    "hero.context.title": "Clear context above 60% — stay sharp.",
    "hero.context.body": "More context = <strong>slower Claude</strong> + <strong>faster limit burn</strong>. Compact early, work efficiently.",
    "hero.context.label": "Context window",
    "hero.context.tip_healthy": "Healthy — keep going.",
    "hero.context.tip_approach": "Approaching threshold.",
    "hero.context.tip_clear": "⚠ Clear soon — quality drops above 60%.",
    "hero.context.tip_compact": "🚨 Compact now — limits burning fast.",
    "hero.context.tip_critical": "🚨 Critical — every reply now wastes tokens.",
    "hero.context.tip_compacted": "✓ Just compacted — sharp again.",
    "hero.cta.install": "Install in 30s",
    "hero.cta.specimens": "See 164 specimens",
    "hero.cta.github": "View on GitHub",
    "hero.meta.github": "GitHub",
    "hero.terminal.label": "Live preview · cycling through 10 themes",
    "note.label": "Editor's Note",
    "note.body.p1": "<span class=\"dropcap\">C</span>laude Code ships with a <strong>sparse</strong> status line. A model name. Maybe a directory. That's it. Meanwhile your context fills up, your <strong>5h and 7d limits tick down</strong>, your session quietly accrues cost — and you find out only when you've blown past the window.",
    "note.body.p2": "This project is the dashboard that should have been there. Eighty-two themes. Twenty-six composable blocks. One bash file. <strong>Pick something pretty</strong> — or build your own.",
    "note.margin": "<em>Editorial note —</em> the project is open source under a <em>source-available license</em>: read freely, but reuse requires the author's permission.",
    "numbers.title": "By the numbers",
    "numbers.themes": "themes",
    "numbers.blocks": "composable blocks",
    "numbers.precision": "bar precision",
    "numbers.lines": "lines (single bundle)",
    "numbers.languages": "documented languages",
    "numbers.limits": "limit warnings (5h + 7d)",
    "numbers.deps": "runtime deps (just bash + jq)",
    "catalog.meta": "Contents · 164 specimens",
    "catalog.title": "The Catalog<br/><em>in two volumes — detailed &amp; compact</em>",
    "catalog.intro": "Eighty-two themes, each in two trims — detailed and compact. Tap a name to jump to its specimen page.",
    "specimens.title": "Specimens",
    "specimens.prev": "Previous specimen",
    "specimens.next": "Next specimen",
    "specimens.id": "Specimen №",
    "specimens.use": "use:",
    "specimens.in_claude": "in Claude Code:",
    "specimens.source": "source:",
    "specimens.detailed": "Detailed",
    "specimens.compact": "Compact",
    "specimens.palette": "Palette",
    "specimens.glyphs": "Glyph kit",
    "specimens.group": "Group",
    "specimens.try.label": "Try it from inside Claude Code",
    "specimens.try.intro": "Already in a Claude Code session? Just type <code class=\"mono\">/statusline</code> with arguments — the shipped slash command routes everything to the bundle below.",
    "specimens.try.caption": "Same script, two modes — <strong>stdin = render</strong>, <strong>args = configure</strong>. Already shipped as <code class=\"mono\">~/.claude/commands/statusline.md</code>.",
    "compare.sub": "A side-by-side",
    "compare.title": "vs. the default<br/>status line",
    "compare.col.feature": "Capability",
    "compare.col.default": "Default Claude Code",
    "compare.col.ours": "This project",
    "compare.yes": "yes",
    "compare.no": "no",
    "recipe.title": "Compose<br/>your own",
    "recipe.intro": "Click blocks to add them to your status line. Watch it render live. Copy the bash and ship.",
    "recipe.palette.h": "Available blocks",
    "recipe.preview": "Live preview",
    "recipe.your": "Your recipe",
    "recipe.bash": "Generated bash",
    "recipe.empty.line": "drop blocks here…",
    "recipe.empty.preview": "// add blocks to see your status line",
    "install.sub": "Get going",
    "vibe.eyebrow": "Vibe-chill install",
    "vibe.title": "Why touch a terminal<br/>when you have <em>Claude Code</em>?",
    "vibe.intro": "Paste this one prompt into your Claude Code session. Say \"y\" when it asks for permission. Done.",
    "vibe.bonus": "No git, no jq install dance, no <code class=\"mono\">settings.json</code> hunt — Claude handles every step and asks before each command.",
    "vibe.panel.label": "paste in Claude Code:",
    "vibe.prompt": "Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: \"command\", command: \"<absolute path to ~/.claude/status-line.sh>\", \"refreshInterval\": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.",
    "vibe.note": "↳ Just say <code class=\"mono\">y</code> (yes) at every permission prompt — Claude will run each command one by one.",
    "install.title": "Install in 30 seconds",
    "install.intro": "A single bundled script does both jobs: it renders your status line when Claude Code calls it, and it acts as a CLI configurator when you call it with arguments.",
    "install.step1.title": "Clone &amp; copy",
    "install.step1.desc": "Drop the bundle into <code class=\"mono\">~/.claude/status-line.sh</code>.",
    "install.step2.title": "Pick a theme",
    "install.step2.desc": "Or compose blocks via <code class=\"mono\">custom</code>.",
    "install.step3.title": "Wire it up",
    "install.step3.desc": "Tell Claude Code about it in <code class=\"mono\">settings.json</code>, restart.",
    "install.claude.label": "Or in Claude Code — easiest",
    "install.claude.intro": "Have Claude Code open? Paste these two prompts and you're done — no terminal needed.",
    "install.claude.prompt1": "Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: \"command\", command: \"<absolute path to ~/.claude/status-line.sh>\", \"refreshInterval\": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.",
    "install.claude.prompt2_label": "Then test it:",
    "install.codelabel.main": "macOS / Linux / WSL",
    "install.codelabel.slash": "Optional: <code class=\"mono\">/statusline</code> slash command",
    "install.refreshTip": "refreshInterval: 30 re-runs the line every 30 seconds even while the session is idle — keeps the reset countdown (5h{1.1h}), the time tracker and post-reset flips live. 30 is a sensible default; 60 is battery-frugal; omit to refresh on events only (new assistant message, /compact, vim toggle).",
    "faq.sub": "Q &amp; A",
    "faq.title": "Frequently<br/>Asked",
    "faq.q.limits": "Why is the 5h / 7d limit display the headline feature?",
    "faq.a.limits": "Because it's the #1 thing users complain about after buying a Claude plan: the default Claude Code status line gives you <strong>zero visibility</strong> into your 5-hour and 7-day rate limits. You only find out you hit them when Claude refuses to respond mid-task. This script reads <code>limits</code> data from the live JSON, renders both meters in real time, and triggers a ⚠️ visual alert when you cross 50 % — so you can plan your session before you crash into the wall.",
    "faq.q.what": "What is \"Claude Code Status Line\"?",
    "faq.a.what": "A bash-based replacement for the default status line in <a href=\"https://claude.com/claude-code\">Claude Code</a> (Anthropic's CLI). It turns the bottom-of-screen line into a real dashboard: model, context %, progress bar, session cost, <strong>5h / 7d limits</strong>, git status, time-on-task, and more.",
    "faq.q.install": "How is it installed?",
    "faq.a.install": "Copy <code>statusline-bundle.sh</code> to <code>~/.claude/status-line.sh</code>, <code>chmod +x</code>, then point Claude Code's <code>~/.claude/settings.json</code> <code>statusLine.command</code> at that path. Full instructions are in the install section above.",
    "faq.q.update": "How do I update to the latest version?",
    "faq.a.update": "Run <code>~/.claude/status-line.sh update</code>. It fetches the latest bundle from GitHub, creates a timestamped backup (<code>~/.claude/status-line.sh.bak.&lt;YYYYMMDD-HHMMSS&gt;</code>), and preserves your theme config. Restart Claude Code afterwards. Check what you have with <code>~/.claude/status-line.sh version</code>.",
    "faq.q.1m": "Does it support the 1M context window models?",
    "faq.a.1m": "Yes. The script detects <code>[1m]</code> in the model id and <code>1M</code> in the display name, and adjusts the bar's denominator to 1,000,000 tokens. You'll see <code>Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K</code>.",
    "faq.q.models": "What models does it work with?",
    "faq.a.models": "Any model Claude Code supports — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, etc. The script reads <code>model.display_name</code> and <code>model.id</code> from stdin JSON; it doesn't hardcode model names.",
    "faq.q.customize": "Can I customize colors, themes, or add my own?",
    "faq.a.customize": "Yes — three ways: (1) pick one of the <strong>164 ready-made variants</strong> in the Specimens section, (2) compose your own from <strong>named blocks</strong> using the Recipe builder above, (3) edit color constants and bar style in <code>statusline.sh</code> directly.",
    "faq.q.perf": "Will it slow down Claude Code?",
    "faq.a.perf": "No. Each render runs once per status redraw, parses the piped JSON with <code>jq</code>, optionally <code>grep</code>s the latest line of the transcript, and prints. Typical render is ≤ 50 ms even with the time-tracker enabled.",
    "faq.q.jq": "Does it work without jq?",
    "faq.a.jq": "<code>jq</code> is required — it parses the JSON Claude Code sends on stdin. Install via <code>brew install jq</code> (macOS), <code>apt install jq</code> (Debian/Ubuntu), or <code>choco install jq</code> (Windows).",
    "faq.q.win": "Does it work on Windows?",
    "faq.a.win": "Yes, in any environment that runs <code>bash</code> 4+ and <code>jq</code> — Git Bash, WSL, MSYS2, Cygwin. Pure CMD/PowerShell aren't supported.",
    "faq.q.conf": "Where is the configuration stored?",
    "faq.a.conf": "<code>~/.claude/statusline.conf</code> — a tiny shell-sourced file written by the bundle's CLI (<code>statusline.sh use &lt;theme&gt;</code>, etc.). Persists across restarts.",
    "faq.q.free": "Is it free? Can I use it commercially?",
    "faq.a.free": "Personal local use is free — see the <a href=\"https://github.com/OWNER/claude-code-statusline/blob/main/LICENSE\">Source-Available License</a>. Any reuse, redistribution, fork, or inclusion in another project requires <strong>prior written permission</strong> from the author. Reasonable requests for personal, educational, and non-commercial use are typically granted.",
    "faq.q.time": "How does the human-hours tracker work?",
    "faq.a.time": "The <strong>time</strong> theme reads timestamps from the JSONL transcript and reports two durations: <strong>active</strong> (sum of inter-message gaps shorter than 5 minutes) and <strong>wall</strong> (total span from first to last message). The 5-minute idle threshold is configurable.",
    "faq.q.revert": "How do I revert to the default Claude Code status line?",
    "faq.a.revert": "Either remove the <code>statusLine</code> block from <code>~/.claude/settings.json</code>, or run <code>~/.claude/status-line.sh reset</code> and switch to the <code>minimal</code> theme that closely matches the default.",
    "faq.q.reset": "What does 5h{1.1h}: 1% mean?",
    "faq.a.reset": "You've used 1% of the 5-hour window, and <code>{1.1h}</code> is a live countdown — the window resets in 1.1 hours (<code>7d{1.1d}</code>: the weekly window resets in 1.1 days). Read from <code>rate_limits.*.resets_at</code> on every render. No reset timestamp in your build? The meter falls back to plain <code>5h: 1%</code>.",
    "faq.q.refresh": "Does the status line update by itself? My {1.1h} countdown looks frozen.",
    "faq.a.refresh": "Claude Code re-renders on events — new assistant message, /compact, permission-mode or vim-mode change (debounced at 300 ms) — so between events the line freezes. Add <code>\"refreshInterval\": 30</code> to the statusLine block in <code>~/.claude/settings.json</code> and it also re-runs on a fixed 30-second timer, keeping the countdown and time tracker ticking while idle. A render costs ~0.1 s, so 30 s is negligible; use <code>60</code> on battery or in huge repos (<code>git status</code> runs each render); minimum is <code>1</code>.",
    "colo.title": "Amazopic",
    "colo.h.author": "Author",
    "colo.h.license": "License",
    "colo.h.set": "Set in",
    "colo.h.links": "Links",
    "colo.license.body": "Source-Available — reuse only with prior written permission.",
    "colo.license.read": "Read full license →",
    "colo.links.repo": "GitHub repo ↗",
    "colo.links.readme": "Read README ↗",
    "colo.links.blocks": "Blocks library",
    "colo.links.examples": "All 82 themes",
    "colo.links.cc": "Claude Code ↗",
    "colo.meta.copyright": "© 2026 Yevgeniy Achin · Source-Available",
    "colo.meta.made": "Made for the Claude Code community",
    "colo.meta.issue": "Issue 01 · v2026.06.06",
    "ui.copy": "Copy",
    "ui.copied": "✓ copied to clipboard",
    "ui.copyfail": "✗ copy failed",
    "ui.loading": "Loading specimens…",
    "cmp.f.model": "Active model name",
    "cmp.f.ctx": "Context window % used",
    "cmp.f.bar": "Progress bar for context",
    "cmp.f.cost": "Session cost in USD",
    "cmp.f.tokmsg": "Per-message tokens (in / out)",
    "cmp.f.toksess": "Total session tokens (API mode)",
    "cmp.f.limits": "★ 5h / 7d rate-limit warnings",
    "cmp.f.git": "Git branch + dirty + ahead/behind",
    "cmp.f.time": "Time-on-task (active vs wall)",
    "cmp.f.think": "Thinking / effort level",
    "cmp.f.themes": "Themed presets",
    "cmp.f.blocks": "Compose from named blocks",
    "cmp.f.cli": "Built-in CLI configurator",
    "cmp.f.slash": "/statusline slash command",
    "cmp.f.deps": "Dependencies",
    "cmp.f.reset": "Reset countdown in limit meters (5h{1.1h})"
  };

// Locale registry. 'en' is always present; others fill in lazily.
const registry = { en };

// Lazy-load a locale chunk. Idempotent; safe to await repeatedly.
// On failure, registers an empty dict so callers transparently fall back to en.
export async function ensureLocale(code) {
  if (registry[code]) return registry[code];
  try {
    registry[code] = (await import(`./locales/${code}.js?v=${ASSET_V}`)).default;
  } catch (e) {
    console.warn('i18n: failed to load locale', code, e);
    registry[code] = {};
  }
  return registry[code];
}

// ─── Helpers ───────────────────────────────────────────────────────────

export function t(key, locale = defaultLocale) {
  return (registry[locale] && registry[locale][key]) ?? en[key] ?? key;
}

// Backfill English-canon strings for keys added after the chunk snapshot.
// Only fills keys not already present, so the shipped dictionary wins.
export function registerEnCanon(obj) {
  for (const [k, v] of Object.entries(obj)) {
    if (en[k] === undefined) en[k] = v;
  }
}

export function detectLocale() {
  // English is the default. The user explicitly opts into another language
  // via the switcher or via ?lang=xx — we do NOT auto-detect from the browser.
  try {
    const saved = localStorage.getItem('lang');
    if (saved && supportedLocales.some(l => l.code === saved)) return saved;
  } catch (_) { /* private mode etc. */ }
  return defaultLocale;
}

export function persistLocale(code) {
  try { localStorage.setItem('lang', code); } catch (_) {}
}
