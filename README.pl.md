# 🛰️ Claude Code Status Line — 79 motywów, konfigurowalne bloki, CLI

> Zamiennik typu drop-in dla domyślnego paska stanu **Claude Code**: na żywo zużycie **okna kontekstu** z płynnym paskiem postępu, **koszt sesji** w USD, ostrzeżenia o **limitach 5h / 7d**, **gałąź git** z licznikami dirty / ahead / behind, **śledzenie czasu pracy** oraz aktywna **nazwa modelu** (ze wskaźnikiem `(1M)` dla wariantów z kontekstem 1M) — wszystko w jednej kolorowej linii Bash. Dostarczany z **79 gotowymi motywami** — najlepsze wybory (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), klasyki (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), marki samochodowe (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), kolejni naukowcy (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), kolejne anime (onepiece, ghibli), kolejni bohaterowie Marvela (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), motywy systemów operacyjnych (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos) oraz religie świata (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) — a do tego **biblioteka 18 bloków**, z których złożysz własny pasek. Zawiera kompleksowy konfigurator CLI oraz komendę slash `/statusline` dla Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-gotowych-wariantów--wybierz-i-działaj)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#wymagania)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · Polski

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **Wskazówka pro — kontrola kontekstu**: im pełniejsze jest okno kontekstu, tym **mniej skuteczna** staje się twoja rozmowa z Claude — i tym **szybciej** wyczerpujesz swoje limity 5h/7d. Czyść kontekst lub używaj `/compact` zawsze, gdy przekroczysz **60%**, aby pracować efektywnie.

### ⏳ Odliczanie do resetu — planuj wokół swoich limitów

Mierniki 5h / 7d zawierają odliczanie na żywo do momentu, w którym każde okno się zresetuje: `5h{1.1h}: 1%` — okno 5-godzinne zresetuje się za 1,1 godziny; `7d{1.1d}: 0%` — okno tygodniowe zresetuje się za 1,1 dnia. Zawsze wiesz, kiedy wrócisz do 0%, więc możesz zaplanować ciężką pracę tuż po resecie i rozłożyć swoją produktywność, zamiast uderzać w limit w połowie zadania. Działa dzięki `rate_limits.*.resets_at` wysyłanemu przez Claude Code; jeśli twoja kompilacja nie wysyła znaczników czasu resetu, mierniki płynnie przechodzą na zwykłe `5h: 1%`.

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**Przewidywalność z założenia** — każdy miernik odlicza do swojego resetu, więc dawkujesz pracę zamiast uderzać w ścianę.

## ⚡ Szybki start

Najszybsza droga — dołączony, kompleksowy skrypt z wbudowanym CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

