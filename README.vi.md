# 🛰️ Claude Code Status Line — 79 chủ đề, khối tùy chỉnh, CLI

> Bản thay thế cắm-là-chạy cho thanh trạng thái mặc định của **Claude Code**: mức sử dụng **cửa sổ ngữ cảnh** theo thời gian thực với thanh tiến trình mượt mà, **chi phí phiên** tính bằng USD, cảnh báo **giới hạn tốc độ 5h / 7d**, **nhánh git** kèm số đếm dirty / ahead / behind, **theo dõi thời gian làm việc**, và tên **mô hình** đang hoạt động (với chỉ báo `(1M)` cho các biến thể ngữ cảnh 1M) — tất cả trong một dòng Bash đầy màu sắc. Đi kèm **79 chủ đề dựng sẵn** — lựa chọn hàng đầu (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), kinh điển (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), thương hiệu xe hơi (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), thêm các nhà khoa học (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), thêm anime (onepiece, ghibli), thêm Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), chủ đề hệ điều hành (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos), và các tôn giáo trên thế giới (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) cùng một **thư viện 26 khối** để bạn tự dựng dòng riêng. Bao gồm trình cấu hình CLI tất-cả-trong-một và lệnh slash `/statusline` cho Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-biến-thể-dựng-sẵn--chọn-một-cái-và-chạy)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#yêu-cầu)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · Tiếng Việt · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **Mẹo hay — Kiểm soát ngữ cảnh**: cửa sổ ngữ cảnh càng đầy thì cuộc trò chuyện với Claude càng **kém hiệu quả** — và bạn **đốt** giới hạn 5h/7d càng **nhanh**. Hãy xóa hoặc `/compact` mỗi khi vượt **60%** để tiếp tục làm việc hiệu quả.

### ⏳ Đếm ngược đến lúc reset — lên kế hoạch quanh giới hạn của bạn

Các đồng hồ đo 5h / 7d bao gồm bộ đếm ngược trực tiếp đến thời điểm mỗi cửa sổ được reset: `5h{1.1h}: 1%` — cửa sổ 5 giờ sẽ reset sau 1,1 giờ; `7d{1.1d}: 0%` — cửa sổ hàng tuần sẽ reset sau 1,1 ngày. Bạn luôn biết khi nào mình quay về 0%, nhờ vậy có thể sắp xếp các tác vụ nặng ngay sau khi reset và phân bổ năng suất thay vì đâm sầm vào giới hạn giữa chừng. Hoạt động nhờ `rate_limits.*.resets_at` do Claude Code gửi; nếu bản dựng của bạn không gửi dấu thời gian reset, các đồng hồ đo sẽ tự động chuyển về dạng đơn giản `5h: 1%`.

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**Dễ đoán theo thiết kế** — mỗi đồng hồ đo đều đếm ngược đến lúc reset, nên bạn điều tiết được nhịp làm việc thay vì đụng phải bức tường giới hạn.

## ⚡ Bắt đầu nhanh

Con đường nhanh nhất — script tất-cả-trong-một đi kèm với CLI tích hợp sẵn:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

