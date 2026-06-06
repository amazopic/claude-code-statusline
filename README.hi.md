# 🛰️ Claude Code Status Line — 79 थीम, कॉन्फ़िगरेबल ब्लॉक्स, CLI

> **Claude Code** की डिफ़ॉल्ट status line का ड्रॉप-इन रिप्लेसमेंट: एक स्मूद प्रोग्रेस बार के साथ लाइव **context window** उपयोग, USD में **session cost**, **5h / 7d rate-limit** चेतावनियाँ, dirty / ahead / behind काउंट के साथ **git branch**, **time-on-task tracking**, और सक्रिय **model name** (1M-context वैरिएंट्स के लिए `(1M)` इंडिकेटर सहित) — सब कुछ एक रंगीन Bash लाइन में। **79 तैयार थीम** के साथ आती है — टॉप पिक्स (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), क्लासिक्स (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), ऑटो ब्रांड्स (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), और वैज्ञानिक (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), और अनिमे (onepiece, ghibli), और Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), OS थीम (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), और विश्व के धर्म (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) और अपनी खुद की लाइन बनाने के लिए एक **26-ब्लॉक लाइब्रेरी**। इसमें एक ऑल-इन-वन CLI कॉन्फ़िगरेटर और Claude Code के लिए एक `/statusline` slash command शामिल है।

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-तैयार-वैरिएंट--एक-चुनें-और-चल-पड़ें)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · हिन्दी · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **प्रो टिप — Context नियंत्रण**: आपका context window जितना भरा होगा, Claude के साथ आपकी बातचीत उतनी ही **कम प्रभावी** होगी — और आपकी 5h/7d सीमाएँ उतनी ही **तेज़ी से** खत्म होंगी। कुशलता से काम करते रहने के लिए जब भी आप **60%** पार करें, तब clear करें या `/compact` चलाएँ।

### ⏳ Reset countdown — अपनी सीमाओं के इर्द-गिर्द योजना बनाएँ

5h / 7d मीटर में एक लाइव countdown शामिल है जो बताता है कि प्रत्येक window कब रीसेट होगी: `5h{1.1h}: 1%` — 5-घंटे की window 1.1 घंटे में रीसेट होती है; `7d{1.1d}: 0%` — साप्ताहिक window 1.1 दिन में रीसेट होती है। आपको हमेशा पता रहता है कि आप कब वापस 0% पर पहुँचेंगे, इसलिए आप भारी काम को रीसेट के ठीक बाद शेड्यूल कर सकते हैं और काम के बीच में ही सीमा से टकराने के बजाय अपनी उत्पादकता को वितरित कर सकते हैं। यह Claude Code द्वारा भेजे गए `rate_limits.*.resets_at` से संचालित होता है; अगर आपका build reset timestamps नहीं भेजता, तो मीटर सहजता से सादे `5h: 1%` पर वापस आ जाते हैं।

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**डिज़ाइन से ही पूर्वानुमेय** — हर मीटर अपने रीसेट तक countdown करता है, ताकि आप दीवार से टकराने के बजाय अपने काम की गति तय करें।

## ⚡ Quick start

सबसे तेज़ रास्ता — बिल्ट-इन CLI के साथ बंडल किया गया ऑल-इन-वन स्क्रिप्ट:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

फिर `~/.claude/settings.json` में जोड़ें:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Claude Code को रीस्टार्ट करें (या `/config` reload चलाएँ)। हो गया।

### या vibe-chill तरीका · Claude से करवाएँ

जब आपके पास Claude Code है तो terminal को छूने की क्या ज़रूरत? इस एक प्रॉम्प्ट को अपने Claude Code सेशन में पेस्ट करें — Claude हर कदम संभालता है और हर कमांड से पहले पूछता है।

