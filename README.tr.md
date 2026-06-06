# 🛰️ Claude Code Status Line — 79 tema, yapılandırılabilir bloklar, CLI

> **Claude Code** varsayılan durum çubuğunun yerine doğrudan kullanılabilen alternatif: yumuşak bir ilerleme çubuğuyla canlı **bağlam penceresi** kullanımı, USD cinsinden **oturum maliyeti**, **5sa / 7g hız limiti** uyarıları, kirli / önde / geride sayaçlarıyla **git dalı**, **göreve harcanan süre takibi** ve etkin **model adı** (1M bağlamlı varyantlar için `(1M)` göstergesiyle) — hepsi tek bir renkli Bash satırında. **79 hazır temayla** birlikte gelir — en çok tercih edilenler (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), klasikler (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), otomobil markaları (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), daha fazla bilim insanı (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), daha fazla anime (onepiece, ghibli), daha fazla Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), işletim sistemi temaları (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos) ve dünya dinleri (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) ve kendinizinkini oluşturmanız için **26 bloktan oluşan bir kütüphane**. Hepsi bir arada CLI yapılandırıcısı ve Claude Code için bir `/statusline` slash komutu içerir.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-hazır-varyant--birini-seç-ve-başla)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#gereksinimler)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · Türkçe · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **Profesyonel ipucu — Bağlam kontrolü**: Bağlam pencereniz ne kadar dolarsa, Claude ile sohbetiniz o kadar **etkisiz** hâle gelir — ve 5sa/7g limitlerinizi o kadar **hızlı** tüketirsiniz. Verimli çalışmaya devam etmek için **%60**'ı geçtiğinizde her seferinde temizleyin veya `/compact` yapın.

### ⏳ Sıfırlanma geri sayımı — limitlerinize göre plan yapın

5sa / 7g ölçerleri, her pencerenin sıfırlandığı ana kadar canlı bir geri sayım içerir: `5h{1.1h}: 1%` — 5 saatlik pencere 1,1 saat içinde sıfırlanır; `7d{1.1d}: 0%` — haftalık pencere 1,1 gün içinde sıfırlanır. Tekrar %0'a ne zaman döneceğinizi her zaman bildiğiniz için, ağır işleri sıfırlanmanın hemen ardından planlayabilir ve görevin ortasında limite toslamak yerine üretkenliğinizi dağıtabilirsiniz. Claude Code tarafından gönderilen `rate_limits.*.resets_at` ile çalışır; sürümünüz sıfırlanma zaman damgaları göndermiyorsa, ölçerler zarif bir şekilde sade `5h: 1%` biçimine geri döner.

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**Tasarım gereği öngörülebilir** — her ölçer kendi sıfırlanmasına kadar geri sayar, böylece duvara toslamak yerine işinizi temponuza göre yürütürsünüz.

## ⚡ Hızlı başlangıç

En hızlı yol — yerleşik CLI ile birlikte gelen, hepsi bir arada betik:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

Ardından `~/.claude/settings.json` dosyasına ekleyin:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Claude Code'u yeniden başlatın (veya `/config` reload çalıştırın). Tamamdır.

### veya vibe-chill yöntemi · bırakın Claude yapsın

Claude Code varken neden bir terminale dokunasınız? Bu tek istemi Claude Code oturumunuza yapıştırın — Claude her adımı halleder ve her komuttan önce onay ister.

```text
amazopic'in claude-code-statusline'ını benim için kur. Önce jq'nun kurulu olduğundan emin ol (`which jq` çalıştır) — eksikse platforma göre kur: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Sonra ~/.claude/settings.json dosyasını oku — mevcut bir dosyaya işaret eden bir statusLine.command varsa (ör. ~/.claude/status-line.sh veya başka bir yol), o dosyayı .bak ekleyerek yedekle (mevcut herhangi bir .bak dosyasının üzerine yaz). Ayrıca ~/.claude/status-line.sh zaten varsa, onu da aynı şekilde yedekle. Sonra github.com/amazopic/claude-code-statusline depodan klonla, statusline-bundle.sh dosyasını ~/.claude/status-line.sh konumuna kopyala ve çalıştırılabilir yap, ayrıca commands/statusline.md dosyasını ~/.claude/commands/ içine kopyala. ~/.claude/settings.json dosyasını statusLine { type: "command", command: "<~/.claude/status-line.sh için mutlak yol>" } olacak şekilde güncelle. Son olarak developer temasını test etmek için ~/.claude/status-line.sh use developer çalıştır ve bana Claude Code'u yeniden başlatmamı söyle.
```