Sau đó thêm vào `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 `refreshInterval: 30` chạy lại dòng trạng thái mỗi 30 giây ngay cả khi phiên đang nhàn rỗi — giữ cho đếm ngược reset (5h{1.1h}), bộ theo dõi thời gian và các bước lật sau reset luôn cập nhật trực tiếp. 30 là giá trị mặc định hợp lý; 60 tiết kiệm pin; bỏ qua để chỉ làm mới theo sự kiện (tin nhắn mới của trợ lý, /compact, bật/tắt vim).

Khởi động lại Claude Code (hoặc chạy `/config` để tải lại). Xong.

### hoặc cách vibe-chill · để Claude làm hết

Tại sao phải đụng vào terminal khi bạn đã có Claude Code? Dán đoạn prompt duy nhất này vào phiên Claude Code của bạn — Claude sẽ xử lý mọi bước và hỏi trước mỗi lệnh.

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", "refreshInterval": 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> Chỉ cần nói `y` (yes) ở mỗi lần hỏi quyền. Xong.


## Tại sao cần một thanh trạng thái tùy chỉnh cho Claude Code?

Thanh trạng thái mặc định của Claude Code khá sơ sài. Bản thay thế cắm-là-chạy này biến thanh trạng thái dưới cùng thành một **bảng điều khiển nhìn-là-thấy** cho mỗi phiên làm việc:

- 🔋 Tôi đã đốt bao nhiêu ngữ cảnh rồi? (các thanh phân số mượt mà bước 1,25%)
- 💰 Phiên này đang tốn của tôi bao nhiêu?
- 🚦 Tôi đang gần giới hạn tốc độ đến mức nào?
- 🧠 Tôi đang ở mức thinking / mô hình nào?
- 🌿 Tôi đang ở nhánh git nào?

Tất cả trong **một dòng**, có mã màu, với các biểu tượng thông minh báo hiệu mức độ khẩn cấp.

## ✨ Tính năng

- 🪐 **Thanh ngữ cảnh trực tiếp** — thanh tiến trình 10 ô với độ chính xác dưới-ô (glyph phân số kiểu góc phần tư hoặc dọc)
- 🧠 **Tên mô hình** — kèm chỉ báo `(1M)` cho các biến thể ngữ cảnh 1M
- 💸 **Chi phí phiên** tính bằng USD, cập nhật mỗi lần render
- ⬆️⬇️ **Bộ đếm token theo từng tin nhắn** (đầu vào / đầu ra)
- 🚦 **Giới hạn tốc độ** — 5h / 7d kèm cảnh báo ⚠️ khi > 50%
- 🔄 **Dự phòng chế độ API** — khi không có giới hạn tốc độ nào được truyền vào, hiển thị tổng token của phiên (`tokens: NNN K`) với dấu phân cách hàng nghìn bằng khoảng trắng mảnh
- 🚀 **Biểu tượng trạng thái thông minh** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% mức đầy ngữ cảnh
- 🎨 **ANSI 256 màu** — màu sắc tươi sáng, khác biệt cho từng phân đoạn
- 🧩 **Kiểu thanh dạng plugin** — chọn `quadrant` (▖▄▙█) hoặc `vertical` (▏▎▍▌▋▊▉█), hoặc tự tạo kiểu của riêng bạn trong 10 dòng bash
- ⚡ **Nhẹ nhàng** — thuần `bash` + `jq`. Không Node, không Python, không daemon, không telemetry

## 🎨 158 biến thể dựng sẵn — chọn một cái và chạy

Mỗi chủ đề có **hai biến thể**:

- **Detailed** — đầy đủ tính năng (mô hình, thanh ngữ cảnh, chi phí, token, git, thời gian, biểu tượng tâm trạng, …)
- **Compact** — chỉ `model · context % + bar · branch`

Áp dụng với `~/.claude/status-line.sh use <name>` (thêm `-compact` cho biến thể compact).

### 🔝 Lựa chọn hàng đầu (10) — được hỏi nhiều nhất, đa văn hóa

| Chủ đề | Phong cách |
|---|---|
| `cyberpunk`  | thế giới phản địa đàng neon · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | terminal Matrix xanh lân tinh · `[SYS] :: ROOT@matrix#` |
| `dragonball` | Goku tăng cấp: base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | màu cam lá Konoha · đồng hồ chakra · 🌀 rasengan |
| `pokemon`    | vàng Pikachu + đỏ pokeball · thanh HP |
| `ironman`    | 🦾 đỏ Stark + vàng lò phản ứng hồ quang |
| `spiderman`  | 🕷 đỏ + xanh người nhện · ngữ cảnh lớn đi kèm chi phí lớn |
| `einstein`   | xanh bảng phấn · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ tím điện + vàng tia chớp · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + vàng Modena |

### 🛠 Thực dụng / Kinh điển (18 chủ đề)

| Chủ đề | Tệp / Áp dụng |
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

> Lưu ý: `cyberpunk` và `hacker` nằm trong phần **Lựa chọn hàng đầu** ở trên — chúng
> cũng có trong thư mục `examples/` nếu bạn muốn cài đặt theo kiểu một-chủ-đề.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Thương hiệu xe hơi (thêm 15, lựa chọn hàng đầu đã có `ferrari`)

