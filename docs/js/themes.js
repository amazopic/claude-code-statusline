// ─────────────────────────────────────────────────────────────────────
// Theme & block metadata for the landing page
// ─────────────────────────────────────────────────────────────────────

/** All 20 themes. Each ships with a detailed and a compact variant. */
export const themes = [
  { id: 'minimal',     name: 'Minimal',    vibe: 'Just the essentials. Model · context · cost. Nothing else.',                  palette: ['#DCBC02','#46DA46','#244A78','#F5F2EA','#0E0E10'], group: 'Practical' },
  { id: 'developer',   name: 'Developer',  vibe: 'Git-aware. Branch, dirty, ahead, behind — all in one breath.',                palette: ['#DCBC02','#46DA46','#E2D200','#244A78','#0E0E10'], group: 'Practical' },
  { id: 'time',        name: 'Time',       vibe: 'Human-hours tracker. Active vs wall. The only honest count.',                 palette: ['#DCBC02','#46DA46','#22D3EE','#A855F7','#0E0E10'], group: 'Practical' },
  { id: 'zen',         name: 'Zen',        vibe: 'Monochrome ASCII. No colors. No emojis. Recording-ready.',                    palette: ['#0E0E10','#4A4A48','#7A7A78','#E5E0D0','#F5F2EA'], group: 'Practical' },
  { id: 'rainbow',     name: 'Rainbow',    vibe: 'Each cell a different color. Pure joy.',                                      palette: ['#FF0000','#FFA500','#FFFF00','#00FF00','#0000FF'], group: 'Themed' },
  { id: 'anime',       name: 'Anime',      vibe: 'Kawaii (◕‿◕). ✨🌸 Hearts, sparkles, pink overload.',                          palette: ['#FF6BD9','#FFB3DB','#C04AFF','#9333EA','#FECDD3'], group: 'Themed' },
  { id: 'love',        name: 'Love',       vibe: 'Hearts and a love-meter. Spent 0.42$ on us.',                                  palette: ['#EF4444','#F472B6','#FB7185','#FDA4AF','#FECDD3'], group: 'Themed' },
  { id: 'cat',         name: 'Cat',        vibe: '🐱 Paw prints. Purrs. =^.^=',                                                  palette: ['#F97316','#FBBF24','#FB923C','#F472B6','#FECDD3'], group: 'Themed' },
  { id: 'christmas',   name: 'Christmas',  vibe: '🎄 Ho ho ho — red, green, gold. Festive cheer.',                              palette: ['#DC2626','#16A34A','#FBBF24','#FFFFFF','#0E0E10'], group: 'Themed' },
  { id: 'hacker',      name: 'Hacker',     vibe: 'Phosphor green Matrix terminal. ROOT@matrix#',                                 palette: ['#00FF6B','#00C054','#008838','#005C28','#0E0E10'], group: 'Sci-fi' },
  { id: 'cyberpunk',   name: 'Cyberpunk',  vibe: 'Neon dystopia. //CTX:12% //₵RED:0.42 ▐ JACK-IN.',                              palette: ['#FF00C8','#00FFFF','#FFFF00','#7C00FF','#0E0E10'], group: 'Sci-fi' },
  { id: 'space',       name: 'Space',      vibe: '🚀 O₂ levels. Fuel gauge. Mission status.',                                    palette: ['#22D3EE','#3B82F6','#A855F7','#F5F2EA','#0E0E10'], group: 'Sci-fi' },
  { id: 'retro',       name: 'Retro',      vibe: '8-bit pixel art. HP:88 SCORE:0042.',                                           palette: ['#46DA46','#FF8800','#0066FF','#FF0000','#0E0E10'], group: 'Sci-fi' },
  { id: 'fire',        name: 'Fire',       vibe: '🔥 Ember → burning → INFERNO → 🌋 LAVA.',                                       palette: ['#EAB308','#F97316','#EF4444','#7F1D1D','#0E0E10'], group: 'Mood' },
  { id: 'ocean',       name: 'Ocean',      vibe: '🌊 Surface → shallow → deep → 🐋 abyss.',                                       palette: ['#22D3EE','#3B82F6','#1D4ED8','#1E1B4B','#0E0E10'], group: 'Mood' },
  { id: 'weather',     name: 'Weather',    vibe: '☀ Clear → ⛅ cloudy → 🌧 rain → ⛈ storm.',                                      palette: ['#FCD34D','#D1D5DB','#3B82F6','#7C3AED','#F5F2EA'], group: 'Mood' },
  { id: 'coffee',      name: 'Coffee',     vibe: '☕ Brew level + cup count. Fueled by caffeine.',                                palette: ['#92400E','#854D0E','#FBBF24','#F5F2EA','#0E0E10'], group: 'Mood' },
  { id: 'music',       name: 'Music',      vibe: '🎵 Notes ♩♪♫♬. Tempo from largo to presto.',                                    palette: ['#C04AFF','#FBBF24','#FFB3DB','#F5F2EA','#0E0E10'], group: 'Mood' },
  { id: 'game',        name: 'Game',       vibe: '⚔ RPG HUD. HP / MP / gold / LV.',                                              palette: ['#EF4444','#3B82F6','#FBBF24','#A855F7','#0E0E10'], group: 'Game' },
  { id: 'pirate',      name: 'Pirate',     vibe: "🏴‍☠️ Cap'n. Doubloons. Yarrr!",                                                 palette: ['#92400E','#FBBF24','#EF4444','#F5F2EA','#0E0E10'], group: 'Game' },
];

