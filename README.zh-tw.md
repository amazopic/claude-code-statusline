# 🛰️ Claude Code Status Line — 79 款主題、可設定區塊、CLI

> **Claude Code** 預設狀態列的隨插即用替代方案：即時顯示 **context window** 使用量並搭配平滑的進度條、以美元計算的 **工作階段花費**、**5h / 7d 速率限制** 警告、含 dirty / ahead / behind 計數的 **git 分支**、**任務耗時追蹤**，以及目前的 **模型名稱**（1M context 版本會標示 `(1M)`）——全部濃縮在同一條色彩繽紛的 Bash 狀態列裡。內建 **79 款現成主題** —— 熱門精選（cyberpunk、hacker、dragonball、naruto、pokemon、ironman、spiderman、einstein、tesla、ferrari）、經典款（minimal、developer、time、zen、rainbow、anime、love、cat、christmas、space、retro、fire、ocean、weather、coffee、music、game、pirate）、汽車品牌（porsche、mercedes、bmw、volvo、ford、chevy、jeep、cadillac、toyota、honda、nissan、hyundai、kia、byd、nio、geely）、更多科學家（newton、curie、darwin、hawking、galileo、feynman、turing、davinci）、更多動漫（onepiece、ghibli）、更多漫威（hulk、thor、captain-america、wolverine、deadpool、blackwidow、strange、wanda）、作業系統主題（macos、windows、linux、ubuntu、arch、debian、fedora、kali、mint、nixos），以及世界宗教（christianity、islam、hinduism、buddhism、judaism、sikhism、shinto），再加上一個 **26 區塊函式庫** 讓你自由組合。隨附一個一站式的 CLI 設定工具，以及一個給 Claude Code 用的 `/statusline` 斜線指令。

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-款現成變體--選一個直接上)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#系統需求)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · 繁體中文 · [Polski](README.pl.md) · [ไทย](README.th.md) · [עברית](README.he.md) · [বাংলা](README.bn.md) · [اردو](README.ur.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **專業提示 — 控制 context**：context window 越滿，你與 Claude 的對話就**越沒效率**，5h / 7d 限額也**消耗得越快**。每當越過 **60%** 就清空或 `/compact`，維持高效運作。

### ⏳ 重置倒數 — 圍繞你的限額來安排工作

5h / 7d 計量器內建一個即時倒數，精確到每個時間窗重置的那一刻：`5h{1.1h}: 1%` —— 5 小時窗口將在 1.1 小時後重置；`7d{1.1d}: 0%` —— 每週窗口將在 1.1 天後重置。你隨時都清楚自己什麼時候會回到 0%，因此可以把繁重的工作排在剛重置之後，把產能分散開來，而不是在任務做到一半時撞上上限。由 Claude Code 送出的 `rate_limits.*.resets_at` 驅動；如果你的版本沒有送出重置時間戳記，計量器會優雅地回退成單純的 `5h: 1%`。

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**生來就可預測** —— 每個計量器都會倒數到它的重置時刻，讓你按節奏分配工作，而不是迎頭撞牆。

## ⚡ 快速開始

