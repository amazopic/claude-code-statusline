# 🛰️ Claude Code Status Line — 79 тем, налаштовувані блоки, CLI

> Гарний, легко розширюваний статусний рядок для Claude Code — контекст, ліміти, вартість, модель та інше — все в одному кольоровому рядку.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-як-зробити-внесок)

**Мови:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · Українська · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

### ⏳ Reset countdown — плануй роботу навколо своїх лімітів

**Передбачуваність роботи — розподіляй свою продуктивність.** Передбачуваність за задумом: кожен лічильник веде зворотний відлік до свого скидання, тож ти задаєш темп роботі, а не врізаєшся в стіну.

Лічильники 5h / 7d містять живий зворотний відлік до моменту, коли скидається кожне вікно: `5h{1.1h}: 1%` — 5-годинне вікно скидається через 1.1 години; `7d{1.1d}: 0%` — тижневе вікно скидається через 1.1 дня. Ти завжди знаєш, коли повернешся до 0%, тож можеш планувати важку роботу одразу після скидання й розподіляти свою продуктивність замість того, щоб посеред задачі впертися в ліміт. Працює на основі `rate_limits.*.resets_at`, який надсилає Claude Code; якщо твоя збірка не надсилає мітки часу скидання, лічильники плавно повертаються до простого вигляду `5h: 1%`.

## 🎨 158 готових варіанти — обирайте і застосовуйте

79 тем × 2 варіанти (`detailed` + `-compact`). Застосовуйте через `~/.claude/status-line.sh use <name>`.

### 🔝 Топ-10 — найпопулярніші, крос-культурні
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 Класика (19): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

### 🚗 Авто-бренди (15)
- 🇪🇺 Європа: `porsche` · `mercedes` · `bmw` · `volvo`
- 🇺🇸 Америка: `ford` · `chevy` · `jeep` · `cadillac`
- 🇯🇵 Японія: `toyota` · `honda` · `nissan`
- 🇰🇷 Корея: `hyundai` · `kia`
- 🇨🇳 Китай: `byd` · `nio` · `geely`

### 🔬 Великі вчені (8): `newton` · `curie` · `darwin` · `hawking` · `galileo` · `feynman` · `turing` · `davinci`

### ✨ Аніме (3 + топ): `onepiece` · `ghibli`

### 🦸 Marvel (8 + топ): `hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Операційні системи (10): `macos` · `windows` · `linux` · `ubuntu` · `arch` · `debian` · `fedora` · `kali` · `mint` · `nixos`

```bash
~/.claude/status-line.sh use cyberpunk        # detailed
~/.claude/status-line.sh use macos-compact    # compact
```


### 🕊 Світові релігії (топ-7): `christianity` · `islam` · `hinduism` · `buddhism` · `judaism` · `sikhism` · `shinto`

## Навіщо?

Стандартний статусний рядок Claude Code — мінімалістичний. Ця заміна перетворює його на **повноцінний дашборд** для кожної сесії:

- 🔋 Скільки контексту я витратив? (плавний бар із кроком 1.25%)
- 💰 Скільки коштує сесія?
- 🚦 Чи близько я до лімітів?
- 🧠 Який рівень мислення / модель зараз активні?
- 🌿 На якій git-гілці я працюю?

Усе в **одному рядку**, з кольоровим кодуванням та розумними іконками, що сигналізують терміновість.

## ✨ Можливості

- 🪐 **Живий бар контексту** — 10 комірок із підкомірковою точністю (квадрантні або вертикальні дробові гліфи)
- 🧠 **Назва моделі** — з позначкою `(1M)` для 1M-контекстних моделей
- 💸 **Вартість сесії** в USD, оновлюється на кожному рендері
- ⬆️⬇️ **Лічильники токенів** останнього повідомлення (вхід / вихід)
- 🚦 **Ліміти** — 5h / 7d з попередженням ⚠️ при > 50%
- 🔄 **Fallback в режимі API** — якщо ліміти не передаються, показує сумарні токени сесії (`tokens: NNN K`) із тонким пробілом як роздільником тисяч
- 🚀 **Розумна іконка статусу** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50%
- 🎨 **256-кольоровий ANSI** — яскраві, чіткі кольори для кожного сегмента
- 🧩 **Підключні стилі барів** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), або власний за 10 рядків bash
- ⚡ **Легкий** — чистий `bash` + `jq`. Без Node, без Python, без демонів, без телеметрії

> 💡 **Порада — Контроль контексту**: чим більше заповнено вікно контексту, тим **менш ефективною** стає розмова з Claude — і тим **швидше згорають** ліміти 5г / 7д. Своєчасне очищення або `/compact` при перетині **60%** = ефективна робота.

## 🚀 Установка

