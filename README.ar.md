<div dir="rtl">

# 🛰️ Claude Code Status Line — 79 سمة، كتل قابلة للتكوين، CLI

> بديل مباشر لشريط حالة **Claude Code** الافتراضي: استخدام مباشر **لنافذة السياق** بشريط تقدم سلس، **تكلفة الجلسة** بالدولار، تحذيرات **حد المعدل 5س / 7ي**، **فرع git** مع عدد dirty / ahead / behind، **تتبع الوقت المستغرق**، واسم **النموذج** النشط (مع مؤشر `(1M)` لمتغيرات سياق 1M) — كل ذلك في سطر Bash ملوّن واحد. يأتي مع **79 سمة جاهزة** — أبرز الاختيارات (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari)، الكلاسيكيات (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate)، علامات السيارات (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely)، علماء (newton, curie, darwin, hawking, galileo, feynman, turing, davinci)، أنمي (onepiece, ghibli)، Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda)، وسمات أنظمة التشغيل (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos)، ومكتبة من **26 كتلة** لإنشاء سمتك الخاصة. يشمل مكوّن CLI شامل وأمر شرطة `/statusline` لـ Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-متغيرًا-جاهزًا)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requirements)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**اللغات:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · العربية · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

<div dir="ltr">

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

</div>

> 💡 **نصيحة احترافية — التحكم في السياق**: كلما كانت نافذة السياق أكثر امتلاءً، أصبحت محادثتك مع Claude **أقل فعالية** — وكلما **استهلكت حدود 5س/7ي بشكل أسرع**. امسح أو `/compact` كلما تجاوزت **60%** للحفاظ على كفاءة العمل.

### ⏳ Reset countdown — خطّط حول حدودك

تتضمن مؤشرات 5س / 7ي عدًّا تنازليًا مباشرًا حتى لحظة إعادة ضبط كل نافذة: `5h{1.1h}: 1%` — تُعاد نافذة الـ5 ساعات خلال 1.1 ساعة؛ `7d{1.1d}: 0%` — تُعاد النافذة الأسبوعية خلال 1.1 يوم. أنت تعرف دائمًا متى تعود إلى 0%، فتستطيع جدولة العمل الثقيل مباشرةً بعد إعادة الضبط وتوزيع إنتاجيتك بدلًا من الاصطدام بالسقف في منتصف المهمة. مدعوم بـ `rate_limits.*.resets_at` الذي يرسله Claude Code؛ وإذا لم تُرسل نسختك طوابع زمنية لإعادة الضبط، تعود المؤشرات بسلاسة إلى الصيغة البسيطة `5h: 1%`.

<div dir="ltr">

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

</div>

**قابل للتنبؤ بالتصميم** — إمكانية التنبؤ بالعمل: وزّع إنتاجيتك. كل مؤشر يَعُدّ تنازليًا حتى إعادة ضبطه، فتضبط إيقاع عملك بدلًا من الارتطام بالجدار.

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

## 🎨 158 متغيرًا جاهزًا — اختر وانطلق

79 سمة × متغيرين (`detailed` + `-compact`). طبّق عبر `~/.claude/status-line.sh use <name>`.

### 🔝 أبرز 10 — الأكثر طلبًا، عبر الثقافات
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 الكلاسيكية (18): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

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

### 🕊 الديانات العالمية (أكثر 7 من حيث عدد المعتنقين): `christianity` · `islam` · `hinduism` · `buddhism` · `judaism` · `sikhism` · `shinto`

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

## 🆚 مقارنة بشريط حالة Claude Code الافتراضي

| القدرة | الافتراضي | هذا المشروع |
|---|---|---|
| اسم **النموذج** النشط | ✅ | ✅ (مع علامة `(1M)` لمتغيرات سياق 1M) |
| نسبة استخدام **نافذة السياق** | ❌ | ✅ مباشر، بدقة 1.25% |
| **شريط تقدم** للسياق | ❌ | ✅ (عمودي، رباعي، قوس قزح، سباركلاين، …) |
| **تكلفة الجلسة** بالدولار | ❌ | ✅ تُحدَّث في كل عرض |
| عدّادات رموز **لكل رسالة** (إدخال / إخراج) | ❌ | ✅ |
| **إجمالي رموز الجلسة** (احتياطي وضع API) | ❌ | ✅ |
| مؤشرات **حد المعدل 5س / 7ي** مع ⚠️ فوق 50% | ❌ | ✅ |
| عدّ تنازلي لإعادة الضبط في مؤشرات الحدود (`5h{1.1h}`) | ❌ | ✅ |
| **فرع Git** + dirty + ahead/behind | ❌ | ✅ |
| **الوقت المستغرق في المهمة** (نشط مقابل ساعة حائط) | ❌ | ✅ |
| عرض **مستوى التفكير / الجهد** | ❌ | ✅ |
| سمات جاهزة | ❌ | ✅ 79 سمة × متغيران = **158 جاهزة** |
| التركيب من كتل مسماة | ❌ | ✅ 26 كتلة، انظر [BLOCKS.md](BLOCKS.md) |
| مكوّن CLI مدمج | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| أمر الشرطة `/statusline` في Claude Code | ❌ | ✅ اختياري، انظر [`commands/`](commands/) |
| اعتماديات خارجية | — | `bash` 4+ و `jq` (بدون Node، بدون Python، بدون daemon) |
| الترخيص | — | مصدر متاح (إعادة استخدام بإذن) |

## ❓ الأسئلة الشائعة

### ما هو «Claude Code Status Line»؟