最快的途徑 —— 隨附的一站式腳本，內建 CLI：

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # or: anime, hacker, minimal, …
```

接著加入 `~/.claude/settings.json`：

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 **`refreshInterval`** ：`refreshInterval: 30` 會每隔 30 秒重跑一次狀態列，即使工作階段處於閒置狀態也一樣 —— 這能讓重置倒數（`5h{1.1h}`）、時間追蹤器以及重置後的翻轉保持即時更新。30 是個合理的預設值；60 較省電；省略則只在事件發生時更新（新的助理訊息、`/compact`、vim 切換）。

重新啟動 Claude Code（或執行 `/config` 重新載入）。完成。

### 或者 vibe-chill 法 · 讓 Claude 幫你做

都有 Claude Code 了，何必動手碰終端機？把這一段提示貼進你的 Claude Code 工作階段 —— Claude 會處理每一個步驟，而且每條指令前都會先問過你。

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>", refreshInterval: 30 }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> 在每個權限提示都回答 `y`（yes）就好。完成。


## 為什麼要為 Claude Code 客製狀態列／狀態欄？

Claude Code 的預設狀態列相當陽春。這個隨插即用的替代方案，把底部的狀態欄變成每個工作階段都能 **一眼掌握** 的儀表板：

- 🔋 我燒掉了多少 context？（平滑的 1.25% 分數進度條）
- 💰 這次工作階段花了我多少錢？
- 🚦 我離速率限制還有多近？
- 🧠 我目前用的是哪個 thinking 等級／模型？
- 🌿 我現在在哪個 git 分支上？

全部濃縮在 **一行** 裡，附上色彩編碼，以及能標示緊急程度的智慧圖示。

## ✨ 功能特色

- 🪐 **即時 context 進度條** —— 10 格進度條，帶子格精度（quadrant 象限或 vertical 垂直分數字符）
- 🧠 **模型名稱** —— 1M context 版本會標示 `(1M)`
- 💸 **工作階段花費**（美元），每次重繪都更新
- ⬆️⬇️ **每則訊息的 token 計數**（輸入／輸出）
- 🚦 **速率限制** —— 5h / 7d，超過 50% 時顯示 ⚠️ 警告
- 🔄 **API 模式回退** —— 當沒有傳入速率限制時，改顯示工作階段的 token 總量（`tokens: NNN K`），並以窄空格作為千位分隔符
- 🚀 **智慧狀態圖示** —— 🚀 < 40%、🚗 40–49%、⚠️ ≥ 50% context 填滿率
- 🎨 **256 色 ANSI** —— 每個區段都有明亮、易辨的不同顏色
- 🧩 **可插拔的進度條樣式** —— 選 `quadrant`（▖▄▙█）或 `vertical`（▏▎▍▌▋▊▉█），或用 10 行 bash 自己寫一個
- ⚡ **輕量** —— 純 `bash` + `jq`。沒有 Node、沒有 Python、沒有常駐程式、沒有遙測

## 🎨 158 款現成變體 — 選一個直接上

每款主題都附 **兩種變體**：

- **Detailed（完整）** —— 完整功能集（模型、context 進度條、花費、token、git、時間、心情圖示……）
- **Compact（精簡）** —— 只有 `model · context % + bar · branch`

用 `~/.claude/status-line.sh use <name>` 套用（加上 `-compact` 即為精簡變體）。

### 🔝 熱門精選（10）—— 最多人指名、跨文化

| 主題 | 風格 |
|---|---|
| `cyberpunk`  | 霓虹反烏托邦 · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | 螢光綠 Matrix 終端機 · `[SYS] :: ROOT@matrix#` |
| `dragonball` | 悟空式升級：base → super-saiyan → ssj-blue → ultra instinct |
| `naruto`     | 木葉橘 · 查克拉計量器 · 🌀 螺旋丸 |
| `pokemon`    | 皮卡丘黃 + 寶貝球紅 · HP 血條 |
| `ironman`    | 🦾 史塔克紅 + 方舟反應爐金 |
| `spiderman`  | 🕷 蜘蛛人紅 + 藍 · 能力越大，花費越大 |
| `einstein`   | 黑板綠 · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ 電光紫 + 閃電黃 · `AC ~` |
| `ferrari`    | 🐎 賽車紅 + 摩德納黃 |

### 🛠 實用／經典（18 款主題）

| 主題 | 檔案 / 套用 |
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

> 注意：`cyberpunk` 和 `hacker` 收錄在上方的 **熱門精選** 裡 —— 如果你想做單一主題安裝，
> 它們在 `examples/` 資料夾裡也有。

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 汽車品牌（再加 15 款，熱門精選已含 `ferrari`）

只收錄在 `statusline-bundle.sh` 裡 —— 任選一款，用 `~/.claude/status-line.sh use <name>` 套用。

| 地區 | 主題 |
|---|---|
| 🇪🇺 歐洲  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 美洲 | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 日本   | `toyota` · `honda` · `nissan` |
| 🇰🇷 韓國   | `hyundai` · `kia` |
| 🇨🇳 中國   | `byd` · `nio` · `geely` |

### 🔬 偉大的科學家（再加 8 款，熱門精選已含 `einstein` 與 `tesla`）

