# 🛰️ Claude Code Status Line — 82 ธีม, บล็อกที่ปรับแต่งได้, CLI

> ตัวแทนแบบ drop-in สำหรับสเตตัสไลน์เริ่มต้นของ **Claude Code**: แสดงการใช้งาน **context window** แบบสดพร้อมแถบความคืบหน้าที่ลื่นไหล, **ค่าใช้จ่ายต่อเซสชัน** เป็นดอลลาร์สหรัฐ, คำเตือน **5h / 7d rate-limit**, **git branch** พร้อมตัวนับ dirty / ahead / behind, **การติดตามเวลาที่ใช้กับงาน**, และ **ชื่อโมเดล** ที่กำลังใช้งาน (พร้อมตัวบ่งชี้ `(1M)` สำหรับรุ่นที่มี context 1M) — ทั้งหมดอยู่ในบรรทัด Bash สีสันสดใสบรรทัดเดียว มาพร้อม **82 ธีมสำเร็จรูป** — ตัวเลือกยอดนิยม (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), คลาสสิก (minimal, developer, muted, mono, hard-worker, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), แบรนด์รถยนต์ (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), นักวิทยาศาสตร์เพิ่มเติม (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), อนิเมะเพิ่มเติม (onepiece, ghibli), Marvel เพิ่มเติม (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), ธีมระบบปฏิบัติการ (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), และศาสนาของโลก (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) พร้อม **คลังบล็อก 26 บล็อก** ให้คุณประกอบของคุณเอง รวมถึง CLI configurator แบบครบในตัวเดียว และ slash command `/statusline` สำหรับ Claude Code

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 164](https://img.shields.io/badge/variants-164-brightgreen.svg)](#-164-ธีมสำเร็จรูป--เลือกแล้วใช้ได้เลย)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#ความต้องการของระบบ)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**ภาษา:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md) · ไทย · [עברית](README.he.md) · [বাংলা](README.bn.md) · [اردو](README.ur.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **เคล็ดลับ — การควบคุม context**: ยิ่ง context window ของคุณเต็มมากเท่าไหร่ การสนทนากับ Claude ก็ยิ่ง **มีประสิทธิภาพน้อยลง** — และคุณก็ **เผาผลาญ** ลิมิต 5h/7d ได้ **เร็วขึ้น** ล้างหรือ `/compact` ทุกครั้งที่คุณเกิน **60%** เพื่อให้ทำงานได้อย่างมีประสิทธิภาพต่อไป

### ⏳ นับถอยหลังการรีเซ็ต — วางแผนรอบลิมิตของคุณ

มิเตอร์ 5h / 7d รวมการนับถอยหลังแบบสดไปยังช่วงเวลาที่แต่ละหน้าต่างจะรีเซ็ต: `5h{1.1h}: 1%` — หน้าต่าง 5 ชั่วโมงจะรีเซ็ตใน 1.1 ชั่วโมง; `7d{1.1d}: 0%` — หน้าต่างรายสัปดาห์จะรีเซ็ตใน 1.1 วัน คุณจะรู้เสมอว่าเมื่อไหร่ที่คุณจะกลับมาอยู่ที่ 0% ดังนั้นคุณสามารถจัดตารางงานหนักได้ทันทีหลังจากการรีเซ็ตและกระจายประสิทธิภาพการทำงานของคุณ แทนที่จะชนเพดานกลางงาน ขับเคลื่อนด้วย `rate_limits.*.resets_at` ที่ส่งโดย Claude Code; หากบิลด์ของคุณไม่ส่ง timestamp การรีเซ็ต มิเตอร์จะถอยกลับไปแสดงแบบธรรมดา `5h: 1%` อย่างนุ่มนวล

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**คาดเดาได้ตามการออกแบบ** — มิเตอร์ทุกตัวนับถอยหลังไปยังการรีเซ็ตของมัน ดังนั้นคุณจึงกำหนดจังหวะการทำงานของตัวเองได้ แทนที่จะชนกำแพง

## ⚡ เริ่มต้นอย่างรวดเร็ว

เส้นทางที่เร็วที่สุด — สคริปต์ครบในตัวเดียวพร้อม CLI ในตัว:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

จากนั้นเพิ่มลงใน `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 `refreshInterval: 30` รันบรรทัดใหม่ทุก 30 วินาที แม้ในขณะที่เซสชันว่างอยู่ — ทำให้การนับถอยหลังการรีเซ็ต (`5h{1.1h}`), ตัวติดตามเวลา และการพลิกค่าหลังรีเซ็ตยังคงทำงานสด 30 เป็นค่าเริ่มต้นที่เหมาะสม; 60 ประหยัดแบตเตอรี่กว่า; ละไว้เพื่อรีเฟรชเฉพาะตอนมีเหตุการณ์ (ข้อความใหม่จากผู้ช่วย, `/compact`, การสลับ vim)

รีสตาร์ท Claude Code (หรือรัน `/config` reload) เสร็จเรียบร้อย

### หรือวิธีชิลล์ๆ · ให้ Claude ทำให้

ทำไมต้องแตะเทอร์มินัลในเมื่อคุณมี Claude Code? วางพรอมต์เดียวนี้ลงในเซสชัน Claude Code ของคุณ — Claude จะจัดการทุกขั้นตอนและถามก่อนทุกคำสั่ง

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", "refreshInterval": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> เพียงพิมพ์ `y` (yes) ที่ทุกคำขออนุญาต เสร็จเรียบร้อย


## ทำไมต้องมีสเตตัสไลน์ / แถบสถานะแบบกำหนดเองสำหรับ Claude Code?

สเตตัสไลน์เริ่มต้นของ Claude Code นั้นเรียบง่ายเกินไป ตัวแทนแบบ drop-in นี้เปลี่ยนแถบสถานะด้านล่างให้กลายเป็น **แดชบอร์ดที่เห็นได้ในพริบตา** สำหรับทุกเซสชัน:

- 🔋 ฉันใช้ context ไปเท่าไหร่แล้ว? (แถบเศษส่วนที่ลื่นไหล 1.25%)
- 💰 เซสชันนี้กำลังทำให้ฉันเสียค่าใช้จ่ายเท่าไหร่?
- 🚦 ฉันใกล้ถึง rate limit แค่ไหนแล้ว?
- 🧠 ฉันกำลังอยู่ในระดับการคิด / โมเดลใด?
- 🌿 ฉันอยู่บน git branch ไหน?

ทั้งหมดอยู่ใน **บรรทัดเดียว** เข้ารหัสด้วยสี พร้อมไอคอนอัจฉริยะที่ส่งสัญญาณความเร่งด่วน

## ✨ คุณสมบัติ

- 🪐 **แถบ context แบบสด** — แถบความคืบหน้า 10 ช่องพร้อมความแม่นยำระดับย่อยช่อง (quadrant หรือ vertical fractional glyphs)
- 🧠 **ชื่อโมเดล** — พร้อมตัวบ่งชี้ `(1M)` สำหรับรุ่นที่มี context 1M
- 💸 **ค่าใช้จ่ายต่อเซสชัน** เป็นดอลลาร์สหรัฐ อัปเดตทุกครั้งที่เรนเดอร์
- ⬆️⬇️ **ตัวนับ token ต่อข้อความ** (input / output)
- 🚦 **Rate limits** — 5h / 7d พร้อมคำเตือน ⚠️ เมื่อ > 50%
- 🔄 **โหมด API fallback** — เมื่อไม่มี rate limit ส่งเข้ามา จะแสดง token รวมทั้งเซสชัน (`tokens: NNN K`) พร้อมตัวคั่นหลักพันด้วย thin-space
- 🚀 **ไอคอนสถานะอัจฉริยะ** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% ของ context fill
- 🎨 **256-color ANSI** — สีสว่าง แยกแยะได้ชัดเจนในแต่ละส่วน
- 🧩 **สไตล์แถบแบบ pluggable** — เลือก `quadrant` (▖▄▙█) หรือ `vertical` (▏▎▍▌▋▊▉█) หรือสร้างของคุณเองใน bash 10 บรรทัด
- ⚡ **เบา** — `bash` + `jq` ล้วน ไม่มี Node ไม่มี Python ไม่มี daemon ไม่มี telemetry

## 🎨 164 ธีมสำเร็จรูป — เลือกแล้วใช้ได้เลย

แต่ละธีมมาพร้อม **สองแบบ**:

- **Detailed** — ชุดคุณสมบัติเต็ม (model, context bar, cost, tokens, git, time, mood icon, …)
- **Compact** — เฉพาะ `model · context % + bar · branch` เท่านั้น

ใช้งานด้วย `~/.claude/status-line.sh use <name>` (เติม `-compact` สำหรับแบบ compact)

### 🔝 ตัวเลือกยอดนิยม (10) — ที่ถูกขอมากที่สุด ข้ามวัฒนธรรม

| ธีม | สไตล์ |
|---|---|
| `cyberpunk`  | นีออนดิสโทเปีย · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | เทอร์มินัล Matrix สีเขียวฟอสฟอร์ · `[SYS] :: ROOT@matrix#` |
| `dragonball` | การสเกลของโกคู: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | สีส้มใบไม้แห่งโคโนฮะ · มิเตอร์ chakra · 🌀 rasengan |
| `pokemon`    | สีเหลืองพิคาชู + สีแดงโปเกบอล · แถบ HP |
| `ironman`    | 🦾 สีแดง Stark + arc-reactor สีทอง |
| `spiderman`  | 🕷 สีแดง webhead + สีน้ำเงิน · พลังที่ยิ่งใหญ่มาพร้อมต้นทุนที่ยิ่งใหญ่ |
| `einstein`   | สีเขียวกระดานชอล์ก · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ สีม่วงไฟฟ้า + สีเหลืองสายฟ้า · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + สีเหลือง Modena |

### 🛠 ใช้งานจริง / คลาสสิก (21 ธีม)

| ธีม | ไฟล์ / การใช้งาน |
|---|---|
| 🛠 minimal       | [`statusline-minimal.sh`](examples/statusline-minimal.sh) · `use minimal` |
| 🛠 developer     | [`statusline-developer.sh`](examples/statusline-developer.sh) · `use developer` |
| 🛠 muted         | `use muted` |
| 🛠 mono          | `use mono` |
| 🛠 hard-worker   | `use hard-worker` |
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

> หมายเหตุ: `cyberpunk` และ `hacker` อยู่ใน **ตัวเลือกยอดนิยม** ด้านบน — พวกมันอยู่ในโฟลเดอร์
> `examples/` ด้วย หากคุณต้องการติดตั้งธีมเดียว

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 แบรนด์รถยนต์ (อีก 16 ตัวเลือกยอดนิยมมี `ferrari`)

มาพร้อมใน `statusline-bundle.sh` เท่านั้น — เลือกตัวใดก็ได้ด้วย `~/.claude/status-line.sh use <name>`

| ภูมิภาค | ธีม |
|---|---|
| 🇪🇺 ยุโรป  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 อเมริกา | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 ญี่ปุ่น   | `toyota` · `honda` · `nissan` |
| 🇰🇷 เกาหลี   | `hyundai` · `kia` |
| 🇨🇳 จีน   | `byd` · `nio` · `geely` |

### 🔬 นักวิทยาศาสตร์ผู้ยิ่งใหญ่ (อีก 8 ตัวเลือกยอดนิยมมี `einstein` และ `tesla`)

| ธีม | สไตล์ |
|---|---|
| `newton`   | หมึกบนกระดาษ parchment, `🍎`, `F=ma` |
| `curie`    | สีเขียวเรเดียม, `☢`, มิเตอร์ครึ่งชีวิต |
| `darwin`   | สีเขียวนักธรรมชาติวิทยา, `🐢`, HMS Beagle |
| `hawking`  | สีม่วงห้วงอวกาศ, `🌌`, `t → ∞` |
| `galileo`  | สีทองดวงอาทิตย์, `🔭`, *eppur si muove* |
| `feynman`  | ชอล์กบนสีเขียว, `〰`, `ψ → ψ'` |
| `turing`   | สีเขียวเทอร์มินัล, `Ⓣ`, แถบ halting `1/0` |
| `davinci`  | codex สีซีเปีย, `✎`, *Vitruvian* |

### ✨ อนิเมะ (อีก 3 ตัวเลือกยอดนิยมมี `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 ฮีโร่ Marvel (อีก 8 ตัวเลือกยอดนิยมมี `ironman` และ `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 ระบบปฏิบัติการ (10 ธีม)

| ธีม | สไตล์ |
|---|---|
| `macos`   | 🍎 สายรุ้งหกสี Apple บนพื้นเทาโครเมียม |
| `windows` | ⊞ ไทล์สี่สี Fluent + WINDOWS 11 สีฟ้า |
| `linux`   | 🐧 Tux สีดำ + จะงอยปากสีส้ม |
| `ubuntu`  | ⊕ วงกลมแห่งมิตรภาพ — สีส้ม + สีม่วงมะเขือยาว |
| `arch`    | ▲ pacman สีฟ้า · btw, I use arch |
| `debian`  | 🌀 ก้นหอยสีแดง · stable / sid / testing |
| `fedora`  | 🎩 หมวก Fedora สีน้ำเงิน · freedom + features |
| `kali`    | 🐉 Kali สีน้ำเงิน + offsec สีแดง · pwn-mode |
| `mint`    | 🌿 สีเขียวมินต์อบเชย · เชลล์ที่เป็นมิตรที่สุด |
| `nixos`   | ❄ เกล็ดหิมะ Nix สีน้ำเงิน · declarative, reproducible |

### 🕊 ศาสนาของโลก (7 อันดับแรกตามจำนวนผู้นับถือ)

| ธีม | สไตล์ |
|---|---|
| `christianity` | ✝ สีแดงไวน์ + สีน้ำเงิน Marian + สีทองสันตะปาปา · มิเตอร์ศรัทธา, € ทาน |
| `islam`        | ☪ สีเขียวอิสลาม + สีขาว + อักษรวิจิตรสีทอง · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 สีหญ้าฝรั่น + สีดาวเรือง + สีแดงชาด · dharma, ₹ seva |
| `buddhism`     | ☸ สีหญ้าฝรั่นพระ + สีทอง + สีน้ำตาลแดง · karma, ฿ dāna |
| `judaism`      | ✡ สีน้ำเงิน tallit + สีขาว + สีทอง menorah · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ สีน้ำเงินเข้ม Khalsa + สีหญ้าฝรั่น + สีขาว · sewa, daswandh |
| `shinto`       | ⛩ torii สีแดงชาด + ศาลเจ้าสีขาว + สีทอง · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 82 themes works
```

**เรียกดูทั้งหมดในเทอร์มินัลของคุณก่อน** — ทุกแบบมี
พรีวิวที่เรนเดอร์ไว้ล่วงหน้าใน [`screenshots/`](screenshots/):

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (164 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

ดู [`examples/README.md`](examples/README.md) สำหรับตารางเต็มพร้อม
คำอธิบาย และ [`screenshots/README.md`](screenshots/README.md) สำหรับ
วิธีการสร้างพรีวิว

## 🧱 สร้างของคุณเองจากบล็อก

ไม่อยากใช้พรีเซ็ต? ประกอบสเตตัสไลน์แบบกำหนดเองจากคลัง
ของบล็อกที่มีชื่อ — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

ดู [**BLOCKS.md**](BLOCKS.md) สำหรับ:

- **แคตตาล็อกของบล็อก** (แต่ละตัวเป็น bash snippet ที่คัดลอกวางได้)
- **style packs** (จานสี & ตัวคั่นจาก `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- **สูตร 3 ขั้นตอน** เพื่อสร้างบรรทัดของคุณเอง: เลือกสไตล์ → ระบุบล็อก
  → วาง

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 บันเดิลครบในตัวเดียว (`statusline-bundle.sh`)

หากคุณไม่อยากจัดการไฟล์มากกว่า 40 ไฟล์ ให้คว้า **สคริปต์บันเดิล
ตัวเดียว** [`statusline-bundle.sh`](statusline-bundle.sh) — มันมี
ทุกธีม + ทุกบล็อก + CLI configurator ในไฟล์เดียว

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

การกำหนดค่าจะถูกบันทึกไว้ที่ `~/.claude/statusline.conf` และคงอยู่
ข้ามการรีสตาร์ท ไฟล์เดียวกันทำหน้าที่เป็นทั้ง **ตัวเรนเดอร์** (เมื่อ
ถูกเรียกโดย Claude Code ด้วย JSON บน stdin) และ **ตัว configurator**
(เมื่อคุณเรียกมันด้วยอาร์กิวเมนต์)

### slash command `/statusline`

วาง [`commands/statusline.md`](commands/statusline.md) ลงใน
`~/.claude/commands/` เพื่อเปิดใช้งาน slash command `/statusline` ภายใน
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

จากนั้นในเซสชัน Claude Code ใดๆ คุณสามารถพิมพ์:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude จะรัน CLI ของบันเดิลให้คุณ รายงานผล และเตือน
ให้คุณ reload

### shell alias (ทางเลือก)

```bash
alias statusline='~/.claude/status-line.sh'
```

จากนั้น `statusline cyberpunk` จะใช้งานได้จากทุกเทอร์มินัล

## 🚀 การติดตั้ง

### ติดตั้งด้วยตนเอง (3 ขั้นตอน)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

จากนั้นเพิ่มลงใน `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 `refreshInterval: 30` รันบรรทัดใหม่ทุก 30 วินาที แม้ในขณะที่เซสชันว่างอยู่ — ทำให้การนับถอยหลังการรีเซ็ต (`5h{1.1h}`), ตัวติดตามเวลา และการพลิกค่าหลังรีเซ็ตยังคงทำงานสด 30 เป็นค่าเริ่มต้นที่เหมาะสม; 60 ประหยัดแบตเตอรี่กว่า; ละไว้เพื่อรีเฟรชเฉพาะตอนมีเหตุการณ์ (ข้อความใหม่จากผู้ช่วย, `/compact`, การสลับ vim)

รีสตาร์ท Claude Code (หรือรัน `/config` reload)

### ติดตั้งผ่าน Claude Code agent (พร้อมสำรองข้อมูลอัตโนมัติ)

อยากให้ Claude Code ติดตั้งให้คุณอย่างปลอดภัย? วางพรอมต์นี้:

> "Install the status line from this repo as my Claude Code status line:
> 1. If `~/.claude/status-line.sh` already exists, back it up to
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (pick a free `-N`
>    suffix if a backup with that name already exists).
> 2. Copy `statusline.sh` from this repo to `~/.claude/status-line.sh` and `chmod +x`.
> 3. Read `~/.claude/settings.json`. If it has no `statusLine` key, add a
>    `statusLine` block pointing to the absolute path of the script and
>    including `"refreshInterval": 30`. If `statusLine` already exists and
>    points elsewhere, back up `settings.json` to `.bak.<timestamp>` first.
> 4. Smoke-test the script:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Tell me to restart Claude Code and report the backups created."

### การอัปเดตเป็นเวอร์ชันล่าสุด

```bash
~/.claude/status-line.sh update
```

ดึงบันเดิลล่าสุดจาก GitHub สร้างการสำรองข้อมูลพร้อม timestamp
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) และเก็บรักษาการกำหนดค่า
ธีมของคุณ (`~/.claude/statusline.conf`) รีสตาร์ท Claude Code หลังจากนั้น

ตรวจสอบว่าคุณติดตั้งอะไรไว้: `~/.claude/status-line.sh version`

### ความต้องการของระบบ

- `bash` 4+ (สคริปต์ใช้ array แบบ 0-indexed — **อย่ารันภายใต้ `zsh`**)
- `jq` สำหรับการ parse JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (จำเป็นเฉพาะสำหรับ `statusline update`; ติดตั้งมาแล้วในระบบส่วนใหญ่)
- เทอร์มินัลแบบ 256 สี (โดยพื้นฐานทุกตัวที่ทันสมัย)

## ⚙️ การกำหนดค่า

แก้ไขค่าคงที่ใกล้ส่วนบนของ `statusline.sh`:

| ตัวแปร / ฟังก์ชัน | ควบคุมอะไร |
|---|---|
| `BAR_STYLE` | `"quadrant"` (ค่าเริ่มต้น, ขั้นละ 2.5%) หรือ `"vertical"` (ขั้นละ 1.25%) |
| `pct_icon()` | เกณฑ์สำหรับไอคอน 🚀 / 🚗 / ⚠️ ก่อนแถบ |
| `pct_color()` | เกณฑ์สีสำหรับเปอร์เซ็นต์ / แถบ |
| ค่าคงที่สี ANSI | เปลี่ยนสีส่วนใดก็ได้ (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 เทียบกับสเตตัสไลน์เริ่มต้นของ Claude Code

| ความสามารถ | เริ่มต้น | โปรเจกต์นี้ |
|---|---|---|
| **ชื่อโมเดล** ที่กำลังใช้งาน | ✅ | ✅ (พร้อมแฟล็ก `(1M)` สำหรับรุ่นที่มี context 1M) |
| **Context window** % ที่ใช้ไป | ❌ | ✅ สด, ความแม่นยำ 1.25 % |
| **แถบความคืบหน้า** สำหรับ context | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **ค่าใช้จ่ายต่อเซสชัน** เป็นดอลลาร์สหรัฐ | ❌ | ✅ อัปเดตทุกครั้งที่เรนเดอร์ |
| ตัวนับ token input/output **ต่อข้อความ** | ❌ | ✅ |
| **token รวมทั้งเซสชัน** (โหมด API fallback) | ❌ | ✅ |
| ตัวบ่งชี้ **5h / 7d rate-limit** พร้อม ⚠️ ที่ > 50 % | ❌ | ✅ |
| การนับถอยหลังการรีเซ็ตในมิเตอร์ลิมิต (`5h{1.1h}`) | ❌ | ✅ |
| **Git branch** + dirty + ahead/behind | ❌ | ✅ |
| **เวลาที่ใช้กับงาน** (active เทียบกับ wall clock) | ❌ | ✅ |
| การแสดง **ระดับการคิด / effort** | ❌ | ✅ |
| พรีเซ็ตธีม | ❌ | ✅ 82 ธีม × 2 แบบ = **164 สำเร็จรูป** |
| ประกอบจากบล็อกที่มีชื่อ | ❌ | ✅ 26 บล็อก ดู [BLOCKS.md](BLOCKS.md) |
| CLI configurator ในตัว | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| slash command `/statusline` ของ Claude Code | ❌ | ✅ ทางเลือก ดู [`commands/`](commands/) |
| dependency ภายนอก | — | `bash` 4+ และ `jq` (ไม่มี Node, ไม่มี Python, ไม่มี daemon) |
| ลิขสิทธิ์ | — | Source-Available (reuse-by-permission) |

## 💡 กรณีการใช้งาน

สถานการณ์รูปธรรมที่โปรเจกต์นี้คุ้มค่า:

- **"ฉันใช้ context 1 M ไปเท่าไหร่แล้ว?"** — เห็นเปอร์เซ็นต์ + แถบแบบสดก่อนทุกพรอมต์
- **"เซสชัน Claude Code นี้ทำให้ฉันเสียค่าใช้จ่ายเท่าไหร่?"** — ยอดรวมดอลลาร์สหรัฐที่อัปเดตทุกครั้งที่เรนเดอร์
- **"วันนี้ฉันจะชน rate limit ไหม?"** — ตัวบ่งชี้ 5 h / 7 d พร้อม ⚠️ เมื่อ > 50 %
- **"ฉันอยู่บน branch ที่ถูกต้องไหม?"** — git branch + dirty + ahead/behind ในสเตตัสไลน์ของคุณ
- **"ฉันใช้เวลาจริงกี่ชั่วโมงกับฟีเจอร์นี้?"** — ตัวติดตามเวลาที่ใช้กับงาน (`active` เทียบกับ `wall`)
- **"ฉันอยากให้เทอร์มินัลของฉันสนุก"** — ธีม anime, cyberpunk, hacker, retro, weather, ocean, fire และอื่นๆ
- **"ฉันอยากได้สเตตัสไลน์แบบ ASCII ล้วน เรียบง่าย สำหรับบันทึกหน้าจอ"** — ธีม `zen`
- **"ฉันอยากส่งมอบสเตตัสไลน์ที่ทั้งทีมของฉันใช้"** — สคริปต์บันเดิลตัวเดียว + CLI configurator + slash command

## ❓ FAQ

### "Claude Code Status Line" คืออะไร?

ตัวแทนที่ใช้ bash เป็นพื้นฐานสำหรับสเตตัสไลน์เริ่มต้นใน [Claude Code](https://claude.com/claude-code) (CLI ของ Anthropic) มันเปลี่ยนบรรทัดด้านล่างหน้าจอให้กลายเป็นแดชบอร์ดจริง: model, context %, แถบความคืบหน้า, ค่าใช้จ่ายต่อเซสชัน, rate limits, สถานะ git, เวลาที่ใช้กับงาน และอื่นๆ

### `5h{1.1h}: 1%` หมายความว่าอะไร?

คุณใช้ไป 1% ของหน้าต่าง 5 ชั่วโมง และ `{1.1h}` คือการนับถอยหลังแบบสด — หน้าต่างจะรีเซ็ตใน 1.1 ชั่วโมง (`7d{1.1d}`: หน้าต่างรายสัปดาห์จะรีเซ็ตใน 1.1 วัน) อ่านจาก `rate_limits.*.resets_at` ในทุกการเรนเดอร์ ไม่มี timestamp การรีเซ็ตในบิลด์ของคุณ? มิเตอร์จะถอยกลับไปแสดงแบบธรรมดา `5h: 1%`

### สเตตัสไลน์อัปเดตด้วยตัวเองไหม? การนับถอยหลัง `{1.1h}` ของฉันดูเหมือนค้างอยู่

Claude Code เรนเดอร์ใหม่เมื่อมีเหตุการณ์ — ข้อความใหม่จากผู้ช่วย, `/compact`, การเปลี่ยน permission-mode หรือ vim-mode (debounced ที่ 300 ms) — ดังนั้นระหว่างเหตุการณ์บรรทัดจะค้าง เพิ่ม `"refreshInterval": 30` ลงในบล็อก statusLine ใน `~/.claude/settings.json` แล้วมันจะรันใหม่บนตัวจับเวลา 30 วินาทีคงที่ด้วย ทำให้การนับถอยหลังและตัวติดตามเวลายังคงเดินขณะที่ว่างอยู่ การเรนเดอร์ใช้เวลาประมาณ 0.1 วินาที ดังนั้น 30 วินาทีจึงน้อยมาก; ใช้ 60 เมื่อใช้แบตเตอรี่หรือใน repo ขนาดใหญ่ (git status รันทุกการเรนเดอร์); ค่าต่ำสุดคือ 1

### ติดตั้งอย่างไร?

คัดลอก `statusline-bundle.sh` ไปยัง `~/.claude/status-line.sh`, `chmod +x`, จากนั้นชี้ `statusLine.command` ใน `~/.claude/settings.json` ของ Claude Code ไปที่พาธนั้น คำแนะนำเต็มอยู่ในส่วน [เริ่มต้นอย่างรวดเร็ว](#-เริ่มต้นอย่างรวดเร็ว) และ [การติดตั้ง](#-การติดตั้ง)

### รองรับโมเดลที่มี context window 1 M ไหม?

รองรับ สคริปต์ตรวจจับ `[1m]` ใน model id และ `1M` ในชื่อที่แสดง และปรับตัวหารของแถบเป็น 1 000 000 token คุณจะเห็น `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`

### ใช้งานได้กับโมเดลใดบ้าง?

โมเดลใดก็ตามที่ Claude Code รองรับ — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, ฯลฯ สคริปต์อ่าน `model.display_name` และ `model.id` จาก stdin JSON ที่ Claude Code ส่งมา; มันไม่ได้ hardcode ชื่อโมเดล

### ฉันปรับแต่งสี ธีม หรือเพิ่มของฉันเองได้ไหม?

ได้ — สามวิธี:

1. เลือกหนึ่งใน **82 ธีม** (164 แบบทั้งหมด) — ใช้ `~/.claude/status-line.sh use <name>` หรือเรียกดู [`examples/`](examples/) สำหรับสคริปต์แบบ standalone
2. ประกอบของคุณเองจาก **บล็อกที่มีชื่อ** — ดู [BLOCKS.md](BLOCKS.md)
3. แก้ไขค่าคงที่สีและสไตล์แถบใน `statusline.sh` โดยตรง

### มันจะทำให้ Claude Code ช้าลงไหม?

ไม่ แต่ละการเรนเดอร์รันหนึ่งครั้งต่อการวาดสเตตัสใหม่ parse JSON ที่ส่งเข้ามาด้วย `jq`, `grep` บรรทัดล่าสุดของ transcript เป็นทางเลือก แล้วพิมพ์ การเรนเดอร์ทั่วไป ≤ 50 ms แม้เปิดตัวติดตามเวลา

### ใช้งานได้โดยไม่มี `jq` ไหม?

`jq` จำเป็น — มัน parse JSON ที่ Claude Code ส่งมาบน stdin ติดตั้งผ่าน `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), หรือ `choco install jq` (Windows)