بديل قائم على Bash لشريط الحالة الافتراضي في [Claude Code](https://claude.com/claude-code) (واجهة Anthropic السطرية). يحوّل السطر أسفل الشاشة إلى لوحة قيادة حقيقية: النموذج، نسبة السياق، شريط التقدم، تكلفة الجلسة، حدود المعدل، حالة git، الوقت المستغرق، والمزيد.

### ماذا يعني `5h{1.1h}: 1%`؟

لقد استخدمت 1% من نافذة الـ5 ساعات، و`{1.1h}` عدّ تنازلي مباشر — تُعاد النافذة خلال 1.1 ساعة (`7d{1.1d}`: تُعاد النافذة الأسبوعية خلال 1.1 يوم). يُقرأ من `rate_limits.*.resets_at` في كل عرض. لا يوجد طابع زمني لإعادة الضبط في نسختك؟ يعود المؤشر بسلاسة إلى الصيغة البسيطة `5h: 1%`.

### كيف يُثبَّت؟

انسخ `statusline-bundle.sh` إلى `~/.claude/status-line.sh`، نفّذ `chmod +x`، ثم وجّه `statusLine.command` في `~/.claude/settings.json` إلى ذلك المسار. التعليمات الكاملة في قسمي [البدء السريع](#-بدء-سريع) و[التثبيت](#-التثبيت).

### هل يدعم نماذج نافذة السياق 1M؟

نعم. يكتشف السكريبت `[1m]` في معرّف النموذج و`1M` في اسم العرض ويضبط مقام الشريط إلى 1,000,000 رمز. سترى `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### ما النماذج التي يعمل معها؟

أي نموذج يدعمه Claude Code — Opus 4.7 و Sonnet 4.6 و Haiku 4.5 و Opus 4.6 وغيرها. يقرأ السكريبت `model.display_name` و `model.id` من JSON الوارد عبر stdin؛ ولا يثبّت أسماء النماذج في الشيفرة.

### هل يمكنني تخصيص الألوان أو السمات أو إضافة سمتي الخاصة؟

نعم — بثلاث طرق:

1. اختر إحدى **79 سمة** (158 متغيرًا إجمالًا) — استخدم `~/.claude/status-line.sh use <name>` أو تصفّح [`examples/`](examples/) للسكريبتات المستقلة.
2. ركّب سمتك من **كتل مسماة** — انظر [BLOCKS.md](BLOCKS.md).
3. عدّل ثوابت الألوان ونمط الشريط في `statusline.sh` مباشرة.

### هل سيبطئ Claude Code؟

لا. كل عرض يعمل مرة واحدة عند إعادة رسم الحالة، يحلّل JSON الوارد عبر `jq`، وقد يبحث في آخر سطر من سجل المحادثة، ثم يطبع. العرض النموذجي ≤ 50 مللي ثانية حتى مع متتبع الوقت مفعّلًا.

### هل يعمل بدون `jq`؟

`jq` مطلوب — فهو يحلّل JSON الذي يرسله Claude Code عبر stdin. ثبّته عبر `brew install jq` (macOS) أو `apt install jq` (Debian/Ubuntu) أو `choco install jq` (Windows).

### هل يعمل على Windows؟

نعم، في أي بيئة تشغّل `bash` 4+ و `jq` — Git Bash و WSL و MSYS2 و Cygwin. أما CMD/PowerShell الخالصان فغير مدعومين.

### هل يعمل على Linux / macOS؟

نعم على كليهما. يستخدم macOS أمر `date` بصيغة BSD و Linux بصيغة GNU — ومتتبع الوقت يتعامل مع كليهما بشفافية.

### هل يمكن استخدامه مع واجهة Anthropic API الخام بدل Claude Code؟

جزئيًا. صُمم شريط الحالة لصيغة JSON الواردة من Claude Code عبر stdin. مع API الخام تعود مؤشرات حد المعدل تلقائيًا إلى عرض **إجمالي رموز الجلسة** (`tokens: NNN K`).

### أين يُخزَّن الإعداد؟

`~/.claude/statusline.conf` — ملف صغير يُحمَّل عبر shell ويكتبه مكوّن CLI الخاص بالحزمة (`statusline.sh use <theme>` وغيرها). يبقى عبر إعادة التشغيل.

### كيف أعود إلى شريط حالة Claude Code الافتراضي؟

إما أن تحذف كتلة `statusLine` من `~/.claude/settings.json`، أو تشغّل `~/.claude/status-line.sh reset` وتنتقل إلى سمة `minimal` القريبة جدًا من المظهر الافتراضي.

### هل هو مجاني؟ هل يمكنني استخدامه تجاريًا؟

الاستخدام الشخصي المحلي مجاني — انظر [ترخيص المصدر المتاح](LICENSE). أي إعادة استخدام أو إعادة توزيع أو تفريع أو تضمين في مشروع آخر يتطلب **إذنًا كتابيًا مسبقًا** من المؤلف (Yevgeniy Achin · amazopic@gmail.com). الطلبات المعقولة تُلبّى عادة.

### كيف يعمل متتبع «ساعات العمل البشرية»؟

تقرأ سمة `time` الطوابع الزمنية من سجل المحادثة JSONL وتعرض مدتين: **نشط** (مجموع الفجوات بين الرسائل الأقصر من 5 دقائق) و**حائط** (المدى الكامل من أول رسالة إلى آخرها). عتبة الخمول البالغة 5 دقائق قابلة للتعديل.

## 📝 المؤلف والترخيص

- **المؤلف:** Yevgeniy Achin · [amazopic@gmail.com](mailto:amazopic@gmail.com)
- **الترخيص:** [مصدر متاح](LICENSE) — إعادة الاستخدام فقط بإذن كتابي مسبق
- **GitHub:** <https://github.com/amazopic/claude-code-statusline>

</div>