> Her izin isteminde sadece `y` (evet) deyin. Tamamdır.


## Claude Code için neden özel bir durum çubuğu / durum satırı?

Claude Code'un varsayılan durum çubuğu sade kalıyor. Doğrudan kullanılabilen bu alternatif, alttaki durum çubuğunu her oturum için **bir bakışta görülebilen bir panoya** dönüştürür:

- 🔋 Ne kadar bağlam harcadım? (yumuşak %1,25 kesirli çubuklar)
- 💰 Bu oturum bana ne kadara mal oluyor?
- 🚦 Hız limitlerime ne kadar yakınım?
- 🧠 Hangi düşünme seviyesindeyim / hangi modeldeyim?
- 🌿 Hangi git dalındayım?

Hepsi **tek satırda**, renk kodlu ve aciliyeti işaret eden akıllı simgelerle.

## ✨ Özellikler

- 🪐 **Canlı bağlam çubuğu** — alt hücre hassasiyetiyle 10 hücreli ilerleme çubuğu (çeyrek veya dikey kesirli glifler)
- 🧠 **Model adı** — 1M bağlamlı varyantlar için `(1M)` göstergesiyle
- 💸 USD cinsinden **oturum maliyeti**, her render'da güncellenir
- ⬆️⬇️ **Mesaj başına token sayaçları** (giriş / çıkış)
- 🚦 **Hız limitleri** — 5sa / 7g, > %50 olduğunda ⚠️ uyarısıyla
- 🔄 **API modu yedeği** — hız limitleri aktarılmadığında, ince boşluklu binlik ayraçlarla toplam oturum token'larını gösterir (`tokens: NNN K`)
- 🚀 **Akıllı durum simgesi** — 🚀 < %40, 🚗 %40–49, ⚠️ ≥ %50 bağlam doluluğu
- 🎨 **256 renkli ANSI** — segment başına parlak, belirgin renk
- 🧩 **Takılabilir çubuk stilleri** — `quadrant` (▖▄▙█) veya `vertical` (▏▎▍▌▋▊▉█) seçin ya da 10 satır bash ile kendinizinkini yazın
- ⚡ **Hafif** — saf `bash` + `jq`. Node yok, Python yok, daemon yok, telemetri yok

## 🎨 158 hazır varyant — birini seç ve başla

Her tema **iki varyantla** gelir:

- **Detailed** — tam özellik seti (model, bağlam çubuğu, maliyet, token'lar, git, süre, ruh hâli simgesi, …)
- **Compact** — yalnızca `model · bağlam % + çubuk · dal`

`~/.claude/status-line.sh use <name>` ile uygulayın (kompakt varyant için `-compact` ekleyin).

### 🔝 En çok tercih edilenler (10) — en çok istenen, kültürlerarası

| Tema | Atmosfer |
|---|---|
| `cyberpunk`  | neon distopya · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | fosfor-yeşili Matrix terminali · `[SYS] :: ROOT@matrix#` |
| `dragonball` | Goku güçlenmesi: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | Konoha yaprağı turuncusu · chakra ölçer · 🌀 rasengan |
| `pokemon`    | Pikachu sarısı + pokeball kırmızısı · HP çubuğu |
| `ironman`    | 🦾 Stark kırmızısı + arc-reactor altını |
| `spiderman`  | 🕷 örümcek-adam kırmızısı + mavisi · büyük bağlam büyük maliyet getirir |
| `einstein`   | kara tahta yeşilleri · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ elektrik moru + şimşek sarısı · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + Modena sarısı |

### 🛠 Pratik / Klasik (18 tema)

| Tema | Dosya / Uygulama |
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

> Not: `cyberpunk` ve `hacker` yukarıdaki **En çok tercih edilenler** bölümünde yer alır — tek temalı kurulum isterseniz `examples/` klasöründe de bulunurlar.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Otomobil markaları (15 tane daha, en çok tercih edilenler `ferrari` içerir)

Yalnızca `statusline-bundle.sh` içinde gelir — herhangi birini `~/.claude/status-line.sh use <name>` ile seçin.

| Bölge | Temalar |
|---|---|
| 🇪🇺 Avrupa  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 Amerika | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japonya   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Kore   | `hyundai` · `kia` |
| 🇨🇳 Çin   | `byd` · `nio` · `geely` |

### 🔬 Büyük bilim insanları (8 tane daha, en çok tercih edilenler `einstein` ve `tesla` içerir)

| Tema | Atmosfer |
|---|---|
| `newton`   | parşömen mürekkebi, `🍎`, `F=ma` |
| `curie`    | radyum yeşili, `☢`, yarı ömür ölçeri |
| `darwin`   | doğa bilimci yeşili, `🐢`, HMS Beagle |
| `hawking`  | derin uzay moru, `🌌`, `t → ∞` |
| `galileo`  | güneş altını, `🔭`, *eppur si muove* |
| `feynman`  | tahtada tebeşir, `〰`, `ψ → ψ'` |
| `turing`   | terminal yeşili, `Ⓣ`, durma çubuğu `1/0` |
| `davinci`  | sepya kodeks, `✎`, *Vitruvius* |

### ✨ Anime (3 tane daha, en çok tercih edilenler `dragonball`, `naruto`, `pokemon` içerir)

`onepiece` · `ghibli`

### 🦸 Marvel süper kahramanları (8 tane daha, en çok tercih edilenler `ironman` ve `spiderman` içerir)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 İşletim sistemleri (10 tema)

| Tema | Atmosfer |
|---|---|
| `macos`   | 🍎 krom griye altı renkli Apple gökkuşağı |
| `windows` | ⊞ Fluent dört renkli karo + WINDOWS 11 camgöbeği |
| `linux`   | 🐧 Tux siyahı + turuncu gaga |
| `ubuntu`  | ⊕ dostluk çemberi — turuncu + patlıcan moru |
| `arch`    | ▲ pacman camgöbeği · btw, I use arch |
| `debian`  | 🌀 kırmızı girdap · stable / sid / testing |
| `fedora`  | 🎩 Fedora şapkası mavisi · freedom + features |
| `kali`    | 🐉 Kali mavisi + offsec kırmızısı · pwn-mode |
| `mint`    | 🌿 cinnamon nane yeşili · en dost canlısı kabuk |
| `nixos`   | ❄ Nix mavisi kar tanesi · declarative, reproducible |

### 🕊 Dünya dinleri (mensup sayısına göre ilk 7)

| Tema | Atmosfer |
|---|---|
| `christianity` | ✝ şarap kırmızısı + Meryem mavisi + papalık altını · iman ölçeri, € sadaka |
| `islam`        | ☪ İslam yeşili + beyaz + altın hat sanatı · takva, ﷼ sadaka |
| `hinduism`     | 🕉 safran + kadife çiçeği + zincifre · dharma, ₹ seva |
| `buddhism`     | ☸ keşiş safranı + altın + bordo · karma, ฿ dāna |
| `judaism`      | ✡ tallit mavisi + beyaz + menora altını · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ Khalsa koyu mavisi + safran + beyaz · sewa, daswandh |
| `shinto`       | ⛩ zincifre torii + tapınak beyazı + altın · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

**Önce hepsine terminalinizde göz atın** — her varyantın
[`screenshots/`](screenshots/) içinde önceden render edilmiş bir önizlemesi vardır:

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (158 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Açıklamalı tam tablo için [`examples/README.md`](examples/README.md) dosyasına,
önizlemelerin nasıl oluşturulduğu için ise [`screenshots/README.md`](screenshots/README.md) dosyasına bakın.

## 🧱 Bloklardan kendinizinkini oluşturun

Hazır bir ayar kullanmak istemiyor musunuz? Adlandırılmış bloklardan oluşan bir kütüphaneden
özel bir durum satırı oluşturun — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

Şunlar için [**BLOCKS.md**](BLOCKS.md) dosyasına bakın:

- **blok kataloğu** (her biri kopyala-yapıştır yapılabilen bir bash parçacığı)
- **stil paketleri** (`classic`, `compact`, `anime`, `hacker`, `cyberpunk`, `zen`
  temalarından renk paletleri ve ayraçlar)
- kendi satırınızı oluşturmak için **3 adımlık bir tarif**: bir stil seç → blokları
  listele → yapıştır

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 Hepsi bir arada paket (`statusline-bundle.sh`)

40'tan fazla dosya yönetmek istemiyorsanız, **tek bir paketlenmiş betiği**
[`statusline-bundle.sh`](statusline-bundle.sh) alın — her temayı + her bloğu + bir CLI
yapılandırıcısını tek bir dosyada içerir.

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

Yapılandırma `~/.claude/statusline.conf` dosyasına kaydedilir ve yeniden başlatmalar
arasında korunur. Aynı dosya hem **render edici** (Claude Code tarafından stdin'de JSON
ile çağrıldığında) hem de **yapılandırıcı** (argümanlarla çağırdığınızda) olarak görev yapar.

### `/statusline` slash komutu

Claude Code içinde bir `/statusline` slash komutunu etkinleştirmek için
[`commands/statusline.md`](commands/statusline.md) dosyasını
`~/.claude/commands/` içine bırakın:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Ardından herhangi bir Claude Code oturumunda şunları yazabilirsiniz:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude paket CLI'sini sizin için çalıştırır, sonucu raporlar ve yeniden yüklemeyi
hatırlatır.

### İsteğe bağlı shell takma adı

```bash
alias statusline='~/.claude/status-line.sh'
```

Sonra `statusline cyberpunk` herhangi bir terminalden çalışır.

## 🚀 Kurulum

### Manuel kurulum (3 adım)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Ardından `~/.claude/settings.json` dosyasına ekleyin:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Claude Code'u yeniden başlatın (veya `/config` reload çalıştırın).

### Claude Code aracısı ile kurulum (otomatik yedeklemeyle)

Claude Code'un bunu sizin için güvenle kurmasını mı istiyorsunuz? Bu istemi yapıştırın:

> "Bu depodaki durum satırını Claude Code durum satırım olarak kur:
> 1. `~/.claude/status-line.sh` zaten varsa, onu
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` dosyasına yedekle (bu adla
>    bir yedek zaten varsa boş bir `-N` soneki seç).
> 2. Bu depodaki `statusline.sh` dosyasını `~/.claude/status-line.sh` konumuna kopyala ve `chmod +x` yap.
> 3. `~/.claude/settings.json` dosyasını oku. `statusLine` anahtarı yoksa, betiğin
>    mutlak yolunu gösteren bir `statusLine` bloğu ekle. `statusLine` zaten varsa ve
>    başka bir yeri gösteriyorsa, önce `settings.json` dosyasını `.bak.<timestamp>`
>    olarak yedekle.
> 4. Betiği duman testinden geçir:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Bana Claude Code'u yeniden başlatmamı söyle ve oluşturulan yedekleri raporla."

### En son sürüme güncelleme

```bash
~/.claude/status-line.sh update
```

En son paketi GitHub'dan getirir, zaman damgalı bir yedek oluşturur
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) ve tema yapılandırmanızı
(`~/.claude/statusline.conf`) korur. Sonrasında Claude Code'u yeniden başlatın.

Neyin kurulu olduğunu kontrol edin: `~/.claude/status-line.sh version`.

### Gereksinimler

- `bash` 4+ (betik 0-indeksli diziler kullanır — **`zsh` altında çalıştırmayın**)
- JSON ayrıştırma için `jq` — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (yalnızca `statusline update` için gerekli; çoğu sistemde önceden kurulu)
- 256 renkli bir terminal (esasen her modern terminal)

## ⚙️ Yapılandırma

`statusline.sh` dosyasının üst kısmındaki sabitleri düzenleyin:

| Değişken / fonksiyon | Neyi kontrol eder |
|---|---|
| `BAR_STYLE` | `"quadrant"` (varsayılan, %2,5 adım) veya `"vertical"` (%1,25 adım) |
| `pct_icon()` | Çubuktan önceki 🚀 / 🚗 / ⚠️ simgeleri için eşikler |
| `pct_color()` | Yüzde / çubuk için renk eşikleri |
| ANSI renk sabitleri | Herhangi bir segmenti yeniden renklendir (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 Varsayılan Claude Code durum satırına karşı

| Yetenek | Varsayılan | Bu proje |
|---|---|---|
| Etkin **model adı** | ✅ | ✅ (1M bağlamlı varyantlar için `(1M)` işaretiyle) |
| Kullanılan **bağlam penceresi** % | ❌ | ✅ canlı, %1,25 hassasiyet |
| Bağlam için **ilerleme çubuğu** | ❌ | ✅ (dikey, çeyrek, gökkuşağı, sparkline, …) |
| USD cinsinden **oturum maliyeti** | ❌ | ✅ her render'da güncellenir |
| **Mesaj başına** giriş/çıkış token sayaçları | ❌ | ✅ |
| **Toplam oturum token'ları** (API modu yedeği) | ❌ | ✅ |
| > %50'de ⚠️ ile **5sa / 7g hız limiti** göstergeleri | ❌ | ✅ |
| Limit ölçerlerinde sıfırlanma geri sayımı (`5h{1.1h}`) | ❌ | ✅ |
| **Git dalı** + kirli + önde/geride | ❌ | ✅ |
| **Göreve harcanan süre** (etkin vs duvar saati) | ❌ | ✅ |
| **Düşünme / çaba seviyesi** gösterimi | ❌ | ✅ |
| Temalı hazır ayarlar | ❌ | ✅ 79 tema × 2 varyant = **158 hazır** |
| Adlandırılmış bloklardan oluşturma | ❌ | ✅ 26 blok, bkz. [BLOCKS.md](BLOCKS.md) |
| Yerleşik CLI yapılandırıcı | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` slash komutu | ❌ | ✅ isteğe bağlı, bkz. [`commands/`](commands/) |
| Dış bağımlılıklar | — | `bash` 4+ ve `jq` (Node yok, Python yok, daemon yok) |
| Lisans | — | Source-Available (izinle yeniden kullanım) |

## 💡 Kullanım senaryoları

Bu projenin kendini amorti ettiği somut senaryolar:

- **"1 M bağlamımın ne kadarını harcadım?"** — her istemden önce canlı bir yüzde + çubuk görün.
- **"Bu Claude Code oturumu bana ne kadara mal oluyor?"** — her render'da güncellenen, akan USD toplamı.
- **"Bugün bir hız limitine takılacak mıyım?"** — > %50 olduğunda ⚠️ ile 5sa / 7g göstergeleri.
- **"Doğru dalda mıyım?"** — durum satırınızda git dalı + kirli + önde/geride.
- **"Bu özelliğe gerçekte kaç saat harcadım?"** — göreve harcanan süre takipçisi (`active` vs `wall`).
- **"Terminalimin eğlenceli olmasını istiyorum."** — anime, cyberpunk, hacker, retro, weather, ocean, fire ve diğer temalar.
- **"Ekran kayıtları için yalnızca ASCII içeren minimal bir durum satırı istiyorum."** — `zen` teması.
- **"Tüm ekibimin kullandığı bir durum satırı dağıtmak istiyorum."** — tek paketlenmiş betik + CLI yapılandırıcı + slash komutu.

## ❓ SSS

### "Claude Code Status Line" nedir?

[Claude Code](https://claude.com/claude-code) (Anthropic'in CLI'si) içindeki varsayılan durum satırının bash tabanlı bir alternatifidir. Ekranın altındaki satırı gerçek bir panoya dönüştürür: model, bağlam %, ilerleme çubuğu, oturum maliyeti, hız limitleri, git durumu, göreve harcanan süre ve daha fazlası.

### `5h{1.1h}: 1%` ne anlama gelir?

5 saatlik pencerenin %1'ini kullandınız ve `{1.1h}` canlı bir geri sayımdır — pencere 1,1 saat içinde sıfırlanır (`7d{1.1d}`: haftalık pencere 1,1 gün içinde sıfırlanır). Her render'da `rate_limits.*.resets_at` değerinden okunur. Sürümünüzde sıfırlanma zaman damgası yok mu? Ölçer sade `5h: 1%` biçimine geri döner.

### Nasıl kurulur?

`statusline-bundle.sh` dosyasını `~/.claude/status-line.sh` konumuna kopyalayın, `chmod +x` yapın, ardından Claude Code'un `~/.claude/settings.json` dosyasındaki `statusLine.command` değerini bu yola yönlendirin. Tam talimatlar [Hızlı başlangıç](#-hızlı-başlangıç) ve [Kurulum](#-kurulum) bölümlerindedir.

### 1 M bağlam penceresi modellerini destekliyor mu?

Evet. Betik, model id'sinde `[1m]` ve görünen adda `1M` tespit eder ve çubuğun paydasını 1 000 000 token'a ayarlar. `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K` görürsünüz.

### Hangi modellerle çalışır?

Claude Code'un desteklediği herhangi bir model — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 vb. Betik, Claude Code'un sağladığı stdin JSON'undan `model.display_name` ve `model.id` değerlerini okur; model adlarını sabit kodlamaz.

### Renkleri, temaları özelleştirebilir veya kendi temamı ekleyebilir miyim?

Evet — üç yolla:

1. **79 temadan** birini seçin (toplam 158 varyant) — `~/.claude/status-line.sh use <name>` kullanın ya da bağımsız betikler için [`examples/`](examples/) klasörüne göz atın.
2. **Adlandırılmış bloklardan** kendinizinkini oluşturun — bkz. [BLOCKS.md](BLOCKS.md).
3. `statusline.sh` içindeki renk sabitlerini ve çubuk stilini doğrudan düzenleyin.

### Claude Code'u yavaşlatır mı?

Hayır. Her render, her durum yeniden çizimi başına bir kez çalışır, aktarılan JSON'u `jq` ile ayrıştırır, isteğe bağlı olarak transcript'in en son satırını `grep`'ler ve yazdırır. Tipik render, süre takipçisi etkin olsa bile ≤ 50 ms'dir.

### `jq` olmadan çalışır mı?

`jq` gereklidir — Claude Code'un stdin'de gönderdiği JSON'u ayrıştırır. `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu) veya `choco install jq` (Windows) ile kurun.

### Windows'ta çalışır mı?

Evet, `bash` 4+ ve `jq` çalıştıran herhangi bir ortamda — Git Bash, WSL, MSYS2, Cygwin. Saf CMD/PowerShell desteklenmez.

### Linux / macOS'ta çalışır mı?

İkisinde de evet. macOS BSD `date` kullanır, Linux GNU `date` kullanır — süre takipçisi ikisini de şeffaf şekilde yönetir.

### Bunu Claude Code yerine ham Anthropic API ile kullanabilir miyim?

Kısmen. Durum satırı Claude Code'un stdin JSON formatı için tasarlanmıştır. Ham API kullanımında, hız limiti göstergeleri otomatik olarak **toplam oturum token'ları** gösterimine geri döner (`tokens: NNN K`).

### Yapılandırma nerede saklanır?

`~/.claude/statusline.conf` — paketin CLI'si (`statusline.sh use <theme>` vb.) tarafından yazılan, küçük, shell tarafından source edilen bir dosya. Yeniden başlatmalar arasında korunur.

### Varsayılan Claude Code durum satırına nasıl geri dönerim?

Ya `~/.claude/settings.json` dosyasından `statusLine` bloğunu kaldırın ya da `~/.claude/status-line.sh reset` çalıştırıp varsayılana yakından benzeyen bir `minimal` temaya geçin.

### Ücretsiz mi? Ticari olarak kullanabilir miyim?

Kişisel, yerel kullanım ücretsizdir — bkz. [Source-Available License](LICENSE). Herhangi bir yeniden kullanım, yeniden dağıtım, fork veya başka bir projeye dahil etme, yazardan (Yevgeniy Achin · amazopic@gmail.com) **önceden yazılı izin** gerektirir. Makul talepler genellikle kabul edilir.

### "İnsan-saatleri" takipçisi nasıl çalışır?

`time` teması JSONL transcript'inden zaman damgalarını okur ve iki süre raporlar: **active** (5 dakikadan kısa mesajlar arası boşlukların toplamı) ve **wall** (ilk mesajdan son mesaja toplam süre). 5 dakikalık boşta kalma eşiği yapılandırılabilir.

## 🏷️ Önerilen GitHub konuları

Bu depoyu yayınladığınızda, keşfedilebilirliği en üst düzeye çıkarmak için bu konuları ekleyin:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Katkıda bulunma

Issue'lar ve PR'lar memnuniyetle karşılanır — ancak lisansı dikkate alın:

- **Okuma, issue açma, PR gönderme**: ücretsiz.
- **Fork'lama, başka bir projeye kopyalama, yeniden dağıtma**: yazardan
  önceden yazılı izin gerektirir.

Yeniden kullanım izni talep etmek için iletişime geçin:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Kişisel, eğitimsel ve ticari olmayan kullanım için makul talepler genellikle
ücretsiz olarak kabul edilir.

## 📜 Lisans

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

Bu projenin kaynağı; okumak, incelemek ve kendi makinenizde kişisel
kullanım için herkese açıktır. Herhangi bir yeniden kullanım — kopyalama,
yeniden dağıtma, değiştirme veya başka bir projeye dahil etme — yazardan
(Yevgeniy Achin · amazopic@gmail.com) **önceden yazılı izin** gerektirir.

Bu, OSI onaylı bir açık kaynak lisansı **değildir**. Topluluğun okumasına,
incelemesine ve katkıda bulunmasına izin verirken, dağıtımı ve türev
çalışmaları yazarın kontrolünde tutmaya yönelik bilinçli bir tercihtir.

## ⭐ Faydalı buldunuz mu?

Claude Code'a saatlerce bakıyorsanız, bari güzel bir durum satırına bakın. Başkalarının keşfetmesine yardımcı olmak için **depoya bir ⭐ verin**!

---

**Yevgeniy Achin** tarafından yapıldı · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · Claude Code topluluğu için.