### ใช้งานบน Windows ได้ไหม?

ได้ ในสภาพแวดล้อมใดก็ตามที่รัน `bash` 4+ และ `jq` — Git Bash, WSL, MSYS2, Cygwin CMD/PowerShell ล้วนๆ ไม่รองรับ

### ใช้งานบน Linux / macOS ได้ไหม?

ได้ทั้งสอง macOS ใช้ BSD `date`, Linux ใช้ GNU `date` — ตัวติดตามเวลาจัดการทั้งสองอย่างโปร่งใส

### ฉันใช้สิ่งนี้กับ Anthropic API ดิบแทน Claude Code ได้ไหม?

ได้บางส่วน สเตตัสไลน์ถูกออกแบบมาสำหรับรูปแบบ stdin JSON ของ Claude Code สำหรับการใช้งาน API ดิบ ตัวบ่งชี้ rate-limit จะถอยกลับโดยอัตโนมัติไปแสดง **token รวมทั้งเซสชัน** (`tokens: NNN K`)

### การกำหนดค่าถูกเก็บไว้ที่ไหน?

`~/.claude/statusline.conf` — ไฟล์เล็กๆ ที่ shell-sourced เขียนโดย CLI ของบันเดิล (`statusline.sh use <theme>` ฯลฯ) คงอยู่ข้ามการรีสตาร์ท

