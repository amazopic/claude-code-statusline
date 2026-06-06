<div dir="rtl">

# 🛰️ Claude Code Status Line — 79 themes, configurable blocks, CLI

> תחליף drop-in לשורת המצב (status line) הברירת-מחדל של **Claude Code**: שימוש חי **בחלון ההקשר (context window)** עם פס התקדמות חלק, **עלות הסשן (session cost)** בדולרים, אזהרות **5h / 7d rate-limit**, **ענף git** עם ספירת dirty / ahead / behind, **מעקב זמן-על-משימה (time-on-task)**, ושם **המודל (model name)** הפעיל (עם מחוון `(1M)` לגרסאות בעלות הקשר 1M) — הכול בשורת Bash צבעונית אחת. מגיע עם **79 themes מוכנות** — הבחירות המובילות (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), קלאסיקות (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), מותגי רכב (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), עוד מדענים (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), עוד anime (onepiece, ghibli), עוד Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), themes של מערכות הפעלה (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), ודתות העולם (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) ו**ספריית 26-block** להרכבת שורה משלך. כולל מגדיר CLI כולל-בכול ופקודת slash בשם `/statusline` עבור Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-variants-מוכנות--בחרו-אחת-וצאו-לדרך)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md) · [ไทย](README.th.md) · עברית · [বাংলা](README.bn.md) · [اردو](README.ur.md)

<div dir="ltr">

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

</div>

> 💡 **טיפ מקצועי — שליטה בהקשר (Context)**: ככל שחלון ההקשר שלכם מלא יותר, כך השיחה שלכם עם Claude הופכת **פחות אפקטיבית** — ואתם **שורפים מהר יותר** את מגבלות ה-5h/7d שלכם. נקו או הריצו `/compact` בכל פעם שאתם חוצים את ה-**60%** כדי להמשיך לעבוד ביעילות.

### ⏳ Reset countdown — תכננו סביב המגבלות שלכם

מדי ה-5h / 7d כוללים ספירה לאחור חיה עד הרגע שבו כל חלון מתאפס: `5h{1.1h}: 1%` — חלון ה-5 שעות מתאפס בעוד 1.1 שעות; `7d{1.1d}: 0%` — החלון השבועי מתאפס בעוד 1.1 ימים. אתם תמיד יודעים מתי תחזרו ל-0%, כך שתוכלו לתזמן עבודה כבדה מיד לאחר איפוס ולפזר את הפרודוקטיביות שלכם במקום להתנגש במגבלה באמצע משימה. מופעל על ידי `rate_limits.*.resets_at` שנשלח על ידי Claude Code; אם הבנייה (build) שלכם לא שולחת חותמות זמן של איפוס, המדים נסוגים בחן לתצוגה הפשוטה `5h: 1%`.

<div dir="ltr">

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

</div>

**צפוי בעיצובו (Predictable by design)** — כל מד סופר לאחור עד האיפוס שלו, כך שאתם קובעים את קצב העבודה במקום להתנגש בקיר.

## ⚡ Quick start

הדרך המהירה ביותר — סקריפט כולל-בכול ארוז (bundled) עם CLI מובנה:

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

</div>

לאחר מכן הוסיפו ל-`~/.claude/settings.json`:

<div dir="ltr">

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

</div>

> 💡 `refreshInterval: 30` מריץ מחדש את השורה כל 30 שניות גם כשהסשן במצב סרק — וזה שומר על ספירת האיפוס לאחור (`5h{1.1h}`), על מעקב הזמן ועל היפוכי ה-post-reset חיים. 30 הוא ברירת מחדל סבירה; 60 חסכוני יותר בסוללה; השמיטו את השדה כדי לרענן רק על אירועים (הודעת assistant חדשה, `/compact`, מעבר vim).

הפעילו מחדש את Claude Code (או הריצו `/config` reload). סיימתם.

### או שיטת vibe-chill · תנו ל-Claude לעשות זאת

למה לגעת בטרמינל כשיש לכם Claude Code? הדביקו את ההנחיה (prompt) היחידה הזו בסשן Claude Code שלכם — Claude מטפל בכל שלב ושואל לפני כל פקודה.

<div dir="ltr">

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", "refreshInterval": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

</div>

