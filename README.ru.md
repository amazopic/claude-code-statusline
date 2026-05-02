# 🛰️ Claude Code Status Line

> Красивая, расширяемая статусная строка для Claude Code — контекст, лимиты, стоимость, модель и многое другое — всё в одной цветной линии.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-как-внести-вклад)

**Языки:** [English](README.md) · Русский · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## Зачем?

Стандартная статусная строка Claude Code минималистична. Эта замена превращает её в **полноценный дашборд** для каждой сессии:

- 🔋 Сколько контекста уже потрачено? (плавный бар с шагом 1.25%)
- 💰 Сколько стоит сессия?
- 🚦 Близко ли я к лимитам?
- 🧠 Какой режим мышления / модель сейчас?
- 🌿 На какой git-ветке я работаю?

Всё в **одну строку**, с цветовой кодировкой и иконками, сигнализирующими срочность.

## ✨ Возможности

- 🪐 **Живой бар контекста** — 10 ячеек с подъячеечной точностью (квадрантные или вертикальные дробные глифы)
- 🧠 **Имя модели** — с пометкой `(1M)` для 1M-контекстных моделей
- 💸 **Стоимость сессии** в USD, обновляется при каждом рендере
- ⬆️⬇️ **Счётчики токенов** последнего сообщения (вход / выход)
- 🚦 **Лимиты** — 5h / 7d с предупреждением ⚠️ при > 50%
- 🔄 **Fallback в API-режиме** — если лимиты не передаются, показывает суммарные токены сессии (`tokens: NNN K`) с тонким пробелом как разделителем тысяч
- 🚀 **Умная иконка статуса** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50%
- 🎨 **256-цветный ANSI** — яркие, чёткие цвета на каждый сегмент
- 🧩 **Подключаемые стили баров** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), или свой за 10 строк bash
- ⚡ **Лёгкость** — чистый `bash` + `jq`. Без Node, без Python, без демонов, без телеметрии

## 🚀 Установка

### Вручную (3 шага)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

Затем добавьте в `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<вы>/.claude/statusline.sh"
  }
}
```

Перезапустите Claude Code (или вызовите `/config` для перезагрузки).

### Установка через агента Claude Code (с автоматическим бэкапом)

Хотите, чтобы Claude Code установил всё сам и безопасно? Скопируйте этот промпт:

> «Установи статусную строку из этого репозитория как мою активную статусную строку Claude Code:
> 1. Если файл `~/.claude/statusline.sh` уже существует — забекапь его в
>    `~/.claude/statusline.sh.bak.<YYYYMMDD-HHMMSS>` (если такой бэкап
>    уже есть, используй свободный суффикс `-N`).
> 2. Скопируй `statusline.sh` из репозитория в `~/.claude/statusline.sh`
>    и сделай `chmod +x`.
> 3. Прочитай `~/.claude/settings.json`. Если ключа `statusLine` нет —
>    добавь блок с абсолютным путём к скрипту. Если `statusLine` уже
>    указывает на другой файл — сначала забекапь сам `settings.json`
>    в `.bak.<timestamp>`.
> 4. Сделай smoke-тест:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/statusline.sh`
> 5. Скажи мне перезапустить Claude Code и сообщи, какие бэкапы создал.»

### Требования

- `bash` 4+ (используются 0-индексные массивы — **не запускайте под `zsh`**)
- `jq` для парсинга JSON
- 256-цветный терминал (то есть практически любой современный)

## ⚙️ Конфигурация

Отредактируйте константы в начале `statusline.sh`:

| Переменная / функция | Что управляет |
|---|---|
| `BAR_STYLE` | `"quadrant"` (по умолчанию, шаг 2.5%) или `"vertical"` (шаг 1.25%) |
| `pct_icon()` | Пороги для иконок 🚀 / 🚗 / ⚠️ перед баром |
| `pct_color()` | Цветовые пороги для процента / бара |
| ANSI-константы цветов | Перекрашивание любого сегмента (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Методология плагинов — свой стиль бара за 10 строк

Каждый стиль — это самодостаточная функция `bar_<имя>(pct)`, которая
возвращает строку из ровно 10 видимых ячеек. Добавление выглядит так:

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

Затем зарегистрируйте в диспетчере `bar()`:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

Готово. Контракт функции:

- Вход: целое `pct` `0..100` (уже нормализованное)
- Выход: ровно 10 видимых ячеек
- Округление к **ближайшему** под-шагу (не floor), чтобы бар не «застревал»

PR со своими стилями очень приветствуются.

### Больше промптов-примеров

<details>
<summary>Шаблоны промптов для добавления стилей, сегментов и доработок</summary>

#### Стиль `shaded` (4 уровня: `░ ▒ ▓ █`)

> «Добавь стиль бара `shaded`: 4 уровня на ячейку — `░ ▒ ▓ █`
> (light → medium → dark → full), шаг 2.5%. Округление как в
> `bar_quadrant`. Активация через `BAR_STYLE="shaded"`.»

#### Стиль `dotted` для ограниченных терминалов

> «Добавь стиль `dotted` для терминалов без поддержки блочных символов:
> 10 ячеек, заполненная — `●`, пустая — `·`, без под-уровней (шаг 10%).»

#### Пороговая раскраска бара

> «Внутри `bar()` после генерации строки оберни её в цвет в зависимости
> от процента: < 50% — зелёный (`$GR`), 50–69% — жёлтый (`$Y`),
> ≥ 70% — красный (`$R`). Должно работать для любого `BAR_STYLE`.»

#### Новый сегмент: Python virtualenv

> «Добавь новый сегмент перед `${git_part}`: имя текущего Python
> virtualenv из `$VIRTUAL_ENV` (basename), цвет magenta (`$M`).
> Если переменная пуста — сегмент и его `${SEP}` опускаются.»

#### Подстройка порогов иконки

> «В `pct_icon` добавь четвёртый порог: при ≥ 80% возвращать `🔥`.
> Текущие иконки сохрани, расставь так: < 40% 🚀, 40–59% 🚗,
> 60–79% ⚠️, ≥ 80% 🔥.»

</details>

## 🤝 Как внести вклад

PR очень приветствуются! Особенно:

- 🎨 Новые варианты `bar_<style>` (спарклайны, индикаторы, ASCII-арт…)
- 🧱 Новые сегменты (kubectl-контекст, Python venv, AWS-профиль, батарея, погода…)
- 🌍 Переводы README на новые языки
- 🐛 Исправления для edge cases (огромные транскрипты, экзотические терминалы)

Перед большими изменениями откройте issue для обсуждения.

## 📜 Лицензия

[Source-Available](LICENSE) — делайте что хотите, упоминание авторства приветствуется, но не обязательно.

## ⭐ Понравилось?

Если вы часами смотрите в Claude Code, пусть статусная строка хотя бы радует глаз. **Поставьте репозиторию ⭐**, чтобы другие тоже его нашли!

---

Сделано с ❤️ для сообщества Claude Code.

---

## Автор / Лицензия / Связь

- **Автор:** Yevgeniy Achin
- **Лицензия:** [Source-Available License](LICENSE) — Source-Available — переиспользование только с письменного разрешения автора
- **Связь:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 All-in-one пакет (`statusline-bundle.sh`)

Не хотите возиться с 40+ файлами? Возьмите **один пакетный скрипт** `statusline-bundle.sh` — он содержит все темы, все блоки и CLI-конфигуратор в одном файле.

```bash
cp statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

~/.claude/statusline.sh use cyberpunk            # switch theme
~/.claude/statusline.sh use cyberpunk-compact    # compact variant
~/.claude/statusline.sh custom model context-bar git cost
~/.claude/statusline.sh list                     # list themes
~/.claude/statusline.sh list blocks              # list blocks
~/.claude/statusline.sh preview anime            # preview without saving
~/.claude/statusline.sh show                     # show current
~/.claude/statusline.sh reset                    # reset to default
```

Конфиг сохраняется в `~/.claude/statusline.conf` и переживает рестарты. Один и тот же файл работает как **рендерер** (когда Claude Code передаёт ему JSON через stdin) и как **конфигуратор** (когда вы вызываете его с аргументами).

### Slash-команда `/statusline`

Положите `commands/statusline.md` в `~/.claude/commands/` — внутри Claude Code появится команда `/statusline`:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

После этого в любой сессии Claude Code можно набирать:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Шелл-алиас (опционально)

```bash
alias statusline='~/.claude/statusline.sh'
```

Тогда `statusline cyberpunk` будет работать из любого терминала.

---

## ⚡ Быстрый старт

Самый быстрый путь — пакетный all-in-one скрипт со встроенным CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
~/.claude/statusline.sh use cyberpunk          # или: anime, hacker, minimal, …
```

Затем добавьте в `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<вы>/.claude/statusline.sh" } }
```

Перезапустите Claude Code (или `/config` reload). Готово.

## 🆚 Сравнение со стандартной статусной строкой Claude Code

