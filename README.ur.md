<div dir="rtl">

# 🛰️ Claude Code Status Line — 82 themes، قابلِ ترتیب blocks، CLI

> **Claude Code** کی ڈیفالٹ status line کا ڈراپ-اِن متبادل: ایک ہموار پروگریس بار کے ساتھ لائیو **context window** استعمال، USD میں **session cost**، **5h / 7d rate-limit** انتباہات، dirty / ahead / behind گنتی کے ساتھ **git branch**، **time-on-task tracking**، اور فعال **model name** (1M-context ویریئنٹس کے لیے `(1M)` انڈیکیٹر کے ساتھ) — یہ سب ایک رنگین Bash لائن میں۔ **82 تیار-شدہ themes** کے ساتھ آتی ہے — ٹاپ پکس (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari)، کلاسیکس (minimal, developer, muted, mono, hard-worker, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate)، آٹو برانڈز (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely)، مزید سائنسدان (newton, curie, darwin, hawking, galileo, feynman, turing, davinci)، مزید anime (onepiece, ghibli)، مزید Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda)، OS themes (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos)، اور دنیا کے مذاہب (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) اور اپنی لائن خود بنانے کے لیے ایک **26-block لائبریری**۔ اس میں ایک آل-اِن-وَن CLI configurator اور Claude Code کے لیے ایک `/statusline` slash command شامل ہے۔

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 164](https://img.shields.io/badge/variants-164-brightgreen.svg)](#-164-تیار-شدہ-ویریئنٹس--ایک-منتخب-کریں-اور-چل-پڑیں)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md) · [ไทย](README.th.md) · [עברית](README.he.md) · [বাংলা](README.bn.md) · اردو

<div dir="ltr">

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1h 6m}: 15% 7d{1d 2h}: 4% │ 🤖 xhigh
```

</div>

> 💡 **پرو ٹِپ — Context کنٹرول**: آپ کی context window جتنی بھری ہوگی، Claude کے ساتھ آپ کی گفتگو اتنی ہی **کم مؤثر** ہوتی جائے گی — اور آپ اپنی 5h/7d حدوں کو اتنی ہی **تیزی سے** ختم کریں گے۔ کام کی کارکردگی برقرار رکھنے کے لیے جب بھی آپ **60%** سے تجاوز کریں تو context صاف کریں یا `/compact` کریں۔

### ⏳ Reset countdown — اپنی حدوں کے گرد منصوبہ بنائیں

5h / 7d میٹرز میں ہر window کے ری سیٹ ہونے کے لمحے تک ایک لائیو کاؤنٹ ڈاؤن شامل ہوتا ہے: `5h{1h 6m}: 1%` — 5 گھنٹے کی window 1 گھنٹہ 6 منٹ میں ری سیٹ ہوتی ہے؛ `7d{1d 2h}: 0%` — ہفتہ وار window 1 دن 2 گھنٹے میں ری سیٹ ہوتی ہے۔ آپ کو ہمیشہ معلوم ہوتا ہے کہ آپ کب دوبارہ 0% پر ہیں، لہٰذا آپ بھاری کام ری سیٹ کے فوراً بعد شیڈول کر سکتے ہیں اور مہم کے درمیان حد سے ٹکرانے کے بجائے اپنی پیداواری صلاحیت تقسیم کر سکتے ہیں۔ یہ Claude Code کے بھیجے گئے `rate_limits.*.resets_at` سے چلتا ہے؛ اگر آپ کا بِلڈ ری سیٹ ٹائم اسٹیمپ نہیں بھیجتا، تو میٹرز خوش اسلوبی سے سادہ `5h: 1%` پر واپس آ جاتے ہیں۔

<div dir="ltr">

```text
… ⎇ main │ 5h{1h 6m}: 1% 7d{1d 2h}: 0% │ 🤖 xhigh
```

</div>

**ڈیزائن کے لحاظ سے قابلِ پیش گوئی** — ہر میٹر اپنے ری سیٹ تک کاؤنٹ ڈاؤن کرتا ہے، لہٰذا آپ دیوار سے ٹکرانے کے بجائے اپنے کام کی رفتار منظم کرتے ہیں۔

## ⚡ فوری آغاز

تیز ترین راستہ — بِلٹ-اِن CLI کے ساتھ بنڈل شدہ آل-اِن-وَن اسکرپٹ:

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

</div>

پھر `~/.claude/settings.json` میں شامل کریں:

<div dir="ltr">

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

</div>

> 💡 `refreshInterval: 30` لائن کو ہر 30 سیکنڈ بعد دوبارہ چلاتا ہے حتیٰ کہ session کے بیکار ہونے کے دوران بھی — یہ ری سیٹ کاؤنٹ ڈاؤن (`5h{1h 6m}`)، ٹائم ٹریکر اور ری سیٹ کے بعد کی تبدیلیوں کو زندہ رکھتا ہے۔ 30 ایک معقول ڈیفالٹ ہے؛ 60 بیٹری کے لیے کفایتی ہے؛ صرف ایونٹس پر اپ ڈیٹ کرنے کے لیے اسے حذف کر دیں (نیا اسسٹنٹ پیغام، `/compact`، vim ٹوگل)۔

Claude Code کو دوبارہ شروع کریں (یا `/config` reload چلائیں)۔ ہو گیا۔

### یا vibe-chill طریقہ · Claude کو یہ کرنے دیں

جب آپ کے پاس Claude Code ہے تو ٹرمینل کو کیوں چھوئیں؟ اس واحد پرامپٹ کو اپنے Claude Code session میں پیسٹ کریں — Claude ہر قدم سنبھالتا ہے اور ہر کمانڈ سے پہلے پوچھتا ہے۔

<div dir="ltr">

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", "refreshInterval": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

</div>

> ہر اجازت کے پرامپٹ پر بس `y` (ہاں) کہیں۔ ہو گیا۔


## Claude Code کے لیے کسٹم status line / status bar کیوں؟

Claude Code کی ڈیفالٹ status line بہت سادہ ہے۔ یہ ڈراپ-اِن متبادل نچلے status bar کو ہر session کے لیے ایک **ایک نظر میں ڈیش بورڈ** میں بدل دیتا ہے:

- 🔋 میں نے کتنا context خرچ کیا؟ (ہموار 1.25% جزوی بارز)
- 💰 یہ session مجھے کتنے میں پڑ رہی ہے؟
- 🚦 میں اپنی rate limits کے کتنا قریب ہوں؟
- 🧠 میں کس thinking لیول / model پر ہوں؟
- 🌿 میں کس git branch پر ہوں؟

یہ سب **ایک لائن** میں، رنگوں سے کوڈ شدہ، اور ایسی سمارٹ آئیکنز کے ساتھ جو فوری توجہ کا اشارہ دیتی ہیں۔

## ✨ خصوصیات

- 🪐 **لائیو context بار** — سب-سیل درستگی کے ساتھ 10-سیل پروگریس بار (quadrant یا عمودی جزوی glyphs)
- 🧠 **Model name** — 1M-context ویریئنٹس کے لیے `(1M)` انڈیکیٹر کے ساتھ
- 💸 USD میں **session cost**، ہر رینڈر پر اپ ڈیٹ
- ⬆️⬇️ **فی پیغام token کاؤنٹرز** (input / output)
- 🚦 **Rate limits** — 5h / 7d، 50% سے زائد پر ⚠️ انتباہ کے ساتھ
- 🔄 **API-موڈ فال بیک** — جب کوئی rate limits نہیں دیے جاتے، تو کل session tokens (`tokens: NNN K`) باریک-اسپیس ہزار سیپریٹرز کے ساتھ دکھاتا ہے
- 🚀 **سمارٹ اسٹیٹس آئیکن** — 🚀 < 40%، 🚗 40–49%، ⚠️ ≥ 50% context بھراؤ
- 🎨 **256-رنگ ANSI** — روشن، ہر سیگمنٹ کے لیے الگ رنگ
- 🧩 **پلگ ایبل بار اسٹائلز** — `quadrant` (▖▄▙█) یا `vertical` (▏▎▍▌▋▊▉█) منتخب کریں، یا 10 لائن bash میں اپنا خود بنائیں
- ⚡ **ہلکا پھلکا** — خالص `bash` + `jq`۔ نہ Node، نہ Python، نہ daemon، نہ telemetry

## 🎨 164 تیار-شدہ ویریئنٹس — ایک منتخب کریں اور چل پڑیں

ہر theme **دو ویریئنٹس** میں آتی ہے:

- **Detailed** — مکمل فیچر سیٹ (model، context بار، cost، tokens، git، time، موڈ آئیکن، …)
- **Compact** — صرف `model · context % + bar · branch`

`~/.claude/status-line.sh use <name>` کے ساتھ لاگو کریں (compact ویریئنٹ کے لیے `-compact` لگائیں)۔

### 🔝 ٹاپ پکس (10) — سب سے زیادہ مانگے گئے، بین الثقافتی

| Theme | وائب |
|---|---|
| `cyberpunk`  | نیون ڈسٹوپیا · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | فاسفر-سبز Matrix ٹرمینل · `[SYS] :: ROOT@matrix#` |
| `dragonball` | Goku اسکیلنگ: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | Konoha پتے کا نارنجی · chakra میٹر · 🌀 rasengan |
| `pokemon`    | Pikachu پیلا + pokeball سرخ · HP بار |
| `ironman`    | 🦾 Stark سرخ + arc-reactor سنہری |
| `spiderman`  | 🕷 ویب ہیڈ سرخ + نیلا · بڑے context کے ساتھ بڑی قیمت آتی ہے |
| `einstein`   | چاک بورڈ سبز · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ برقی جامنی + بجلی کا پیلا · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + Modena پیلا |