Chỉ đi kèm trong `statusline-bundle.sh` — chọn bất kỳ cái nào với `~/.claude/status-line.sh use <name>`.

| Khu vực | Chủ đề |
|---|---|
| 🇪🇺 Châu Âu  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 Châu Mỹ | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Nhật Bản   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Hàn Quốc   | `hyundai` · `kia` |
| 🇨🇳 Trung Quốc   | `byd` · `nio` · `geely` |

### 🔬 Những nhà khoa học vĩ đại (thêm 8, lựa chọn hàng đầu đã có `einstein` & `tesla`)

| Chủ đề | Phong cách |
|---|---|
| `newton`   | mực trên giấy da, `🍎`, `F=ma` |
| `curie`    | xanh radium, `☢`, đồng hồ chu kỳ bán rã |
| `darwin`   | xanh nhà tự nhiên học, `🐢`, tàu HMS Beagle |
| `hawking`  | tím không gian sâu, `🌌`, `t → ∞` |
| `galileo`  | vàng mặt trời, `🔭`, *eppur si muove* |
| `feynman`  | phấn trên nền xanh, `〰`, `ψ → ψ'` |
| `turing`   | xanh terminal, `Ⓣ`, thanh dừng `1/0` |
| `davinci`  | bản chép tay nâu sepia, `✎`, *Vitruvian* |

### ✨ Anime (thêm 3, lựa chọn hàng đầu đã có `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 Siêu anh hùng Marvel (thêm 8, lựa chọn hàng đầu đã có `ironman` & `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Hệ điều hành (10 chủ đề)

| Chủ đề | Phong cách |
|---|---|
| `macos`   | 🍎 cầu vồng sáu màu của Apple trên nền xám chrome |
| `windows` | ⊞ ô gạch Fluent bốn màu + WINDOWS 11 màu lục lam |
| `linux`   | 🐧 Tux đen + mỏ cam |
| `ubuntu`  | ⊕ vòng tròn bạn bè — cam + tím cà tím |
| `arch`    | ▲ pacman lục lam · btw, I use arch |
| `debian`  | 🌀 xoáy đỏ · stable / sid / testing |
| `fedora`  | 🎩 mũ Fedora xanh · tự do + tính năng |
| `kali`    | 🐉 xanh Kali + đỏ offsec · chế độ pwn |
| `mint`    | 🌿 xanh bạc hà quế · shell thân thiện nhất |
| `nixos`   | ❄ bông tuyết Nix xanh · khai báo, tái lập được |

### 🕊 Các tôn giáo trên thế giới (top 7 theo số tín đồ)

| Chủ đề | Phong cách |
|---|---|
| `christianity` | ✝ đỏ rượu + xanh Marian + vàng giáo hoàng · đồng hồ đức tin, € của bố thí |
| `islam`        | ☪ xanh Hồi giáo + trắng + thư pháp vàng · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 nghệ tây + cúc vạn thọ + son · dharma, ₹ seva |
| `buddhism`     | ☸ vàng nghệ nhà sư + vàng + nâu đỏ · karma, ฿ dāna |
| `judaism`      | ✡ xanh tallit + trắng + vàng menorah · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ xanh đậm Khalsa + nghệ tây + trắng · sewa, daswandh |
| `shinto`       | ⛩ torii son + trắng đền thờ + vàng · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

**Hãy xem qua tất cả ngay trong terminal trước** — mỗi biến thể đều có bản
xem trước được dựng sẵn trong [`screenshots/`](screenshots/):

```bash
# preview a single one
cat screenshots/statusline-cyberpunk.ansi

# or browse the whole gallery (158 variants + main)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Xem [`examples/README.md`](examples/README.md) để có bảng đầy đủ kèm
mô tả, và [`screenshots/README.md`](screenshots/README.md) để biết
cách các bản xem trước được tạo ra.

## 🧱 Tự dựng dòng riêng từ các khối

Không muốn dùng preset có sẵn? Hãy soạn một thanh trạng thái tùy chỉnh từ một thư viện
các khối có tên — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

Xem [**BLOCKS.md**](BLOCKS.md) để biết:

- **danh mục các khối** (mỗi khối là một đoạn bash dán-là-chạy)
- **các gói phong cách** (bảng màu & dấu phân cách từ `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- **công thức 3 bước** để tự dựng dòng của bạn: chọn phong cách → liệt kê khối
  → dán

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 Gói tất-cả-trong-một (`statusline-bundle.sh`)