```text
मेरे लिए amazopic का claude-code-statusline इंस्टॉल करें। पहले सुनिश्चित करें कि jq इंस्टॉल है (`which jq` चलाएँ) — अगर नहीं है, तो प्लेटफ़ॉर्म के अनुसार इंस्टॉल करें: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine)। फिर ~/.claude/settings.json पढ़ें — अगर इसमें कोई मौजूदा फ़ाइल की ओर इशारा करने वाला statusLine.command है (जैसे ~/.claude/status-line.sh या कोई और पथ), तो उस फ़ाइल का .bak जोड़कर बैकअप बनाएँ (किसी भी मौजूदा .bak को ओवरराइट करें)। साथ ही अगर ~/.claude/status-line.sh पहले से मौजूद है, तो उसका भी इसी तरह बैकअप बनाएँ। फिर github.com/amazopic/claude-code-statusline को clone करें, statusline-bundle.sh को ~/.claude/status-line.sh में कॉपी करें और उसे executable बनाएँ, साथ ही commands/statusline.md को ~/.claude/commands/ में कॉपी करें। ~/.claude/settings.json को अपडेट करें ताकि statusLine बने { type: "command", command: "<~/.claude/status-line.sh का पूर्ण पथ>" }। अंत में developer थीम को टेस्ट करने के लिए ~/.claude/status-line.sh use developer चलाएँ और मुझे Claude Code रीस्टार्ट करने के लिए कहें।
```

> हर permission prompt पर बस `y` (yes) कहें। हो गया।


## Claude Code के लिए कस्टम status line / status bar क्यों?

Claude Code की डिफ़ॉल्ट status line विरल है। यह ड्रॉप-इन रिप्लेसमेंट नीचे की status bar को हर सेशन के लिए एक **एक-नज़र में दिखने वाला dashboard** बना देता है:

- 🔋 मैंने कितना context खर्च कर लिया है? (स्मूद 1.25% फ्रैक्शनल बार)
- 💰 यह सेशन मुझे कितना खर्च करा रहा है?
- 🚦 मैं अपनी rate limits के कितने करीब हूँ?
- 🧠 मैं किस thinking level / model पर हूँ?
- 🌿 मैं किस git branch पर हूँ?

सब कुछ **एक लाइन** में, रंग-कोडित, ऐसे स्मार्ट आइकन के साथ जो तात्कालिकता का संकेत देते हैं।

## ✨ Features

- 🪐 **लाइव context bar** — सब-सेल परिशुद्धता के साथ 10-सेल प्रोग्रेस बार (quadrant या vertical फ्रैक्शनल ग्लिफ़)
- 🧠 **Model name** — 1M-context वैरिएंट्स के लिए `(1M)` इंडिकेटर सहित
- 💸 USD में **Session cost**, हर render पर अपडेट होता है
- ⬆️⬇️ **प्रति-संदेश token काउंटर** (input / output)
- 🚦 **Rate limits** — 5h / 7d, > 50% होने पर ⚠️ चेतावनी के साथ
- 🔄 **API-mode fallback** — जब कोई rate limits पाइप न की जाएँ, तो पतले-स्पेस हज़ार विभाजक के साथ कुल session tokens (`tokens: NNN K`) दिखाता है
- 🚀 **स्मार्ट status आइकन** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% context fill
- 🎨 **256-color ANSI** — हर सेगमेंट के लिए चमकीला, अलग रंग
- 🧩 **Pluggable bar styles** — `quadrant` (▖▄▙█) या `vertical` (▏▎▍▌▋▊▉█) चुनें, या bash की 10 लाइनों में अपना खुद का बनाएँ
- ⚡ **हल्का** — शुद्ध `bash` + `jq`। कोई Node नहीं, कोई Python नहीं, कोई daemon नहीं, कोई telemetry नहीं

## 🎨 158 तैयार वैरिएंट — एक चुनें और चल पड़ें

हर थीम **दो वैरिएंट** में आती है:

- **Detailed** — पूरा फ़ीचर सेट (model, context bar, cost, tokens, git, time, mood आइकन, …)
- **Compact** — केवल `model · context % + bar · branch`

`~/.claude/status-line.sh use <name>` से लागू करें (compact वैरिएंट के लिए `-compact` जोड़ें)।

### 🔝 टॉप पिक्स (10) — सबसे ज़्यादा मांगी गई, क्रॉस-कल्चरल

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

### 🛠 व्यावहारिक / क्लासिक (19 थीम)

| Theme | File / Apply |
|---|---|
| 🛠 minimal       | [`statusline-minimal.sh`](examples/statusline-minimal.sh) · `use minimal` |
| 🛠 developer     | [`statusline-developer.sh`](examples/statusline-developer.sh) · `use developer` |
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

> नोट: `cyberpunk` और `hacker` ऊपर **टॉप पिक्स** में हैं — अगर आप सिंगल-थीम
> इंस्टॉल चाहते हैं तो वे `examples/` फ़ोल्डर में भी मौजूद हैं।

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 ऑटो ब्रांड्स (15 और, टॉप पिक्स में `ferrari` शामिल है)

केवल `statusline-bundle.sh` में आती हैं — किसी भी को `~/.claude/status-line.sh use <name>` से चुनें।

| Region | Themes |
|---|---|
| 🇪🇺 Europe  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 America | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japan   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 महान वैज्ञानिक (8 और, टॉप पिक्स में `einstein` और `tesla` शामिल हैं)

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

### ✨ अनिमे (3 और, टॉप पिक्स में `dragonball`, `naruto`, `pokemon` शामिल हैं)

`onepiece` · `ghibli`

### 🦸 Marvel सुपरहीरो (8 और, टॉप पिक्स में `ironman` और `spiderman` शामिल हैं)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 ऑपरेटिंग सिस्टम (10 थीम)

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

### 🕊 विश्व के धर्म (अनुयायियों के अनुसार टॉप 7)

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
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