### ⚡ або vibe-chill метод · хай Claude зробить сам

Навіщо самому, коли є Claude Code? Встав один промпт у сесію Claude Code — Claude зробить усе покроково і запитає перед кожною командою.

```text
Встанови claude-code-statusline від amazopic. Спочатку перевір що встановлено jq (запусти `which jq`) — якщо немає, постав під поточну систему: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Потім прочитай ~/.claude/settings.json — якщо там statusLine.command вказує на існуючий файл (наприклад ~/.claude/status-line.sh або інший шлях), зроби резервну копію того файлу додавши .bak (перезапиши існуючий .bak). Також якщо ~/.claude/status-line.sh вже є — забекап його так само. Потім склонуй github.com/amazopic/claude-code-statusline, скопіюй statusline-bundle.sh у ~/.claude/status-line.sh і зроби виконуваним, також скопіюй commands/statusline.md у ~/.claude/commands/. Онови ~/.claude/settings.json щоб statusLine = { type: "command", command: "<абсолютний шлях до ~/.claude/status-line.sh>" }. Наприкінці запусти ~/.claude/status-line.sh use developer для перевірки теми developer і попроси перезапустити Claude Code.
```

> Просто кажи `y` (так) на кожен запит дозволу. Готово.


### Вручну (3 кроки)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Потім додайте до `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<ви>/.claude/status-line.sh"
  }
}
```

Перезапустіть Claude Code (або викличте `/config` для перезавантаження).

### Установка через агента Claude Code (з автоматичним резервним копіюванням)

Хочете, щоб Claude Code установив усе сам та безпечно? Скопіюйте цей промпт:

> «Установи статусний рядок із цього репозиторію як мій активний:
> 1. Якщо файл `~/.claude/status-line.sh` вже існує — зроби резервну
>    копію в `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (якщо така
>    копія вже існує — використовуй вільний суфікс `-N`).
> 2. Скопіюй `statusline.sh` із репозиторію в `~/.claude/status-line.sh`
>    і зроби `chmod +x`.
> 3. Прочитай `~/.claude/settings.json`. Якщо ключа `statusLine` немає —
>    додай блок з абсолютним шляхом до скрипта. Якщо `statusLine` уже
>    вказує на інший файл — спочатку зроби резервну копію самого
>    `settings.json` у `.bak.<timestamp>`.
> 4. Зроби smoke-тест:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Скажи мені перезапустити Claude Code та повідом, які копії створив.»

### Оновлення до останньої версії

```bash
~/.claude/status-line.sh update
```

Завантажує останню версію bundle з GitHub, робить резервну копію з
міткою часу (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) і
зберігає ваше налаштування теми (`~/.claude/statusline.conf`). Після
оновлення перезапустіть Claude Code.

Перевірити встановлену версію: `~/.claude/status-line.sh version`.

### Вимоги

- `bash` 4+ (скрипт використовує 0-індексні масиви — **не запускайте під `zsh`**)
- `jq` для парсингу JSON
- 256-кольоровий термінал (тобто практично будь-який сучасний)

## ⚙️ Конфігурація

Відредагуйте константи на початку `statusline.sh`:

| Змінна / функція | Що керує |
|---|---|
| `BAR_STYLE` | `"quadrant"` (за замовчуванням, крок 2.5%) або `"vertical"` (крок 1.25%) |
| `pct_icon()` | Пороги для іконок 🚀 / 🚗 / ⚠️ перед баром |
| `pct_color()` | Кольорові пороги для відсотка / бара |
| ANSI-константи кольорів | Перефарбування будь-якого сегмента (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Методологія плагінів — власний стиль бара за 10 рядків

Кожен стиль — це самодостатня функція `bar_<ім'я>(pct)`, яка повертає
рядок із рівно 10 видимих комірок. Додавання:

```bash
bar_dotted() {
  local pct=$1
  local cells=$(( (pct + 5) / 10 ))
  local s="" i
  for (( i=0; i<cells;     i++ )); do s+="●"; done
  for (( i=0; i<10-cells;  i++ )); do s+="·"; done
  printf '%s' "$s"
}
```

Потім зареєструйте в диспетчері `bar()`:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

Готово. Контракт функції:

- Вхід: ціле `pct` `0..100` (вже нормалізоване)
- Вихід: рівно 10 видимих комірок
- Округлення до **найближчого** під-кроку (не floor), щоб бар не «застрягав»

PR з власними стилями дуже вітаються.

### Більше прикладів промптів

<details>
<summary>Шаблони промптів для додавання стилів, сегментів та налаштувань</summary>

#### Стиль `shaded` (4 рівні: `░ ▒ ▓ █`)

> «Додай стиль бара `shaded`: 4 рівні на комірку — `░ ▒ ▓ █`
> (light → medium → dark → full), крок 2.5%. Округлення як у
> `bar_quadrant`. Активація через `BAR_STYLE="shaded"`.»

#### Стиль `dotted` для обмежених терміналів

> «Додай стиль `dotted` для терміналів без підтримки блочних символів:
> 10 комірок, заповнена — `●`, порожня — `·`, без під-рівнів (крок 10%).»

#### Порогова розмальовка бара

> «У `bar()` після генерації рядка обгорни його в колір залежно від
> відсотка: < 50% — зелений (`$GR`), 50–69% — жовтий (`$Y`),
> ≥ 70% — червоний (`$R`). Має працювати для будь-якого `BAR_STYLE`.»

#### Новий сегмент: Python virtualenv

> «Додай новий сегмент перед `${git_part}`: ім'я поточного Python
> virtualenv з `$VIRTUAL_ENV` (basename), колір magenta (`$M`).
> Якщо змінна порожня — сегмент та його `${SEP}` опускаються.»

#### Налаштування порогів іконки

> «У `pct_icon` додай четвертий поріг: при ≥ 80% повертати `🔥`.
> Поточні іконки збережи, розташуй так: < 40% 🚀, 40–59% 🚗,
> 60–79% ⚠️, ≥ 80% 🔥.»

</details>

## 🤝 Як зробити внесок

PR дуже вітаються! Особливо:

- 🎨 Нові варіанти `bar_<style>` (спарклайни, індикатори, ASCII-арт…)
- 🧱 Нові сегменти (kubectl-контекст, Python venv, AWS-профіль, батарея, погода…)
- 🌍 Переклади README на нові мови
- 🐛 Виправлення для edge cases (величезні транскрипти, екзотичні термінали)

Перед великими змінами відкрийте issue для обговорення.

## 📜 Ліцензія

[Source-Available](LICENSE) — робіть що хочете, згадка авторства вітається, але не обов'язкова.

## ⭐ Сподобалося?

Якщо ви годинами дивитесь у Claude Code, нехай статусний рядок хоча б тішить око. **Поставте репозиторію ⭐**, щоб інші теж його знайшли!

---

Зроблено з ❤️ для спільноти Claude Code.

---

## Автор / Ліцензія / Зв'язок

- **Автор:** Yevgeniy Achin
- **Ліцензія:** [Source-Available License](LICENSE) — Source-Available — використання лише з письмового дозволу автора
- **Зв'язок:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 All-in-one пакет (`statusline-bundle.sh`)

Не хочете працювати з 40+ файлами? Візьміть **один пакетний скрипт** `statusline-bundle.sh` — він містить усі теми, всі блоки та CLI-конфігуратор в одному файлі.

```bash
cp statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh

~/.claude/status-line.sh use cyberpunk            # switch theme
~/.claude/status-line.sh use cyberpunk-compact    # compact variant
~/.claude/status-line.sh custom model context-bar git cost
~/.claude/status-line.sh list                     # list themes
~/.claude/status-line.sh list blocks              # list blocks
~/.claude/status-line.sh preview anime            # preview without saving
~/.claude/status-line.sh show                     # show current
~/.claude/status-line.sh reset                    # reset to default
```

Конфіг зберігається в `~/.claude/statusline.conf` і переживає рестарти. Той самий файл працює і як **рендерер** (коли Claude Code передає йому JSON через stdin), і як **конфігуратор** (коли ви викликаєте його з аргументами).

### Slash-команда `/statusline`

Покладіть `commands/statusline.md` у `~/.claude/commands/` — у Claude Code з'явиться команда `/statusline`:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Після цього в будь-якій сесії Claude Code можна набирати:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Shell-аліас (опціонально)

```bash
alias statusline='~/.claude/status-line.sh'
```

Тоді `statusline cyberpunk` працюватиме з будь-якого терміналу.

---

## ⚡ Швидкий старт

Найшвидший шлях — пакетний all-in-one скрипт із вбудованим CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # або: anime, hacker, minimal, …
```

Потім додайте до `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<ви>/.claude/status-line.sh" } }
```

Перезапустіть Claude Code (або `/config` reload). Готово.

## 🆚 Порівняння зі стандартним статусним рядком Claude Code

| Можливість | За замовчуванням | Цей проєкт |
|---|---|---|
| Ім'я активної моделі | ✅ | ✅ (з позначкою `(1M)` для 1M-контекстних) |
| Контекстне вікно: % використання | ❌ | ✅ live, точність 1.25 % |
| Прогрес-бар контексту | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Вартість сесії в USD | ❌ | ✅ оновлюється на кожному рендері |
| Лічильники токенів вхід/вихід | ❌ | ✅ |
| Сума токенів сесії (fallback в API-режимі) | ❌ | ✅ |
| Індикатори лімітів 5h / 7d з ⚠️ при > 50 % | ❌ | ✅ |
| Зворотний відлік до скидання в лічильниках лімітів (`5h{1.1h}`) | ❌ | ✅ |
| Git-гілка + dirty + ahead/behind | ❌ | ✅ |
| Час на задачі (active vs wall) | ❌ | ✅ |
| Рівень thinking / effort | ❌ | ✅ |
| Готові теми | ❌ | ✅ 79 тем × 2 варіанти = **158 варіантів** |
| Збірка з іменованих блоків | ❌ | ✅ 19 блоків, див. [BLOCKS.md](BLOCKS.md) |
| Вбудований CLI-конфігуратор | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Slash-команда `/statusline` | ❌ | ✅ опціонально, див. [`commands/`](commands/) |
| Залежності | — | `bash` 4+ і `jq` (без Node, Python, демонів) |

## 💡 Сценарії використання

- **«Скільки контексту (з 1M) я вже витратив?»** — живий % + бар перед кожним промптом.
- **«Скільки коштує поточна сесія?»** — поточна сума в USD, оновлюється на кожному рендері.
- **«Чи близько я до лімітів?»** — індикатори 5h / 7d з ⚠️ при > 50 %.
- **«На якій я git-гілці?»** — git-гілка + dirty + ahead/behind у статусному рядку.
- **«Скільки годин реально витратив на цю фічу?»** — трекер часу (`active` vs `wall`).
- **«Хочу яскравий термінал.»** — anime, cyberpunk, hacker, retro, weather, ocean, fire та інші теми.
- **«Потрібен мінімальний ASCII-only вигляд для запису скрінкастів.»** — тема `zen`.
- **«Хочу єдиний статусбар для всієї команди.»** — єдиний bundle-скрипт + CLI + slash-команда.

## ❓ Часті запитання (FAQ)

### Що таке Claude Code Status Line?

Bash-заміна стандартного статусного рядка в [Claude Code](https://claude.com/claude-code) (CLI від Anthropic). Перетворює нижній рядок на повноцінний дашборд: модель, контекст %, прогрес-бар, вартість сесії, ліміти, git, час та інше.

### Що означає `5h{1.1h}: 1%`?

Ти використав 1% від 5-годинного вікна, а `{1.1h}` — це живий зворотний відлік: вікно скидається через 1.1 години (`7d{1.1d}`: тижневе вікно скидається через 1.1 дня). Читається з `rate_limits.*.resets_at` на кожному рендері. Немає мітки часу скидання у твоїй збірці? Лічильник повертається до простого вигляду `5h: 1%`.

### Як встановити?

Скопіювати `statusline-bundle.sh` у `~/.claude/status-line.sh`, зробити `chmod +x`, прописати шлях у `~/.claude/settings.json` → `statusLine.command`. Повні інструкції в розділах [Швидкий старт](#-швидкий-старт) і Установка.

### Чи підтримує 1 M контекст?

Так. Скрипт визначає `[1m]` в model id і `1M` в display name, виставляє знаменник шкали 1 000 000 токенів.

### З якими моделями працює?

З будь-якою, що підтримує Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 тощо. Скрипт читає `model.display_name` та `model.id` з JSON, не хардкодить імена.

### Чи можна налаштувати теми та кольори?

Так, трьома способами: (1) вибрати з **158 готових варіантів** у [`examples/`](examples/), (2) зібрати свій з іменованих блоків — див. [BLOCKS.md](BLOCKS.md), (3) редагувати кольорові константи в `statusline.sh` напряму.

### Чи сповільнить Claude Code?

Ні. Кожен рендер ≤ 50 мс навіть з увімкненим трекером часу.

### Чи потрібен `jq`?

Так, для парсингу JSON. `brew install jq` / `apt install jq`.

### Працює на Windows / macOS / Linux?

Так на всіх. На Windows — через Git Bash, WSL, MSYS2 або Cygwin.

### Чи можна використовувати з Anthropic API напряму?

Частково. Для прямого API індикатори лімітів автоматично перемикаються на показ сумарних токенів сесії (`tokens: NNN K`).

### Де зберігається конфігурація?

`~/.claude/statusline.conf` — невеликий shell-source файл. Переживає рестарти.

### Чи безкоштовно? Чи можна комерційно?

Особисте використання — безкоштовно (див. [Source-Available License](LICENSE)). Будь-яке переиспользование вимагає **письмового дозволу** автора (amazopic@gmail.com). Розумні прохання зазвичай задовольняються.

### Як повернути стандартний статусний рядок Claude Code?

Видалити блок `statusLine` з `~/.claude/settings.json` або виконати `~/.claude/status-line.sh reset`.

## 🏷️ Рекомендовані GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
