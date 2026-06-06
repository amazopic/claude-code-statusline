# 🛰️ Claude Code Status Line — 79 tema, blok yang dapat dikonfigurasi, CLI

> Pengganti langsung untuk status line bawaan **Claude Code**: penggunaan **jendela konteks** secara langsung dengan progress bar yang mulus, **biaya sesi** dalam USD, peringatan **batas penggunaan 5 jam / 7 hari**, **branch git** dengan hitungan dirty / ahead / behind, **pelacakan waktu pengerjaan**, dan **nama model** aktif (dengan indikator `(1M)` untuk varian konteks 1M) — semuanya dalam satu baris Bash yang penuh warna. Hadir dengan **79 tema siap pakai** — pilihan teratas (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), klasik (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), merek mobil (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), lebih banyak ilmuwan (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), lebih banyak anime (onepiece, ghibli), lebih banyak Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), tema OS (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), dan agama-agama dunia (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) serta **pustaka 26 blok** untuk menyusun status line Anda sendiri. Termasuk konfigurator CLI lengkap dalam satu perintah dan slash command `/statusline` untuk Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-varian-siap-pakai--pilih-satu-dan-jalankan)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#persyaratan)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · Bahasa Indonesia · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **Tips pro — Kontrol konteks**: Semakin penuh jendela konteks Anda, semakin **kurang efektif** percakapan Anda dengan Claude — dan semakin **cepat** Anda menghabiskan batas 5 jam / 7 hari Anda. Bersihkan atau `/compact` setiap kali Anda melewati **60%** agar tetap bekerja secara efisien.

### ⏳ Hitung mundur reset — rencanakan di seputar batas Anda

Meter 5 jam / 7 hari menyertakan hitung mundur langsung hingga momen setiap jendela di-reset: `5h{1.1h}: 1%` — jendela 5 jam di-reset dalam 1,1 jam; `7d{1.1d}: 0%` — jendela mingguan di-reset dalam 1,1 hari. Anda selalu tahu kapan kembali ke 0%, sehingga Anda dapat menjadwalkan pekerjaan berat tepat setelah reset dan mendistribusikan produktivitas Anda alih-alih menabrak batas di tengah tugas. Ditenagai oleh `rate_limits.*.resets_at` yang dikirim oleh Claude Code; jika build Anda tidak mengirim timestamp reset, meter dengan mulus beralih ke `5h: 1%` biasa.

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**Dapat diprediksi secara desain** — setiap meter menghitung mundur hingga reset-nya, sehingga Anda mengatur ritme kerja alih-alih menabrak tembok.

## ⚡ Mulai cepat

Jalur tercepat — skrip all-in-one yang sudah dipaket dengan CLI bawaan:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # atau: anime, hacker, minimal, …
```

Lalu tambahkan ke `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Mulai ulang Claude Code (atau jalankan reload `/config`). Selesai.

### atau metode vibe-chill · biarkan Claude yang melakukannya

Untuk apa menyentuh terminal kalau Anda punya Claude Code? Tempel satu prompt ini ke sesi Claude Code Anda — Claude menangani setiap langkah dan bertanya sebelum setiap perintah.

```text
Install claude-code-statusline buatan amazopic untuk saya. Pertama, pastikan jq sudah terpasang (jalankan `which jq`) — jika tidak ada, pasang sesuai platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Lalu baca ~/.claude/settings.json — jika ada statusLine.command yang menunjuk ke file yang sudah ada (mis. ~/.claude/status-line.sh atau path lain), cadangkan file itu dengan menambahkan .bak (timpa .bak yang sudah ada). Juga jika ~/.claude/status-line.sh sudah ada, cadangkan dengan cara yang sama. Lalu clone github.com/amazopic/claude-code-statusline, salin statusline-bundle.sh ke ~/.claude/status-line.sh dan buat dapat dieksekusi, juga salin commands/statusline.md ke ~/.claude/commands/. Perbarui ~/.claude/settings.json agar statusLine menjadi { type: "command", command: "<path absolut ke ~/.claude/status-line.sh>" }. Terakhir jalankan ~/.claude/status-line.sh use developer untuk menguji tema developer dan beri tahu saya untuk memulai ulang Claude Code.
```