Następnie dodaj do `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Zrestartuj Claude Code (lub wykonaj `/config` reload). Gotowe.

### lub metoda na luzie · niech zrobi to Claude

Po co dotykać terminala, skoro masz Claude Code? Wklej ten pojedynczy prompt do swojej sesji Claude Code — Claude wykona każdy krok i zapyta przed każdą komendą.

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>" }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> Po prostu odpowiedz `y` (tak) przy każdym pytaniu o uprawnienia. Gotowe.


## Po co własny pasek stanu / pasek statusu dla Claude Code?

Domyślny pasek stanu Claude Code jest ubogi. Ten zamiennik typu drop-in zamienia dolny pasek statusu w **pulpit dostępny na pierwszy rzut oka** dla każdej sesji:

- 🔋 Ile kontekstu już zużyłem? (płynne paski ułamkowe o kroku 1,25%)
- 💰 Ile kosztuje mnie ta sesja?
- 🚦 Jak blisko jestem swoich limitów?
- 🧠 Na jakim poziomie myślenia / modelu jestem?
- 🌿 Na jakiej gałęzi git jestem?

Wszystko w **jednej linii**, z kodowaniem kolorami i inteligentnymi ikonami sygnalizującymi pilność.

## ✨ Funkcje

- 🪐 **Pasek kontekstu na żywo** — 10-komórkowy pasek postępu z precyzją podkomórkową (glify ćwiartkowe lub pionowe ułamkowe)
- 🧠 **Nazwa modelu** — ze wskaźnikiem `(1M)` dla wariantów z kontekstem 1M
- 💸 **Koszt sesji** w USD, aktualizowany przy każdym renderze
- ⬆️⬇️ **Liczniki tokenów na wiadomość** (wejście / wyjście)
- 🚦 **Limity użycia** — 5h / 7d z ostrzeżeniem ⚠️ przy > 50%
- 🔄 **Awaryjny tryb API** — gdy limity nie są przekazywane, pokazuje całkowitą liczbę tokenów sesji (`tokens: NNN K`) z cienkimi spacjami jako separatorami tysięcy
- 🚀 **Inteligentna ikona statusu** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% zapełnienia kontekstu
- 🎨 **256-kolorowe ANSI** — jasny, wyraźny kolor dla każdego segmentu
- 🧩 **Wymienne style paska** — wybierz `quadrant` (▖▄▙█) lub `vertical` (▏▎▍▌▋▊▉█), albo stwórz własny w 10 liniach bash
- ⚡ **Lekki** — czysty `bash` + `jq`. Bez Node, bez Pythona, bez demona, bez telemetrii

## 🎨 158 gotowych wariantów — wybierz i działaj

Każdy motyw jest dostarczany w **dwóch wariantach**:

- **Detailed** — pełen zestaw funkcji (model, pasek kontekstu, koszt, tokeny, git, czas, ikona nastroju, …)
- **Compact** — tylko `model · context % + bar · branch`

Zastosuj przez `~/.claude/status-line.sh use <name>` (dodaj `-compact` dla wariantu compact).

### 🔝 Najlepsze wybory (10) — najczęściej proszone, ponadkulturowe

| Motyw | Klimat |
|---|---|
| `cyberpunk`  | neonowa dystopia · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | fosforowo-zielony terminal Matrix · `[SYS] :: ROOT@matrix#` |
| `dragonball` | skalowanie Goku: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | pomarańcz liścia Konohy · miernik czakry · 🌀 rasengan |
| `pokemon`    | żółć Pikachu + czerwień pokeballa · pasek HP |
| `ironman`    | 🦾 czerwień Starka + złoto reaktora łukowego |
| `spiderman`  | 🕷 czerwień + błękit pajęczaka · z wielkim kontekstem wiąże się wielki koszt |
| `einstein`   | tablicowe zielenie · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ elektryczny fiolet + błyskawicowa żółć · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + żółć Modeny |

### 🛠 Praktyczne / Klasyczne (19 motywów)

| Motyw | Plik / Zastosuj |
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

> Uwaga: `cyberpunk` i `hacker` znajdują się w sekcji **Najlepsze wybory** powyżej — są
> również w folderze `examples/`, jeśli chcesz instalację pojedynczego motywu.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Marki samochodowe (15 kolejnych, najlepsze wybory zawierają `ferrari`)

Dostarczane wyłącznie w `statusline-bundle.sh` — wybierz dowolny przez `~/.claude/status-line.sh use <name>`.

| Region | Motywy |
|---|---|
| 🇪🇺 Europa  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 Ameryka | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japonia | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 Chiny   | `byd` · `nio` · `geely` |

### 🔬 Wielcy naukowcy (8 kolejnych, najlepsze wybory zawierają `einstein` i `tesla`)

| Motyw | Klimat |
|---|---|
| `newton`   | atrament na pergaminie, `🍎`, `F=ma` |
| `curie`    | radowa zieleń, `☢`, miernik okresu połowicznego rozpadu |
| `darwin`   | przyrodnicza zieleń, `🐢`, HMS Beagle |
| `hawking`  | fiolet głębokiego kosmosu, `🌌`, `t → ∞` |
| `galileo`  | słoneczne złoto, `🔭`, *eppur si muove* |
| `feynman`  | kreda na zielonym, `〰`, `ψ → ψ'` |
| `turing`   | terminalowa zieleń, `Ⓣ`, pasek zatrzymania `1/0` |
| `davinci`  | sepiowy kodeks, `✎`, *Vitruvian* |