Nếu bạn không muốn quản lý hơn 40 tệp, hãy lấy **script gói đơn lẻ**
[`statusline-bundle.sh`](statusline-bundle.sh) — nó chứa
mọi chủ đề + mọi khối + một trình cấu hình CLI trong cùng một tệp.

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

Cấu hình được lưu vào `~/.claude/statusline.conf` và được giữ lại qua
các lần khởi động lại. Cùng một tệp này vừa đóng vai trò **bộ render** (khi
được Claude Code gọi với JSON trên stdin) vừa là **trình cấu hình**
(khi bạn gọi nó kèm tham số).

### Lệnh slash `/statusline`

Thả [`commands/statusline.md`](commands/statusline.md) vào
`~/.claude/commands/` để bật lệnh slash `/statusline` ngay trong
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Rồi trong bất kỳ phiên Claude Code nào bạn có thể gõ:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude sẽ chạy CLI của gói cho bạn, báo cáo kết quả, và nhắc bạn
tải lại.

### Bí danh shell tùy chọn

```bash
alias statusline='~/.claude/status-line.sh'
```

Sau đó `statusline cyberpunk` sẽ hoạt động từ bất kỳ terminal nào.

## 🚀 Cài đặt

### Cài đặt thủ công (3 bước)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Sau đó thêm vào `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 `refreshInterval: 30` chạy lại dòng trạng thái mỗi 30 giây ngay cả khi phiên đang nhàn rỗi — giữ cho đếm ngược reset (5h{1.1h}), bộ theo dõi thời gian và các bước lật sau reset luôn cập nhật trực tiếp. 30 là giá trị mặc định hợp lý; 60 tiết kiệm pin; bỏ qua để chỉ làm mới theo sự kiện (tin nhắn mới của trợ lý, /compact, bật/tắt vim).

Khởi động lại Claude Code (hoặc chạy `/config` để tải lại).

### Cài đặt qua agent Claude Code (kèm sao lưu tự động)

Muốn Claude Code cài đặt nó một cách an toàn cho bạn? Hãy dán prompt này:

> "Hãy cài đặt thanh trạng thái từ repo này làm thanh trạng thái Claude Code của tôi:
> 1. Nếu `~/.claude/status-line.sh` đã tồn tại, hãy sao lưu nó thành
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (chọn một hậu tố `-N`
>    còn trống nếu đã có bản sao lưu cùng tên).
> 2. Sao chép `statusline.sh` từ repo này sang `~/.claude/status-line.sh` rồi `chmod +x`.
> 3. Đọc `~/.claude/settings.json`. Nếu chưa có khóa `statusLine`, hãy thêm một
>    khối `statusLine` trỏ đến đường dẫn tuyệt đối của script và kèm thêm trường
>    `"refreshInterval": 30`. Nếu
>    `statusLine` đã tồn tại và trỏ đến nơi khác, hãy sao lưu
>    `settings.json` thành `.bak.<timestamp>` trước.
> 4. Kiểm tra nhanh script:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Bảo tôi khởi động lại Claude Code và báo cáo các bản sao lưu đã tạo."

### Cập nhật lên phiên bản mới nhất

```bash
~/.claude/status-line.sh update
```