### 🛠 عملی / کلاسک (21 themes)

| Theme | فائل / لاگو کریں |
|---|---|
| 🛠 minimal       | [`statusline-minimal.sh`](examples/statusline-minimal.sh) · `use minimal` |
| 🛠 developer     | [`statusline-developer.sh`](examples/statusline-developer.sh) · `use developer` |
| 🛠 muted         | `use muted` |
| 🛠 mono          | `use mono` |
| 🛠 hard-worker   | `use hard-worker` |
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

> نوٹ: `cyberpunk` اور `hacker` اوپر **ٹاپ پکس** میں ہیں — اگر آپ سنگل-theme انسٹال چاہتے ہیں تو وہ
> `examples/` فولڈر میں بھی موجود ہیں۔

<div dir="ltr">

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

</div>

### 🚗 آٹو برانڈز (16 مزید، ٹاپ پکس میں `ferrari` شامل ہے)

صرف `statusline-bundle.sh` میں آتے ہیں — `~/.claude/status-line.sh use <name>` کے ساتھ کوئی بھی منتخب کریں۔

| خطہ | Themes |
|---|---|
| 🇪🇺 یورپ    | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 امریکہ  | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 جاپان   | `toyota` · `honda` · `nissan` |
| 🇰🇷 کوریا   | `hyundai` · `kia` |
| 🇨🇳 چین     | `byd` · `nio` · `geely` |