### ✨ Anime (3 kolejne, najlepsze wybory zawierają `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 Superbohaterowie Marvela (8 kolejnych, najlepsze wybory zawierają `ironman` i `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Systemy operacyjne (10 motywów)

| Motyw | Klimat |
|---|---|
| `macos`   | 🍎 sześciokolorowa tęcza Apple na chromowej szarości |
| `windows` | ⊞ czterokolorowy kafelek Fluent + cyjan WINDOWS 11 |
| `linux`   | 🐧 czarny Tux + pomarańczowy dziób |
| `ubuntu`  | ⊕ krąg przyjaciół — pomarańcz + bakłażanowy fiolet |
| `arch`    | ▲ pacman cyan · btw, I use arch |
| `debian`  | 🌀 czerwony zawijas · stable / sid / testing |
| `fedora`  | 🎩 błękit kapelusza Fedora · freedom + features |
| `kali`    | 🐉 błękit Kali + offsec red · tryb pwn |
| `mint`    | 🌿 cynamonowo-miętowa zieleń · najprzyjaźniejsza powłoka |
| `nixos`   | ❄ niebieski płatek śniegu Nix · deklaratywny, odtwarzalny |

### 🕊 Religie świata (top 7 wg liczby wyznawców)

| Motyw | Klimat |
|---|---|
| `christianity` | ✝ winna czerwień + maryjny błękit + papieskie złoto · miernik wiary, jałmużna € |
| `islam`        | ☪ islamska zieleń + biel + złota kaligrafia · taqwa, sadaqah ﷼ |
| `hinduism`     | 🕉 szafran + aksamitka + cynober · dharma, seva ₹ |
| `buddhism`     | ☸ mnisi szafran + złoto + bordo · karma, dāna ฿ |
| `judaism`      | ✡ błękit tałesu + biel + złoto menory · micwa, cedaka ₪ |
| `sikhism`      | ☬ głęboki błękit Chalsy + szafran + biel · sewa, daswandh |
| `shinto`       | ⛩ cynobrowa torii + świątynna biel + złoto · kami, saisen ¥ |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