/** Building blocks for the recipe section. */
export const blocks = [
  { id: 'model',           label: 'model',           desc: 'model name with (1M) tag' },
  { id: 'context',         label: 'context',         desc: 'icon + % + bar + tokens' },
  { id: 'context-pct',     label: 'context-pct',     desc: 'just the percentage' },
  { id: 'context-bar',     label: 'context-bar',     desc: 'just the bar' },
  { id: 'cost',            label: 'cost',            desc: 'session cost in USD' },
  { id: 'folder',          label: 'folder',          desc: 'current dir basename' },
  { id: 'git',             label: 'git',             desc: 'branch + dirty + ahead/behind' },
  { id: 'git-branch',      label: 'git-branch',      desc: 'branch only' },
  { id: 'tokens-msg',      label: 'tokens-msg',      desc: 'last message ↑ output / ↓ input' },
  { id: 'tokens-session',  label: 'tokens-session',  desc: 'total session tokens' },
  { id: 'limits',          label: 'limits',          desc: '5h / 7d rate limits with ⚠️' },
  { id: 'thinking',        label: 'thinking',        desc: 'effort level (with 🤖)' },
  { id: 'time-active',     label: 'time-active',     desc: 'active time (gaps < 5min)' },
  { id: 'time-wall',       label: 'time-wall',       desc: 'wall-clock session span' },
  { id: 'turns',           label: 'turns',           desc: 'message-pair count' },
  { id: 'host',            label: 'host',            desc: 'short hostname' },
  { id: 'cups',            label: 'cups',            desc: 'cost-derived ☕ count' },
  { id: 'level',           label: 'level',           desc: 'cost-derived RPG level' },
  { id: 'mood-icon',       label: 'mood-icon',       desc: 'emoji that changes with context %' },
];

/** FAQ data — keys reference i18n.js. The limits Q&A is FIRST = #1 SEO/feature. */
export const faq = [
  { qKey: 'faq.q.limits',    aKey: 'faq.a.limits' },
  { qKey: 'faq.q.what',      aKey: 'faq.a.what' },
  { qKey: 'faq.q.install',   aKey: 'faq.a.install' },
  { qKey: 'faq.q.update',    aKey: 'faq.a.update' },
  { qKey: 'faq.q.1m',        aKey: 'faq.a.1m' },
  { qKey: 'faq.q.models',    aKey: 'faq.a.models' },
  { qKey: 'faq.q.customize', aKey: 'faq.a.customize' },
  { qKey: 'faq.q.perf',      aKey: 'faq.a.perf' },
  { qKey: 'faq.q.jq',        aKey: 'faq.a.jq' },
  { qKey: 'faq.q.win',       aKey: 'faq.a.win' },
  { qKey: 'faq.q.conf',      aKey: 'faq.a.conf' },
  { qKey: 'faq.q.free',      aKey: 'faq.a.free' },
  { qKey: 'faq.q.time',      aKey: 'faq.a.time' },
  { qKey: 'faq.q.revert',    aKey: 'faq.a.revert' },
];