### 🔬 عظیم سائنسدان (8 مزید، ٹاپ پکس میں `einstein` اور `tesla` شامل ہیں)

| Theme | وائب |
|---|---|
| `newton`   | پارچمنٹ روشنائی، `🍎`، `F=ma` |
| `curie`    | ریڈیئم سبز، `☢`، نصف-عمر میٹر |
| `darwin`   | نیچرلسٹ سبز، `🐢`، HMS Beagle |
| `hawking`  | گہرا خلائی بنفشی، `🌌`، `t → ∞` |
| `galileo`  | سورج سنہری، `🔭`، *eppur si muove* |
| `feynman`  | چاک-آن-سبز، `〰`، `ψ → ψ'` |
| `turing`   | ٹرمینل سبز، `Ⓣ`، halting بار `1/0` |
| `davinci`  | سیپیا codex، `✎`، *Vitruvian* |

### ✨ Anime (3 مزید، ٹاپ پکس میں `dragonball`, `naruto`, `pokemon` شامل ہیں)

`onepiece` · `ghibli`

### 🦸 Marvel سپر ہیروز (8 مزید، ٹاپ پکس میں `ironman` اور `spiderman` شامل ہیں)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 آپریٹنگ سسٹمز (10 themes)

| Theme | وائب |
|---|---|
| `macos`   | 🍎 کروم-گرے پر چھ-رنگی Apple رینبو |
| `windows` | ⊞ Fluent چار-رنگی ٹائل + WINDOWS 11 سیان |
| `linux`   | 🐧 Tux کالا + نارنجی چونچ |
| `ubuntu`  | ⊕ دوست دائرہ — نارنجی + بینگنی جامنی |
| `arch`    | ▲ pacman سیان · btw, I use arch |
| `debian`  | 🌀 سرخ بھنور · stable / sid / testing |
| `fedora`  | 🎩 Fedora ہیٹ نیلا · آزادی + خصوصیات |
| `kali`    | 🐉 Kali نیلا + offsec سرخ · pwn-موڈ |
| `mint`    | 🌿 cinnamon mint سبز · سب سے دوستانہ شیل |
| `nixos`   | ❄ Nix نیلا برف کا گالا · ڈیکلیریٹو، قابلِ تکرار |