| 主題 | 風格 |
|---|---|
| `newton`   | 羊皮紙墨水、`🍎`、`F=ma` |
| `curie`    | 鐳綠、`☢`、半衰期計量器 |
| `darwin`   | 博物學家綠、`🐢`、小獵犬號 |
| `hawking`  | 深空紫羅蘭、`🌌`、`t → ∞` |
| `galileo`  | 太陽金、`🔭`、*eppur si muove* |
| `feynman`  | 綠底粉筆、`〰`、`ψ → ψ'` |
| `turing`   | 終端機綠、`Ⓣ`、停機條 `1/0` |
| `davinci`  | 棕褐手稿、`✎`、*維特魯威人* |

### ✨ 動漫（再加 3 款，熱門精選已含 `dragonball`、`naruto`、`pokemon`）

`onepiece` · `ghibli`

### 🦸 漫威超級英雄（再加 8 款，熱門精選已含 `ironman` 與 `spiderman`）

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 作業系統（10 款主題）

| 主題 | 風格 |
|---|---|
| `macos`   | 🍎 鉻灰底上的六色蘋果彩虹 |
| `windows` | ⊞ Fluent 四色磁磚 + WINDOWS 11 青色 |
| `linux`   | 🐧 Tux 黑 + 橘色嘴喙 |
| `ubuntu`  | ⊕ 朋友圈 —— 橘色 + 茄紫色 |
| `arch`    | ▲ pacman 青色 · btw, I use arch |
| `debian`  | 🌀 紅色漩渦 · stable / sid / testing |
| `fedora`  | 🎩 Fedora 帽藍 · freedom + features |
| `kali`    | 🐉 Kali 藍 + offsec 紅 · pwn-mode |
| `mint`    | 🌿 肉桂薄荷綠 · 最友善的 shell |
| `nixos`   | ❄ Nix 藍雪花 · 宣告式、可重現 |

### 🕊 世界宗教（依信眾人數前 7）

| 主題 | 風格 |
|---|---|
| `christianity` | ✝ 酒紅 + 聖母藍 + 教宗金 · 信心計量器、€ 奉獻 |
| `islam`        | ☪ 伊斯蘭綠 + 白 + 金色書法 · taqwa、﷼ sadaqah |
| `hinduism`     | 🕉 藏紅 + 金盞花 + 朱紅 · dharma、₹ seva |
| `buddhism`     | ☸ 僧袍橙 + 金 + 栗紅 · 業力、฿ dāna |
| `judaism`      | ✡ 塔利特藍 + 白 + 燭台金 · mitzvah、₪ tzedakah |
| `sikhism`      | ☬ Khalsa 深藍 + 藏紅 + 白 · sewa、daswandh |
| `shinto`       | ⛩ 朱紅鳥居 + 神社白 + 金 · kami、¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # any of the 79 themes works
```

**先在你的終端機裡逐一瀏覽** —— 每個變體在 [`screenshots/`](screenshots/) 裡都有
預先算好的預覽：

```bash
# 預覽單一一個
cat screenshots/statusline-cyberpunk.ansi

# 或瀏覽整個藝廊（158 個變體 + 主版本）
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

完整的描述表格請見 [`examples/README.md`](examples/README.md)，
預覽如何產生則請見 [`screenshots/README.md`](screenshots/README.md)。

## 🧱 用區塊組出你自己的

不想用預設主題？從一個具名區塊的函式庫
—— `model`、`context-bar`、`cost`、`git`、`tokens-msg`、
`time-active`、`thinking`…… —— 自由組合出客製的狀態列。

請見 [**BLOCKS.md**](BLOCKS.md)，內含：

- **區塊目錄**（每一個都是可直接複製貼上的 bash 片段）
- **樣式組合包**（來自 `classic`、`compact`、`anime`、`hacker`、
  `cyberpunk`、`zen` 的配色與分隔符）
- 組出自己那一行的 **3 步驟食譜**：選樣式 → 列出區塊
  → 貼上

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 一站式打包腳本（`statusline-bundle.sh`）

如果你不想管理 40 多個檔案，就拿那個 **單一打包腳本**
[`statusline-bundle.sh`](statusline-bundle.sh) —— 它在一個檔案裡
包含了每一款主題 + 每一個區塊 + 一個 CLI 設定工具。

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

設定會存到 `~/.claude/statusline.conf`，並在重新啟動之間
保留。同一個檔案同時扮演 **算繪器**（當 Claude Code 透過
stdin 傳入 JSON 呼叫它時）與 **設定器**（當你帶參數呼叫它時）。

### `/statusline` 斜線指令

