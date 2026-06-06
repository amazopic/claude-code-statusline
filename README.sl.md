# 🛰️ Claude Code Status Line — 79 tem, nastavljivi bloki, CLI

> Dovršena, prilagodljiva statusna vrstica za Claude Code — kontekst, omejitve, stroški, model in več — vse v eni lepo obarvani vrstici. 79 tem in knjižnica 26 blokov za sestavljanje lastne vrstice.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-prispevanje)

**Jeziki:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · Slovenščina · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md) · [ไทย](README.th.md) · [עברית](README.he.md) · [বাংলা](README.bn.md) · [اردو](README.ur.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ tokens: 87 K │ 🤖 xhigh
```

## 🎨 158 pripravljenih variant — izberite in uporabite

79 tem × 2 varianti (`detailed` + `-compact`). Uporabite z `~/.claude/status-line.sh use <name>`.

### 🔝 Top 10 — najbolj iskane, mednarodne
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 Klasika (18): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

### 🚗 Avtomobilske znamke (15)
- 🇪🇺 Evropa: `porsche` · `mercedes` · `bmw` · `volvo`
- 🇺🇸 Amerika: `ford` · `chevy` · `jeep` · `cadillac`
- 🇯🇵 Japonska: `toyota` · `honda` · `nissan`
- 🇰🇷 Koreja: `hyundai` · `kia`
- 🇨🇳 Kitajska: `byd` · `nio` · `geely`

### 🔬 Veliki znanstveniki (8): `newton` · `curie` · `darwin` · `hawking` · `galileo` · `feynman` · `turing` · `davinci`

### ✨ Anime (3 + top): `onepiece` · `ghibli`

### 🦸 Marvel (8 + top): `hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Operacijski sistemi (10): `macos` · `windows` · `linux` · `ubuntu` · `arch` · `debian` · `fedora` · `kali` · `mint` · `nixos`

```bash
~/.claude/status-line.sh use cyberpunk        # detailed
~/.claude/status-line.sh use macos-compact    # compact
```


### 🕊 Svetovne religije (top 7): `christianity` · `islam` · `hinduism` · `buddhism` · `judaism` · `sikhism` · `shinto`

## Zakaj?

Privzeta statusna vrstica Claude Code je skopa. Ta nadomestek jo spremeni v **nadzorno ploščo na prvi pogled** za vsako sejo:

- 🔋 Koliko konteksta sem porabil? (gladke ulomljene vrstice s korakom 1,25 %)
- 💰 Koliko me ta seja stane?
- 🚦 Kako blizu omejitev sem?
- 🧠 Kateri nivo razmišljanja / model je aktiven?
- 🌿 Na kateri git veji sem?

Vse v **eni vrstici**, barvno kodirano, s pametnimi ikonami, ki nakazujejo nujnost.

## ✨ Funkcije

- 🪐 **Živa kontekstna vrstica** — 10 celic s podcelično natančnostjo (kvadrantni ali navpični ulomljeni glifi)
- 🧠 **Ime modela** — z oznako `(1M)` za različice s kontekstom 1M
- 💸 **Stroški seje** v USD, posodobljeni ob vsakem izrisu
- ⬆️⬇️ **Števci žetonov** zadnjega sporočila (vhod / izhod)
- 🚦 **Omejitve** — 5h / 7d z opozorilom ⚠️ pri > 50 %
- 🔄 **Rezerva v API načinu** — če omejitve niso prenesene, prikaže skupne žetone seje (`tokens: NNN K`) s tankim presledkom kot ločilom tisočic
- 🚀 **Pametna statusna ikona** — 🚀 < 40 %, 🚗 40–49 %, ⚠️ ≥ 50 %
- 🎨 **256-barvni ANSI** — žive, razločne barve za vsak segment
- 🧩 **Vključljivi slogi vrstic** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), ali svoj v 10 vrsticah bash
- ⚡ **Lahek** — čisti `bash` + `jq`. Brez Node, brez Python, brez demonov, brez telemetrije

> 💡 **Nasvet — Nadzor konteksta**: bolj kot je vaše okno konteksta polno, **manj učinkovit** je vaš pogovor s Claudom — in **hitreje** gorijo vaše 5h-/7d-omejitve. Počistite ali `/compact`, ko prečkate **60%**, da ostanete produktivni.