/** Comparison rows. Feature label is i18n; value cells are short, often non-translated. */
export const compare = [
  { fKey: 'cmp.f.limits', def: false, ours: '⚠️ when > 50 %', highlight: true },
  { fKey: 'cmp.f.model',  def: true,  ours: 'with (1M) flag for 1M variants' },
  { fKey: 'cmp.f.ctx',    def: false, ours: 'live, 1.25 % precision' },
  { fKey: 'cmp.f.bar',    def: false, ours: 'vertical / quadrant / rainbow / sparkline' },
  { fKey: 'cmp.f.cost',   def: false, ours: 'updated every render' },
  { fKey: 'cmp.f.tokmsg', def: false, ours: 'live' },
  { fKey: 'cmp.f.toksess',def: false, ours: 'fallback when no rate limits piped' },
  { fKey: 'cmp.f.git',    def: false, ours: 'in one block' },
  { fKey: 'cmp.f.time',   def: false, ours: 'active vs wall' },
  { fKey: 'cmp.f.think',  def: false, ours: '🤖 indicator' },
  { fKey: 'cmp.f.themes', def: false, ours: '20 themes × 2 variants = 40' },
  { fKey: 'cmp.f.blocks', def: false, ours: '18 blocks, BLOCKS.md' },
  { fKey: 'cmp.f.cli',    def: false, ours: 'use / custom / list / preview' },
  { fKey: 'cmp.f.slash',  def: false, ours: 'optional, drop-in' },
  { fKey: 'cmp.f.deps',   def: '—',  ours: 'bash + jq' },
];

/** A handful of editorial captions for specimen pages. */
export const specimenCaptions = {
  minimal:    'A study in restraint. Three segments, one separator. Whitespace as content.',
  developer:  'Built for the active worktree. Branch, dirt, divergence — all readable at a glance.',
  time:       'A reckoning. Five minutes of idle and the clock pauses; this is what you actually spent.',
  zen:        'Stripped to ASCII. No glyphs, no colors, no emoji. Made for the screencast.',
  rainbow:    'Cell-by-cell color shift. Decoration over meaning — and proud of it.',
  anime:      'Kawaii maximalism. Hearts replace bars, faces replace warnings. Joyfully extra.',
  love:       'A confession. Each filled heart is one percent more spent on this conversation.',
  cat:        'Paw prints fill in like a soft cat walking across the line. Purr-driven UX.',
  christmas:  'Snow that fills with red baubles. Permitted only between Nov. 25 and Jan. 6.',
  hacker:     'Fixed-pitch phosphor. The Matrix did not invent this; it canonized it.',
  cyberpunk:  'All-caps chrome. Neon pink on neon cyan on near-black. ₵-glyph included.',
  space:      'Mission control glance. O₂ depletes as context fills. MAYDAY appears at 90 %.',
  retro:      'A status line that thinks it\'s an arcade cabinet. SCORE:0042 = $0.42.',
  fire:       'A gradient ember. The closer you get to compaction, the hotter the bar burns.',
  ocean:      'Wavy glyphs (≈≈≋≋) for shallow context, solid for the abyss. Tide as metric.',
  weather:    'Forecast disguised as status. ☀ clear → ⛈ STORM means: compact soon.',
  coffee:     'Inverted bar — the mug empties as you fill the context. ☕ counter included.',
  music:      'A fragment of a staff. Notes accrue as context grows; tempo accelerates with %.',
  game:       'Two bars in opposition. HP drains as MP (context) fills. Gold = cost.',
  pirate:     'A flag, a chest of doubloons, and "Yarrr!" Less efficient. More fun.',
};