### 🕊 دنیا کے مذاہب (معتقدین کے لحاظ سے سرفہرست 7)

| Theme | وائب |
|---|---|
| `christianity` | ✝ شراب سرخ + Marian نیلا + papal سنہری · faith میٹر، € خیرات |
| `islam`        | ☪ اسلامی سبز + سفید + سنہری خطاطی · تقویٰ، ﷼ صدقہ |
| `hinduism`     | 🕉 زعفرانی + marigold + سندوری · dharma، ₹ seva |
| `buddhism`     | ☸ راہب زعفرانی + سنہری + maroon · karma، ฿ dāna |
| `judaism`      | ✡ tallit نیلا + سفید + menorah سنہری · mitzvah، ₪ tzedakah |
| `sikhism`      | ☬ Khalsa گہرا نیلا + زعفرانی + سفید · sewa، daswandh |
| `shinto`       | ⛩ سندوری torii + shrine سفید + سنہری · kami، ¥ saisen |

<div dir="ltr">

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 82 themes works
```

</div>

**پہلے انہیں اپنے ٹرمینل میں براؤز کریں** — ہر ویریئنٹ کا [`screenshots/`](screenshots/) میں
پہلے سے رینڈر شدہ پری ویو موجود ہے:

<div dir="ltr">

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (164 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

</div>

تفصیلات کے ساتھ مکمل جدول کے لیے [`examples/README.md`](examples/README.md) دیکھیں، اور
پری ویوز کیسے بنتے ہیں اس کے لیے [`screenshots/README.md`](screenshots/README.md) دیکھیں۔

## 🧱 blocks سے اپنی خود بنائیں

پری سیٹ استعمال نہیں کرنا چاہتے؟ نامزد blocks کی ایک لائبریری سے ایک کسٹم status line
ترتیب دیں — `model`، `context-bar`، `cost`، `git`، `tokens-msg`،
`time-active`، `thinking`، …

ان کے لیے [**BLOCKS.md**](BLOCKS.md) دیکھیں:

- **blocks کی فہرست** (ہر ایک ایک کاپی-پیسٹ-ایبل bash اسنیپٹ ہے)
- **اسٹائل پیکس** (`classic`، `compact`، `anime`، `hacker`، `cyberpunk`، `zen` سے رنگ پیلیٹس اور سیپریٹرز)
- اپنی لائن بنانے کا **3-قدمی نسخہ**: ایک اسٹائل منتخب کریں → blocks کی فہرست بنائیں
  → پیسٹ کریں

<div dir="ltr">

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

</div>

## 📦 آل-اِن-وَن بنڈل (`statusline-bundle.sh`)

اگر آپ 40+ فائلیں سنبھالنا نہیں چاہتے، تو **واحد بنڈل شدہ
اسکرپٹ** [`statusline-bundle.sh`](statusline-bundle.sh) لیں — اس میں
ہر theme + ہر block + ایک CLI configurator ایک ہی فائل میں ہے۔

<div dir="ltr">

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

</div>

ترتیب `~/.claude/statusline.conf` میں محفوظ ہوتی ہے اور دوبارہ شروع کرنے پر
برقرار رہتی ہے۔ یہی فائل بیک وقت **رینڈرر** (جب Claude Code اسے stdin پر JSON کے ساتھ
بلاتا ہے) اور **configurator** (جب آپ اسے آرگیومنٹس کے ساتھ بلاتے ہیں)
دونوں کا کام کرتی ہے۔

### `/statusline` slash command

Claude Code کے اندر `/statusline` slash command فعال کرنے کے لیے
[`commands/statusline.md`](commands/statusline.md) کو
`~/.claude/commands/` میں ڈالیں:

<div dir="ltr">

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

</div>

پھر کسی بھی Claude Code session میں آپ ٹائپ کر سکتے ہیں:

<div dir="ltr">

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

</div>

Claude آپ کے لیے بنڈل CLI چلائے گا، نتیجہ بتائے گا، اور آپ کو
ری لوڈ کرنے کی یاد دہانی کرائے گا۔

### اختیاری شیل اَلیاس

<div dir="ltr">

```bash
alias statusline='~/.claude/status-line.sh'
```

</div>

پھر `statusline cyberpunk` کسی بھی ٹرمینل سے کام کرتا ہے۔

## 🚀 انسٹال

### دستی انسٹال (3 اقدامات)

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

</div>

پھر `~/.claude/settings.json` میں شامل کریں:

<div dir="ltr">

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

</div>

> 💡 `refreshInterval: 30` لائن کو ہر 30 سیکنڈ بعد دوبارہ چلاتا ہے حتیٰ کہ session کے بیکار ہونے کے دوران بھی — یہ ری سیٹ کاؤنٹ ڈاؤن (`5h{1h 6m}`)، ٹائم ٹریکر اور ری سیٹ کے بعد کی تبدیلیوں کو زندہ رکھتا ہے۔ 30 ایک معقول ڈیفالٹ ہے؛ 60 بیٹری کے لیے کفایتی ہے؛ صرف ایونٹس پر اپ ڈیٹ کرنے کے لیے اسے حذف کر دیں (نیا اسسٹنٹ پیغام، `/compact`، vim ٹوگل)۔

Claude Code کو دوبارہ شروع کریں (یا `/config` reload چلائیں)۔

### Claude Code ایجنٹ کے ذریعے انسٹال (خودکار بیک اپ کے ساتھ)

چاہتے ہیں کہ Claude Code اسے آپ کے لیے محفوظ طریقے سے انسٹال کرے؟ یہ پرامپٹ پیسٹ کریں:

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

### تازہ ترین ورژن میں اپ ڈیٹ

<div dir="ltr">

```bash
~/.claude/status-line.sh update
```

</div>

GitHub سے تازہ ترین بنڈل لاتا ہے، ایک ٹائم اسٹیمپ شدہ بیک اپ بناتا ہے
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`)، اور آپ کی
theme ترتیب (`~/.claude/statusline.conf`) محفوظ رکھتا ہے۔ اس کے بعد Claude Code دوبارہ شروع کریں۔