> פשוט אמרו `y` (כן) בכל בקשת הרשאה. סיימתם.


## למה שורת מצב / סרגל מצב מותאם אישית עבור Claude Code?

שורת המצב הברירת-מחדל של Claude Code דלילה. תחליף drop-in זה הופך את סרגל המצב התחתון ל**דשבורד במבט אחד** עבור כל סשן:

- 🔋 כמה הקשר שרפתי? (פסים שבריריים חלקים של 1.25%)
- 💰 כמה הסשן הזה עולה לי?
- 🚦 כמה קרוב אני למגבלות הקצב (rate limits) שלי?
- 🧠 באיזו רמת thinking / model אני נמצא?
- 🌿 באיזה ענף git אני נמצא?

הכול ב**שורה אחת**, מקודד בצבעים, עם אייקונים חכמים שמסמנים דחיפות.

## ✨ Features

- 🪐 **פס הקשר חי (Live context bar)** — פס התקדמות בן 10 תאים עם דיוק תת-תאי (גליפים שבריריים quadrant או vertical)
- 🧠 **שם המודל (Model name)** — עם מחוון `(1M)` לגרסאות בעלות הקשר 1M
- 💸 **עלות הסשן (Session cost)** בדולרים, מתעדכנת בכל render
- ⬆️⬇️ **מוני token לכל הודעה** (input / output)
- 🚦 **Rate limits** — 5h / 7d עם אזהרת ⚠️ כש- > 50%
- 🔄 **נסיגת API-mode** — כשלא מועברות מגבלות קצב, מציג את סך ה-token של הסשן (`tokens: NNN K`) עם מפרידי אלפים ברווח דק
- 🚀 **אייקון מצב חכם** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% מילוי הקשר
- 🎨 **256-color ANSI** — בהיר, צבע ייחודי לכל מקטע
- 🧩 **סגנונות פס ניתנים לחיבור (Pluggable bar styles)** — בחרו `quadrant` (▖▄▙█) או `vertical` (▏▎▍▌▋▊▉█), או צרו משלכם ב-10 שורות bash
- ⚡ **קליל** — `bash` + `jq` טהורים. ללא Node, ללא Python, ללא daemon, ללא טלמטריה

## 🎨 158 variants מוכנות — בחרו אחת וצאו לדרך

כל theme מגיעה ב**שני variants**:

- **Detailed** — מערך תכונות מלא (model, context bar, cost, tokens, git, time, אייקון mood, …)
- **Compact** — רק `model · context % + bar · branch`

החילו עם `~/.claude/status-line.sh use <name>` (הוסיפו `-compact` עבור גרסת ה-compact).

### 🔝 בחירות מובילות (10) — המבוקשות ביותר, חוצות תרבויות

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

### 🛠 מעשיות / קלאסיות (18 themes)

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

> הערה: `cyberpunk` ו-`hacker` נמצאות ב**בחירות המובילות** למעלה — הן נמצאות
> גם בתיקיית `examples/` אם תרצו התקנה של theme יחידה.

<div dir="ltr">

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

</div>

### 🚗 מותגי רכב (15 נוספים, הבחירות המובילות כוללות את `ferrari`)

מגיעים ב-`statusline-bundle.sh` בלבד — בחרו כל אחד עם `~/.claude/status-line.sh use <name>`.

| Region | Themes |
|---|---|
| 🇪🇺 Europe  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 America | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japan   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 מדענים גדולים (8 נוספים, הבחירות המובילות כוללות את `einstein` ו-`tesla`)

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

### ✨ Anime (3 נוספים, הבחירות המובילות כוללות את `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 גיבורי-על של Marvel (8 נוספים, הבחירות המובילות כוללות את `ironman` ו-`spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 מערכות הפעלה (10 themes)

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

### 🕊 דתות העולם (7 המובילות לפי מספר המאמינים)

| Theme | Vibe |
|---|---|
| `christianity` | ✝ wine red + Marian blue + papal gold · faith meter, € alms |
| `islam`        | ☪ Islamic green + white + gold calligraphy · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 saffron + marigold + vermilion · dharma, ₹ seva |
| `buddhism`     | ☸ monk saffron + gold + maroon · karma, ฿ dāna |
| `judaism`      | ✡ tallit blue + white + menorah gold · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ Khalsa deep blue + saffron + white · sewa, daswandh |
| `shinto`       | ⛩ vermilion torii + shrine white + gold · kami, ¥ saisen |