### ⏳ Reset countdown — načrtujte okrog svojih omejitev

**Predvidljivost dela — porazdelite svojo produktivnost.** Predvidljivo po
zasnovi — vsak merilnik odšteva do svojega ponastavitvenega trenutka, tako
da delo uravnavate po tempu, namesto da bi treščili v zid.

Merilnika 5h / 7d vključujeta živo odštevanje do trenutka, ko se vsako okno
ponastavi: `5h{1.1h}: 1%` — 5-urno okno se ponastavi čez 1,1 ure;
`7d{1.1d}: 0%` — tedensko okno se ponastavi čez 1,1 dneva. Vedno veste, kdaj
boste spet pri 0 %, zato lahko zahtevno delo razporedite takoj po
ponastavitvi in porazdelite svojo produktivnost, namesto da bi sredi naloge
treščili v zgornjo mejo. Poganja ga `rate_limits.*.resets_at`, ki ga pošilja
Claude Code; če vaša gradnja ne pošilja ponastavitvenih časovnih žigov, se
merilnika gladko vrneta na navadni `5h: 1%`.

## 🚀 Namestitev

### ⚡ ali vibe-chill metoda · pusti Claudu

Zakaj sam, ko imaš Claude Code? Prilepi ta en poziv v sejo Claude Code — Claude opravi vsak korak in vpraša pred vsakim ukazom.

```text
Namesti claude-code-statusline od amazopic zame. Najprej preveri da je jq nameščen (zaženi `which jq`) — če ga ni, ga namesti glede na platformo: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Nato preberi ~/.claude/settings.json — če je tam statusLine.command, ki kaže na obstoječo datoteko (npr. ~/.claude/status-line.sh ali drugo pot), naredi varnostno kopijo te datoteke z dodatkom .bak (prepiši obstoječo .bak). Tudi če ~/.claude/status-line.sh že obstaja — naredi varnostno kopijo enako. Nato kloniraj github.com/amazopic/claude-code-statusline, kopiraj statusline-bundle.sh v ~/.claude/status-line.sh in ga naredi izvršljivega, kopiraj tudi commands/statusline.md v ~/.claude/commands/. Posodobi ~/.claude/settings.json tako da statusLine = { type: "command", command: "<absolutna pot do ~/.claude/status-line.sh>", refreshInterval: 30 }. Na koncu zaženi ~/.claude/status-line.sh use developer za test teme developer in mi reci da ponovno zaženem Claude Code.
```

> Samo reci `y` (ja) ob vsaki zahtevi za dovoljenje. Končano.


### Ročno (3 koraki)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Nato dodajte v `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<vi>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 `refreshInterval: 30` znova požene vrstico vsakih 30 sekund, tudi ko je seja nedejavna — tako ostanejo živi odštevanje do ponastavitve (5h{1.1h}), sledilnik časa in preklopi po ponastavitvi. 30 je razumna privzeta vrednost; 60 varčuje z baterijo; izpustite jo, da se osvežuje le ob dogodkih (novo sporočilo pomočnika, /compact, preklop vim).

Ponovno zaženite Claude Code (ali zaženite `/config` reload).

### Namestitev prek Claude Code agenta (z avtomatsko varnostno kopijo)

Naj Claude Code namesti namesto vas, varno? Prilepite ta poziv:

> »Namesti statusno vrstico iz tega repozitorija kot mojo aktivno
> Claude Code statusno vrstico:
> 1. Če `~/.claude/status-line.sh` že obstaja, ga varnostno kopiraj v
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (uporabi prosto
>    pripono `-N`, če kopija s tem imenom že obstaja).
> 2. Kopiraj `statusline.sh` iz repozitorija v `~/.claude/status-line.sh`
>    in `chmod +x`.
> 3. Preberi `~/.claude/settings.json`. Če ključa `statusLine` ni,
>    dodaj blok z absolutno potjo do skripte in poljem `"refreshInterval": 30`.
>    Če `statusLine` že kaže
>    drugam, najprej varnostno kopiraj `settings.json` v `.bak.<timestamp>`.
> 4. Hitri test:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Reci mi, naj ponovno zaženem Claude Code in poročaj o ustvarjenih
>    varnostnih kopijah.«

