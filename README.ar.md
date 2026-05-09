<div dir="rtl">

# 🛰️ Claude Code Status Line — 72 سمة، كتل قابلة للتكوين، CLI

> بديل مباشر لشريط حالة **Claude Code** الافتراضي: استخدام مباشر **لنافذة السياق** بشريط تقدم سلس، **تكلفة الجلسة** بالدولار، تحذيرات **حد المعدل 5س / 7ي**، **فرع git** مع عدد dirty / ahead / behind، **تتبع الوقت المستغرق**، واسم **النموذج** النشط (مع مؤشر `(1M)` لمتغيرات سياق 1M) — كل ذلك في سطر Bash ملوّن واحد. يأتي مع **72 سمة جاهزة** — أبرز الاختيارات (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari)، الكلاسيكيات (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate)، علامات السيارات (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely)، علماء (newton, curie, darwin, hawking, galileo, feynman, turing, davinci)، أنمي (onepiece, ghibli)، Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda)، وسمات أنظمة التشغيل (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos)، ومكتبة من **18 كتلة** لإنشاء سمتك الخاصة. يشمل مكوّن CLI شامل وأمر شرطة `/statusline` لـ Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 144](https://img.shields.io/badge/variants-144-brightgreen.svg)](#-144-pripravljenih-variant)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**اللغات:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · العربية

<div dir="ltr">

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

</div>

> 💡 **نصيحة احترافية — التحكم في السياق**: كلما كانت نافذة السياق أكثر امتلاءً، أصبحت محادثتك مع Claude **أقل فعالية** — وكلما **استهلكت حدود 5س/7ي بشكل أسرع**. امسح أو `/compact` كلما تجاوزت **60%** للحفاظ على كفاءة العمل.

## ⚡ بدء سريع

أسرع طريق — سكريبت مجمع شامل مع CLI مدمج:

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

</div>

ثم أضف إلى `~/.claude/settings.json`:

<div dir="ltr">

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

</div>

أعد تشغيل Claude Code (أو شغّل `/config reload`). تم.

### أو طريقة سهلة · دع Claude يفعل ذلك

لماذا تلمس الطرفية عندما يكون لديك Claude Code؟ الصق هذا الموجه الواحد في جلسة Claude Code — Claude يتعامل مع كل خطوة ويسأل قبل كل أمر.

<div dir="ltr">

```text
ثبّت لي claude-code-statusline من amazopic. أولاً تأكد من تثبيت jq (شغّل `which jq`) — إذا لم يكن موجودًا، ثبّته حسب المنصة: `sudo apt-get install -y jq` (Ubuntu/Debian)، `sudo dnf install -y jq` (Fedora)، `brew install jq` (macOS)، `sudo apk add jq` (Alpine). ثم اقرأ ~/.claude/settings.json — إذا كان به statusLine.command يشير إلى ملف موجود (مثل ~/.claude/status-line.sh أو مسار آخر)، فاحفظ نسخة احتياطية من ذلك الملف بإضافة .bak (الكتابة فوق أي .bak موجود). أيضًا إذا كان ~/.claude/status-line.sh موجودًا بالفعل، فاحفظه احتياطيًا بنفس الطريقة. ثم استنسخ github.com/amazopic/claude-code-statusline، وانسخ statusline-bundle.sh إلى ~/.claude/status-line.sh واجعله قابلاً للتنفيذ، وانسخ أيضًا commands/statusline.md إلى ~/.claude/commands/. حدّث ~/.claude/settings.json بحيث يكون statusLine = { type: "command", command: "<المسار المطلق إلى ~/.claude/status-line.sh>" }. أخيرًا شغّل ~/.claude/status-line.sh use developer لاختبار سمة developer وأخبرني بإعادة تشغيل Claude Code.
```

</div>

> فقط قل `y` (نعم) في كل طلب إذن. تم.

## 🎨 144 متغيرًا جاهزًا — اختر وانطلق

72 سمة × متغيرين (`detailed` + `-compact`). طبّق عبر `~/.claude/status-line.sh use <name>`.

### 🔝 أبرز 10 — الأكثر طلبًا، عبر الثقافات
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 الكلاسيكية (19): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

### 🚗 علامات السيارات (15)
- 🇪🇺 أوروبا: `porsche` · `mercedes` · `bmw` · `volvo`
- 🇺🇸 أمريكا: `ford` · `chevy` · `jeep` · `cadillac`
- 🇯🇵 اليابان: `toyota` · `honda` · `nissan`
- 🇰🇷 كوريا: `hyundai` · `kia`
- 🇨🇳 الصين: `byd` · `nio` · `geely`

### 🔬 علماء عظماء (8): `newton` · `curie` · `darwin` · `hawking` · `galileo` · `feynman` · `turing` · `davinci`

### ✨ أنمي (3 + الأبرز): `onepiece` · `ghibli`

### 🦸 Marvel (8 + الأبرز): `hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 أنظمة التشغيل (10): `macos` · `windows` · `linux` · `ubuntu` · `arch` · `debian` · `fedora` · `kali` · `mint` · `nixos`

<div dir="ltr">

```bash
~/.claude/status-line.sh use cyberpunk        # detailed
~/.claude/status-line.sh use macos-compact    # compact
```

</div>

## ✨ الميزات

- 🪐 **شريط سياق مباشر** — شريط تقدم 10 خلايا بدقة فرعية للخلية
- 🧠 **اسم النموذج** — مع مؤشر `(1M)` لمتغيرات سياق 1M
- 💸 **تكلفة الجلسة** بالدولار، محدّثة في كل عرض
- ⬆️⬇️ **عدّاد رموز لكل رسالة** (إدخال / إخراج)
- 🚦 **حدود المعدل** — 5س / 7ي مع تحذير ⚠️ عند تجاوز 50%
- 🔄 **احتياطي وضع API** — عند عدم تمرير حدود المعدل، يعرض إجمالي رموز الجلسة
- 🚀 **أيقونة حالة ذكية** — 🚀 < 40%، 🚗 40–49%، ⚠️ ≥ 50% امتلاء سياق
- 🎨 **256 لون ANSI** — ساطع، لون مميز لكل قسم
- ⚡ **خفيف** — `bash` + `jq` فقط. بدون Node، بدون Python، بدون daemon، بدون قياس عن بعد

## 🚀 التثبيت

### التثبيت الأساسي

<div dir="ltr">

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

</div>

### التحديث إلى أحدث إصدار

<div dir="ltr">

```bash
~/.claude/status-line.sh update
```

</div>

يجلب أحدث حزمة من GitHub، وينشئ نسخة احتياطية بطابع زمني (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`)، ويحافظ على إعداد السمة (`~/.claude/statusline.conf`). أعد تشغيل Claude Code بعد ذلك.

تحقق من النسخة المثبتة: `~/.claude/status-line.sh version`.

### المتطلبات

- `bash` 4+ (السكريبت يستخدم مصفوفات بفهرسة 0 — **لا تشغّل تحت `zsh`**)
- `jq` لتحليل JSON — `apt-get install jq` (Debian/Ubuntu)، `brew install jq` (macOS)، `dnf install jq` (Fedora)
- `curl` (مطلوب فقط لـ `statusline update`؛ مثبت مسبقًا في معظم الأنظمة)
- طرفية بـ 256 لون (أساسيًا أي طرفية حديثة)

## ⚙️ التكوين

عدّل الثوابت بالقرب من بداية `statusline.sh`:

| المتغير / الدالة | ما يتحكم به |
|---|---|
| `BAR_STYLE` | `"quadrant"` (افتراضي، خطوة 2.5%) أو `"vertical"` (خطوة 1.25%) |
| `pct_icon()` | عتبات لأيقونات 🚀 / 🚗 / ⚠️ قبل الشريط |
| `pct_color()` | عتبات الألوان للنسبة المئوية / الشريط |
| ثوابت ألوان ANSI | إعادة تلوين أي قسم (`G`، `Y`، `R`، `B`، `C`، `M`، …) |

## 📝 المؤلف والترخيص

- **المؤلف:** Yevgeniy Achin · [amazopic@gmail.com](mailto:amazopic@gmail.com)
- **الترخيص:** [مصدر متاح](LICENSE) — إعادة الاستخدام فقط بإذن كتابي مسبق
- **GitHub:** <https://github.com/amazopic/claude-code-statusline>

</div>
