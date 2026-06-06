// ─────────────────────────────────────────────────────────────────────
// Theme & block metadata for the landing page
// ─────────────────────────────────────────────────────────────────────

/** All 79 themes — Top 10 picks first, then Classic, Auto, Scientists,
 *  Anime, Marvel, OS. Each ships with a detailed and a compact variant. */
export const themes = [
  // ── Top picks (cross-cultural recognition) ────────────────────────
  { id: 'cyberpunk',       name: 'Cyberpunk',       vibe: 'Neon dystopia. //CTX:12% //₵RED:0.42 ▐ JACK-IN.',                                  palette: ['#FF00C8','#00FFFF','#FFFF00','#7C00FF','#0E0E10'], group: 'Top' },
  { id: 'hacker',          name: 'Hacker',          vibe: 'Phosphor green Matrix terminal. ROOT@matrix#',                                     palette: ['#00FF6B','#00C054','#008838','#005C28','#0E0E10'], group: 'Top' },
  { id: 'dragonball',      name: 'Dragon Ball',     vibe: 'Goku power scaling: base → super-saiyan → ssj-blue → ultra instinct.',             palette: ['#FF8800','#FFD700','#3B82F6','#7C3AED','#0E0E10'], group: 'Top' },
  { id: 'naruto',          name: 'Naruto',          vibe: 'Konoha leaf orange. Chakra meter, rasengan accents.',                              palette: ['#F97316','#22C55E','#FBBF24','#0E0E10','#F5F2EA'], group: 'Top' },
  { id: 'pokemon',         name: 'Pokémon',         vibe: 'Pikachu yellow + pokeball red. HP bar, poké counter.',                             palette: ['#FFD700','#EF4444','#3B82F6','#0E0E10','#F5F2EA'], group: 'Top' },
  { id: 'ironman',         name: 'Iron Man',        vibe: 'Stark red + arc-reactor gold. Repulsor energy meter.',                             palette: ['#DC2626','#FBBF24','#F5F2EA','#7F1D1D','#0E0E10'], group: 'Top' },
  { id: 'spiderman',       name: 'Spider-Man',      vibe: 'Webhead red and blue. With great context comes great cost.',                       palette: ['#DC2626','#1E40AF','#0E0E10','#F5F2EA','#FBBF24'], group: 'Top' },
  { id: 'einstein',        name: 'Einstein',        vibe: 'Chalkboard greens. Ψ Einstein · E=mc² · ε spent.',                                 palette: ['#16A34A','#22D3EE','#FBBF24','#F5F2EA','#0E0E10'], group: 'Top' },
  { id: 'tesla',           name: 'Tesla',           vibe: 'Electric purple + lightning yellow. Coil meter, AC ~.',                            palette: ['#7C3AED','#FFD700','#A855F7','#0E0E10','#F5F2EA'], group: 'Top' },
  { id: 'ferrari',         name: 'Ferrari',         vibe: 'Rosso corsa + Modena yellow. Cavallino rampante.',                                 palette: ['#DC2626','#FBBF24','#0E0E10','#F5F2EA','#7F1D1D'], group: 'Top' },

  // ── Practical / Classic ──────────────────────────────────────────
  { id: 'minimal',         name: 'Minimal',         vibe: 'Just the essentials. Model · context · cost. Nothing else.',                       palette: ['#DCBC02','#46DA46','#244A78','#F5F2EA','#0E0E10'], group: 'Practical' },
  { id: 'developer',       name: 'Developer',       vibe: 'Git-aware. Branch, dirty, ahead, behind — all in one breath.',                     palette: ['#DCBC02','#46DA46','#E2D200','#244A78','#0E0E10'], group: 'Practical' },
  { id: 'time',            name: 'Time',            vibe: 'Human-hours tracker. Active vs wall. The only honest count.',                      palette: ['#DCBC02','#46DA46','#22D3EE','#A855F7','#0E0E10'], group: 'Practical' },
  { id: 'zen',             name: 'Zen',             vibe: 'Monochrome ASCII. No colors. No emojis. Recording-ready.',                         palette: ['#0E0E10','#4A4A48','#7A7A78','#E5E0D0','#F5F2EA'], group: 'Practical' },
  { id: 'rainbow',         name: 'Rainbow',         vibe: 'Each cell a different color. Pure joy.',                                           palette: ['#FF0000','#FFA500','#FFFF00','#00FF00','#0000FF'], group: 'Themed' },
  { id: 'anime',           name: 'Anime',           vibe: 'Kawaii (◕‿◕). ✨🌸 Hearts, sparkles, pink overload.',                               palette: ['#FF6BD9','#FFB3DB','#C04AFF','#9333EA','#FECDD3'], group: 'Themed' },
  { id: 'love',            name: 'Love',            vibe: 'Hearts and a love-meter. Spent 0.42$ on us.',                                       palette: ['#EF4444','#F472B6','#FB7185','#FDA4AF','#FECDD3'], group: 'Themed' },
  { id: 'cat',             name: 'Cat',             vibe: '🐱 Paw prints. Purrs. =^.^=',                                                       palette: ['#F97316','#FBBF24','#FB923C','#F472B6','#FECDD3'], group: 'Themed' },
  { id: 'christmas',       name: 'Christmas',       vibe: '🎄 Ho ho ho — red, green, gold. Festive cheer.',                                   palette: ['#DC2626','#16A34A','#FBBF24','#FFFFFF','#0E0E10'], group: 'Themed' },
  { id: 'space',           name: 'Space',           vibe: '🚀 O₂ levels. Fuel gauge. Mission status.',                                         palette: ['#22D3EE','#3B82F6','#A855F7','#F5F2EA','#0E0E10'], group: 'Sci-fi' },
  { id: 'retro',           name: 'Retro',           vibe: '8-bit pixel art. HP:88 SCORE:0042.',                                                palette: ['#46DA46','#FF8800','#0066FF','#FF0000','#0E0E10'], group: 'Sci-fi' },
  { id: 'fire',            name: 'Fire',            vibe: '🔥 Ember → burning → INFERNO → 🌋 LAVA.',                                            palette: ['#EAB308','#F97316','#EF4444','#7F1D1D','#0E0E10'], group: 'Mood' },
  { id: 'ocean',           name: 'Ocean',           vibe: '🌊 Surface → shallow → deep → 🐋 abyss.',                                            palette: ['#22D3EE','#3B82F6','#1D4ED8','#1E1B4B','#0E0E10'], group: 'Mood' },
  { id: 'weather',         name: 'Weather',         vibe: '☀ Clear → ⛅ cloudy → 🌧 rain → ⛈ storm.',                                           palette: ['#FCD34D','#D1D5DB','#3B82F6','#7C3AED','#F5F2EA'], group: 'Mood' },
  { id: 'coffee',          name: 'Coffee',          vibe: '☕ Brew level + cup count. Fueled by caffeine.',                                     palette: ['#92400E','#854D0E','#FBBF24','#F5F2EA','#0E0E10'], group: 'Mood' },
  { id: 'music',           name: 'Music',           vibe: '🎵 Notes ♩♪♫♬. Tempo from largo to presto.',                                         palette: ['#C04AFF','#FBBF24','#FFB3DB','#F5F2EA','#0E0E10'], group: 'Mood' },
  { id: 'game',            name: 'Game',            vibe: '⚔ RPG HUD. HP / MP / gold / LV.',                                                   palette: ['#EF4444','#3B82F6','#FBBF24','#A855F7','#0E0E10'], group: 'Game' },
  { id: 'pirate',          name: 'Pirate',          vibe: "🏴‍☠️ Cap'n. Doubloons. Yarrr!",                                                      palette: ['#92400E','#FBBF24','#EF4444','#F5F2EA','#0E0E10'], group: 'Game' },

  // ── Auto: Europe ─────────────────────────────────────────────────
  { id: 'porsche',         name: 'Porsche',         vibe: 'German precision. Black + Porsche red 911 chrome.',                                palette: ['#DC2626','#0E0E10','#F5F2EA','#7F1D1D','#4A4A48'], group: 'Auto · Europe' },
  { id: 'mercedes',        name: 'Mercedes-Benz',   vibe: 'Tri-star silver + Stuttgart blue. Quiet luxury.',                                  palette: ['#9CA3AF','#1E40AF','#F5F2EA','#0E0E10','#3B82F6'], group: 'Auto · Europe' },
  { id: 'bmw',             name: 'BMW',             vibe: 'Bavarian roundel. M//BMW + propeller blue and white.',                             palette: ['#1E40AF','#F5F2EA','#0E0E10','#3B82F6','#9CA3AF'], group: 'Auto · Europe' },
  { id: 'volvo',           name: 'Volvo',           vibe: 'Swedish iron. ♂ safety scale, Scandinavian blue.',                                  palette: ['#1E40AF','#9CA3AF','#F5F2EA','#0E0E10','#3B82F6'], group: 'Auto · Europe' },

  // ── Auto: America ────────────────────────────────────────────────
  { id: 'ford',            name: 'Ford',            vibe: 'Blue oval ⊰FORD⊱. Built tough.',                                                    palette: ['#003478','#9CA3AF','#F5F2EA','#0E0E10','#22D3EE'], group: 'Auto · America' },
  { id: 'chevy',           name: 'Chevrolet',       vibe: 'Bowtie ⋈ + American gold. SS muscle.',                                              palette: ['#FBBF24','#1E40AF','#F5F2EA','#0E0E10','#3B82F6'], group: 'Auto · America' },
  { id: 'jeep',            name: 'Jeep',            vibe: 'Olive drab + 7-slot grille. Wrangler trail.',                                       palette: ['#92400E','#854D0E','#16A34A','#FBBF24','#0E0E10'], group: 'Auto · America' },
  { id: 'cadillac',        name: 'Cadillac',        vibe: 'Silver crest + crimson. Escalade prestige.',                                        palette: ['#9CA3AF','#DC2626','#F5F2EA','#0E0E10','#4A4A48'], group: 'Auto · America' },

  // ── Auto: Japan ──────────────────────────────────────────────────
  { id: 'toyota',          name: 'Toyota',          vibe: 'Toyota red oval ⊝. ⛩ torii branding.',                                              palette: ['#DC2626','#F5F2EA','#0E0E10','#9CA3AF','#7F1D1D'], group: 'Auto · Japan' },
  { id: 'honda',           name: 'Honda',           vibe: 'Red Ⓗ + chrome. VTEC engineering.',                                                  palette: ['#DC2626','#22D3EE','#F5F2EA','#0E0E10','#9CA3AF'], group: 'Auto · Japan' },
  { id: 'nissan',          name: 'Nissan',          vibe: 'GT-R gunmetal + Nismo red. JDM.',                                                   palette: ['#DC2626','#3B82F6','#9CA3AF','#0E0E10','#F5F2EA'], group: 'Auto · Japan' },

  // ── Auto: Korea ──────────────────────────────────────────────────
  { id: 'hyundai',         name: 'Hyundai',         vibe: 'Hyundai blue + chrome. Modern silhouette.',                                          palette: ['#1E40AF','#22D3EE','#F5F2EA','#0E0E10','#3B82F6'], group: 'Auto · Korea' },
  { id: 'kia',             name: 'Kia',             vibe: 'Vibrant red + green EV9 charge.',                                                    palette: ['#DC2626','#16A34A','#F5F2EA','#0E0E10','#22C55E'], group: 'Auto · Korea' },

  // ── Auto: China ──────────────────────────────────────────────────
  { id: 'byd',             name: 'BYD',             vibe: '⚡ Build Your Dream. Battery green + electric cyan.',                                palette: ['#16A34A','#22D3EE','#0E0E10','#F5F2EA','#3B82F6'], group: 'Auto · China' },
  { id: 'nio',             name: 'NIO',             vibe: 'Premium EV cyan ◐. ET7 driver-focus.',                                              palette: ['#22D3EE','#1E40AF','#0E0E10','#F5F2EA','#3B82F6'], group: 'Auto · China' },
  { id: 'geely',           name: 'Geely',           vibe: 'Global blue ◆. Restrained, modern.',                                                palette: ['#1E40AF','#22D3EE','#9CA3AF','#0E0E10','#F5F2EA'], group: 'Auto · China' },

  // ── Scientists ───────────────────────────────────────────────────
  { id: 'newton',          name: 'Newton',          vibe: '🍎 Parchment beige + apple red. F = ma, gravity meter.',                            palette: ['#92400E','#DC2626','#FBBF24','#0E0E10','#F5F2EA'], group: 'Scientists' },
  { id: 'curie',           name: 'Curie',           vibe: '☢ Radium green. Half-life bar, atomic.',                                            palette: ['#16A34A','#22D3EE','#FBBF24','#0E0E10','#F5F2EA'], group: 'Scientists' },
  { id: 'darwin',          name: 'Darwin',          vibe: '🐢 Naturalist green + sea blue. HMS Beagle.',                                       palette: ['#16A34A','#22D3EE','#92400E','#FBBF24','#F5F2EA'], group: 'Scientists' },
  { id: 'hawking',         name: 'Hawking',         vibe: '🌌 Deep space violet. Black hole horizon, t → ∞.',                                  palette: ['#7C3AED','#22D3EE','#0E0E10','#F5F2EA','#A855F7'], group: 'Scientists' },
  { id: 'galileo',         name: 'Galileo',         vibe: '🔭 Sun gold + sky blue. Eppur si muove.',                                            palette: ['#FBBF24','#3B82F6','#F5F2EA','#0E0E10','#FCD34D'], group: 'Scientists' },
  { id: 'feynman',         name: 'Feynman',         vibe: 'Chalkboard green. ψ → ψ\' diagrams, QED.',                                          palette: ['#16A34A','#F5F2EA','#FBBF24','#0E0E10','#22C55E'], group: 'Scientists' },
  { id: 'turing',          name: 'Turing',          vibe: 'Terminal green Ⓣ. h(p) halting bar, 1/0.',                                          palette: ['#00FF6B','#DC2626','#0E0E10','#F5F2EA','#16A34A'], group: 'Scientists' },
  { id: 'davinci',         name: 'da Vinci',        vibe: '✎ Sepia codex. Vitruvian sketch, ƒ florin.',                                        palette: ['#92400E','#FBBF24','#854D0E','#F5F2EA','#0E0E10'], group: 'Scientists' },

  // ── Anime ────────────────────────────────────────────────────────
  { id: 'onepiece',        name: 'One Piece',       vibe: '🏴‍☠️ Mugiwara red + straw yellow. Berry currency.',                                   palette: ['#DC2626','#FBBF24','#3B82F6','#F5F2EA','#0E0E10'], group: 'Anime' },
  { id: 'ghibli',          name: 'Ghibli',          vibe: '🌳 Soft pastels — Totoro forest, leaf bar.',                                         palette: ['#16A34A','#22D3EE','#F5F2EA','#FCD34D','#0E0E10'], group: 'Anime' },

  // ── Marvel ───────────────────────────────────────────────────────
  { id: 'hulk',            name: 'Hulk',            vibe: '🟢 Bruce → HULK SMASH. Green meter, purple pants.',                                  palette: ['#16A34A','#7C3AED','#0E0E10','#F5F2EA','#22C55E'], group: 'Marvel' },
  { id: 'thor',            name: 'Thor',            vibe: '⚡ Mjölnir lightning + Asgard red.',                                                  palette: ['#FBBF24','#DC2626','#F5F2EA','#0E0E10','#FCD34D'], group: 'Marvel' },
  { id: 'captain-america', name: 'Captain America', vibe: '🛡 RWB shield + Steve Rogers steady.',                                                palette: ['#DC2626','#1E40AF','#F5F2EA','#0E0E10','#3B82F6'], group: 'Marvel' },
  { id: 'wolverine',       name: 'Wolverine',       vibe: '🗡 Yellow + blue cowl. Snikt!',                                                       palette: ['#FBBF24','#1E40AF','#0E0E10','#F5F2EA','#FCD34D'], group: 'Marvel' },
  { id: 'deadpool',        name: 'Deadpool',        vibe: '🌮 Red + black + chimichanga. Max effort.',                                            palette: ['#DC2626','#0E0E10','#F5F2EA','#9CA3AF','#7F1D1D'], group: 'Marvel' },
  { id: 'blackwidow',      name: 'Black Widow',     vibe: '🕸 Red hourglass + S.H.I.E.L.D. ops.',                                                palette: ['#DC2626','#0E0E10','#F5F2EA','#9CA3AF','#7F1D1D'], group: 'Marvel' },
  { id: 'strange',         name: 'Doctor Strange',  vibe: '🔮 Mystic violet + cloak red. ⌬ Sanctum.',                                            palette: ['#7C3AED','#DC2626','#FBBF24','#0E0E10','#A855F7'], group: 'Marvel' },
  { id: 'wanda',           name: 'Scarlet Witch',   vibe: '🌹 Chaos magic — red + violet. 🪄 hex.',                                              palette: ['#DC2626','#7C3AED','#A855F7','#0E0E10','#F5F2EA'], group: 'Marvel' },

  // ── Operating Systems ────────────────────────────────────────────
  { id: 'macos',           name: 'macOS',           vibe: '🍎 Six-color Apple rainbow on chrome-grey.',                                          palette: ['#22C55E','#DC2626','#F97316','#FBBF24','#3B82F6'], group: 'OS' },
  { id: 'windows',         name: 'Windows 11',      vibe: '⊞ Fluent four-color tile + Windows cyan.',                                            palette: ['#DC2626','#16A34A','#3B82F6','#FBBF24','#22D3EE'], group: 'OS' },
  { id: 'linux',           name: 'Linux',           vibe: '🐧 Tux black + orange beak. GNU/Linux.',                                              palette: ['#F97316','#0E0E10','#F5F2EA','#FBBF24','#92400E'], group: 'OS' },
  { id: 'ubuntu',          name: 'Ubuntu',          vibe: '⊕ Friend circle — Ubuntu orange + aubergine purple.',                                 palette: ['#E95420','#77216F','#F5F2EA','#0E0E10','#A855F7'], group: 'OS' },
  { id: 'arch',            name: 'Arch',            vibe: '▲ Pacman cyan. btw, I use arch.',                                                     palette: ['#22D3EE','#1793D1','#0E0E10','#F5F2EA','#3B82F6'], group: 'OS' },
  { id: 'debian',          name: 'Debian',          vibe: '🌀 Debian red swirl. Stable, sid, testing.',                                          palette: ['#A80030','#DC2626','#0E0E10','#F5F2EA','#9CA3AF'], group: 'OS' },
  { id: 'fedora',          name: 'Fedora',          vibe: '🎩 Fedora hat blue. Freedom + features.',                                              palette: ['#3C6EB4','#22D3EE','#F5F2EA','#0E0E10','#3B82F6'], group: 'OS' },
  { id: 'kali',            name: 'Kali',            vibe: '🐉 Kali blue + offsec red. pwn-mode.',                                                 palette: ['#367BF0','#DC2626','#0E0E10','#F5F2EA','#3B82F6'], group: 'OS' },
  { id: 'mint',            name: 'Mint',            vibe: '🌿 Cinnamon mint green. Fresh.',                                                       palette: ['#86BE43','#22C55E','#F5F2EA','#0E0E10','#22D3EE'], group: 'OS' },
  { id: 'nixos',           name: 'NixOS',           vibe: '❄ Nix blue snowflake. Declarative, reproducible.',                                    palette: ['#5277C3','#22D3EE','#3B82F6','#F5F2EA','#0E0E10'], group: 'OS' },

  // ── World religions (top 7 by adherents) ─────────────────────────
  { id: 'christianity',    name: 'Christianity',    vibe: '✝ Wine-red + Marian blue + papal gold. Faith meter, € alms.',                            palette: ['#7F1D1D','#1E40AF','#FBBF24','#F5F2EA','#0E0E10'], group: 'Religion' },
  { id: 'islam',           name: 'Islam',           vibe: '☪ Islamic green + white + gold calligraphy. Taqwa, ﷼ sadaqah.',                          palette: ['#16A34A','#F5F2EA','#FBBF24','#0E0E10','#22C55E'], group: 'Religion' },
  { id: 'hinduism',        name: 'Hinduism',        vibe: '🕉 Saffron + marigold + vermilion. Dharma scale, ₹ seva.',                                palette: ['#F97316','#FBBF24','#DC2626','#F5F2EA','#0E0E10'], group: 'Religion' },
  { id: 'buddhism',        name: 'Buddhism',        vibe: '☸ Monk saffron + gold + maroon. Karma meter, ฿ dāna.',                                   palette: ['#F97316','#FBBF24','#7F1D1D','#F5F2EA','#0E0E10'], group: 'Religion' },
  { id: 'judaism',         name: 'Judaism',         vibe: '✡ Tallit blue + white + menorah gold. Mitzvah, ₪ tzedakah.',                              palette: ['#1E40AF','#F5F2EA','#FBBF24','#0E0E10','#3B82F6'], group: 'Religion' },
  { id: 'sikhism',         name: 'Sikhism',         vibe: '☬ Khalsa deep blue + saffron + white. Sewa, daswandh.',                                  palette: ['#1E40AF','#F97316','#F5F2EA','#0E0E10','#FBBF24'], group: 'Religion' },
  { id: 'shinto',          name: 'Shinto',          vibe: '⛩ Vermilion torii + shrine white + gold. Kami, ¥ saisen.',                              palette: ['#DC2626','#F5F2EA','#FBBF24','#0E0E10','#7F1D1D'], group: 'Religion' },
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
  { qKey: 'faq.q.reset',     aKey: 'faq.a.reset' },
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
  { fKey: 'cmp.f.themes', def: false, ours: '79 themes × 2 variants = 158' },
  { fKey: 'cmp.f.blocks', def: false, ours: '19 blocks, BLOCKS.md' },
  { fKey: 'cmp.f.cli',    def: false, ours: 'use / custom / list / preview / update' },
  { fKey: 'cmp.f.slash',  def: false, ours: 'optional, drop-in' },
  { fKey: 'cmp.f.deps',   def: '—',  ours: 'bash + jq' },
  { fKey: 'cmp.f.reset',  def: false, ours: true, highlight: true },
];