把 [`commands/statusline.md`](commands/statusline.md) 放進
`~/.claude/commands/`，即可在 Claude Code 裡啟用 `/statusline` 斜線指令：

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

接著在任何 Claude Code 工作階段裡，你都可以輸入：

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

Claude 會替你執行 bundle CLI、回報結果，並提醒你
重新載入。

### 選用的 shell 別名

```bash
alias statusline='~/.claude/status-line.sh'
```

之後 `statusline cyberpunk` 就能在任何終端機裡用了。

## 🚀 安裝

### 手動安裝（3 步驟）

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

接著加入 `~/.claude/settings.json`：

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 **`refreshInterval`** ：`refreshInterval: 30` 會每隔 30 秒重跑一次狀態列，即使工作階段處於閒置狀態也一樣 —— 這能讓重置倒數（`5h{1.1h}`）、時間追蹤器以及重置後的翻轉保持即時更新。30 是個合理的預設值；60 較省電；省略則只在事件發生時更新（新的助理訊息、`/compact`、vim 切換）。

重新啟動 Claude Code（或執行 `/config` 重新載入）。

### 透過 Claude Code 代理安裝（含自動備份）

想讓 Claude Code 安全地幫你安裝？貼上這段提示：

> 「把這個 repo 裡的狀態列安裝成我的 Claude Code 狀態列：
> 1. 如果 `~/.claude/status-line.sh` 已經存在，把它備份到
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`（若同名備份
>    已存在，就挑一個空的 `-N` 後綴）。
> 2. 把這個 repo 裡的 `statusline.sh` 複製到 `~/.claude/status-line.sh` 並 `chmod +x`。
> 3. 讀取 `~/.claude/settings.json`。如果它沒有 `statusLine` 鍵，就加上一個
>    指向腳本絕對路徑的 `statusLine` 區塊，並在其中加入 `"refreshInterval": 30`。如果
>    `statusLine` 已存在且指向別處，先把
>    `settings.json` 備份成 `.bak.<timestamp>`。
> 4. 冒煙測試這支腳本：
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. 提醒我重新啟動 Claude Code，並回報建立了哪些備份。」

### 更新到最新版本

```bash
~/.claude/status-line.sh update
```

從 GitHub 抓取最新的 bundle，建立一份帶時間戳記的備份
（`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`），並保留你的
主題設定（`~/.claude/statusline.conf`）。之後重新啟動 Claude Code。

查看你已安裝的版本：`~/.claude/status-line.sh version`。

### 系統需求

- `bash` 4+（腳本使用 0 起始索引的陣列 —— **請勿在 `zsh` 下執行**）
- 用來解析 JSON 的 `jq` —— `apt-get install jq`（Debian/Ubuntu）、`brew install jq`（macOS）、`dnf install jq`（Fedora）
- `curl`（只有 `statusline update` 需要；大多數系統都已預先安裝）
- 一個 256 色終端機（基本上每個現代終端機都是）

## ⚙️ 設定

編輯 `statusline.sh` 頂部附近的常數：

| 變數 / 函式 | 控制內容 |
|---|---|
| `BAR_STYLE` | `"quadrant"`（預設，2.5% 步進）或 `"vertical"`（1.25% 步進） |
| `pct_icon()` | 進度條前 🚀 / 🚗 / ⚠️ 圖示的門檻 |
| `pct_color()` | 百分比 / 進度條的顏色門檻 |
| ANSI 顏色常數 | 重新為任何區段上色（`G`、`Y`、`R`、`B`、`C`、`M`……） |

## 🆚 對比 Claude Code 預設狀態列

| 能力 | 預設 | 本專案 |
|---|---|---|
| 目前 **模型名稱** | ✅ | ✅（1M context 版本會標示 `(1M)`） |
| **context window** 已用 % | ❌ | ✅ 即時，1.25 % 精度 |
| context 的 **進度條** | ❌ | ✅（vertical、quadrant、rainbow、sparkline……） |
| 以美元計算的 **工作階段花費** | ❌ | ✅ 每次重繪都更新 |
| **每則訊息** 的輸入／輸出 token 計數 | ❌ | ✅ |
| **工作階段 token 總量**（API 模式回退） | ❌ | ✅ |
| **5h / 7d 速率限制** 指示器，> 50 % 時顯示 ⚠️ | ❌ | ✅ |
| 限額計量器裡的重置倒數（`5h{1.1h}`） | ❌ | ✅ |
| **Git 分支** + dirty + ahead/behind | ❌ | ✅ |
| **任務耗時**（active 對 wall clock） | ❌ | ✅ |
| **Thinking / effort 等級** 顯示 | ❌ | ✅ |
| 主題預設 | ❌ | ✅ 79 款主題 × 2 變體 = **158 款現成** |
| 從具名區塊組合 | ❌ | ✅ 26 個區塊，見 [BLOCKS.md](BLOCKS.md) |
| 內建 CLI 設定工具 | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` 斜線指令 | ❌ | ✅ 選用，見 [`commands/`](commands/) |
| 外部相依套件 | — | `bash` 4+ 和 `jq`（無 Node、無 Python、無常駐程式） |
| 授權 | — | Source-Available（須經許可才能重用） |