آپ کے پاس کیا انسٹال ہے دیکھیں: `~/.claude/status-line.sh version`۔

### تقاضے

- `bash` 4+ (اسکرپٹ 0-انڈیکسڈ arrays استعمال کرتا ہے — **`zsh` کے تحت نہ چلائیں**)
- JSON پارسنگ کے لیے `jq` — `apt-get install jq` (Debian/Ubuntu)، `brew install jq` (macOS)، `dnf install jq` (Fedora)
- `curl` (صرف `statusline update` کے لیے درکار؛ زیادہ تر سسٹمز پر پہلے سے انسٹال ہوتا ہے)
- ایک 256-رنگ ٹرمینل (بنیادی طور پر ہر جدید ٹرمینل)

## ⚙️ ترتیب

`statusline.sh` کے اوپری حصے کے قریب ثوابت میں ترمیم کریں:

| متغیر / فنکشن | یہ کیا کنٹرول کرتا ہے |
|---|---|
| `BAR_STYLE` | `"quadrant"` (ڈیفالٹ، 2.5% قدم) یا `"vertical"` (1.25% قدم) |
| `pct_icon()` | بار سے پہلے 🚀 / 🚗 / ⚠️ آئیکنز کے لیے حد بندیاں |
| `pct_color()` | فیصد / بار کے لیے رنگ کی حد بندیاں |
| ANSI رنگ ثوابت | کسی بھی سیگمنٹ کا رنگ بدلیں (`G`، `Y`، `R`، `B`، `C`، `M`، …) |

## 🆚 ڈیفالٹ Claude Code status line کے مقابلے میں