### Posodobitev na najnovejšo različico

```bash
~/.claude/status-line.sh update
```

Prenese najnovejši bundle z GitHub, ustvari varnostno kopijo s časovnim
žigom (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) in ohrani vašo
konfiguracijo teme (`~/.claude/statusline.conf`). Nato znova zaženite
Claude Code.

Preverite nameščeno različico: `~/.claude/status-line.sh version`.

### Zahteve

- `bash` 4+ (skripta uporablja 0-indeksirana polja — **ne zaganjaj pod `zsh`**)
- `jq` za parsiranje JSON
- 256-barvni terminal (skoraj vsak sodoben)

## ⚙️ Konfiguracija

Uredite konstante na vrhu `statusline.sh`:

| Spremenljivka / funkcija | Kaj nadzira |
|---|---|
| `BAR_STYLE` | `"quadrant"` (privzeto, korak 2,5 %) ali `"vertical"` (korak 1,25 %) |
| `pct_icon()` | Pragovi za ikone 🚀 / 🚗 / ⚠️ pred vrstico |
| `pct_color()` | Barvni pragovi za odstotek / vrstico |
| Konstante barv ANSI | Prebarvanje katerega koli segmenta (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Metodologija vtičnikov — lasten slog vrstice v 10 vrsticah

Vsak slog je samostojna funkcija `bar_<ime>(pct)`, ki vrne niz iz natanko
10 vidnih celic:

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

Nato registrirajte v dispatcherju `bar()`:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

To je vse. Pogodba funkcije:

- Vhod: celo število `pct` `0..100` (že omejeno)
- Izhod: natanko 10 vidnih celic
- Zaokroževanje k **najbližjemu** podkoraku (ne floor), da se vrstica ne zatakne

PR z novimi slogi so zelo dobrodošli.

### Več primerov pozivov

<details>
<summary>Predloge pozivov za dodajanje slogov, segmentov in popravkov</summary>

#### Slog `shaded` (4 nivoji: `░ ▒ ▓ █`)

> »Dodaj slog vrstice `shaded`: 4 nivoji na celico — `░ ▒ ▓ █`
> (light → medium → dark → full), korak 2,5 %. Ista pravila zaokroževanja
> kot `bar_quadrant`. Aktivacija prek `BAR_STYLE="shaded"`.«

#### Slog `dotted` za omejene terminale

> »Dodaj slog `dotted` za terminale brez podpore za blokovne znake:
> 10 celic, polna = `●`, prazna = `·`, brez podnivojev (korak 10 %).«

#### Pragovno barvanje vrstice

> »V `bar()` po generaciji niza ga ovij v barvo glede na odstotek:
> < 50 % zelena (`$GR`), 50–69 % rumena (`$Y`), ≥ 70 % rdeča (`$R`).
> Mora delovati za kateri koli `BAR_STYLE`.«

#### Nov segment: Python virtualenv

> »Dodaj nov segment pred `${git_part}`: ime trenutnega Python
> virtualenv iz `$VIRTUAL_ENV` (basename), barva magenta (`$M`).
> Če je prazno, izpusti segment in njegov `${SEP}`.«

#### Nastavitev pragov ikone

> »V `pct_icon` dodaj četrti prag: pri ≥ 80 % vrne `🔥`. Obstoječe
> ikone obdrži, prerazporedi: < 40 % 🚀, 40–59 % 🚗, 60–79 % ⚠️,
> ≥ 80 % 🔥.«

</details>

## 🤝 Prispevanje

PR so zelo dobrodošli! Še posebej:

- 🎨 Nove različice `bar_<style>` (sparklines, merilniki, ASCII art …)
- 🧱 Novi segmenti (kontekst kubectl, Python venv, AWS profil, baterija, vreme …)
- 🌍 Več prevodov README
- 🐛 Popravki za robne primere (ogromni transkripti, eksotični terminali)

Pri večjih spremembah najprej odprite issue.

## 📜 Licenca

[Source-Available](LICENSE) — počnite kar želite, omemba avtorstva je cenjena, a ne obvezna.

## ⭐ Vam je všeč?

Če ure strmite v Claude Code, naj vsaj statusna vrstica razveseli oko. **Dajte repozitoriju ⭐**, da ga drugi najdejo!

---

Narejeno z ❤️ za skupnost Claude Code.

---

## Avtor / Licenca / Stik

- **Avtor:** Yevgeniy Achin
- **Licenca:** [Source-Available License](LICENSE) — Source-Available — ponovna uporaba le z avtorjevim pisnim dovoljenjem
- **Stik:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 Paket vse-v-enem (`statusline-bundle.sh`)

Ne želite upravljati 40+ datotek? Vzemite **eno samo skripto** `statusline-bundle.sh` — vsebuje vse teme, vse bloke in CLI-konfigurator v eni datoteki.

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

Konfiguracija je shranjena v `~/.claude/statusline.conf` in preživi ponovne zagone. Ista datoteka deluje kot **upodabljalnik** (ko Claude Code pošlje JSON prek stdin) in kot **konfigurator** (ko jo pokličete z argumenti).

### Slash-ukaz `/statusline`

Položite `commands/statusline.md` v `~/.claude/commands/` — v Claude Code bo na voljo ukaz `/statusline`:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Nato lahko v katerikoli seji Claude Code vtipkate:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Shell-vzdevek (neobvezno)

```bash
alias statusline='~/.claude/status-line.sh'
```

Nato `statusline cyberpunk` deluje iz katerega koli terminala.

---

## ⚡ Hitri začetek

Najhitrejša pot — pakirana skripta vse-v-enem z vgrajenim CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # ali: anime, hacker, minimal, …
```

Nato dodajte v `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<vi>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 `refreshInterval: 30` znova požene vrstico vsakih 30 sekund, tudi ko je seja nedejavna — tako ostanejo živi odštevanje do ponastavitve (5h{1.1h}), sledilnik časa in preklopi po ponastavitvi. 30 je razumna privzeta vrednost; 60 varčuje z baterijo; izpustite jo, da se osvežuje le ob dogodkih (novo sporočilo pomočnika, /compact, preklop vim).

Ponovno zaženite Claude Code (ali `/config` reload). Končano.

## 🆚 Primerjava s privzeto statusno vrstico Claude Code

| Zmožnost | Privzeto | Ta projekt |
|---|---|---|
| Ime aktivnega modela | ✅ | ✅ (z oznako `(1M)` za 1M-kontekstne različice) |
| Kontekstno okno: % uporabljen | ❌ | ✅ v živo, natančnost 1,25 % |
| Vrstica napredka konteksta | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Stroški seje v USD | ❌ | ✅ posodobljeno ob vsakem izrisu |
| Števci žetonov vhod/izhod | ❌ | ✅ |
| Skupni žetoni seje (rezerva v API načinu) | ❌ | ✅ |
| Indikatorji omejitev 5h / 7d z ⚠️ pri > 50 % | ❌ | ✅ |
| Reset countdown v merilnikih omejitev (`5h{1.1h}`) | ❌ | ✅ |
| Git veja + dirty + ahead/behind | ❌ | ✅ |
| Čas na nalogi (active vs wall) | ❌ | ✅ |
| Raven thinking / effort | ❌ | ✅ |
| Pripravljene teme | ❌ | ✅ 79 tem × 2 različici = **158 pripravljenih** |
| Sestavljanje iz imenovanih blokov | ❌ | ✅ 26 blokov, glej [BLOCKS.md](BLOCKS.md) |
| Vgrajen CLI konfigurator | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Slash ukaz `/statusline` Claude Code | ❌ | ✅ neobvezno, glej [`commands/`](commands/) |
| Odvisnosti | — | `bash` 4+ in `jq` (brez Node, Python, demonov) |

## 💡 Primeri uporabe

- **»Koliko od mojega 1 M konteksta sem porabil?«** — odstotek in vrstica v živo pred vsakim pozivom.
- **»Koliko me stane ta seja Claude Code?«** — tekoča USD vsota, posodobljena ob vsakem izrisu.
- **»Bom danes dosegel omejitev?«** — indikatorji 5h / 7d z ⚠️ pri > 50 %.
- **»Sem na pravi veji?«** — git veja + dirty + ahead/behind v statusni vrstici.
- **»Koliko ur sem dejansko porabil za to funkcijo?«** — sledilnik časa (`active` vs `wall`).
- **»Želim si zabaven terminal.«** — teme anime, cyberpunk, hacker, retro, weather, ocean, fire.
- **»Potrebujem minimalno ASCII statusno vrstico za snemanje zaslona.«** — tema `zen`.

## ❓ Pogosta vprašanja (FAQ)

### Kaj je Claude Code Status Line?

Bash zamenjava za privzeto statusno vrstico v [Claude Code](https://claude.com/claude-code) (Anthropicov CLI). Spodnjo vrstico spremeni v pravo nadzorno ploščo: model, kontekst %, vrstica napredka, stroški seje, omejitve, git, čas in več.

### Kaj pomeni `5h{1.1h}: 1%`?

Porabili ste 1 % 5-urnega okna, `{1.1h}` pa je živo odštevanje — okno se
ponastavi čez 1,1 ure (`7d{1.1d}`: tedensko okno se ponastavi čez 1,1 dneva).
Prebrano iz `rate_limits.*.resets_at` ob vsakem izrisu. V vaši gradnji ni
ponastavitvenega časovnega žiga? Merilnik se vrne na navadni `5h: 1%`.

### Ali se statusna vrstica posodablja sama od sebe? Moje odštevanje {1.1h} je videti zamrznjeno.

Claude Code se znova izriše ob dogodkih — novo sporočilo pomočnika, `/compact`,
sprememba načina dovoljenj ali načina vim (z zakasnitvijo 300 ms) — zato se med
dogodki vrstica zamrzne. Dodajte `"refreshInterval": 30` v blok statusLine v
`~/.claude/settings.json` in tako se bo vrstica znova pognala tudi po fiksnem
30-sekundnem časovniku, kar ohranja živo odštevanje in sledilnik časa, ko je
seja nedejavna. Izris stane ~0,1 s, zato je 30 s zanemarljivo; uporabite 60 na
bateriji ali v ogromnih repozitorijih (`git status` se izvede ob vsakem
izrisu); minimum je 1.

### Kako se namesti?

Kopirajte `statusline-bundle.sh` v `~/.claude/status-line.sh`, naredite `chmod +x`, usmerite `~/.claude/settings.json` → `statusLine.command` na to pot.

### Ali podpira modele z 1 M kontekstom?

Da. Skripta zazna `[1m]` v model id in `1M` v display name, prilagodi imenovalec na 1 000 000 žetonov.

### S katerimi modeli deluje?

S katerimkoli modelom, ki ga podpira Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 itd.

### Ali lahko prilagodim barve, teme ali dodam svoje?

Da, na tri načine: (1) izbira med **40 pripravljenimi različicami** v [`examples/`](examples/), (2) sestaviti svojo iz imenovanih blokov — glej [BLOCKS.md](BLOCKS.md), (3) urediti barvne konstante v `statusline.sh` neposredno.

### Bo upočasnil Claude Code?

Ne. Tipični izris ≤ 50 ms.

### Deluje brez `jq`?

`jq` je obvezen. Namestitev: `brew install jq` (macOS) ali `apt install jq` (Debian/Ubuntu).

### Deluje na Windows / macOS / Linux?

Da na vseh. Na Windows — preko Git Bash, WSL, MSYS2 ali Cygwin.

### Ali ga lahko uporabim z neposrednim Anthropic API?

Delno. Indikatorji omejitev se samodejno preklopijo na prikaz skupnih žetonov seje (`tokens: NNN K`).

### Kje je shranjena konfiguracija?

`~/.claude/statusline.conf` — majhna shell-source datoteka. Preživi ponovne zagone.

### Ali je brezplačno? Lahko uporabljam komercialno?

Osebna lokalna uporaba je brezplačna (glej [Source-Available License](LICENSE)). Vsaka ponovna uporaba zahteva **predhodno pisno dovoljenje** avtorja (amazopic@gmail.com).

### Kako se vrnem na privzeto statusno vrstico Claude Code?

Odstranite blok `statusLine` iz `~/.claude/settings.json` ali zaženite `~/.claude/status-line.sh reset`.

## 🏷️ Priporočeni GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
