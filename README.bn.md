# 🛰️ Claude Code Status Line — ৮১টি থিম, কনফিগারযোগ্য ব্লক, CLI

> **Claude Code**-এর ডিফল্ট স্ট্যাটাস লাইনের ড্রপ-ইন বিকল্প: মসৃণ প্রোগ্রেস বার সহ লাইভ **context window** ব্যবহার, USD-তে **session cost**, **5h / 7d rate-limit** সতর্কতা, dirty / ahead / behind গণনা সহ **git branch**, **time-on-task tracking**, এবং সক্রিয় **model name** (1M-context ভ্যারিয়েন্টের জন্য `(1M)` ইন্ডিকেটর সহ) — সব একটি রঙিন Bash লাইনে। **৮১টি তৈরি থিম** সহ আসে — শীর্ষ পছন্দ (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), ক্লাসিক (minimal, developer, muted, mono, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), গাড়ির ব্র্যান্ড (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), আরও বিজ্ঞানী (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), আরও anime (onepiece, ghibli), আরও Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), OS থিম (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), এবং বিশ্ব ধর্ম (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) — আর নিজের লাইন তৈরির জন্য একটি **26-block library**। একটি অল-ইন-ওয়ান CLI কনফিগারেটর এবং Claude Code-এর জন্য একটি `/statusline` স্ল্যাশ কমান্ড অন্তর্ভুক্ত।

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 162](https://img.shields.io/badge/variants-162-brightgreen.svg)](#-162-ready-made-variants--pick-one-and-go)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md) · [ไทย](README.th.md) · [עברית](README.he.md) · বাংলা · [اردو](README.ur.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **প্রো টিপ — Context নিয়ন্ত্রণ**: আপনার context window যত বেশি ভরে যায়, Claude-এর সাথে আপনার কথোপকথন তত **কম কার্যকর** হয়ে ওঠে — এবং আপনি তত **দ্রুত** আপনার 5h/7d সীমা শেষ করে ফেলেন। দক্ষভাবে কাজ চালিয়ে যেতে যখনই আপনি **60%** অতিক্রম করেন তখনই clear বা `/compact` করুন।

### ⏳ Reset countdown — আপনার সীমার চারপাশে পরিকল্পনা করুন

5h / 7d মিটারে প্রতিটি উইন্ডো রিসেট হওয়ার মুহূর্ত পর্যন্ত একটি লাইভ কাউন্টডাউন অন্তর্ভুক্ত থাকে: `5h{1.1h}: 1%` — 5-ঘণ্টার উইন্ডো 1.1 ঘণ্টায় রিসেট হয়; `7d{1.1d}: 0%` — সাপ্তাহিক উইন্ডো 1.1 দিনে রিসেট হয়। আপনি সবসময় জানেন কখন আপনি আবার 0%-এ ফিরে আসবেন, তাই আপনি একটি রিসেটের ঠিক পরেই ভারী কাজ শিডিউল করতে পারেন এবং কাজের মাঝখানে সীমায় ধাক্কা না খেয়ে আপনার উৎপাদনশীলতা বিতরণ করতে পারেন। Claude Code দ্বারা পাঠানো `rate_limits.*.resets_at` দ্বারা চালিত; যদি আপনার বিল্ড রিসেট টাইমস্ট্যাম্প না পাঠায়, মিটারগুলি সুন্দরভাবে সাধারণ `5h: 1%`-এ ফিরে যায়।

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**ডিজাইন অনুসারে অনুমানযোগ্য** — প্রতিটি মিটার তার রিসেটের দিকে কাউন্টডাউন করে, তাই আপনি দেয়ালে ধাক্কা না খেয়ে আপনার কাজের গতি নিয়ন্ত্রণ করেন।

## ⚡ Quick start

দ্রুততম পথ — বিল্ট-ইন CLI সহ বান্ডেল করা অল-ইন-ওয়ান স্ক্রিপ্ট:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

তারপর `~/.claude/settings.json`-এ যোগ করুন:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 `refreshInterval: 30` সেশন নিষ্ক্রিয় থাকা অবস্থায়ও প্রতি 30 সেকেন্ডে লাইনটি পুনরায় চালায় — এটি reset countdown (`5h{1.1h}`), time tracker এবং রিসেট-পরবর্তী পরিবর্তনগুলি লাইভ রাখে। 30 একটি যুক্তিসঙ্গত ডিফল্ট; 60 ব্যাটারি-সাশ্রয়ী; শুধুমাত্র ইভেন্টে (নতুন assistant মেসেজ, `/compact`, vim টগল) রিফ্রেশ করতে এটি বাদ দিন।

Claude Code পুনরায় চালু করুন (অথবা `/config` reload চালান)। হয়ে গেল।

### অথবা vibe-chill পদ্ধতি · Claude-কে করতে দিন

যখন আপনার কাছে Claude Code আছে তখন কেন একটি টার্মিনাল স্পর্শ করবেন? আপনার Claude Code সেশনে এই একটি প্রম্পট পেস্ট করুন — Claude প্রতিটি ধাপ পরিচালনা করে এবং প্রতিটি কমান্ডের আগে জিজ্ঞাসা করে।

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", "refreshInterval": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> প্রতিটি অনুমতির প্রম্পটে শুধু `y` (yes) বলুন। হয়ে গেল।


## Claude Code-এর জন্য একটি কাস্টম স্ট্যাটাস লাইন / স্ট্যাটাস বার কেন?

Claude Code-এর ডিফল্ট স্ট্যাটাস লাইন অপ্রতুল। এই ড্রপ-ইন বিকল্পটি নিচের স্ট্যাটাস বারকে প্রতিটি সেশনের জন্য একটি **এক নজরে ড্যাশবোর্ডে** পরিণত করে:

- 🔋 আমি কতটা context পুড়িয়েছি? (মসৃণ 1.25% ভগ্নাংশ বার)
- 💰 এই সেশনে আমার কত খরচ হচ্ছে?
- 🚦 আমি আমার rate limit-এর কতটা কাছাকাছি?
- 🧠 আমি কোন thinking লেভেল / মডেলে আছি?
- 🌿 আমি কোন git branch-এ আছি?

সব **এক লাইনে**, রঙ-কোডেড, জরুরিত্ব নির্দেশকারী স্মার্ট আইকন সহ।

## ✨ Features

- 🪐 **লাইভ context বার** — সাব-সেল নির্ভুলতা সহ 10-সেল প্রোগ্রেস বার (quadrant বা vertical ভগ্নাংশ গ্লিফ)
- 🧠 **Model name** — 1M-context ভ্যারিয়েন্টের জন্য `(1M)` ইন্ডিকেটর সহ
- 💸 USD-তে **Session cost**, প্রতিটি রেন্ডারে আপডেট হয়
- ⬆️⬇️ **প্রতি-মেসেজ টোকেন কাউন্টার** (input / output)
- 🚦 **Rate limits** — 5h / 7d, > 50% হলে ⚠️ সতর্কতা সহ
- 🔄 **API-mode fallback** — যখন কোনো rate limit পাইপ করা হয় না, তখন থিন-স্পেস হাজার বিভাজক সহ মোট সেশন টোকেন (`tokens: NNN K`) দেখায়
- 🚀 **স্মার্ট স্ট্যাটাস আইকন** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% context fill
- 🎨 **256-color ANSI** — প্রতিটি সেগমেন্টে উজ্জ্বল, স্বতন্ত্র রঙ
- 🧩 **প্লাগেবল বার স্টাইল** — `quadrant` (▖▄▙█) বা `vertical` (▏▎▍▌▋▊▉█) বেছে নিন, অথবা 10 লাইন bash-এ নিজের তৈরি করুন
- ⚡ **হালকা** — খাঁটি `bash` + `jq`। কোনো Node নেই, কোনো Python নেই, কোনো daemon নেই, কোনো telemetry নেই

## 🎨 162 ready-made variants — একটি বেছে নিন আর শুরু করুন

প্রতিটি থিম **দুটি ভ্যারিয়েন্টে** আসে:

- **Detailed** — সম্পূর্ণ ফিচার সেট (model, context bar, cost, tokens, git, time, mood icon, …)
- **Compact** — শুধু `model · context % + bar · branch`

`~/.claude/status-line.sh use <name>` দিয়ে প্রয়োগ করুন (compact ভ্যারিয়েন্টের জন্য `-compact` যোগ করুন)।

### 🔝 Top picks (10) — সবচেয়ে বেশি চাওয়া, ক্রস-কালচারাল

| Theme | Vibe |
|---|---|
| `cyberpunk`  | neon dystopia · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | phosphor-green Matrix terminal · `[SYS] :: ROOT@matrix#` |
| `dragonball` | Goku scaling: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | Konoha leaf orange · chakra meter · 🌀 rasengan |
| `pokemon`    | Pikachu yellow + pokeball red · HP bar |
| `ironman`    | 🦾 Stark red + arc-reactor gold |
| `spiderman`  | 🕷 webhead red + blue · with great context comes great cost |
| `einstein`   | chalkboard greens · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ electric purple + lightning yellow · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + Modena yellow |

### 🛠 Practical / Classic (20 themes)

| Theme | File / Apply |
|---|---|
| 🛠 minimal       | [`statusline-minimal.sh`](examples/statusline-minimal.sh) · `use minimal` |
| 🛠 developer     | [`statusline-developer.sh`](examples/statusline-developer.sh) · `use developer` |
| 🛠 muted         | `use muted` |
| 🛠 mono          | `use mono` |
| 🛠 time          | [`statusline-time.sh`](examples/statusline-time.sh) · `use time` |
| 🛠 zen           | [`statusline-zen.sh`](examples/statusline-zen.sh) · `use zen` |
| 🌈 rainbow       | [`statusline-rainbow.sh`](examples/statusline-rainbow.sh) · `use rainbow` |
| ✨ anime         | [`statusline-anime.sh`](examples/statusline-anime.sh) · `use anime` |
| 💖 love          | [`statusline-love.sh`](examples/statusline-love.sh) · `use love` |
| 🐱 cat           | [`statusline-cat.sh`](examples/statusline-cat.sh) · `use cat` |
| 🎄 christmas     | [`statusline-christmas.sh`](examples/statusline-christmas.sh) · `use christmas` |
| 🚀 space         | [`statusline-space.sh`](examples/statusline-space.sh) · `use space` |
| 🕹 retro         | [`statusline-retro.sh`](examples/statusline-retro.sh) · `use retro` |
| 🔥 fire          | [`statusline-fire.sh`](examples/statusline-fire.sh) · `use fire` |
| 🌊 ocean         | [`statusline-ocean.sh`](examples/statusline-ocean.sh) · `use ocean` |
| ☀ weather        | [`statusline-weather.sh`](examples/statusline-weather.sh) · `use weather` |
| ☕ coffee        | [`statusline-coffee.sh`](examples/statusline-coffee.sh) · `use coffee` |
| 🎵 music         | [`statusline-music.sh`](examples/statusline-music.sh) · `use music` |
| ⚔ game           | [`statusline-game.sh`](examples/statusline-game.sh) · `use game` |
| 🏴‍☠️ pirate       | [`statusline-pirate.sh`](examples/statusline-pirate.sh) · `use pirate` |

> নোট: `cyberpunk` এবং `hacker` উপরের **Top picks**-এ আছে — আপনি একটি single-theme
> ইনস্টল চাইলে সেগুলি `examples/` ফোল্ডারেও আছে।

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Auto brands (আরও 16, top picks-এ `ferrari` অন্তর্ভুক্ত)

শুধুমাত্র `statusline-bundle.sh`-এ আসে — `~/.claude/status-line.sh use <name>` দিয়ে যেকোনোটি বেছে নিন।

| Region | Themes |
|---|---|
| 🇪🇺 Europe  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 America | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japan   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 Great scientists (আরও 8, top picks-এ `einstein` ও `tesla` অন্তর্ভুক্ত)

| Theme | Vibe |
|---|---|
| `newton`   | parchment ink, `🍎`, `F=ma` |
| `curie`    | radium green, `☢`, half-life meter |
| `darwin`   | naturalist green, `🐢`, HMS Beagle |
| `hawking`  | deep space violet, `🌌`, `t → ∞` |
| `galileo`  | sun gold, `🔭`, *eppur si muove* |
| `feynman`  | chalk-on-green, `〰`, `ψ → ψ'` |
| `turing`   | terminal green, `Ⓣ`, halting bar `1/0` |
| `davinci`  | sepia codex, `✎`, *Vitruvian* |

### ✨ Anime (আরও 3, top picks-এ `dragonball`, `naruto`, `pokemon` অন্তর্ভুক্ত)

`onepiece` · `ghibli`

### 🦸 Marvel superheroes (আরও 8, top picks-এ `ironman` ও `spiderman` অন্তর্ভুক্ত)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Operating systems (10 themes)

| Theme | Vibe |
|---|---|
| `macos`   | 🍎 six-color Apple rainbow on chrome-grey |
| `windows` | ⊞ Fluent four-color tile + WINDOWS 11 cyan |
| `linux`   | 🐧 Tux black + orange beak |
| `ubuntu`  | ⊕ friend circle — orange + aubergine purple |
| `arch`    | ▲ pacman cyan · btw, I use arch |
| `debian`  | 🌀 red swirl · stable / sid / testing |
| `fedora`  | 🎩 Fedora hat blue · freedom + features |
| `kali`    | 🐉 Kali blue + offsec red · pwn-mode |
| `mint`    | 🌿 cinnamon mint green · the friendliest shell |
| `nixos`   | ❄ Nix blue snowflake · declarative, reproducible |

### 🕊 World religions (অনুসারীর সংখ্যা অনুযায়ী শীর্ষ 7)

| Theme | Vibe |
|---|---|
| `christianity` | ✝ wine red + Marian blue + papal gold · faith meter, € alms |
| `islam`        | ☪ Islamic green + white + gold calligraphy · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 saffron + marigold + vermilion · dharma, ₹ seva |
| `buddhism`     | ☸ monk saffron + gold + maroon · karma, ฿ dāna |
| `judaism`      | ✡ tallit blue + white + menorah gold · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ Khalsa deep blue + saffron + white · sewa, daswandh |
| `shinto`       | ⛩ vermilion torii + shrine white + gold · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 81 themes works
```

**প্রথমে আপনার টার্মিনালে সবগুলি ব্রাউজ করুন** — প্রতিটি ভ্যারিয়েন্টের
[`screenshots/`](screenshots/)-এ একটি প্রি-রেন্ডার করা প্রিভিউ আছে:

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (162 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

বিবরণ সহ সম্পূর্ণ টেবিলের জন্য [`examples/README.md`](examples/README.md) দেখুন,
এবং প্রিভিউগুলি কীভাবে তৈরি হয় তার জন্য [`screenshots/README.md`](screenshots/README.md) দেখুন।

## 🧱 ব্লক থেকে নিজের তৈরি করুন

কোনো প্রিসেট ব্যবহার করতে চান না? নামকরা ব্লকের একটি লাইব্রেরি থেকে একটি কাস্টম স্ট্যাটাস লাইন
তৈরি করুন — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

[**BLOCKS.md**](BLOCKS.md) দেখুন এর জন্য:

- **ব্লকের ক্যাটালগ** (প্রতিটি একটি কপি-পেস্টযোগ্য bash স্নিপেট)
- **স্টাইল প্যাক** (`classic`, `compact`, `anime`, `hacker`, `cyberpunk`, `zen`
  থেকে রঙের প্যালেট ও বিভাজক)
- আপনার নিজের লাইন তৈরির একটি **3-step রেসিপি**: একটি স্টাইল বেছে নিন → ব্লক তালিকাভুক্ত করুন
  → পেস্ট করুন

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 All-in-one bundle (`statusline-bundle.sh`)

আপনি যদি 40+ ফাইল পরিচালনা করতে না চান, তাহলে **একক বান্ডেল করা
স্ক্রিপ্ট** [`statusline-bundle.sh`](statusline-bundle.sh) নিন — এতে
প্রতিটি থিম + প্রতিটি ব্লক + একটি CLI কনফিগারেটর একটি ফাইলে আছে।

```bash
cp statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh

~/.claude/status-line.sh use cyberpunk            # switch theme
~/.claude/status-line.sh use cyberpunk-compact    # use compact variant
~/.claude/status-line.sh custom model context-bar git cost  # compose from blocks
~/.claude/status-line.sh list                     # list themes
~/.claude/status-line.sh list blocks              # list blocks
~/.claude/status-line.sh preview anime            # preview without saving
~/.claude/status-line.sh show                     # show current config
~/.claude/status-line.sh reset                    # reset to default
```

কনফিগারেশন `~/.claude/statusline.conf`-এ সংরক্ষিত হয় এবং রিস্টার্ট জুড়ে
টিকে থাকে। একই ফাইল **রেন্ডারার** হিসেবে (যখন Claude Code stdin-এ JSON সহ
এটিকে কল করে) এবং **কনফিগারেটর** হিসেবে (যখন আপনি আর্গুমেন্ট সহ এটিকে কল করেন)
উভয়ভাবেই কাজ করে।

### `/statusline` স্ল্যাশ কমান্ড

Claude Code-এর ভিতরে একটি `/statusline` স্ল্যাশ কমান্ড সক্ষম করতে
[`commands/statusline.md`](commands/statusline.md) `~/.claude/commands/`-এ রাখুন:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

তারপর যেকোনো Claude Code সেশনে আপনি টাইপ করতে পারেন:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude আপনার জন্য বান্ডেল CLI চালাবে, ফলাফল রিপোর্ট করবে, এবং আপনাকে
reload করার কথা মনে করিয়ে দেবে।

### ঐচ্ছিক shell alias

```bash
alias statusline='~/.claude/status-line.sh'
```

তারপর `statusline cyberpunk` যেকোনো টার্মিনাল থেকে কাজ করে।

## 🚀 Install

### Manual install (3 steps)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

তারপর `~/.claude/settings.json`-এ যোগ করুন:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 `refreshInterval: 30` সেশন নিষ্ক্রিয় থাকা অবস্থায়ও প্রতি 30 সেকেন্ডে লাইনটি পুনরায় চালায় — এটি reset countdown (`5h{1.1h}`), time tracker এবং রিসেট-পরবর্তী পরিবর্তনগুলি লাইভ রাখে। 30 একটি যুক্তিসঙ্গত ডিফল্ট; 60 ব্যাটারি-সাশ্রয়ী; শুধুমাত্র ইভেন্টে (নতুন assistant মেসেজ, `/compact`, vim টগল) রিফ্রেশ করতে এটি বাদ দিন।

Claude Code পুনরায় চালু করুন (অথবা `/config` reload চালান)।

### Claude Code agent-এর মাধ্যমে ইনস্টল (স্বয়ংক্রিয় ব্যাকআপ সহ)

Claude Code আপনার জন্য এটি নিরাপদে ইনস্টল করুক? এই প্রম্পট পেস্ট করুন:

> "Install the status line from this repo as my Claude Code status line:
> 1. If `~/.claude/status-line.sh` already exists, back it up to
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (pick a free `-N`
>    suffix if a backup with that name already exists).
> 2. Copy `statusline.sh` from this repo to `~/.claude/status-line.sh` and `chmod +x`.
> 3. Read `~/.claude/settings.json`. If it has no `statusLine` key, add a
>    `statusLine` block pointing to the absolute path of the script and
>    including `"refreshInterval": 30`. If `statusLine` already exists and
>    points elsewhere, back up `settings.json` to `.bak.<timestamp>` first.
> 4. Smoke-test the script:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Tell me to restart Claude Code and report the backups created."

### সর্বশেষ সংস্করণে আপডেট করা

```bash
~/.claude/status-line.sh update
```

GitHub থেকে সর্বশেষ বান্ডেল আনে, একটি টাইমস্ট্যাম্প করা ব্যাকআপ তৈরি করে
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), এবং আপনার থিম কনফিগ
(`~/.claude/statusline.conf`) সংরক্ষণ করে। এরপর Claude Code পুনরায় চালু করুন।

আপনি কী ইনস্টল করেছেন তা পরীক্ষা করুন: `~/.claude/status-line.sh version`।

### Requirements

- `bash` 4+ (স্ক্রিপ্ট 0-indexed অ্যারে ব্যবহার করে — **`zsh`-এর অধীনে চালাবেন না**)
- JSON পার্সিংয়ের জন্য `jq` — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (শুধুমাত্র `statusline update`-এর জন্য প্রয়োজন; বেশিরভাগ সিস্টেমে প্রি-ইনস্টল করা)
- একটি 256-color টার্মিনাল (মূলত প্রতিটি আধুনিক টার্মিনাল)

## ⚙️ Configuration

`statusline.sh`-এর উপরের দিকে থাকা ধ্রুবকগুলি সম্পাদনা করুন:

| Variable / function | এটি কী নিয়ন্ত্রণ করে |
|---|---|
| `BAR_STYLE` | `"quadrant"` (ডিফল্ট, 2.5% step) বা `"vertical"` (1.25% step) |
| `pct_icon()` | বারের আগে 🚀 / 🚗 / ⚠️ আইকনের জন্য থ্রেশহোল্ড |
| `pct_color()` | শতাংশ / বারের জন্য রঙের থ্রেশহোল্ড |
| ANSI color constants | যেকোনো সেগমেন্ট পুনরায় রঙ করুন (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 ডিফল্ট Claude Code স্ট্যাটাস লাইনের সাথে তুলনা

| Capability | Default | This project |
|---|---|---|
| সক্রিয় **model name** | ✅ | ✅ (1M-context ভ্যারিয়েন্টের জন্য `(1M)` ফ্ল্যাগ সহ) |
| ব্যবহৃত **Context window** % | ❌ | ✅ লাইভ, 1.25 % নির্ভুলতা |
| context-এর জন্য **Progress bar** | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| USD-তে **Session cost** | ❌ | ✅ প্রতিটি রেন্ডারে আপডেট হয় |
| **প্রতি-মেসেজ** input/output টোকেন কাউন্টার | ❌ | ✅ |
| **মোট সেশন টোকেন** (API mode fallback) | ❌ | ✅ |
| > 50 %-এ ⚠️ সহ **5h / 7d rate-limit** ইন্ডিকেটর | ❌ | ✅ |
| limit মিটারে Reset countdown (`5h{1.1h}`) | ❌ | ✅ |
| **Git branch** + dirty + ahead/behind | ❌ | ✅ |
| **Time-on-task** (active vs wall clock) | ❌ | ✅ |
| **Thinking / effort level** প্রদর্শন | ❌ | ✅ |
| থিমড প্রিসেট | ❌ | ✅ 81 থিম × 2 ভ্যারিয়েন্ট = **162 ready-made** |
| নামকরা ব্লক থেকে রচনা | ❌ | ✅ 26 ব্লক, দেখুন [BLOCKS.md](BLOCKS.md) |
| বিল্ট-ইন CLI কনফিগারেটর | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` স্ল্যাশ কমান্ড | ❌ | ✅ ঐচ্ছিক, দেখুন [`commands/`](commands/) |
| বাহ্যিক নির্ভরতা | — | `bash` 4+ এবং `jq` (কোনো Node নেই, কোনো Python নেই, কোনো daemon নেই) |
| License | — | Source-Available (reuse-by-permission) |

## 💡 Use cases

কংক্রিট পরিস্থিতি যেখানে এই প্রকল্পটি নিজের মূল্য পরিশোধ করে:

- **"আমি আমার 1 M context-এর কতটা পুড়িয়েছি?"** — প্রতিটি প্রম্পটের আগে একটি লাইভ শতাংশ + বার দেখুন।
- **"এই Claude Code সেশনে আমার কত খরচ হচ্ছে?"** — চলমান USD মোট, প্রতিটি রেন্ডারে আপডেট হয়।
- **"আমি কি আজ একটি rate limit-এ পৌঁছাব?"** — > 50 % হলে ⚠️ সহ 5 h / 7 d ইন্ডিকেটর।
- **"আমি কি সঠিক branch-এ আছি?"** — আপনার স্ট্যাটাস লাইনে git branch + dirty + ahead/behind।
- **"আমি এই ফিচারে আসলে কত ঘণ্টা ব্যয় করেছি?"** — time-on-task tracker (`active` vs `wall`)।
- **"আমি চাই আমার টার্মিনাল মজার হোক।"** — anime, cyberpunk, hacker, retro, weather, ocean, fire এবং অন্যান্য থিম।
- **"আমি স্ক্রিন রেকর্ডিংয়ের জন্য একটি minimal, ASCII-only স্ট্যাটাস লাইন চাই।"** — `zen` থিম।
- **"আমি একটি স্ট্যাটাস লাইন শিপ করতে চাই যা আমার পুরো টিম ব্যবহার করে।"** — একক বান্ডেল করা স্ক্রিপ্ট + CLI কনফিগারেটর + স্ল্যাশ কমান্ড।

## ❓ FAQ

### "Claude Code Status Line" কী?

[Claude Code](https://claude.com/claude-code)-এ (Anthropic-এর CLI) ডিফল্ট স্ট্যাটাস লাইনের একটি bash-ভিত্তিক বিকল্প। এটি স্ক্রিনের নিচের লাইনটিকে একটি বাস্তব ড্যাশবোর্ডে পরিণত করে: model, context %, progress bar, session cost, rate limits, git status, time-on-task, এবং আরও অনেক কিছু।

### `5h{1.1h}: 1%` মানে কী?

আপনি 5-ঘণ্টার উইন্ডোর 1% ব্যবহার করেছেন, এবং `{1.1h}` একটি লাইভ কাউন্টডাউন — উইন্ডোটি 1.1 ঘণ্টায় রিসেট হয় (`7d{1.1d}`: সাপ্তাহিক উইন্ডো 1.1 দিনে রিসেট হয়)। প্রতিটি রেন্ডারে `rate_limits.*.resets_at` থেকে পড়া হয়। আপনার বিল্ডে কোনো reset টাইমস্ট্যাম্প নেই? মিটারটি সাধারণ `5h: 1%`-এ ফিরে যায়।

### স্ট্যাটাস লাইন কি নিজে নিজে আপডেট হয়? আমার `{1.1h}` কাউন্টডাউন জমে যাওয়া দেখাচ্ছে।

Claude Code ইভেন্টে পুনরায় রেন্ডার করে — নতুন assistant মেসেজ, `/compact`, permission-mode বা vim-mode পরিবর্তন (300 ms-এ ডিবাউন্স করা) — তাই ইভেন্টের মধ্যে লাইনটি জমে যায়। `~/.claude/settings.json`-এ statusLine ব্লকে `"refreshInterval": 30` যোগ করুন এবং এটি একটি নির্দিষ্ট 30-সেকেন্ড টাইমারেও পুনরায় চালায়, নিষ্ক্রিয় থাকা অবস্থায়ও কাউন্টডাউন এবং time tracker চলমান রাখে। একটি রেন্ডারে ~0.1 s খরচ হয়, তাই 30 s নগণ্য; ব্যাটারিতে বা বিশাল রিপোতে 60 ব্যবহার করুন (প্রতিটি রেন্ডারে git status চলে); সর্বনিম্ন 1।

### এটি কীভাবে ইনস্টল করা হয়?

`statusline-bundle.sh`-কে `~/.claude/status-line.sh`-এ কপি করুন, `chmod +x` করুন, তারপর Claude Code-এর `~/.claude/settings.json`-এর `statusLine.command`-কে সেই পথের দিকে নির্দেশ করান। সম্পূর্ণ নির্দেশাবলী [Quick start](#-quick-start) এবং [Install](#-install) সেকশনে।

### এটি কি 1 M context window মডেল সমর্থন করে?

হ্যাঁ। স্ক্রিপ্টটি মডেল আইডিতে `[1m]` এবং display name-এ `1M` সনাক্ত করে এবং বারের ডিনোমিনেটরকে 1 000 000 টোকেনে সমন্বয় করে। আপনি দেখবেন `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`।

### এটি কোন কোন মডেলের সাথে কাজ করে?

Claude Code যে কোনো মডেল সমর্থন করে — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, ইত্যাদি। স্ক্রিপ্টটি Claude Code প্রদত্ত stdin JSON থেকে `model.display_name` এবং `model.id` পড়ে; এটি মডেলের নাম হার্ডকোড করে না।

### আমি কি রঙ, থিম কাস্টমাইজ করতে বা নিজের যোগ করতে পারি?

হ্যাঁ — তিনটি উপায়:

1. **81টি থিমের** একটি বেছে নিন (মোট 162 ভ্যারিয়েন্ট) — `~/.claude/status-line.sh use <name>` ব্যবহার করুন অথবা স্ট্যান্ডঅ্যালোন স্ক্রিপ্টের জন্য [`examples/`](examples/) ব্রাউজ করুন।
2. **নামকরা ব্লক** থেকে নিজের রচনা করুন — দেখুন [BLOCKS.md](BLOCKS.md)।
3. সরাসরি `statusline.sh`-এ রঙের ধ্রুবক এবং বার স্টাইল সম্পাদনা করুন।

### এটি কি Claude Code-কে ধীর করবে?

না। প্রতিটি রেন্ডার প্রতি স্ট্যাটাস পুনঃ-অঙ্কনে একবার চলে, পাইপ করা JSON-কে `jq` দিয়ে পার্স করে, ঐচ্ছিকভাবে transcript-এর সর্বশেষ লাইন `grep` করে, এবং প্রিন্ট করে। time-tracker সক্ষম থাকলেও সাধারণ রেন্ডার ≤ 50 ms।

### এটি কি `jq` ছাড়া কাজ করে?

`jq` প্রয়োজন — এটি Claude Code stdin-এ যে JSON পাঠায় তা পার্স করে। এটি `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), বা `choco install jq` (Windows) দিয়ে ইনস্টল করুন।

### এটি কি Windows-এ কাজ করে?

হ্যাঁ, যেকোনো পরিবেশে যা `bash` 4+ এবং `jq` চালায় — Git Bash, WSL, MSYS2, Cygwin। খাঁটি CMD/PowerShell সমর্থিত নয়।

### এটি কি Linux / macOS-এ কাজ করে?

উভয়েই হ্যাঁ। macOS BSD `date` ব্যবহার করে, Linux GNU `date` ব্যবহার করে — time-tracker উভয়টিই স্বচ্ছভাবে পরিচালনা করে।

### আমি কি এটি Claude Code-এর পরিবর্তে raw Anthropic API-এর সাথে ব্যবহার করতে পারি?

আংশিকভাবে। স্ট্যাটাস লাইনটি Claude Code-এর stdin JSON ফরম্যাটের জন্য ডিজাইন করা। raw API ব্যবহারের জন্য, rate-limit ইন্ডিকেটরগুলি স্বয়ংক্রিয়ভাবে একটি **মোট সেশন টোকেন** প্রদর্শনে (`tokens: NNN K`) ফিরে যায়।

### কনফিগারেশন কোথায় সংরক্ষিত হয়?

`~/.claude/statusline.conf` — বান্ডেলের CLI দ্বারা লেখা একটি ক্ষুদ্র shell-sourced ফাইল (`statusline.sh use <theme>` ইত্যাদি)। রিস্টার্ট জুড়ে টিকে থাকে।

### আমি কীভাবে ডিফল্ট Claude Code স্ট্যাটাস লাইনে ফিরে যাব?

হয় `~/.claude/settings.json` থেকে `statusLine` ব্লকটি সরিয়ে ফেলুন, অথবা `~/.claude/status-line.sh reset` চালান এবং একটি `minimal` থিমে স্যুইচ করুন যা ডিফল্টের সাথে ঘনিষ্ঠভাবে মেলে।

### এটি কি বিনামূল্যে? আমি কি এটি বাণিজ্যিকভাবে ব্যবহার করতে পারি?

ব্যক্তিগত, লোকাল ব্যবহার বিনামূল্যে — দেখুন [Source-Available License](LICENSE)। যেকোনো পুনঃব্যবহার, পুনর্বিতরণ, fork, বা অন্য কোনো প্রকল্পে অন্তর্ভুক্তির জন্য লেখকের (Yevgeniy Achin · amazopic@gmail.com) **পূর্ব লিখিত অনুমতি** প্রয়োজন। যুক্তিসঙ্গত অনুরোধ সাধারণত মঞ্জুর করা হয়।

### "human-hours" tracker কীভাবে কাজ করে?

`time` থিম JSONL transcript থেকে টাইমস্ট্যাম্প পড়ে এবং দুটি সময়কাল রিপোর্ট করে: **active** (5 মিনিটের চেয়ে ছোট আন্তঃ-মেসেজ ফাঁকের যোগফল) এবং **wall** (প্রথম থেকে শেষ মেসেজ পর্যন্ত মোট ব্যাপ্তি)। 5-মিনিটের idle থ্রেশহোল্ড কনফিগারযোগ্য।

## 🏷️ প্রস্তাবিত GitHub topics

আপনি যখন এই রিপো প্রকাশ করবেন, আবিষ্কারযোগ্যতা সর্বাধিক করতে এই topicগুলি যোগ করুন:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Contributing

Issue এবং PR স্বাগত — তবে লাইসেন্সটি লক্ষ্য করুন:

- **পড়া, issue খোলা, PR জমা দেওয়া**: বিনামূল্যে।
- **Fork করা, অন্য প্রকল্পে কপি করা, পুনর্বিতরণ**: লেখকের কাছ থেকে
  পূর্ব লিখিত অনুমতি প্রয়োজন।

পুনঃব্যবহারের অনুমতির অনুরোধ করতে, যোগাযোগ করুন:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

ব্যক্তিগত, শিক্ষামূলক, এবং অ-বাণিজ্যিক ব্যবহারের জন্য যুক্তিসঙ্গত অনুরোধ
সাধারণত বিনামূল্যে মঞ্জুর করা হয়।

## 📜 License

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

এই প্রকল্পের সোর্স পড়া, অধ্যয়ন, এবং আপনার নিজের মেশিনে ব্যক্তিগত ব্যবহারের
জন্য সর্বজনীনভাবে উপলব্ধ। যেকোনো পুনঃব্যবহার — কপি করা, পুনর্বিতরণ,
পরিবর্তন, বা অন্য কোনো প্রকল্পে অন্তর্ভুক্তি — লেখকের (Yevgeniy Achin ·
amazopic@gmail.com) **পূর্ব লিখিত অনুমতি** প্রয়োজন।

এটি OSI-অনুমোদিত ওপেন-সোর্স লাইসেন্স **নয়**। এটি একটি ইচ্ছাকৃত পছন্দ যা
বিতরণ এবং ডেরিভেটিভ কাজগুলিকে লেখকের নিয়ন্ত্রণে রেখে সম্প্রদায়কে পড়া,
অধ্যয়ন, এবং অবদান রাখার অনুমতি দেয়।

## ⭐ এটি দরকারী মনে হয়েছে?

আপনি যদি Claude Code-এর দিকে ঘণ্টার পর ঘণ্টা তাকিয়ে থাকেন, তাহলে আপনি একটি সুন্দর স্ট্যাটাস লাইনের দিকেও তাকাতে পারেন। অন্যদের এটি আবিষ্কার করতে সাহায্য করতে **রিপোতে একটি ⭐ দিন**!

---

Made by **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · for the Claude Code community.