Tải gói mới nhất từ GitHub, tạo một bản sao lưu có dấu thời gian
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`), và giữ nguyên
cấu hình chủ đề của bạn (`~/.claude/statusline.conf`). Hãy khởi động lại Claude Code sau đó.

Kiểm tra phiên bản bạn đã cài: `~/.claude/status-line.sh version`.

### Yêu cầu

- `bash` 4+ (script dùng mảng đánh chỉ số từ 0 — **đừng chạy dưới `zsh`**)
- `jq` để phân tích JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (chỉ cần cho `statusline update`; được cài sẵn trên hầu hết hệ thống)
- Một terminal hỗ trợ 256 màu (về cơ bản là mọi terminal hiện đại)

## ⚙️ Cấu hình

Chỉnh sửa các hằng số gần đầu tệp `statusline.sh`:

| Biến / hàm | Điều khiển gì |
|---|---|
| `BAR_STYLE` | `"quadrant"` (mặc định, bước 2,5%) hoặc `"vertical"` (bước 1,25%) |
| `pct_icon()` | Ngưỡng cho các biểu tượng 🚀 / 🚗 / ⚠️ trước thanh |
| `pct_color()` | Ngưỡng màu cho phần trăm / thanh |
| Các hằng số màu ANSI | Đổi màu bất kỳ phân đoạn nào (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 So với thanh trạng thái mặc định của Claude Code

| Khả năng | Mặc định | Dự án này |
|---|---|---|
| **Tên mô hình** đang hoạt động | ✅ | ✅ (kèm cờ `(1M)` cho các biến thể ngữ cảnh 1M) |
| % **cửa sổ ngữ cảnh** đã dùng | ❌ | ✅ trực tiếp, độ chính xác 1,25% |
| **Thanh tiến trình** cho ngữ cảnh | ❌ | ✅ (dọc, góc phần tư, cầu vồng, sparkline, …) |
| **Chi phí phiên** tính bằng USD | ❌ | ✅ cập nhật mỗi lần render |
| Bộ đếm token vào/ra **theo từng tin nhắn** | ❌ | ✅ |
| **Tổng token của phiên** (dự phòng chế độ API) | ❌ | ✅ |
| Chỉ báo **giới hạn tốc độ 5h / 7d** kèm ⚠️ ở mức > 50% | ❌ | ✅ |
| Đếm ngược reset trong đồng hồ giới hạn (`5h{1.1h}`) | ❌ | ✅ |
| **Nhánh git** + dirty + ahead/behind | ❌ | ✅ |
| **Thời gian làm việc** (active so với đồng hồ thực) | ❌ | ✅ |
| Hiển thị mức **thinking / effort** | ❌ | ✅ |
| Preset theo chủ đề | ❌ | ✅ 79 chủ đề × 2 biến thể = **158 dựng sẵn** |
| Soạn từ các khối có tên | ❌ | ✅ 26 khối, xem [BLOCKS.md](BLOCKS.md) |
| Trình cấu hình CLI tích hợp | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Lệnh slash `/statusline` của Claude Code | ❌ | ✅ tùy chọn, xem [`commands/`](commands/) |
| Phụ thuộc bên ngoài | — | `bash` 4+ và `jq` (không Node, không Python, không daemon) |
| Giấy phép | — | Source-Available (tái sử dụng theo cấp phép) |

## 💡 Trường hợp sử dụng

Các kịch bản cụ thể mà dự án này tự chứng minh giá trị của nó:

- **"Tôi đã đốt bao nhiêu trong 1 M ngữ cảnh rồi?"** — xem phần trăm + thanh trực tiếp trước mỗi prompt.
- **"Phiên Claude Code này đang tốn của tôi bao nhiêu?"** — tổng USD chạy liên tục, cập nhật mỗi lần render.
- **"Hôm nay tôi có đụng giới hạn tốc độ không?"** — chỉ báo 5 h / 7 d kèm ⚠️ khi > 50%.
- **"Tôi có đang ở đúng nhánh không?"** — nhánh git + dirty + ahead/behind ngay trên thanh trạng thái.
- **"Tôi đã bỏ ra bao nhiêu giờ thực cho tính năng này?"** — bộ theo dõi thời gian làm việc (`active` so với `wall`).
- **"Tôi muốn terminal của mình vui mắt."** — anime, cyberpunk, hacker, retro, weather, ocean, fire và các chủ đề khác.
- **"Tôi muốn một thanh trạng thái tối giản, chỉ ASCII để quay màn hình."** — chủ đề `zen`.
- **"Tôi muốn triển khai một thanh trạng thái cho cả nhóm dùng."** — một script gói duy nhất + trình cấu hình CLI + lệnh slash.

## ❓ FAQ

### "Claude Code Status Line" là gì?

Một bản thay thế dựa trên bash cho thanh trạng thái mặc định trong [Claude Code](https://claude.com/claude-code) (CLI của Anthropic). Nó biến dòng dưới cùng màn hình thành một bảng điều khiển thực thụ: mô hình, % ngữ cảnh, thanh tiến trình, chi phí phiên, giới hạn tốc độ, trạng thái git, thời gian làm việc, và nhiều hơn nữa.

### `5h{1.1h}: 1%` nghĩa là gì?

Bạn đã dùng 1% của cửa sổ 5 giờ, và `{1.1h}` là bộ đếm ngược trực tiếp — cửa sổ sẽ reset sau 1,1 giờ (`7d{1.1d}`: cửa sổ hàng tuần reset sau 1,1 ngày). Được đọc từ `rate_limits.*.resets_at` ở mỗi lần render. Bản dựng của bạn không có dấu thời gian reset? Đồng hồ đo sẽ chuyển về dạng đơn giản `5h: 1%`.

### Dòng trạng thái có tự cập nhật không? Bộ đếm ngược `{1.1h}` của tôi trông như bị đóng băng.

Claude Code render lại theo sự kiện — tin nhắn mới của trợ lý, `/compact`, thay đổi chế độ quyền hoặc chế độ vim (chống dội ở 300 ms) — nên giữa các sự kiện thì dòng bị đóng băng. Thêm `"refreshInterval": 30` vào khối `statusLine` trong `~/.claude/settings.json` và nó cũng sẽ chạy lại theo bộ hẹn giờ cố định 30 giây, giữ cho bộ đếm ngược và bộ theo dõi thời gian luôn nhích đều khi nhàn rỗi. Một lần render tốn ~0,1 s, nên 30 s là không đáng kể; dùng 60 khi chạy pin hoặc trong repo khổng lồ (git status chạy ở mỗi lần render); tối thiểu là 1.

### Cài đặt như thế nào?

Sao chép `statusline-bundle.sh` sang `~/.claude/status-line.sh`, `chmod +x`, rồi trỏ `statusLine.command` trong `~/.claude/settings.json` của Claude Code đến đường dẫn đó. Hướng dẫn đầy đủ trong các phần [Bắt đầu nhanh](#-bắt-đầu-nhanh) và [Cài đặt](#-cài-đặt).

### Nó có hỗ trợ các mô hình cửa sổ ngữ cảnh 1 M không?

Có. Script phát hiện `[1m]` trong id mô hình và `1M` trong tên hiển thị rồi điều chỉnh mẫu số của thanh thành 1 000 000 token. Bạn sẽ thấy `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### Nó hoạt động với những mô hình nào?