**Najpierw przejrzyj je wszystkie w terminalu** — każdy wariant ma
wstępnie wyrenderowany podgląd w [`screenshots/`](screenshots/):

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (158 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Zobacz [`examples/README.md`](examples/README.md) dla pełnej tabeli z
opisami oraz [`screenshots/README.md`](screenshots/README.md), aby zobaczyć,
jak generowane są podglądy.

## 🧱 Zbuduj własny z bloków

Nie chcesz korzystać z gotowego presetu? Skomponuj własny pasek stanu z biblioteki
nazwanych bloków — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

Zobacz [**BLOCKS.md**](BLOCKS.md), aby poznać:

- **katalog bloków** (każdy to gotowy do skopiowania fragment bash)
- **pakiety stylów** (palety kolorów i separatory z `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- **3-krokowy przepis** na zbudowanie własnej linii: wybierz styl → wypisz bloki
  → wklej

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 Pakiet wszystko-w-jednym (`statusline-bundle.sh`)

Jeśli nie chcesz zarządzać 40+ plikami, weź **pojedynczy spakowany
skrypt** [`statusline-bundle.sh`](statusline-bundle.sh) — zawiera
każdy motyw + każdy blok + konfigurator CLI w jednym pliku.

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

Konfiguracja jest zapisywana w `~/.claude/statusline.conf` i utrzymuje się
między restartami. Ten sam plik pełni rolę zarówno **renderera** (gdy
wywołuje go Claude Code z JSON na stdin), jak i **konfiguratora**
(gdy wywołujesz go z argumentami).

### Komenda slash `/statusline`

Umieść [`commands/statusline.md`](commands/statusline.md) w
`~/.claude/commands/`, aby włączyć komendę slash `/statusline` wewnątrz
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Następnie w dowolnej sesji Claude Code możesz wpisać:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude uruchomi za ciebie CLI pakietu, zgłosi wynik i przypomni
ci o przeładowaniu.

### Opcjonalny alias powłoki

```bash
alias statusline='~/.claude/status-line.sh'
```

Wtedy `statusline cyberpunk` działa z dowolnego terminala.

## 🚀 Instalacja

### Instalacja ręczna (3 kroki)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Następnie dodaj do `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Zrestartuj Claude Code (lub wykonaj `/config` reload).

### Instalacja przez agenta Claude Code (z automatycznym backupem)

Chcesz, aby Claude Code zainstalował to dla ciebie bezpiecznie? Wklej ten prompt:

> „Zainstaluj pasek stanu z tego repozytorium jako mój pasek stanu Claude Code:
> 1. Jeśli `~/.claude/status-line.sh` już istnieje, zrób jego kopię zapasową w
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (wybierz wolny sufiks `-N`,
>    jeśli kopia o tej nazwie już istnieje).
> 2. Skopiuj `statusline.sh` z tego repozytorium do `~/.claude/status-line.sh` i wykonaj `chmod +x`.
> 3. Odczytaj `~/.claude/settings.json`. Jeśli nie ma klucza `statusLine`, dodaj
>    blok `statusLine` wskazujący na bezwzględną ścieżkę skryptu. Jeśli
>    `statusLine` już istnieje i wskazuje gdzie indziej, najpierw zrób kopię
>    zapasową `settings.json` do `.bak.<timestamp>`.
> 4. Wykonaj test dymny skryptu:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Powiedz mi, żebym zrestartował Claude Code, i zgłoś utworzone kopie zapasowe.”

### Aktualizacja do najnowszej wersji

```bash
~/.claude/status-line.sh update
```

Pobiera najnowszy pakiet z GitHuba, tworzy kopię zapasową ze znacznikiem
czasu (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) i zachowuje twoją
konfigurację motywu (`~/.claude/statusline.conf`). Po tym zrestartuj Claude Code.

Sprawdź, co masz zainstalowane: `~/.claude/status-line.sh version`.

### Wymagania

- `bash` 4+ (skrypt używa tablic indeksowanych od 0 — **nie uruchamiaj pod `zsh`**)
- `jq` do parsowania JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (potrzebny tylko do `statusline update`; preinstalowany w większości systemów)
- Terminal 256-kolorowy (w zasadzie każdy nowoczesny)

## ⚙️ Konfiguracja

Edytuj stałe na początku `statusline.sh`:

| Zmienna / funkcja | Co kontroluje |
|---|---|
| `BAR_STYLE` | `"quadrant"` (domyślny, krok 2,5%) lub `"vertical"` (krok 1,25%) |
| `pct_icon()` | Progi dla ikon 🚀 / 🚗 / ⚠️ przed paskiem |
| `pct_color()` | Progi kolorów dla procentu / paska |
| Stałe kolorów ANSI | Przekoloruj dowolny segment (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 Porównanie z domyślnym paskiem stanu Claude Code

| Możliwość | Domyślny | Ten projekt |
|---|---|---|
| Aktywna **nazwa modelu** | ✅ | ✅ (z flagą `(1M)` dla wariantów z kontekstem 1M) |
| **Okno kontekstu** % użyte | ❌ | ✅ na żywo, precyzja 1,25% |
| **Pasek postępu** kontekstu | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **Koszt sesji** w USD | ❌ | ✅ aktualizowany przy każdym renderze |
| **Liczniki tokenów** wejścia/wyjścia na wiadomość | ❌ | ✅ |
| **Całkowita liczba tokenów sesji** (awaryjny tryb API) | ❌ | ✅ |
| Wskaźniki **limitów 5h / 7d** z ⚠️ przy > 50% | ❌ | ✅ |
| Odliczanie do resetu w miernikach limitów (`5h{1.1h}`) | ❌ | ✅ |
| **Gałąź git** + dirty + ahead/behind | ❌ | ✅ |
| **Czas pracy** (aktywny vs zegar ścienny) | ❌ | ✅ |
| Wyświetlanie poziomu **myślenia / wysiłku** | ❌ | ✅ |
| Gotowe presety motywów | ❌ | ✅ 79 motywów × 2 warianty = **158 gotowych** |
| Komponowanie z nazwanych bloków | ❌ | ✅ 18 bloków, zobacz [BLOCKS.md](BLOCKS.md) |
| Wbudowany konfigurator CLI | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Komenda slash `/statusline` w Claude Code | ❌ | ✅ opcjonalna, zobacz [`commands/`](commands/) |
| Zależności zewnętrzne | — | `bash` 4+ i `jq` (bez Node, bez Pythona, bez demona) |
| Licencja | — | Source-Available (ponowne użycie za zgodą) |

## 💡 Przypadki użycia

Konkretne scenariusze, w których ten projekt sam na siebie zarabia:

- **„Ile z mojego kontekstu 1 M już zużyłem?”** — zobacz procent + pasek na żywo przed każdym promptem.
- **„Ile kosztuje mnie ta sesja Claude Code?”** — bieżąca suma w USD, aktualizowana przy każdym renderze.
- **„Czy dziś osiągnę limit?”** — wskaźniki 5h / 7d z ⚠️ przy > 50%.
- **„Czy jestem na właściwej gałęzi?”** — gałąź git + dirty + ahead/behind w pasku stanu.
- **„Ile faktycznych godzin spędziłem na tej funkcji?”** — tracker czasu pracy (`active` vs `wall`).
- **„Chcę, żeby mój terminal był fajny.”** — motywy anime, cyberpunk, hacker, retro, weather, ocean, fire i inne.
- **„Chcę minimalistyczny, czysto ASCII pasek stanu do nagrań ekranu.”** — motyw `zen`.
- **„Chcę dostarczyć pasek stanu, którego używa cały mój zespół.”** — pojedynczy spakowany skrypt + konfigurator CLI + komenda slash.

## ❓ FAQ

### Czym jest „Claude Code Status Line”?

Zamiennik domyślnego paska stanu w [Claude Code](https://claude.com/claude-code) (CLI Anthropic) oparty na bashu. Zamienia linię na dole ekranu w prawdziwy pulpit: model, kontekst %, pasek postępu, koszt sesji, limity użycia, status git, czas pracy i więcej.

### Co oznacza `5h{1.1h}: 1%`?

Wykorzystałeś 1% okna 5-godzinnego, a `{1.1h}` to odliczanie na żywo — okno zresetuje się za 1,1 godziny (`7d{1.1d}`: okno tygodniowe zresetuje się za 1,1 dnia). Odczytywane z `rate_limits.*.resets_at` przy każdym renderze. Brak znacznika czasu resetu w twojej kompilacji? Miernik przechodzi na zwykłe `5h: 1%`.

### Jak się to instaluje?

Skopiuj `statusline-bundle.sh` do `~/.claude/status-line.sh`, wykonaj `chmod +x`, a następnie wskaż w `~/.claude/settings.json` Claude Code w `statusLine.command` tę ścieżkę. Pełne instrukcje w sekcjach [Szybki start](#-szybki-start) oraz [Instalacja](#-instalacja).

### Czy obsługuje modele z oknem kontekstu 1 M?

Tak. Skrypt wykrywa `[1m]` w identyfikatorze modelu oraz `1M` w nazwie wyświetlanej i dostosowuje mianownik paska do 1 000 000 tokenów. Zobaczysz `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### Z jakimi modelami działa?

Z dowolnym modelem obsługiwanym przez Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 itd. Skrypt odczytuje `model.display_name` oraz `model.id` z JSON ze stdin dostarczanego przez Claude Code; nie ma na sztywno zakodowanych nazw modeli.

### Czy mogę dostosować kolory, motywy lub dodać własne?

Tak — na trzy sposoby:

1. Wybierz jeden z **79 motywów** (łącznie 158 wariantów) — użyj `~/.claude/status-line.sh use <name>` lub przejrzyj [`examples/`](examples/) w poszukiwaniu samodzielnych skryptów.
2. Skomponuj własny z **nazwanych bloków** — zobacz [BLOCKS.md](BLOCKS.md).
3. Edytuj stałe kolorów i styl paska bezpośrednio w `statusline.sh`.

### Czy spowolni to Claude Code?

Nie. Każdy render wykonuje się raz na każde odświeżenie statusu, parsuje przekazany JSON za pomocą `jq`, opcjonalnie wykonuje `grep` ostatniej linii transkrypcji i drukuje. Typowy render to ≤ 50 ms nawet z włączonym trackerem czasu.

### Czy działa bez `jq`?

`jq` jest wymagany — parsuje JSON, który Claude Code wysyła na stdin. Zainstaluj go przez `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu) lub `choco install jq` (Windows).

### Czy działa na Windowsie?

Tak, w każdym środowisku, które uruchamia `bash` 4+ oraz `jq` — Git Bash, WSL, MSYS2, Cygwin. Czysty CMD/PowerShell nie jest obsługiwany.

### Czy działa na Linuksie / macOS?

Tak, na obu. macOS używa BSD `date`, Linux używa GNU `date` — tracker czasu obsługuje oba w sposób przezroczysty.

### Czy mogę używać tego z surowym API Anthropic zamiast Claude Code?

Częściowo. Pasek stanu jest zaprojektowany dla formatu JSON ze stdin Claude Code. Przy korzystaniu z surowego API wskaźniki limitów automatycznie przechodzą na wyświetlanie **całkowitej liczby tokenów sesji** (`tokens: NNN K`).

### Gdzie przechowywana jest konfiguracja?

`~/.claude/statusline.conf` — maleńki plik powłoki ładowany przez source, zapisywany przez CLI pakietu (`statusline.sh use <theme>` itp.). Utrzymuje się między restartami.

### Jak wrócić do domyślnego paska stanu Claude Code?

Albo usuń blok `statusLine` z `~/.claude/settings.json`, albo wykonaj `~/.claude/status-line.sh reset` i przełącz się na motyw `minimal`, który ściśle przypomina domyślny.

### Czy jest darmowy? Czy mogę go używać komercyjnie?

Osobiste, lokalne użycie jest darmowe — zobacz [Source-Available License](LICENSE). Każde ponowne użycie, redystrybucja, fork lub włączenie do innego projektu wymaga **uprzedniej pisemnej zgody** autora (Yevgeniy Achin · amazopic@gmail.com). Rozsądne prośby są zazwyczaj rozpatrywane pozytywnie.

### Jak działa tracker „roboczogodzin”?

Motyw `time` odczytuje znaczniki czasu z transkrypcji JSONL i raportuje dwa czasy trwania: **active** (suma przerw między wiadomościami krótszych niż 5 minut) oraz **wall** (całkowity rozstęp od pierwszej do ostatniej wiadomości). 5-minutowy próg bezczynności jest konfigurowalny.

## 🏷️ Sugerowane tematy (topics) GitHub

Publikując to repozytorium, dodaj te tematy, aby zmaksymalizować odkrywalność:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Współtworzenie

Zgłoszenia (issues) i PR-y są mile widziane — pamiętaj jednak o licencji:

- **Czytanie, otwieranie zgłoszeń, przesyłanie PR-ów**: za darmo.
- **Forkowanie, kopiowanie do innego projektu, redystrybucja**: wymaga
  uprzedniej pisemnej zgody autora.

Aby poprosić o zgodę na ponowne użycie, skontaktuj się:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Rozsądne prośby dotyczące użytku osobistego, edukacyjnego i niekomercyjnego
są zazwyczaj rozpatrywane pozytywnie i bezpłatnie.

## 📜 Licencja

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

Źródło tego projektu jest publicznie dostępne do czytania, nauki i
osobistego użytku na własnej maszynie. Każde ponowne użycie — kopiowanie, redystrybucja,
modyfikowanie lub włączanie do innego projektu — wymaga **uprzedniej pisemnej
zgody** autora (Yevgeniy Achin · amazopic@gmail.com).

To **nie** jest licencja open-source zatwierdzona przez OSI. Jest to celowy
wybór, by utrzymać dystrybucję i prace pochodne pod kontrolą autora,
jednocześnie pozwalając społeczności na czytanie, naukę i współtworzenie.

## ⭐ Uznałeś to za przydatne?

Jeśli spędzasz godziny, wpatrując się w Claude Code, równie dobrze możesz wpatrywać się w piękny pasek stanu. **Daj repozytorium ⭐**, aby pomóc innym je odkryć!

---

Stworzone przez **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · dla społeczności Claude Code.