> Cukup ketik `y` (ya) di setiap prompt izin. Selesai.


## Mengapa status line / status bar kustom untuk Claude Code?

Status line bawaan Claude Code itu minim. Pengganti langsung ini mengubah status bar di bagian bawah menjadi **dashboard sekali lihat** untuk setiap sesi:

- 🔋 Sudah seberapa banyak konteks yang saya habiskan? (bar fraksional mulus dengan langkah 1,25%)
- 💰 Berapa biaya sesi ini?
- 🚦 Seberapa dekat saya dengan batas penggunaan?
- 🧠 Pada level thinking / model apa saya sekarang?
- 🌿 Saya berada di branch git yang mana?

Semuanya dalam **satu baris**, dengan kode warna, lengkap dengan ikon pintar yang menandakan urgensi.

## ✨ Fitur

- 🪐 **Bar konteks langsung** — progress bar 10 sel dengan presisi sub-sel (glif fraksional kuadran atau vertikal)
- 🧠 **Nama model** — dengan indikator `(1M)` untuk varian konteks 1M
- 💸 **Biaya sesi** dalam USD, diperbarui setiap render
- ⬆️⬇️ **Penghitung token per pesan** (input / output)
- 🚦 **Batas penggunaan** — 5 jam / 7 hari dengan peringatan ⚠️ saat > 50%
- 🔄 **Fallback mode-API** — saat tidak ada batas penggunaan yang dialirkan, menampilkan total token sesi (`tokens: NNN K`) dengan pemisah ribuan spasi tipis
- 🚀 **Ikon status pintar** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% pengisian konteks
- 🎨 **ANSI 256 warna** — warna cerah dan berbeda untuk setiap segmen
- 🧩 **Gaya bar yang dapat dipasang** — pilih `quadrant` (▖▄▙█) atau `vertical` (▏▎▍▌▋▊▉█), atau buat sendiri dalam 10 baris bash
- ⚡ **Ringan** — murni `bash` + `jq`. Tanpa Node, tanpa Python, tanpa daemon, tanpa telemetri

## 🎨 158 varian siap pakai — pilih satu dan jalankan

Setiap tema hadir dalam **dua varian**:

- **Detailed** — set fitur lengkap (model, bar konteks, biaya, token, git, waktu, ikon suasana, …)
- **Compact** — hanya `model · konteks % + bar · branch`

Terapkan dengan `~/.claude/status-line.sh use <name>` (tambahkan `-compact` untuk varian compact).

### 🔝 Pilihan teratas (10) — paling banyak diminta, lintas budaya

| Tema | Vibe |
|---|---|
| `cyberpunk`  | distopia neon · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | terminal Matrix hijau fosfor · `[SYS] :: ROOT@matrix#` |
| `dragonball` | penskalaan Goku: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | oranye daun Konoha · meter chakra · 🌀 rasengan |
| `pokemon`    | kuning Pikachu + merah pokeball · bar HP |
| `ironman`    | 🦾 merah Stark + emas arc-reactor |
| `spiderman`  | 🕷 merah + biru webhead · dengan konteks besar datang biaya besar |
| `einstein`   | hijau papan tulis · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ ungu listrik + kuning petir · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + kuning Modena |

### 🛠 Praktis / Klasik (18 tema)

| Tema | File / Terapkan |
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

> Catatan: `cyberpunk` dan `hacker` ada di **Pilihan teratas** di atas — keduanya
> juga ada di folder `examples/` jika Anda ingin instalasi tema tunggal.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Merek mobil (15 lagi, pilihan teratas termasuk `ferrari`)

Hanya hadir di `statusline-bundle.sh` — pilih mana saja dengan `~/.claude/status-line.sh use <name>`.

| Wilayah | Tema |
|---|---|
| 🇪🇺 Eropa   | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 Amerika | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Jepang  | `toyota` · `honda` · `nissan` |
| 🇰🇷 Korea   | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 Ilmuwan besar (8 lagi, pilihan teratas termasuk `einstein` & `tesla`)