Bất kỳ mô hình nào Claude Code hỗ trợ — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, v.v. Script đọc `model.display_name` và `model.id` từ JSON trên stdin mà Claude Code cung cấp; nó không gắn cứng tên mô hình.

### Tôi có thể tùy chỉnh màu sắc, chủ đề, hoặc thêm cái của riêng mình không?

Có — ba cách:

1. Chọn một trong **79 chủ đề** (tổng cộng 158 biến thể) — dùng `~/.claude/status-line.sh use <name>` hoặc duyệt [`examples/`](examples/) để lấy các script độc lập.
2. Tự soạn từ **các khối có tên** — xem [BLOCKS.md](BLOCKS.md).
3. Chỉnh trực tiếp các hằng số màu và kiểu thanh trong `statusline.sh`.

### Nó có làm Claude Code chậm đi không?

Không. Mỗi lần render chạy một lần cho mỗi lần vẽ lại trạng thái, phân tích JSON được truyền vào bằng `jq`, tùy chọn `grep` dòng mới nhất của transcript, rồi in ra. Một lần render điển hình ≤ 50 ms ngay cả khi bật bộ theo dõi thời gian.

### Nó có hoạt động khi không có `jq` không?

Bắt buộc phải có `jq` — nó phân tích JSON mà Claude Code gửi trên stdin. Cài đặt qua `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), hoặc `choco install jq` (Windows).

### Nó có hoạt động trên Windows không?

Có, trong bất kỳ môi trường nào chạy được `bash` 4+ và `jq` — Git Bash, WSL, MSYS2, Cygwin. CMD/PowerShell thuần thì không được hỗ trợ.

### Nó có hoạt động trên Linux / macOS không?

Có, trên cả hai. macOS dùng `date` của BSD, Linux dùng `date` của GNU — bộ theo dõi thời gian xử lý cả hai một cách trong suốt.

### Tôi có thể dùng cái này với API Anthropic thô thay vì Claude Code không?

Một phần. Thanh trạng thái được thiết kế cho định dạng JSON trên stdin của Claude Code. Với việc dùng API thô, các chỉ báo giới hạn tốc độ tự động chuyển về hiển thị **tổng token của phiên** (`tokens: NNN K`).

### Cấu hình được lưu ở đâu?

`~/.claude/statusline.conf` — một tệp nhỏ được source bởi shell, do CLI của gói ghi ra (`statusline.sh use <theme>` v.v.). Được giữ lại qua các lần khởi động lại.

### Làm sao để quay về thanh trạng thái mặc định của Claude Code?

Hoặc xóa khối `statusLine` khỏi `~/.claude/settings.json`, hoặc chạy `~/.claude/status-line.sh reset` rồi chuyển sang chủ đề `minimal` vốn rất giống với mặc định.

### Nó có miễn phí không? Tôi có thể dùng cho mục đích thương mại không?

Sử dụng cá nhân, cục bộ là miễn phí — xem [Giấy phép Source-Available](LICENSE). Mọi việc tái sử dụng, phân phối lại, fork, hoặc đưa vào dự án khác đều cần **sự cho phép bằng văn bản trước** từ tác giả (Yevgeniy Achin · amazopic@gmail.com). Các yêu cầu hợp lý thường được chấp thuận.

### Bộ theo dõi "giờ-công người" hoạt động ra sao?

Chủ đề `time` đọc các dấu thời gian từ transcript JSONL và báo cáo hai khoảng thời gian: **active** (tổng các khoảng cách giữa các tin nhắn ngắn hơn 5 phút) và **wall** (tổng khoảng từ tin nhắn đầu tiên đến cuối cùng). Ngưỡng nhàn rỗi 5 phút có thể tùy chỉnh.

## 🏷️ Chủ đề GitHub gợi ý

Khi bạn xuất bản repo này, hãy thêm các chủ đề (topics) sau để tối đa hóa khả năng được tìm thấy:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Đóng góp

Issue và PR luôn được hoan nghênh — nhưng hãy lưu ý giấy phép:

- **Đọc, mở issue, gửi PR**: miễn phí.
- **Fork, sao chép vào dự án khác, phân phối lại**: cần sự cho phép
  bằng văn bản trước từ tác giả.

Để xin phép tái sử dụng, hãy liên hệ:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Các yêu cầu hợp lý cho mục đích cá nhân, giáo dục, và phi thương mại
thường được chấp thuận miễn phí.

## 📜 Giấy phép

[**Giấy phép Source-Available (Tái sử dụng theo cấp phép)**](LICENSE)

Mã nguồn của dự án này được công khai để đọc, nghiên cứu, và sử dụng
cá nhân trên máy của riêng bạn. Mọi việc tái sử dụng — sao chép, phân phối lại,
chỉnh sửa, hoặc đưa vào dự án khác — đều cần **sự cho phép bằng văn bản
trước** từ tác giả (Yevgeniy Achin · amazopic@gmail.com).

Đây **không phải** là giấy phép mã nguồn mở được OSI phê duyệt. Đó là một lựa chọn
có chủ đích nhằm giữ việc phân phối và các tác phẩm phái sinh dưới sự kiểm soát
của tác giả trong khi vẫn cho phép cộng đồng đọc, nghiên cứu, và đóng góp.

## ⭐ Thấy hữu ích?

Nếu bạn dành hàng giờ nhìn chằm chằm vào Claude Code, thì cũng nên nhìn vào một thanh trạng thái đẹp đẽ. **Hãy tặng repo một ⭐** để giúp người khác khám phá ra nó!

---

Được tạo bởi **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · cho cộng đồng Claude Code.