<div dir="ltr">

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

</div>

**עיינו בכולן בטרמינל שלכם תחילה** — לכל variant יש
תצוגה מקדימה מעובדת מראש ב-[`screenshots/`](screenshots/):

<div dir="ltr">

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (158 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

</div>

ראו את [`examples/README.md`](examples/README.md) עבור הטבלה המלאה עם
תיאורים, ואת [`screenshots/README.md`](screenshots/README.md) עבור
האופן שבו התצוגות המקדימות נוצרות.

## 🧱 בנו משלכם מ-blocks

לא רוצים להשתמש ב-preset? הרכיבו status line מותאם אישית מתוך ספרייה
של blocks בעלי שם — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

ראו את [**BLOCKS.md**](BLOCKS.md) עבור:

- **קטלוג ה-blocks** (כל אחד הוא קטע bash שניתן להעתקה-הדבקה)
- **חבילות הסגנון (style packs)** (פלטות צבעים ומפרידים מ-`classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- **מתכון בן 3 שלבים** לבניית השורה שלכם: בחרו סגנון → רשמו blocks
  → הדביקו

<div dir="ltr">

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

</div>

## 📦 חבילת כולל-בכול (`statusline-bundle.sh`)

אם אינכם רוצים לנהל 40+ קבצים, קחו את **הסקריפט הארוז היחיד**
[`statusline-bundle.sh`](statusline-bundle.sh) — הוא מכיל
כל theme + כל block + מגדיר CLI בקובץ אחד.

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

התצורה נשמרת ב-`~/.claude/statusline.conf` ונשמרת
לאורך הפעלות מחדש. אותו קובץ משמש גם כ-**renderer** (כש-Claude Code
קורא לו עם JSON ב-stdin) וגם כ-**configurator**
(כשאתם קוראים לו עם ארגומנטים).

### פקודת slash בשם `/statusline`

הניחו את [`commands/statusline.md`](commands/statusline.md) בתוך
`~/.claude/commands/` כדי לאפשר פקודת slash בשם `/statusline` בתוך
Claude Code:

<div dir="ltr">

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

</div>

לאחר מכן בכל סשן Claude Code תוכלו להקליד:

<div dir="ltr">

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

</div>

Claude יריץ עבורכם את ה-CLI של החבילה, ידווח על התוצאה, ויזכיר
לכם לטעון מחדש.

### alias אופציונלי ל-shell

<div dir="ltr">

```bash
alias statusline='~/.claude/status-line.sh'
```

</div>

ואז `statusline cyberpunk` עובד מכל טרמינל.

## 🚀 Install

### התקנה ידנית (3 שלבים)

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

</div>

לאחר מכן הוסיפו ל-`~/.claude/settings.json`:

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

> 💡 `refreshInterval: 30` מריץ מחדש את השורה כל 30 שניות גם כשהסשן במצב סרק — וזה שומר על ספירת האיפוס לאחור (`5h{1.1h}`), על מעקב הזמן ועל היפוכי ה-post-reset חיים. 30 הוא ברירת מחדל סבירה; 60 חסכוני יותר בסוללה; השמיטו את השדה כדי לרענן רק על אירועים (הודעת assistant חדשה, `/compact`, מעבר vim).

הפעילו מחדש את Claude Code (או הריצו `/config` reload).

### התקנה דרך סוכן Claude Code (עם גיבוי אוטומטי)

רוצים ש-Claude Code יתקין זאת עבורכם בבטחה? הדביקו את ההנחיה הזו:

> "התקן את שורת המצב מ-repo זה כשורת המצב של Claude Code שלי:
> 1. אם `~/.claude/status-line.sh` כבר קיים, גבה אותו אל
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (בחר סיומת `-N`
>    פנויה אם גיבוי בשם זה כבר קיים).
> 2. העתק את `statusline.sh` מ-repo זה אל `~/.claude/status-line.sh` ו-`chmod +x`.
> 3. קרא את `~/.claude/settings.json`. אם אין בו מפתח `statusLine`, הוסף
>    בלוק `statusLine` המצביע אל הנתיב המלא של הסקריפט וכולל
>    `"refreshInterval": 30`. אם `statusLine` כבר קיים ומצביע
>    למקום אחר, גבה תחילה את `settings.json` אל `.bak.<timestamp>`.
> 4. בצע smoke-test לסקריפט:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. אמור לי להפעיל מחדש את Claude Code ודווח על הגיבויים שנוצרו."

### עדכון לגרסה האחרונה

<div dir="ltr">

```bash
~/.claude/status-line.sh update
```

</div>

מביא את החבילה האחרונה מ-GitHub, יוצר גיבוי בעל חותמת זמן
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), ושומר על תצורת ה-theme
שלכם (`~/.claude/statusline.conf`). הפעילו מחדש את Claude Code לאחר מכן.

בדקו מה התקנתם: `~/.claude/status-line.sh version`.

### Requirements

- `bash` 4+ (הסקריפט משתמש במערכים באינדקס-0 — **אל תריצו תחת `zsh`**)
- `jq` לפענוח JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (נדרש רק עבור `statusline update`; מותקן מראש ברוב המערכות)
- טרמינל בעל 256 צבעים (בעצם כל טרמינל מודרני)

## ⚙️ Configuration

ערכו את הקבועים בקרבת ראש הקובץ `statusline.sh`:

| Variable / function | מה זה שולט |
|---|---|
| `BAR_STYLE` | `"quadrant"` (ברירת מחדל, צעד 2.5%) או `"vertical"` (צעד 1.25%) |
| `pct_icon()` | ספים לאייקונים 🚀 / 🚗 / ⚠️ לפני הפס |
| `pct_color()` | ספי צבע עבור האחוז / הפס |
| קבועי צבע ANSI | צבעו מחדש כל מקטע (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 לעומת שורת המצב הברירת-מחדל של Claude Code

| Capability | Default | This project |
|---|---|---|
| **שם המודל (model name)** הפעיל | ✅ | ✅ (עם דגל `(1M)` לגרסאות בעלות הקשר 1M) |
| % שימוש ב**חלון ההקשר (Context window)** | ❌ | ✅ חי, דיוק 1.25 % |
| **פס התקדמות** עבור ההקשר | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **עלות הסשן (Session cost)** בדולרים | ❌ | ✅ מתעדכנת בכל render |
| מוני token של input/output **לכל הודעה** | ❌ | ✅ |
| **סך token של הסשן** (נסיגת API mode) | ❌ | ✅ |
| מחווני **5h / 7d rate-limit** עם ⚠️ ב- > 50 % | ❌ | ✅ |
| Reset countdown במדי המגבלות (`5h{1.1h}`) | ❌ | ✅ |
| **ענף Git** + dirty + ahead/behind | ❌ | ✅ |
| **זמן-על-משימה (Time-on-task)** (active לעומת wall clock) | ❌ | ✅ |
| תצוגת **רמת thinking / effort** | ❌ | ✅ |
| presets ערוכות מראש (Themed) | ❌ | ✅ 79 themes × 2 variants = **158 מוכנות** |
| הרכבה מ-blocks בעלי שם | ❌ | ✅ 26 blocks, ראו [BLOCKS.md](BLOCKS.md) |
| מגדיר CLI מובנה | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| פקודת slash `/statusline` של Claude Code | ❌ | ✅ אופציונלי, ראו [`commands/`](commands/) |
| תלויות חיצוניות | — | `bash` 4+ ו-`jq` (ללא Node, ללא Python, ללא daemon) |
| License | — | Source-Available (שימוש-חוזר-באישור) |

## 💡 Use cases

תרחישים קונקרטיים שבהם הפרויקט הזה משתלם:

- **"כמה מתוך ה-context 1 M שלי שרפתי?"** — ראו אחוז חי + פס לפני כל prompt.
- **"כמה הסשן הזה של Claude Code עולה לי?"** — סך כולל בדולרים רץ, מתעדכן בכל render.
- **"האם אגיע למגבלת קצב היום?"** — מחווני 5 h / 7 d עם ⚠️ כש- > 50 %.
- **"האם אני בענף הנכון?"** — ענף git + dirty + ahead/behind בשורת המצב שלכם.
- **"כמה שעות בפועל ביליתי על הפיצ'ר הזה?"** — מעקב זמן-על-משימה (`active` לעומת `wall`).
- **"אני רוצה שהטרמינל שלי יהיה כיפי."** — themes כמו anime, cyberpunk, hacker, retro, weather, ocean, fire ואחרות.
- **"אני רוצה status line מינימלי, ASCII בלבד, להקלטות מסך."** — theme בשם `zen`.
- **"אני רוצה להפיץ status line שכל הצוות שלי משתמש בו."** — סקריפט ארוז יחיד + מגדיר CLI + פקודת slash.

## ❓ FAQ

### מה זה "Claude Code Status Line"?

תחליף מבוסס-bash לשורת המצב הברירת-מחדל ב-[Claude Code](https://claude.com/claude-code) (ה-CLI של Anthropic). הוא הופך את השורה שבתחתית המסך לדשבורד אמיתי: model, % הקשר, פס התקדמות, עלות סשן, מגבלות קצב, סטטוס git, זמן-על-משימה, ועוד.

### מה משמעות `5h{1.1h}: 1%`?

ניצלתם 1% מחלון ה-5 שעות, ו-`{1.1h}` הוא ספירה לאחור חיה — החלון מתאפס בעוד 1.1 שעות (`7d{1.1d}`: החלון השבועי מתאפס בעוד 1.1 ימים). נקרא מ-`rate_limits.*.resets_at` בכל render. אין חותמת זמן של איפוס בבנייה שלכם? המד נסוג לתצוגה הפשוטה `5h: 1%`.

### האם שורת המצב מתעדכנת מעצמה? ספירת ה-`{1.1h}` שלי נראית קפואה.

Claude Code מעבד מחדש על אירועים — הודעת assistant חדשה, `/compact`, שינוי permission-mode או vim-mode (עם debounce של 300 ms) — כך שבין אירועים השורה קופאת. הוסיפו `"refreshInterval": 30` לבלוק ה-statusLine ב-`~/.claude/settings.json` והוא יריץ מחדש גם על טיימר קבוע של 30 שניות, ושומר על הספירה לאחור ועל מעקב הזמן פועלים במצב סרק. render עולה ~0.1 s, כך ש-30 s זניח; השתמשו ב-60 על סוללה או ב-repos ענקיים (git status רץ בכל render); המינימום הוא 1.

### איך זה מותקן?

העתיקו את `statusline-bundle.sh` אל `~/.claude/status-line.sh`, `chmod +x`, ואז כוונו את `statusLine.command` ב-`~/.claude/settings.json` של Claude Code לנתיב הזה. הוראות מלאות בסעיפי [Quick start](#-quick-start) ו-[Install](#-install).

### האם זה תומך במודלים של חלון הקשר 1 M?

כן. הסקריפט מזהה `[1m]` ב-model id ו-`1M` בשם התצוגה ומתאים את המכנה של הפס ל-1 000 000 tokens. תראו `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### עם אילו מודלים זה עובד?

כל מודל ש-Claude Code תומך בו — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, וכו'. הסקריפט קורא את `model.display_name` ו-`model.id` מ-JSON ה-stdin ש-Claude Code מספק; הוא לא מקודד קשיח שמות מודלים.

### האם אני יכול להתאים אישית צבעים, themes, או להוסיף משלי?

כן — בשלוש דרכים:

1. בחרו אחת מתוך **79 ה-themes** (158 variants בסך הכול) — השתמשו ב-`~/.claude/status-line.sh use <name>` או עיינו ב-[`examples/`](examples/) עבור הסקריפטים העצמאיים.
2. הרכיבו משלכם מ-**blocks בעלי שם** — ראו [BLOCKS.md](BLOCKS.md).
3. ערכו ישירות את קבועי הצבע ואת סגנון הפס ב-`statusline.sh`.

### האם זה יאט את Claude Code?

לא. כל render רץ פעם אחת לכל ציור-מחדש של המצב, מפענח את ה-JSON המועבר עם `jq`, אופציונלית מבצע `grep` על השורה האחרונה של ה-transcript, ומדפיס. render טיפוסי הוא ≤ 50 ms גם עם מעקב הזמן מופעל.

### האם זה עובד בלי `jq`?

`jq` נדרש — הוא מפענח את ה-JSON ש-Claude Code שולח ב-stdin. התקינו אותו דרך `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), או `choco install jq` (Windows).

### האם זה עובד ב-Windows?

כן, בכל סביבה שמריצה `bash` 4+ ו-`jq` — Git Bash, WSL, MSYS2, Cygwin. CMD/PowerShell טהורים אינם נתמכים.

### האם זה עובד ב-Linux / macOS?

כן בשניהם. macOS משתמש ב-`date` של BSD, Linux משתמש ב-`date` של GNU — מעקב הזמן מטפל בשניהם בשקיפות.

### האם אני יכול להשתמש בזה עם Anthropic API הגולמי במקום Claude Code?

חלקית. שורת המצב מעוצבת עבור פורמט ה-JSON של stdin של Claude Code. עבור שימוש ב-API גולמי, מחווני מגבלת הקצב נסוגים אוטומטית לתצוגת **סך token של הסשן** (`tokens: NNN K`).

### היכן מאוחסנת התצורה?

`~/.claude/statusline.conf` — קובץ זעיר הנטען דרך shell שנכתב על ידי ה-CLI של החבילה (`statusline.sh use <theme>` וכו'). נשמר לאורך הפעלות מחדש.

### איך אני חוזר לשורת המצב הברירת-מחדל של Claude Code?

או הסירו את בלוק ה-`statusLine` מ-`~/.claude/settings.json`, או הריצו `~/.claude/status-line.sh reset` ועברו ל-theme בשם `minimal` שמתאים מאוד לברירת המחדל.

### האם זה חינמי? האם אני יכול להשתמש בזה מסחרית?

שימוש אישי ומקומי הוא חינמי — ראו את [Source-Available License](LICENSE). כל שימוש חוזר, הפצה מחדש, fork, או הכללה בפרויקט אחר מחייבים **אישור בכתב מראש** מהמחבר (Yevgeniy Achin · amazopic@gmail.com). בקשות סבירות מאושרות בדרך כלל.

### איך עובד מעקב "שעות-האדם (human-hours)"?

ה-theme בשם `time` קורא חותמות זמן מתוך ה-transcript בפורמט JSONL ומדווח על שני משכי זמן: **active** (סכום הפערים בין הודעות הקצרים מ-5 דקות) ו-**wall** (המוטווח הכולל מההודעה הראשונה לאחרונה). סף הסרק של 5 דקות ניתן להגדרה.

## 🏷️ נושאי GitHub מומלצים

כשתפרסמו את ה-repo הזה, הוסיפו את הנושאים האלה כדי למקסם את יכולת הגילוי:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Contributing

Issues ו-PRs מתקבלים בברכה — אך שימו לב לרישיון:

- **קריאה, פתיחת issues, הגשת PRs**: חינם.
- **Forking, העתקה לפרויקט אחר, הפצה מחדש**: מחייבים
  אישור בכתב מראש מהמחבר.

כדי לבקש אישור לשימוש חוזר, צרו קשר:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

בקשות סבירות לשימוש אישי, חינוכי, ולא-מסחרי
מאושרות בדרך כלל ללא תשלום.

## 📜 License

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

הקוד של פרויקט זה זמין באופן ציבורי לקריאה, לימוד, ושימוש
אישי במכונה שלכם. כל שימוש חוזר — העתקה, הפצה מחדש,
שינוי, או הכללה בפרויקט אחר — מחייב **אישור בכתב מראש**
מהמחבר (Yevgeniy Achin · amazopic@gmail.com).

זהו **לא** רישיון קוד-פתוח מאושר על ידי OSI. זוהי בחירה
מכוונת לשמור על הפצה ועל יצירות נגזרות בשליטת המחבר תוך
מתן אפשרות לקהילה לקרוא, ללמוד, ולתרום.

## ⭐ מצאתם את זה שימושי?

אם אתם מבלים שעות בלהביט ב-Claude Code, אז כדאי שתביטו ב-status line יפה. **תנו ל-repo ⭐** כדי לעזור לאחרים לגלות אותו!

---

נוצר על ידי **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · עבור קהילת Claude Code.

</div>