| Tema | Vibe |
|---|---|
| `newton`   | tinta perkamen, `🍎`, `F=ma` |
| `curie`    | hijau radium, `☢`, meter waktu-paruh |
| `darwin`   | hijau naturalis, `🐢`, HMS Beagle |
| `hawking`  | ungu ruang angkasa, `🌌`, `t → ∞` |
| `galileo`  | emas matahari, `🔭`, *eppur si muove* |
| `feynman`  | kapur-di-hijau, `〰`, `ψ → ψ'` |
| `turing`   | hijau terminal, `Ⓣ`, bar halting `1/0` |
| `davinci`  | codex sepia, `✎`, *Vitruvian* |

### ✨ Anime (3 lagi, pilihan teratas termasuk `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 Pahlawan super Marvel (8 lagi, pilihan teratas termasuk `ironman` & `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Sistem operasi (10 tema)

| Tema | Vibe |
|---|---|
| `macos`   | 🍎 pelangi enam warna Apple di atas abu-abu krom |
| `windows` | ⊞ ubin empat warna Fluent + cyan WINDOWS 11 |
| `linux`   | 🐧 hitam Tux + paruh oranye |
| `ubuntu`  | ⊕ lingkaran teman — oranye + ungu terong |
| `arch`    | ▲ cyan pacman · btw, I use arch |
| `debian`  | 🌀 pusaran merah · stable / sid / testing |
| `fedora`  | 🎩 biru topi Fedora · freedom + features |
| `kali`    | 🐉 biru Kali + merah offsec · mode-pwn |
| `mint`    | 🌿 hijau cinnamon mint · shell yang paling ramah |
| `nixos`   | ❄ kepingan salju biru Nix · deklaratif, reproducible |

### 🕊 Agama dunia (7 teratas berdasarkan jumlah penganut)

| Tema | Vibe |
|---|---|
| `christianity` | ✝ merah anggur + biru Marian + emas kepausan · meter iman, € sedekah |
| `islam`        | ☪ hijau Islam + putih + kaligrafi emas · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 saffron + marigold + vermilion · dharma, ₹ seva |
| `buddhism`     | ☸ saffron biksu + emas + maroon · karma, ฿ dāna |
| `judaism`      | ✡ biru tallit + putih + emas menorah · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ biru tua Khalsa + saffron + putih · sewa, daswandh |
| `shinto`       | ⛩ torii vermilion + putih kuil + emas · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # salah satu dari 79 tema mana pun berfungsi
```

**Lihat semuanya di terminal Anda lebih dulu** — setiap varian punya
preview yang sudah dirender di [`screenshots/`](screenshots/):

```bash
# preview satu saja
cat screenshots/statusline-cyberpunk.ansi

# atau jelajahi seluruh galeri (158 varian + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Lihat [`examples/README.md`](examples/README.md) untuk tabel lengkap beserta
deskripsi, dan [`screenshots/README.md`](screenshots/README.md) untuk
cara preview dibuat.

## 🧱 Susun sendiri dari blok

Tidak ingin pakai preset? Susun status line kustom dari pustaka
blok bernama — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

Lihat [**BLOCKS.md**](BLOCKS.md) untuk:

- **katalog blok** (masing-masing berupa snippet bash yang siap salin-tempel)
- **paket gaya** (palet warna & pemisah dari `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- **resep 3 langkah** untuk membuat baris Anda sendiri: pilih gaya → daftar blok
  → tempel

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 Bundle all-in-one (`statusline-bundle.sh`)

Jika Anda tidak ingin mengelola 40+ file, ambil **satu skrip
bundel** [`statusline-bundle.sh`](statusline-bundle.sh) — berisi
setiap tema + setiap blok + konfigurator CLI dalam satu file.

```bash
cp statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh

~/.claude/status-line.sh use cyberpunk            # ganti tema
~/.claude/status-line.sh use cyberpunk-compact    # gunakan varian compact
~/.claude/status-line.sh custom model context-bar git cost  # susun dari blok
~/.claude/status-line.sh list                     # daftar tema
~/.claude/status-line.sh list blocks              # daftar blok
~/.claude/status-line.sh preview anime            # preview tanpa menyimpan
~/.claude/status-line.sh show                     # tampilkan konfigurasi saat ini
~/.claude/status-line.sh reset                    # reset ke default
```

Konfigurasi disimpan di `~/.claude/statusline.conf` dan tetap ada
antar restart. File yang sama berperan sebagai **renderer** (saat
dipanggil oleh Claude Code dengan JSON di stdin) sekaligus **konfigurator**
(saat Anda memanggilnya dengan argumen).

### Slash command `/statusline`

Letakkan [`commands/statusline.md`](commands/statusline.md) ke dalam
`~/.claude/commands/` untuk mengaktifkan slash command `/statusline` di dalam
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Lalu di sesi Claude Code mana pun Anda dapat mengetik:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude akan menjalankan CLI bundel untuk Anda, melaporkan hasilnya, dan
mengingatkan Anda untuk reload.

### Alias shell opsional

```bash
alias statusline='~/.claude/status-line.sh'
```

Lalu `statusline cyberpunk` berfungsi dari terminal mana pun.

## 🚀 Instalasi

### Instalasi manual (3 langkah)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Lalu tambahkan ke `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Mulai ulang Claude Code (atau jalankan reload `/config`).

### Instalasi via agen Claude Code (dengan cadangan otomatis)

Ingin Claude Code memasangnya dengan aman untuk Anda? Tempel prompt ini:

> "Pasang status line dari repo ini sebagai status line Claude Code saya:
> 1. Jika `~/.claude/status-line.sh` sudah ada, cadangkan ke
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (pilih akhiran `-N`
>    yang kosong jika cadangan dengan nama itu sudah ada).
> 2. Salin `statusline.sh` dari repo ini ke `~/.claude/status-line.sh` lalu `chmod +x`.
> 3. Baca `~/.claude/settings.json`. Jika tidak ada kunci `statusLine`, tambahkan
>    blok `statusLine` yang menunjuk ke path absolut skrip. Jika
>    `statusLine` sudah ada dan menunjuk ke tempat lain, cadangkan dulu
>    `settings.json` ke `.bak.<timestamp>`.
> 4. Uji-coba skrip:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Beri tahu saya untuk memulai ulang Claude Code dan laporkan cadangan yang dibuat."

### Memperbarui ke versi terbaru

```bash
~/.claude/status-line.sh update
```

Mengambil bundel terbaru dari GitHub, membuat cadangan bertimestamp
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), dan mempertahankan
konfigurasi tema Anda (`~/.claude/statusline.conf`). Mulai ulang Claude Code setelahnya.

Periksa versi yang terpasang: `~/.claude/status-line.sh version`.

### Persyaratan

- `bash` 4+ (skrip menggunakan array berindeks-0 — **jangan jalankan di bawah `zsh`**)
- `jq` untuk mengurai JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (hanya dibutuhkan untuk `statusline update`; sudah terpasang di sebagian besar sistem)
- Terminal 256-warna (pada dasarnya semua terminal modern)

## ⚙️ Konfigurasi

Sunting konstanta di dekat bagian atas `statusline.sh`:

| Variabel / fungsi | Apa yang dikontrol |
|---|---|
| `BAR_STYLE` | `"quadrant"` (default, langkah 2,5%) atau `"vertical"` (langkah 1,25%) |
| `pct_icon()` | Ambang batas untuk ikon 🚀 / 🚗 / ⚠️ sebelum bar |
| `pct_color()` | Ambang batas warna untuk persentase / bar |
| Konstanta warna ANSI | Warnai ulang segmen mana pun (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 vs status line bawaan Claude Code

| Kemampuan | Bawaan | Proyek ini |
|---|---|---|
| **Nama model** aktif | ✅ | ✅ (dengan flag `(1M)` untuk varian konteks 1M) |
| **Jendela konteks** % terpakai | ❌ | ✅ langsung, presisi 1,25% |
| **Progress bar** untuk konteks | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **Biaya sesi** dalam USD | ❌ | ✅ diperbarui setiap render |
| Penghitung token input/output **per pesan** | ❌ | ✅ |
| **Total token sesi** (fallback mode API) | ❌ | ✅ |
| Indikator **batas penggunaan 5 jam / 7 hari** dengan ⚠️ saat > 50% | ❌ | ✅ |
| Hitung mundur reset di meter batas (`5h{1.1h}`) | ❌ | ✅ |
| **Branch git** + dirty + ahead/behind | ❌ | ✅ |
| **Waktu pengerjaan** (active vs jam dinding) | ❌ | ✅ |
| Tampilan level **thinking / effort** | ❌ | ✅ |
| Preset bertema | ❌ | ✅ 79 tema × 2 varian = **158 siap pakai** |
| Susun dari blok bernama | ❌ | ✅ 26 blok, lihat [BLOCKS.md](BLOCKS.md) |
| Konfigurator CLI bawaan | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Slash command `/statusline` Claude Code | ❌ | ✅ opsional, lihat [`commands/`](commands/) |
| Dependensi eksternal | — | `bash` 4+ dan `jq` (tanpa Node, tanpa Python, tanpa daemon) |
| Lisensi | — | Source-Available (penggunaan-ulang-dengan-izin) |

## 💡 Kasus penggunaan

Skenario konkret di mana proyek ini sepadan dengan dirinya sendiri:

- **"Sudah seberapa banyak dari konteks 1 M saya yang terpakai?"** — lihat persen + bar langsung sebelum setiap prompt.
- **"Berapa biaya sesi Claude Code ini?"** — total USD berjalan, diperbarui setiap render.
- **"Apakah saya akan mencapai batas penggunaan hari ini?"** — indikator 5 jam / 7 hari dengan ⚠️ saat > 50%.
- **"Apakah saya berada di branch yang benar?"** — branch git + dirty + ahead/behind di status line Anda.
- **"Berapa jam sesungguhnya yang saya habiskan untuk fitur ini?"** — pelacak waktu pengerjaan (`active` vs `wall`).
- **"Saya ingin terminal saya menyenangkan."** — tema anime, cyberpunk, hacker, retro, weather, ocean, fire, dan lainnya.
- **"Saya ingin status line minimal, hanya-ASCII untuk perekaman layar."** — tema `zen`.
- **"Saya ingin merilis status line yang dipakai seluruh tim saya."** — satu skrip bundel + konfigurator CLI + slash command.

## ❓ FAQ

### Apa itu "Claude Code Status Line"?

Pengganti berbasis bash untuk status line bawaan di [Claude Code](https://claude.com/claude-code) (CLI dari Anthropic). Ia mengubah baris di bagian bawah layar menjadi dashboard sungguhan: model, konteks %, progress bar, biaya sesi, batas penggunaan, status git, waktu pengerjaan, dan lainnya.

### Apa arti `5h{1.1h}: 1%`?

Anda telah memakai 1% dari jendela 5 jam, dan `{1.1h}` adalah hitung mundur langsung — jendela di-reset dalam 1,1 jam (`7d{1.1d}`: jendela mingguan di-reset dalam 1,1 hari). Dibaca dari `rate_limits.*.resets_at` pada setiap render. Tidak ada timestamp reset di build Anda? Meter beralih ke `5h: 1%` biasa.

### Bagaimana cara memasangnya?

Salin `statusline-bundle.sh` ke `~/.claude/status-line.sh`, `chmod +x`, lalu arahkan `statusLine.command` di `~/.claude/settings.json` Claude Code ke path itu. Instruksi lengkap ada di bagian [Mulai cepat](#-mulai-cepat) dan [Instalasi](#-instalasi).

### Apakah mendukung model jendela konteks 1 M?

Ya. Skrip mendeteksi `[1m]` di id model dan `1M` di nama tampilan lalu menyesuaikan penyebut bar menjadi 1.000.000 token. Anda akan melihat `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### Bekerja dengan model apa saja?

Model apa pun yang didukung Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, dsb. Skrip membaca `model.display_name` dan `model.id` dari JSON stdin yang disediakan Claude Code; ia tidak meng-hardcode nama model.

### Bisakah saya menyesuaikan warna, tema, atau menambahkan milik saya sendiri?

Ya — tiga cara:

1. Pilih salah satu dari **79 tema** (total 158 varian) — gunakan `~/.claude/status-line.sh use <name>` atau jelajahi [`examples/`](examples/) untuk skrip mandirinya.
2. Susun sendiri dari **blok bernama** — lihat [BLOCKS.md](BLOCKS.md).
3. Sunting konstanta warna dan gaya bar di `statusline.sh` secara langsung.

### Apakah akan memperlambat Claude Code?

Tidak. Setiap render berjalan sekali per penggambaran ulang status, mengurai JSON yang dialirkan dengan `jq`, opsional `grep` baris terakhir transkrip, lalu mencetak. Render tipikal ≤ 50 ms bahkan dengan pelacak waktu aktif.

### Apakah bekerja tanpa `jq`?

`jq` wajib ada — ia mengurai JSON yang dikirim Claude Code di stdin. Pasang melalui `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), atau `choco install jq` (Windows).

### Apakah bekerja di Windows?

Ya, di lingkungan apa pun yang menjalankan `bash` 4+ dan `jq` — Git Bash, WSL, MSYS2, Cygwin. CMD/PowerShell murni tidak didukung.

### Apakah bekerja di Linux / macOS?

Ya, di keduanya. macOS menggunakan `date` BSD, Linux menggunakan `date` GNU — pelacak waktu menangani keduanya secara transparan.

### Bisakah saya memakai ini dengan API Anthropic mentah alih-alih Claude Code?

Sebagian. Status line dirancang untuk format JSON stdin Claude Code. Untuk penggunaan API mentah, indikator batas penggunaan otomatis beralih ke tampilan **total token sesi** (`tokens: NNN K`).

### Di mana konfigurasi disimpan?

`~/.claude/statusline.conf` — file kecil yang di-source shell, ditulis oleh CLI bundel (`statusline.sh use <theme>` dll.). Tetap ada antar restart.

### Bagaimana cara kembali ke status line bawaan Claude Code?

Hapus blok `statusLine` dari `~/.claude/settings.json`, atau jalankan `~/.claude/status-line.sh reset` lalu beralih ke tema `minimal` yang sangat mirip dengan bawaan.

### Apakah gratis? Bisakah saya memakainya secara komersial?

Penggunaan pribadi dan lokal gratis — lihat [Lisensi Source-Available](LICENSE). Setiap penggunaan ulang, redistribusi, fork, atau penyertaan dalam proyek lain memerlukan **izin tertulis terlebih dahulu** dari penulis (Yevgeniy Achin · amazopic@gmail.com). Permintaan yang wajar biasanya dikabulkan.

### Bagaimana cara kerja pelacak "jam-manusia"?

Tema `time` membaca timestamp dari transkrip JSONL dan melaporkan dua durasi: **active** (jumlah jeda antar-pesan yang lebih pendek dari 5 menit) dan **wall** (rentang total dari pesan pertama hingga terakhir). Ambang idle 5 menit dapat dikonfigurasi.

## 🏷️ Topik GitHub yang disarankan

Saat Anda menerbitkan repo ini, tambahkan topik-topik ini untuk memaksimalkan keterlihatan:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Berkontribusi

Issue dan PR disambut — tetapi perhatikan lisensinya:

- **Membaca, membuka issue, mengirim PR**: gratis.
- **Fork, menyalin ke proyek lain, redistribusi**: memerlukan
  izin tertulis terlebih dahulu dari penulis.

Untuk meminta izin penggunaan ulang, hubungi:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Permintaan yang wajar untuk penggunaan pribadi, edukasi, dan non-komersial
biasanya dikabulkan secara cuma-cuma.

## 📜 Lisensi

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

Source proyek ini tersedia untuk umum untuk dibaca, dipelajari, dan
digunakan secara pribadi di mesin Anda sendiri. Setiap penggunaan ulang — menyalin, mendistribusikan ulang,
memodifikasi, atau menyertakan dalam proyek lain — memerlukan **izin tertulis
terlebih dahulu** dari penulis (Yevgeniy Achin · amazopic@gmail.com).

Ini **bukan** lisensi open-source yang disetujui OSI. Ini adalah pilihan
yang disengaja untuk menjaga distribusi dan karya turunan tetap di bawah kendali
penulis sambil tetap memungkinkan komunitas membaca, mempelajari, dan berkontribusi.

## ⭐ Merasa berguna?

Jika Anda menghabiskan berjam-jam menatap Claude Code, sekalian saja menatap status line yang indah. **Beri repo ⭐** untuk membantu orang lain menemukannya!

---

Dibuat oleh **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · untuk komunitas Claude Code.