## 💡 使用情境

這個專案能替自己賺回成本的具體情境：

- **「我的 1 M context 燒掉多少了？」** —— 每次下提示前都看得到即時百分比 + 進度條。
- **「這次 Claude Code 工作階段花了我多少錢？」** —— 累計的美元總額，每次重繪都更新。
- **「我今天會不會撞到速率限制？」** —— 5 h / 7 d 指示器，> 50 % 時顯示 ⚠️。
- **「我在對的分支上嗎？」** —— 狀態列裡的 git 分支 + dirty + ahead/behind。
- **「這個功能我實際花了幾個小時？」** —— 任務耗時追蹤器（`active` 對 `wall`）。
- **「我想要一個好玩的終端機。」** —— anime、cyberpunk、hacker、retro、weather、ocean、fire 等主題。
- **「我想要一個極簡、純 ASCII 的狀態列來錄螢幕。」** —— `zen` 主題。
- **「我想推一個讓整個團隊都用的狀態列。」** —— 單一打包腳本 + CLI 設定工具 + 斜線指令。

## ❓ 常見問題（FAQ）

### 什麼是「Claude Code Status Line」？

一個以 bash 寫成、用來取代 [Claude Code](https://claude.com/claude-code)（Anthropic 的 CLI）預設狀態列的方案。它把螢幕底部那一行變成真正的儀表板：模型、context %、進度條、工作階段花費、速率限制、git 狀態、任務耗時，以及更多。

### `5h{1.1h}: 1%` 是什麼意思？

你已經用掉了 5 小時窗口的 1%，而 `{1.1h}` 是一個即時倒數 —— 該窗口將在 1.1 小時後重置（`7d{1.1d}`：每週窗口將在 1.1 天後重置）。每次重繪時都會從 `rate_limits.*.resets_at` 讀取。你的版本沒有重置時間戳記？計量器會回退成單純的 `5h: 1%`。

### 狀態列會自己更新嗎？我的 `{1.1h}` 倒數看起來凍住了。

Claude Code 會在事件發生時重新算繪 —— 新的助理訊息、`/compact`、權限模式或 vim 模式切換（debounce 在 300 ms）—— 所以在事件之間狀態列會凍住。把 `"refreshInterval": 30` 加到 `~/.claude/settings.json` 的 `statusLine` 區塊，它就會額外按照固定的 30 秒計時器重跑，讓倒數與時間追蹤器在閒置時也持續跳動。一次算繪約耗 0.1 秒，所以 30 秒可以忽略不計；在電池供電或超大型 repo 裡用 60（每次算繪都會跑 git status）；最小值為 1。

### 它怎麼安裝？

把 `statusline-bundle.sh` 複製到 `~/.claude/status-line.sh`、執行 `chmod +x`，然後把 Claude Code 的 `~/.claude/settings.json` 裡的 `statusLine.command` 指向那個路徑。完整說明在 [快速開始](#-快速開始) 和 [安裝](#-安裝) 兩節裡。

### 它支援 1 M context window 的模型嗎？

支援。腳本會偵測模型 id 裡的 `[1m]` 和顯示名稱裡的 `1M`，並把進度條的分母調整成 1 000 000 token。你會看到 `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`。

### 它支援哪些模型？

任何 Claude Code 支援的模型 —— Opus 4.7、Sonnet 4.6、Haiku 4.5、Opus 4.6 等。腳本會從 Claude Code 提供的 stdin JSON 讀取 `model.display_name` 與 `model.id`；它不會把模型名稱寫死。

### 我可以自訂顏色、主題，或加入自己的嗎？

可以 —— 有三種方式：

1. 從 **79 款主題**（共 158 個變體）中挑一個 —— 用 `~/.claude/status-line.sh use <name>`，或瀏覽 [`examples/`](examples/) 裡的獨立腳本。
2. 從 **具名區塊** 組出你自己的 —— 見 [BLOCKS.md](BLOCKS.md)。
3. 直接編輯 `statusline.sh` 裡的顏色常數與進度條樣式。

### 它會拖慢 Claude Code 嗎？

不會。每次重繪只在狀態重畫時跑一次，用 `jq` 解析傳入的 JSON、視情況 `grep` transcript 的最後一行，然後印出來。即使開了時間追蹤器，典型的重繪也 ≤ 50 ms。

### 沒有 `jq` 也能用嗎？

`jq` 是必要的 —— 它負責解析 Claude Code 透過 stdin 送來的 JSON。安裝方式：`brew install jq`（macOS）、`apt install jq`（Debian/Ubuntu），或 `choco install jq`（Windows）。

### 它在 Windows 上能用嗎？

可以，只要該環境能跑 `bash` 4+ 和 `jq` —— Git Bash、WSL、MSYS2、Cygwin 都行。純 CMD/PowerShell 不支援。

### 它在 Linux / macOS 上能用嗎？

兩者都能。macOS 用 BSD `date`，Linux 用 GNU `date` —— 時間追蹤器會自動透明地處理兩者。

### 我可以直接搭配原始的 Anthropic API、而不透過 Claude Code 嗎？

部分支援。狀態列是為 Claude Code 的 stdin JSON 格式設計的。若是原始 API 用法，速率限制指示器會自動回退成 **工作階段 token 總量** 的顯示（`tokens: NNN K`）。

### 設定存在哪裡？

`~/.claude/statusline.conf` —— 一個由 bundle 的 CLI（`statusline.sh use <theme>` 等）寫入、可被 shell source 的小檔案。在重新啟動之間會保留。

### 我要怎麼還原成 Claude Code 的預設狀態列？

不是把 `~/.claude/settings.json` 裡的 `statusLine` 區塊移除，就是執行 `~/.claude/status-line.sh reset`，並切換到與預設相當接近的 `minimal` 主題。

### 它免費嗎？我可以商用嗎？

個人、在地使用是免費的 —— 見 [Source-Available License](LICENSE)。任何重用、再散布、fork，或併入其他專案，都需要作者（Yevgeniy Achin · amazopic@gmail.com）的 **事前書面許可**。合理的請求通常會獲准。

### 「人時」追蹤器是怎麼運作的？

`time` 主題會從 JSONL transcript 讀取時間戳記，並回報兩個時長：**active**（所有間隔短於 5 分鐘的訊息間隙之總和）與 **wall**（從第一則到最後一則訊息的總跨度）。那個 5 分鐘的閒置門檻是可設定的。

## 🏷️ 建議的 GitHub topics

當你發布這個 repo 時，加上這些 topics 以提升被發現的機會：

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 參與貢獻

歡迎開 issue 與 PR —— 但請留意授權條款：

- **閱讀、開 issue、提交 PR**：免費。
- **Fork、複製到其他專案、再散布**：需要
  作者的事前書面許可。

要申請重用許可，請聯絡：
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

針對個人、教育與非商業用途的合理請求，
通常會免費獲准。

## 📜 授權

[**Source-Available License（須經許可才能重用）**](LICENSE)

本專案的原始碼公開供閱讀、研究，以及在你自己的機器上
個人使用。任何重用 —— 複製、再散布、
修改，或併入其他專案 —— 都需要作者
（Yevgeniy Achin · amazopic@gmail.com）的 **事前書面許可**。

這 **不是** 一個經 OSI 認可的開源授權。這是一個刻意的
選擇，在讓社群得以閱讀、研究與貢獻的同時，
把散布與衍生作品的控制權留在作者手上。

## ⭐ 覺得有用嗎？

既然你要花好幾個小時盯著 Claude Code，那不如盯著一個漂亮的狀態列。**給這個 repo 點顆 ⭐**，幫助別人發現它！

---

由 **Yevgeniy Achin** 製作 · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · 獻給 Claude Code 社群。