| Возможность | По умолчанию | Этот проект |
|---|---|---|
| Имя активной модели | ✅ | ✅ (с пометкой `(1M)` для 1M-контекстных) |
| Контекстное окно: % использования | ❌ | ✅ live, точность 1.25 % |
| Прогресс-бар контекста | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Стоимость сессии в USD | ❌ | ✅ обновляется при каждом рендере |
| Счётчики токенов вход/выход | ❌ | ✅ |
| Сумма токенов сессии (fallback в API-режиме) | ❌ | ✅ |
| Индикаторы лимитов 5h / 7d с ⚠️ при > 50 % | ❌ | ✅ |
| Git-ветка + dirty + ahead/behind | ❌ | ✅ |
| Время на задаче (active vs wall) | ❌ | ✅ |
| Уровень thinking / effort | ❌ | ✅ |
| Готовые темы | ❌ | ✅ 20 тем × 2 варианта = **40 вариантов** |
| Сборка из именованных блоков | ❌ | ✅ 18 блоков, см. [BLOCKS.md](BLOCKS.md) |
| Встроенный CLI-конфигуратор | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Slash-команда `/statusline` для Claude Code | ❌ | ✅ опционально, см. [`commands/`](commands/) |
| Зависимости | — | `bash` 4+ и `jq` (без Node, Python, демонов) |

## 💡 Сценарии использования

- **«Сколько контекста (из 1M) я уже потратил?»** — живой % + бар перед каждым промптом.
- **«Во сколько мне обходится текущая сессия?»** — текущая сумма в USD, обновляется на каждом рендере.
- **«Близко ли я к лимитам?»** — индикаторы 5h / 7d с ⚠️ при > 50 %.
- **«На какой я ветке git?»** — git-ветка + dirty + ahead/behind в статусной строке.
- **«Сколько часов реально потратил на эту фичу?»** — трекер времени (`active` vs `wall`).
- **«Хочу яркий терминал.»** — anime, cyberpunk, hacker, retro, weather, ocean, fire и другие темы.
- **«Нужен минимальный ASCII-only вид для записи скринкастов.»** — тема `zen`.
- **«Хочу единый статусбар для всей команды.»** — единый bundle-скрипт + CLI + slash-команда.

## ❓ Часто задаваемые вопросы (FAQ)

### Что такое Claude Code Status Line?

Bash-замена стандартной статусной строки в [Claude Code](https://claude.com/claude-code) (CLI от Anthropic). Превращает нижнюю строку в реальный дашборд: модель, контекст %, прогресс-бар, стоимость сессии, лимиты, git, время и больше.

### Как установить?

Скопировать `statusline-bundle.sh` в `~/.claude/statusline.sh`, сделать `chmod +x`, прописать путь в `~/.claude/settings.json` → `statusLine.command`. Полные инструкции в разделах [Быстрый старт](#-быстрый-старт) и Установка.

### Поддерживает ли 1 M контекст?

Да. Скрипт определяет `[1m]` в model id и `1M` в display name, выставляет знаменатель шкалы в 1 000 000 токенов. Видите `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### С какими моделями работает?

С любой моделью, которую поддерживает Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 и т.д. Скрипт читает `model.display_name` и `model.id` из JSON, не хардкодит имена.

### Можно ли кастомизировать темы и цвета?

Да, тремя способами: (1) выбрать из **40 готовых вариантов** в [`examples/`](examples/), (2) собрать свою из именованных блоков — см. [BLOCKS.md](BLOCKS.md), (3) править цветовые константы в `statusline.sh` напрямую.

### Замедлит ли Claude Code?

Нет. Каждый рендер парсит JSON через `jq`, опционально `grep`-ает последнюю строку транскрипта, выводит. Типичное время — ≤ 50 мс даже с включённым трекером времени.

### Работает без `jq`?

`jq` обязателен — он парсит JSON, который Claude Code передаёт через stdin. Установка: `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu).

### Работает на Windows / macOS / Linux?

Да на всех. На Windows — через Git Bash, WSL, MSYS2 или Cygwin. Чистый CMD/PowerShell не поддерживается.

### Можно использовать с Anthropic API напрямую (а не через Claude Code)?

Частично. Статусная строка спроектирована под формат stdin JSON от Claude Code. Для прямого API индикаторы лимитов автоматически переключаются на показ суммарных токенов сессии (`tokens: NNN K`).

### Где хранится конфигурация?

`~/.claude/statusline.conf` — небольшой shell-source файл, который пишет CLI-конфигуратор bundle-скрипта (`statusline.sh use <theme>` и т.д.). Переживает рестарты.

### Бесплатно ли? Можно ли коммерчески?

Личное локальное использование — бесплатно (см. [Source-Available License](LICENSE)). Любое переиспользование, форк, включение в другой проект — требует **письменного разрешения** автора (Yevgeniy Achin · amazopic@gmail.com). Разумные просьбы обычно одобряются.

### Как откатиться к стандартной статусной строке Claude Code?

Удалите блок `statusLine` из `~/.claude/settings.json` или выполните `~/.claude/statusline.sh reset`.

## 🏷️ Рекомендуемые GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