### ฉันจะกลับไปใช้สเตตัสไลน์เริ่มต้นของ Claude Code ได้อย่างไร?

ลบบล็อก `statusLine` ออกจาก `~/.claude/settings.json` หรือรัน `~/.claude/status-line.sh reset` แล้วสลับไปใช้ธีม `minimal` ที่ใกล้เคียงกับค่าเริ่มต้นมากที่สุด

### มันฟรีไหม? ใช้เชิงพาณิชย์ได้ไหม?

การใช้งานส่วนตัวในเครื่องฟรี — ดู [Source-Available License](LICENSE) การนำกลับมาใช้ใหม่ การแจกจ่ายซ้ำ การ fork หรือการรวมเข้าในโปรเจกต์อื่นใดต้องได้รับ **อนุญาตเป็นลายลักษณ์อักษรล่วงหน้า** จากผู้สร้าง (Yevgeniy Achin · amazopic@gmail.com) คำขอที่สมเหตุสมผลมักได้รับการอนุมัติ

### ตัวติดตาม "ชั่วโมงมนุษย์" ทำงานอย่างไร?

ธีม `time` อ่าน timestamp จาก transcript แบบ JSONL และรายงานระยะเวลาสองค่า: **active** (ผลรวมของช่วงห่างระหว่างข้อความที่สั้นกว่า 5 นาที) และ **wall** (ช่วงเวลารวมจากข้อความแรกถึงข้อความสุดท้าย) เกณฑ์ idle 5 นาทีสามารถกำหนดค่าได้