| صلاحیت | ڈیفالٹ | یہ پروجیکٹ |
|---|---|---|
| فعال **model name** | ✅ | ✅ (1M-context ویریئنٹس کے لیے `(1M)` فلیگ کے ساتھ) |
| استعمال شدہ **context window** % | ❌ | ✅ لائیو، 1.25 % درستگی |
| context کے لیے **پروگریس بار** | ❌ | ✅ (عمودی، quadrant، رینبو، sparkline، …) |
| USD میں **session cost** | ❌ | ✅ ہر رینڈر پر اپ ڈیٹ |
| **فی پیغام** input/output token کاؤنٹرز | ❌ | ✅ |
| **کل session tokens** (API موڈ فال بیک) | ❌ | ✅ |
| 50 % سے زائد پر ⚠️ کے ساتھ **5h / 7d rate-limit** انڈیکیٹرز | ❌ | ✅ |
| حد میٹرز میں ری سیٹ کاؤنٹ ڈاؤن (`5h{1h 6m}`) | ❌ | ✅ |
| **Git branch** + dirty + ahead/behind | ❌ | ✅ |
| **Time-on-task** (فعال بمقابلہ وال کلاک) | ❌ | ✅ |
| **Thinking / effort لیول** ڈسپلے | ❌ | ✅ |
| تھیمڈ پری سیٹس | ❌ | ✅ 82 themes × 2 ویریئنٹس = **164 تیار-شدہ** |
| نامزد blocks سے ترتیب | ❌ | ✅ 26 blocks، دیکھیں [BLOCKS.md](BLOCKS.md) |
| بِلٹ-اِن CLI configurator | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` slash command | ❌ | ✅ اختیاری، دیکھیں [`commands/`](commands/) |
| بیرونی انحصار | — | `bash` 4+ اور `jq` (نہ Node، نہ Python، نہ daemon) |
| لائسنس | — | Source-Available (اجازت-بہ-اجازت دوبارہ استعمال) |

## 💡 استعمال کے کیسز

ٹھوس منظرنامے جہاں یہ پروجیکٹ اپنی قیمت ادا کر دیتا ہے:

- **"میں نے اپنے 1 M context میں سے کتنا خرچ کیا؟"** — ہر پرامپٹ سے پہلے ایک لائیو فیصد + بار دیکھیں۔
- **"یہ Claude Code session مجھے کتنے میں پڑ رہی ہے؟"** — رننگ USD ٹوٹل، ہر رینڈر پر اپ ڈیٹ۔
- **"کیا میں آج rate limit سے ٹکراؤں گا؟"** — 50 % سے زائد پر ⚠️ کے ساتھ 5 h / 7 d انڈیکیٹرز۔
- **"کیا میں صحیح branch پر ہوں؟"** — آپ کی status line میں git branch + dirty + ahead/behind۔
- **"اس فیچر پر میں نے اصل میں کتنے گھنٹے صرف کیے؟"** — time-on-task ٹریکر (`active` بمقابلہ `wall`)۔
- **"میں چاہتا ہوں میرا ٹرمینل مزے دار ہو۔"** — anime، cyberpunk، hacker، retro، weather، ocean، fire اور دیگر themes۔
- **"میں اسکرین ریکارڈنگ کے لیے ایک minimal، صرف-ASCII status line چاہتا ہوں۔"** — `zen` theme۔
- **"میں ایک ایسی status line بھیجنا چاہتا ہوں جسے میری پوری ٹیم استعمال کرے۔"** — واحد بنڈل شدہ اسکرپٹ + CLI configurator + slash command۔

## ❓ اکثر پوچھے گئے سوالات

### "Claude Code Status Line" کیا ہے؟

[Claude Code](https://claude.com/claude-code) (Anthropic کی CLI) میں ڈیفالٹ status line کا ایک bash-بنیاد متبادل۔ یہ اسکرین کے نچلے حصے کی لائن کو ایک حقیقی ڈیش بورڈ میں بدل دیتا ہے: model، context %، پروگریس بار، session cost، rate limits، git اسٹیٹس، time-on-task، اور بہت کچھ۔

### `5h{1h 6m}: 1%` کا کیا مطلب ہے؟

آپ نے 5-گھنٹے کی window کا 1% استعمال کیا ہے، اور `{1h 6m}` ایک لائیو کاؤنٹ ڈاؤن ہے — window 1 گھنٹہ 6 منٹ میں ری سیٹ ہوتی ہے (`7d{1d 2h}`: ہفتہ وار window 1 دن 2 گھنٹے میں ری سیٹ ہوتی ہے)۔ ہر رینڈر پر `rate_limits.*.resets_at` سے پڑھا جاتا ہے۔ آپ کے بِلڈ میں کوئی ری سیٹ ٹائم اسٹیمپ نہیں؟ میٹر سادہ `5h: 1%` پر واپس آ جاتا ہے۔

### کیا status line خود بخود اپ ڈیٹ ہوتی ہے؟ میرا `{1h 6m}` کاؤنٹ ڈاؤن منجمد لگتا ہے۔

Claude Code ایونٹس پر دوبارہ رینڈر کرتا ہے — نیا اسسٹنٹ پیغام، `/compact`، اجازت-موڈ یا vim-موڈ تبدیلی (300 ms پر ڈی باؤنسڈ) — لہٰذا ایونٹس کے درمیان لائن منجمد ہو جاتی ہے۔ `~/.claude/settings.json` میں statusLine block میں `"refreshInterval": 30` شامل کریں اور یہ ایک مقررہ 30-سیکنڈ ٹائمر پر بھی دوبارہ چلتی ہے، جو خمول کے دوران کاؤنٹ ڈاؤن اور ٹائم ٹریکر کو چلتا رکھتی ہے۔ ایک رینڈر کی لاگت ~0.1 s ہے، لہٰذا 30 s نہ ہونے کے برابر ہے؛ بیٹری پر یا بڑے repos میں 60 استعمال کریں (git status ہر رینڈر پر چلتا ہے)؛ کم از کم 1 ہے۔

### اسے کیسے انسٹال کیا جاتا ہے؟

`statusline-bundle.sh` کو `~/.claude/status-line.sh` میں کاپی کریں، `chmod +x` کریں، پھر Claude Code کے `~/.claude/settings.json` کے `statusLine.command` کو اس راستے پر سیٹ کریں۔ مکمل ہدایات [فوری آغاز](#-فوری-آغاز) اور [انسٹال](#-انسٹال) سیکشنز میں ہیں۔

### کیا یہ 1 M context window models کو سپورٹ کرتا ہے؟

ہاں۔ اسکرپٹ model id میں `[1m]` اور display name میں `1M` کا پتہ لگاتا ہے اور بار کے denominator کو 1 000 000 tokens پر ایڈجسٹ کرتا ہے۔ آپ دیکھیں گے `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`۔

### یہ کن models کے ساتھ کام کرتا ہے؟

کسی بھی model کے ساتھ جسے Claude Code سپورٹ کرتا ہے — Opus 4.7، Sonnet 4.6، Haiku 4.5، Opus 4.6، وغیرہ۔ اسکرپٹ Claude Code کے فراہم کردہ stdin JSON سے `model.display_name` اور `model.id` پڑھتا ہے؛ یہ model کے نام ہارڈ کوڈ نہیں کرتا۔

### کیا میں رنگ، themes تبدیل کر سکتا ہوں یا اپنی خود شامل کر سکتا ہوں؟

ہاں — تین طریقوں سے:

1. **82 themes** میں سے ایک منتخب کریں (کل 164 ویریئنٹس) — `~/.claude/status-line.sh use <name>` استعمال کریں یا اسٹینڈ اَلون اسکرپٹس کے لیے [`examples/`](examples/) براؤز کریں۔
2. **نامزد blocks** سے اپنی خود ترتیب دیں — دیکھیں [BLOCKS.md](BLOCKS.md)۔
3. `statusline.sh` میں رنگ ثوابت اور بار اسٹائل براہِ راست ترمیم کریں۔

### کیا یہ Claude Code کو سست کر دے گا؟

نہیں۔ ہر رینڈر ہر اسٹیٹس ری ڈرا پر ایک بار چلتا ہے، دیے گئے JSON کو `jq` سے پارس کرتا ہے، اختیاری طور پر transcript کی تازہ ترین لائن کو `grep` کرتا ہے، اور پرنٹ کرتا ہے۔ ٹائم-ٹریکر فعال ہونے کے باوجود معمول کا رینڈر ≤ 50 ms ہے۔

### کیا یہ `jq` کے بغیر کام کرتا ہے؟

`jq` درکار ہے — یہ اس JSON کو پارس کرتا ہے جو Claude Code stdin پر بھیجتا ہے۔ اسے `brew install jq` (macOS)، `apt install jq` (Debian/Ubuntu)، یا `choco install jq` (Windows) کے ذریعے انسٹال کریں۔

### کیا یہ Windows پر کام کرتا ہے؟

ہاں، کسی بھی ماحول میں جو `bash` 4+ اور `jq` چلائے — Git Bash، WSL، MSYS2، Cygwin۔ خالص CMD/PowerShell سپورٹ نہیں ہیں۔

### کیا یہ Linux / macOS پر کام کرتا ہے؟

دونوں پر ہاں۔ macOS BSD `date` استعمال کرتا ہے، Linux GNU `date` استعمال کرتا ہے — ٹائم-ٹریکر دونوں کو شفاف طریقے سے سنبھالتا ہے۔

### کیا میں اسے Claude Code کے بجائے خام Anthropic API کے ساتھ استعمال کر سکتا ہوں؟

جزوی طور پر۔ status line Claude Code کے stdin JSON فارمیٹ کے لیے ڈیزائن کی گئی ہے۔ خام API استعمال کے لیے، rate-limit انڈیکیٹرز خودکار طور پر ایک **کل session tokens** ڈسپلے (`tokens: NNN K`) پر واپس آ جاتے ہیں۔

### ترتیب کہاں محفوظ ہوتی ہے؟

`~/.claude/statusline.conf` — ایک چھوٹی shell-سورسڈ فائل جو بنڈل کی CLI لکھتی ہے (`statusline.sh use <theme>` وغیرہ)۔ دوبارہ شروع کرنے پر برقرار رہتی ہے۔

### میں ڈیفالٹ Claude Code status line پر کیسے واپس جاؤں؟

یا تو `~/.claude/settings.json` سے `statusLine` block ہٹا دیں، یا `~/.claude/status-line.sh reset` چلائیں اور ایک `minimal` theme پر سوئچ کریں جو ڈیفالٹ سے کافی مشابہ ہے۔

### کیا یہ مفت ہے؟ کیا میں اسے تجارتی طور پر استعمال کر سکتا ہوں؟

ذاتی، مقامی استعمال مفت ہے — دیکھیں [Source-Available License](LICENSE)۔ کوئی بھی دوبارہ استعمال، دوبارہ تقسیم، fork، یا کسی دوسرے پروجیکٹ میں شامل کرنا مصنف (Yevgeniy Achin · amazopic@gmail.com) سے **پیشگی تحریری اجازت** کا متقاضی ہے۔ معقول درخواستیں عام طور پر منظور کر لی جاتی ہیں۔

### "ہیومن-آورز" ٹریکر کیسے کام کرتا ہے؟

`time` theme JSONL transcript سے ٹائم اسٹیمپس پڑھتی ہے اور دو دورانیے رپورٹ کرتی ہے: **active** (5 منٹ سے کم بین-پیغام وقفوں کا مجموعہ) اور **wall** (پہلے سے آخری پیغام تک کل دورانیہ)۔ 5-منٹ کی خمول کی حد قابلِ ترتیب ہے۔

## 🏷️ تجویز کردہ GitHub topics

جب آپ یہ repo شائع کریں، تو دریافت کی صلاحیت بڑھانے کے لیے یہ topics شامل کریں:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 شراکت

Issues اور PRs کا خیرمقدم ہے — لیکن لائسنس نوٹ کریں:

- **پڑھنا، issues کھولنا، PRs جمع کرانا**: مفت۔
- **Forking، کسی دوسرے پروجیکٹ میں کاپی کرنا، دوبارہ تقسیم**: مصنف سے
  پیشگی تحریری اجازت کا متقاضی ہے۔

دوبارہ استعمال کی اجازت کی درخواست کے لیے رابطہ کریں:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

ذاتی، تعلیمی، اور غیر-تجارتی استعمال کی معقول درخواستیں
عام طور پر مفت منظور کر لی جاتی ہیں۔

## 📜 لائسنس

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

اس پروجیکٹ کا سورس پڑھنے، مطالعے، اور آپ کی اپنی مشین پر ذاتی استعمال کے لیے
عوامی طور پر دستیاب ہے۔ کوئی بھی دوبارہ استعمال — کاپی کرنا، دوبارہ تقسیم،
ترمیم، یا کسی دوسرے پروجیکٹ میں شامل کرنا — مصنف (Yevgeniy Achin · amazopic@gmail.com) سے
**پیشگی تحریری اجازت** کا متقاضی ہے۔

یہ ایک OSI-منظور شدہ اوپن-سورس لائسنس **نہیں** ہے۔ یہ ایک سوچا سمجھا
انتخاب ہے جو تقسیم اور مشتق کاموں کو مصنف کے کنٹرول میں رکھتا ہے جبکہ
کمیونٹی کو پڑھنے، مطالعہ کرنے، اور شراکت کرنے کی اجازت دیتا ہے۔

## ⭐ مفید لگا؟

اگر آپ گھنٹوں Claude Code کو دیکھتے رہتے ہیں، تو بہتر ہے کہ ایک خوبصورت status line کو دیکھیں۔ دوسروں کو اسے دریافت کرنے میں مدد کے لیے **repo کو ایک ⭐ دیں**!

---

بنایا گیا **Yevgeniy Achin** کے ہاتھوں · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · Claude Code کمیونٹی کے لیے۔

</div>