**पहले अपने terminal में इन सभी को ब्राउज़ करें** — हर वैरिएंट का
[`screenshots/`](screenshots/) में एक प्री-रेंडर किया गया प्रीव्यू है:

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (158 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

विवरण सहित पूरी तालिका के लिए [`examples/README.md`](examples/README.md) देखें,
और प्रीव्यू कैसे जेनरेट होते हैं इसके लिए
[`screenshots/README.md`](screenshots/README.md) देखें।

## 🧱 ब्लॉक्स से अपनी खुद की बनाएँ

प्रीसेट नहीं इस्तेमाल करना चाहते? नामित ब्लॉक्स की एक लाइब्रेरी से
एक कस्टम status line बनाएँ — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

[**BLOCKS.md**](BLOCKS.md) में देखें:

- **ब्लॉक्स की सूची** (हर एक एक कॉपी-पेस्ट करने योग्य bash स्निपेट है)
- **style packs** (`classic`, `compact`, `anime`, `hacker`, `cyberpunk`, `zen`
  से रंग पैलेट और सेपरेटर)
- अपनी खुद की लाइन बनाने की **3-स्टेप रेसिपी**: एक style चुनें → ब्लॉक्स सूचीबद्ध करें
  → पेस्ट करें

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 ऑल-इन-वन बंडल (`statusline-bundle.sh`)

अगर आप 40+ फ़ाइलें मैनेज नहीं करना चाहते, तो **सिंगल बंडल किया गया
स्क्रिप्ट** [`statusline-bundle.sh`](statusline-bundle.sh) लें — इसमें हर
थीम + हर ब्लॉक + एक CLI कॉन्फ़िगरेटर एक ही फ़ाइल में हैं।

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

कॉन्फ़िगरेशन `~/.claude/statusline.conf` में सहेजा जाता है और
रीस्टार्ट के बीच बना रहता है। वही फ़ाइल **renderer** (जब Claude Code
इसे stdin पर JSON के साथ कॉल करता है) और **configurator** (जब आप इसे
आर्ग्यूमेंट्स के साथ कॉल करते हैं) दोनों के रूप में काम करती है।

### `/statusline` slash command

Claude Code के अंदर एक `/statusline` slash command सक्षम करने के लिए
[`commands/statusline.md`](commands/statusline.md) को `~/.claude/commands/`
में डालें:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

फिर किसी भी Claude Code सेशन में आप टाइप कर सकते हैं:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude आपके लिए बंडल CLI चलाएगा, परिणाम रिपोर्ट करेगा, और आपको रीलोड
करने की याद दिलाएगा।

### वैकल्पिक shell alias

```bash
alias statusline='~/.claude/status-line.sh'
```

फिर `statusline cyberpunk` किसी भी terminal से काम करता है।

## 🚀 Install

### मैनुअल इंस्टॉल (3 स्टेप)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

फिर `~/.claude/settings.json` में जोड़ें:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Claude Code को रीस्टार्ट करें (या `/config` reload चलाएँ)।

### Claude Code एजेंट के ज़रिए इंस्टॉल (स्वचालित बैकअप के साथ)

चाहते हैं कि Claude Code इसे आपके लिए सुरक्षित रूप से इंस्टॉल करे? यह प्रॉम्प्ट पेस्ट करें:

> "इस repo से status line को मेरी Claude Code status line के रूप में इंस्टॉल करें:
> 1. अगर `~/.claude/status-line.sh` पहले से मौजूद है, तो उसका बैकअप
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` में बनाएँ (अगर उस नाम
>    का बैकअप पहले से मौजूद है तो एक मुक्त `-N` सफ़िक्स चुनें)।
> 2. इस repo से `statusline.sh` को `~/.claude/status-line.sh` में कॉपी करें और `chmod +x` करें।
> 3. `~/.claude/settings.json` पढ़ें। अगर इसमें कोई `statusLine` key नहीं है, तो
>    स्क्रिप्ट के पूर्ण पथ की ओर इशारा करने वाला एक `statusLine` ब्लॉक जोड़ें। अगर
>    `statusLine` पहले से मौजूद है और कहीं और इशारा करता है, तो पहले
>    `settings.json` का बैकअप `.bak.<timestamp>` में बनाएँ।
> 4. स्क्रिप्ट का स्मोक-टेस्ट करें:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. मुझे Claude Code रीस्टार्ट करने के लिए कहें और बनाए गए बैकअप की रिपोर्ट दें।"

### नवीनतम संस्करण में अपडेट करना

```bash
~/.claude/status-line.sh update
```

GitHub से नवीनतम बंडल लाता है, एक timestamped बैकअप बनाता है
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), और आपके थीम कॉन्फ़िग
(`~/.claude/statusline.conf`) को संरक्षित रखता है। बाद में Claude Code को रीस्टार्ट करें।

देखें कि आपने क्या इंस्टॉल किया है: `~/.claude/status-line.sh version`।

### Requirements

- `bash` 4+ (स्क्रिप्ट 0-indexed arrays का उपयोग करती है — **`zsh` के तहत न चलाएँ**)
- JSON पार्सिंग के लिए `jq` — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (केवल `statusline update` के लिए आवश्यक; अधिकांश सिस्टम पर प्रीइंस्टॉल्ड)
- एक 256-color terminal (मूल रूप से हर आधुनिक terminal)

## ⚙️ Configuration

`statusline.sh` के शीर्ष के पास मौजूद स्थिरांकों को संपादित करें:

| Variable / function | यह क्या नियंत्रित करता है |
|---|---|
| `BAR_STYLE` | `"quadrant"` (डिफ़ॉल्ट, 2.5% स्टेप) या `"vertical"` (1.25% स्टेप) |
| `pct_icon()` | बार से पहले 🚀 / 🚗 / ⚠️ आइकन के लिए थ्रेशोल्ड |
| `pct_color()` | प्रतिशत / बार के लिए रंग थ्रेशोल्ड |
| ANSI रंग स्थिरांक | किसी भी सेगमेंट को रीकलर करें (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 डिफ़ॉल्ट Claude Code status line की तुलना में

| Capability | Default | This project |
|---|---|---|
| सक्रिय **model name** | ✅ | ✅ (1M-context वैरिएंट्स के लिए `(1M)` फ़्लैग के साथ) |
| **Context window** % उपयोग | ❌ | ✅ live, 1.25 % परिशुद्धता |
| context के लिए **Progress bar** | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| USD में **Session cost** | ❌ | ✅ हर render पर अपडेट |
| **प्रति-संदेश** input/output token काउंटर | ❌ | ✅ |
| **कुल session tokens** (API mode fallback) | ❌ | ✅ |
| **5h / 7d rate-limit** इंडिकेटर, > 50 % पर ⚠️ के साथ | ❌ | ✅ |
| limit मीटर में Reset countdown (`5h{1.1h}`) | ❌ | ✅ |
| **Git branch** + dirty + ahead/behind | ❌ | ✅ |
| **Time-on-task** (active बनाम wall clock) | ❌ | ✅ |
| **Thinking / effort level** डिस्प्ले | ❌ | ✅ |
| थीम प्रीसेट | ❌ | ✅ 79 थीम × 2 वैरिएंट = **158 तैयार** |
| नामित ब्लॉक्स से कंपोज़ करना | ❌ | ✅ 26 ब्लॉक्स, देखें [BLOCKS.md](BLOCKS.md) |
| बिल्ट-इन CLI कॉन्फ़िगरेटर | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` slash command | ❌ | ✅ वैकल्पिक, देखें [`commands/`](commands/) |
| External dependencies | — | `bash` 4+ और `jq` (कोई Node नहीं, कोई Python नहीं, कोई daemon नहीं) |
| License | — | Source-Available (अनुमति-द्वारा-पुनःउपयोग) |

## 💡 Use cases

ठोस परिदृश्य जहाँ यह प्रोजेक्ट अपनी कीमत वसूल करता है:

- **"मैंने अपने 1 M context का कितना खर्च कर लिया है?"** — हर प्रॉम्प्ट से पहले एक लाइव प्रतिशत + बार देखें।
- **"यह Claude Code सेशन मुझे कितना खर्च करा रहा है?"** — चलता हुआ USD कुल, हर render पर अपडेट।
- **"क्या मैं आज rate limit से टकराऊँगा?"** — > 50 % पर ⚠️ के साथ 5 h / 7 d इंडिकेटर।
- **"क्या मैं सही branch पर हूँ?"** — आपकी status line में git branch + dirty + ahead/behind।
- **"मैंने इस feature पर वास्तव में कितने घंटे बिताए?"** — time-on-task tracker (`active` बनाम `wall`)।
- **"मैं चाहता हूँ कि मेरा terminal मज़ेदार हो।"** — anime, cyberpunk, hacker, retro, weather, ocean, fire और अन्य थीम।
- **"मुझे स्क्रीन रिकॉर्डिंग के लिए एक मिनिमल, केवल-ASCII status line चाहिए।"** — `zen` थीम।
- **"मैं एक ऐसी status line शिप करना चाहता हूँ जिसे मेरी पूरी टीम इस्तेमाल करे।"** — सिंगल बंडल किया गया स्क्रिप्ट + CLI कॉन्फ़िगरेटर + slash command।

## ❓ FAQ

### "Claude Code Status Line" क्या है?

[Claude Code](https://claude.com/claude-code) (Anthropic की CLI) में डिफ़ॉल्ट status line का एक bash-आधारित रिप्लेसमेंट। यह स्क्रीन के नीचे की लाइन को एक असली dashboard में बदल देता है: model, context %, progress bar, session cost, rate limits, git status, time-on-task, और भी बहुत कुछ।

### `5h{1.1h}: 1%` का क्या मतलब है?

आपने 5-घंटे की window का 1% इस्तेमाल कर लिया है, और `{1.1h}` एक लाइव countdown है — window 1.1 घंटे में रीसेट होती है (`7d{1.1d}`: साप्ताहिक window 1.1 दिन में रीसेट होती है)। हर render पर `rate_limits.*.resets_at` से पढ़ा जाता है। आपके build में कोई reset timestamp नहीं है? मीटर सादे `5h: 1%` पर वापस आ जाता है।

### इसे कैसे इंस्टॉल किया जाता है?

`statusline-bundle.sh` को `~/.claude/status-line.sh` में कॉपी करें, `chmod +x` करें, फिर Claude Code की `~/.claude/settings.json` के `statusLine.command` को उस पथ की ओर इंगित करें। पूरे निर्देश [Quick start](#-quick-start) और [Install](#-install) सेक्शन में हैं।

### क्या यह 1 M context window models को सपोर्ट करता है?

हाँ। स्क्रिप्ट model id में `[1m]` और display name में `1M` का पता लगाती है और बार के denominator को 1 000 000 tokens में समायोजित करती है। आपको दिखेगा `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`।

### यह किन models के साथ काम करता है?

किसी भी model के साथ जिसे Claude Code सपोर्ट करता है — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, आदि। स्क्रिप्ट Claude Code द्वारा प्रदान किए गए stdin JSON से `model.display_name` और `model.id` पढ़ती है; यह model नामों को hardcode नहीं करती।

### क्या मैं रंग, थीम कस्टमाइज़ कर सकता हूँ, या अपनी खुद की जोड़ सकता हूँ?

हाँ — तीन तरीके:

1. **79 थीम** में से एक चुनें (कुल 158 वैरिएंट) — `~/.claude/status-line.sh use <name>` का उपयोग करें या स्टैंडअलोन स्क्रिप्ट्स के लिए [`examples/`](examples/) ब्राउज़ करें।
2. **नामित ब्लॉक्स** से अपनी खुद की कंपोज़ करें — देखें [BLOCKS.md](BLOCKS.md)।
3. `statusline.sh` में सीधे रंग स्थिरांक और bar style संपादित करें।

### क्या यह Claude Code को धीमा कर देगा?

नहीं। हर render प्रति status redraw एक बार चलता है, पाइप किए गए JSON को `jq` से पार्स करता है, वैकल्पिक रूप से transcript की नवीनतम लाइन को `grep` करता है, और प्रिंट करता है। typical render ≤ 50 ms होता है, time-tracker सक्षम होने पर भी।

### क्या यह `jq` के बिना काम करता है?

`jq` आवश्यक है — यह उस JSON को पार्स करता है जो Claude Code stdin पर भेजता है। इसे `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), या `choco install jq` (Windows) के ज़रिए इंस्टॉल करें।

### क्या यह Windows पर काम करता है?

हाँ, किसी भी ऐसे वातावरण में जो `bash` 4+ और `jq` चलाता है — Git Bash, WSL, MSYS2, Cygwin। शुद्ध CMD/PowerShell सपोर्टेड नहीं हैं।

### क्या यह Linux / macOS पर काम करता है?

दोनों पर हाँ। macOS BSD `date` का उपयोग करता है, Linux GNU `date` का — time-tracker दोनों को पारदर्शी रूप से संभालता है।

### क्या मैं इसे Claude Code के बजाय raw Anthropic API के साथ इस्तेमाल कर सकता हूँ?

आंशिक रूप से। status line को Claude Code के stdin JSON फ़ॉर्मेट के लिए डिज़ाइन किया गया है। raw API उपयोग के लिए, rate-limit इंडिकेटर स्वतः ही एक **कुल session tokens** डिस्प्ले (`tokens: NNN K`) पर वापस आ जाते हैं।

### कॉन्फ़िगरेशन कहाँ संग्रहित होती है?

`~/.claude/statusline.conf` — एक छोटी shell-sourced फ़ाइल जो बंडल के CLI (`statusline.sh use <theme>` आदि) द्वारा लिखी जाती है। रीस्टार्ट के बीच बनी रहती है।

### मैं डिफ़ॉल्ट Claude Code status line पर वापस कैसे जाऊँ?

या तो `~/.claude/settings.json` से `statusLine` ब्लॉक हटाएँ, या `~/.claude/status-line.sh reset` चलाएँ और एक `minimal` थीम पर स्विच करें जो डिफ़ॉल्ट से काफ़ी मिलती-जुलती है।

### क्या यह मुफ़्त है? क्या मैं इसे व्यावसायिक रूप से उपयोग कर सकता हूँ?

व्यक्तिगत, स्थानीय उपयोग मुफ़्त है — देखें [Source-Available License](LICENSE)। कोई भी पुनःउपयोग, पुनर्वितरण, fork, या किसी अन्य प्रोजेक्ट में शामिल करना लेखक (Yevgeniy Achin · amazopic@gmail.com) से **पूर्व लिखित अनुमति** की आवश्यकता रखता है। उचित अनुरोध आमतौर पर स्वीकृत किए जाते हैं।

### "human-hours" tracker कैसे काम करता है?

`time` थीम JSONL transcript से timestamps पढ़ती है और दो अवधियाँ रिपोर्ट करती है: **active** (5 मिनट से छोटे अंतर-संदेश अंतरालों का योग) और **wall** (पहले से अंतिम संदेश तक का कुल विस्तार)। 5-मिनट का idle थ्रेशोल्ड कॉन्फ़िगरेबल है।

## 🏷️ सुझाए गए GitHub topics

जब आप यह repo प्रकाशित करें, तो खोज-योग्यता अधिकतम करने के लिए ये topics जोड़ें:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Contributing

Issues और PRs का स्वागत है — लेकिन लाइसेंस का ध्यान रखें:

- **पढ़ना, issues खोलना, PRs सबमिट करना**: मुफ़्त।
- **Forking, किसी अन्य प्रोजेक्ट में कॉपी करना, पुनर्वितरण**: लेखक से
  पूर्व लिखित अनुमति की आवश्यकता है।

पुनःउपयोग की अनुमति का अनुरोध करने के लिए, संपर्क करें:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

व्यक्तिगत, शैक्षिक, और गैर-व्यावसायिक उपयोग के लिए उचित अनुरोध
आमतौर पर निःशुल्क स्वीकृत किए जाते हैं।

## 📜 License

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

इस प्रोजेक्ट का सोर्स पढ़ने, अध्ययन करने, और आपकी अपनी मशीन पर
व्यक्तिगत उपयोग के लिए सार्वजनिक रूप से उपलब्ध है। कोई भी पुनःउपयोग —
कॉपी करना, पुनर्वितरण, संशोधन, या किसी अन्य प्रोजेक्ट में शामिल करना —
लेखक (Yevgeniy Achin · amazopic@gmail.com) से **पूर्व लिखित अनुमति** की
आवश्यकता रखता है।

यह एक OSI-अनुमोदित ओपन-सोर्स लाइसेंस **नहीं** है। यह वितरण और व्युत्पन्न
कार्यों को लेखक के नियंत्रण में रखते हुए समुदाय को पढ़ने, अध्ययन करने और
योगदान देने की अनुमति देने का एक सुविचारित विकल्प है।

## ⭐ उपयोगी लगा?

अगर आप घंटों Claude Code को देखते रहते हैं, तो क्यों न एक सुंदर status line देखें। दूसरों को इसे खोजने में मदद करने के लिए **repo को एक ⭐ दें**!

---

बनाया **Yevgeniy Achin** द्वारा · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · Claude Code समुदाय के लिए।