## 🏷️ หัวข้อ GitHub ที่แนะนำ

เมื่อคุณเผยแพร่ repo นี้ ให้เพิ่มหัวข้อเหล่านี้เพื่อเพิ่มการค้นพบให้สูงสุด:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 การมีส่วนร่วม

Issues และ PRs ยินดีต้อนรับ — แต่โปรดทราบลิขสิทธิ์:

- **การอ่าน, การเปิด issue, การส่ง PR**: ฟรี
- **การ fork, คัดลอกเข้าในโปรเจกต์อื่น, แจกจ่ายซ้ำ**: ต้องได้รับ
  อนุญาตเป็นลายลักษณ์อักษรล่วงหน้าจากผู้สร้าง

หากต้องการขออนุญาตนำกลับมาใช้ใหม่ ติดต่อ:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

คำขอที่สมเหตุสมผลสำหรับการใช้งานส่วนตัว เพื่อการศึกษา และไม่ใช่เชิงพาณิชย์
มักได้รับการอนุมัติโดยไม่มีค่าใช้จ่าย

## 📜 ลิขสิทธิ์

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

ซอร์สของโปรเจกต์นี้เปิดเผยต่อสาธารณะสำหรับการอ่าน การศึกษา และ
การใช้งานส่วนตัวบนเครื่องของคุณเอง การนำกลับมาใช้ใหม่ใดๆ — การคัดลอก การแจกจ่ายซ้ำ
การแก้ไข หรือการรวมเข้าในโปรเจกต์อื่น — ต้องได้รับ **อนุญาตเป็นลายลักษณ์อักษร
ล่วงหน้า** จากผู้สร้าง (Yevgeniy Achin · amazopic@gmail.com)

นี่**ไม่ใช่**ลิขสิทธิ์โอเพนซอร์สที่ได้รับการรับรองจาก OSI มันเป็นทางเลือก
โดยเจตนาเพื่อคงการแจกจ่ายและงานดัดแปลงไว้ภายใต้การควบคุมของผู้สร้าง
ในขณะที่อนุญาตให้ชุมชนอ่าน ศึกษา และมีส่วนร่วม

## ⭐ พบว่ามีประโยชน์ไหม?

หากคุณใช้เวลาหลายชั่วโมงจ้องมอง Claude Code คุณก็น่าจะจ้องมองสเตตัสไลน์ที่สวยงาม **กดดาว ⭐ ให้ repo** เพื่อช่วยให้ผู้อื่นค้นพบมัน!

---

จัดทำโดย **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · เพื่อชุมชน Claude Code
