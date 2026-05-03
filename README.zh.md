# 🛰️ Claude Code Status Line

> 为 Claude Code 打造的精致、可定制状态栏 —— 上下文进度、速率限制、费用、模型等信息全部呈现在一行优雅的彩色文本中。

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-贡献)

**语言:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · 中文 · [日本語](README.ja.md) · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## 为什么用它?

Claude Code 自带的状态栏过于简陋。这个替换方案把它升级为每次会话都能 **一眼看清** 的仪表盘:

- 🔋 我消耗了多少上下文?(1.25% 步进的平滑分数进度条)
- 💰 这次会话花了多少钱?
- 🚦 我离速率限制有多近?
- 🧠 当前的 thinking 等级 / 模型是什么?
- 🌿 当前在哪个 git 分支?

全部呈现在 **一行** 中,带颜色编码和提示紧急程度的智能图标。

## ✨ 功能特性

- 🪐 **实时上下文进度条** —— 10 格进度条,带子格精度(quadrant 或 vertical 分数字符)
- 🧠 **模型名称** —— 1M 上下文模型带 `(1M)` 标识
- 💸 **会话费用**(USD),每次渲染都会更新
- ⬆️⬇️ **每条消息的 token 计数**(输入 / 输出)
- 🚦 **速率限制** —— 5h / 7d,超过 50% 显示 ⚠️ 警告
- 🔄 **API 模式回退** —— 如果未传递限制信息,显示会话总 token(`tokens: NNN K`),用细空格作千位分隔符
- 🚀 **智能状态图标** —— 🚀 < 40%,🚗 40–49%,⚠️ ≥ 50%
- 🎨 **256 色 ANSI** —— 每段使用明亮、清晰的不同颜色
- 🧩 **可插拔的进度条样式** —— 选择 `quadrant` (▖▄▙█)、`vertical` (▏▎▍▌▋▊▉█),或用 10 行 bash 写自己的
- ⚡ **轻量** —— 纯 `bash` + `jq`,无 Node、无 Python、无后台进程、无遥测

> 💡 **小贴士 — 上下文控制**：上下文窗口越满，与 Claude 的对话**效率越低**，5 小时 / 7 天**限额烧得越快**。每次超过 **60%** 就清理或 `/compact`，保持高效工作。

## 🚀 安装

### ⚡ 或 vibe-chill 方法 · 让 Claude 来做

有 Claude Code，何必碰终端？把这一条提示粘到 Claude Code 会话里 — Claude 全程包办，每条命令前都会问你。

```text
帮我安装 amazopic 的 claude-code-statusline。克隆 github.com/amazopic/claude-code-statusline，如果已有 ~/.claude/statusline.sh 请先备份，把 statusline-bundle.sh 复制到 ~/.claude/statusline.sh 并设为可执行，再把 commands/statusline.md 复制到 ~/.claude/commands/。然后告诉我应该在 ~/.claude/settings.json 中加什么，让 Claude Code 连接新的 statusLine。最后运行 ~/.claude/statusline.sh use developer 测试 developer 主题,并提醒我重启 Claude Code。
```

> 每个权限提示都回 `y`（yes）即可。搞定。


### 手动安装(3 步)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

然后在 `~/.claude/settings.json` 中添加:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<你>/.claude/statusline.sh"
  }
}
```

重启 Claude Code(或运行 `/config` 重新加载)。

### 通过 Claude Code 智能体安装(自动备份)

想让 Claude Code 帮你安全地安装?粘贴这个 prompt:

> "把本仓库中的状态栏安装为我的 Claude Code 状态栏:
> 1. 如果 `~/.claude/statusline.sh` 已存在,把它备份到
>    `~/.claude/statusline.sh.bak.<YYYYMMDD-HHMMSS>`(若该名称的备份
>    已存在,使用空闲的 `-N` 后缀)。
> 2. 把仓库中的 `statusline.sh` 复制到 `~/.claude/statusline.sh` 并
>    `chmod +x`。
> 3. 读取 `~/.claude/settings.json`。如果没有 `statusLine` 键,添加一个
>    指向脚本绝对路径的 `statusLine` 块。如果 `statusLine` 已指向其他
>    地方,先把 `settings.json` 备份为 `.bak.<timestamp>`。
> 4. 冒烟测试:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/statusline.sh`
> 5. 提醒我重启 Claude Code,并报告创建的备份文件。"

### 系统要求

- `bash` 4+(脚本使用 0-索引数组 —— **不要在 `zsh` 下运行**)
- `jq` 用于 JSON 解析
- 256 色终端(基本上每个现代终端都支持)

## ⚙️ 配置

编辑 `statusline.sh` 顶部的常量:

| 变量 / 函数 | 控制内容 |
|---|---|
| `BAR_STYLE` | `"quadrant"`(默认,2.5% 步进)或 `"vertical"`(1.25% 步进)|
| `pct_icon()` | 进度条前 🚀 / 🚗 / ⚠️ 图标的阈值 |
| `pct_color()` | 百分比 / 进度条的颜色阈值 |
| ANSI 颜色常量 | 重新着色任何段(`G`、`Y`、`R`、`B`、`C`、`M`、…)|

## 🧩 插件方法 —— 10 行写出自己的进度条样式

每种样式都是一个独立函数 `bar_<name>(pct)`,返回恰好 10 个可见单元的字符串:

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

然后在 `bar()` 调度器中注册:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

就这么简单。函数契约:

- 输入: 整数 `pct` `0..100`(已规范化)
- 输出: 恰好 10 个可见单元
- 四舍五入到 **最近** 的子步进(不是 floor),避免进度条卡在整齐数值上

非常欢迎 PR 添加新样式。

### 更多 prompt 示例

<details>
<summary>添加样式、段落和调整的 prompt 模板</summary>

#### `shaded` 样式(4 个等级: `░ ▒ ▓ █`)

> "添加 `shaded` 进度条样式: 每格 4 级 —— `░ ▒ ▓ █`(light → medium →
> dark → full),步进 2.5%。使用与 `bar_quadrant` 相同的舍入规则。
> 通过 `BAR_STYLE=\"shaded\"` 启用。"

#### `dotted` 样式(用于受限终端)

> "添加 `dotted` 样式,适用于不支持块字符的终端: 10 格,填充 = `●`,
> 空 = `·`,无子级别(步进 10%)。"

#### 进度条按阈值着色

> "在 `bar()` 中生成字符串后,根据百分比包裹颜色: < 50% 绿色 (`$GR`),
> 50–69% 黄色 (`$Y`),≥ 70% 红色 (`$R`)。必须对所有 `BAR_STYLE` 都生效。"

#### 新段落: Python virtualenv

> "在 `${git_part}` 之前添加新段落: 当前 Python virtualenv 名称
> (取自 `$VIRTUAL_ENV` 的 basename),颜色为 magenta (`$M`)。
> 如果变量为空,该段及其 `${SEP}` 都省略。"

#### 调整图标阈值

> "在 `pct_icon` 中添加第四个阈值: ≥ 80% 返回 `🔥`。保留现有图标,
> 重新排列: < 40% 🚀,40–59% 🚗,60–79% ⚠️,≥ 80% 🔥。"

</details>

## 🤝 贡献

非常欢迎 PR!特别是:

- 🎨 新的 `bar_<style>` 变体(sparkline、仪表、ASCII 艺术…)
- 🧱 新段落(kubectl 上下文、Python venv、AWS profile、电池、天气…)
- 🌍 更多 README 翻译
- 🐛 修复边界情况的 bug(超大 transcript、奇异终端)

大改动前请先开 issue 讨论。

## 📜 许可

[Source-Available](LICENSE) —— 随意使用,标注作者为佳但非必须。

## ⭐ 觉得有用?

既然你要花数小时盯着 Claude Code,不如盯着一个漂亮的状态栏。**给仓库点个 ⭐**,帮助别人发现它!

---

为 Claude Code 社区用 ❤️ 制作。

---

## 作者 / 许可 / 联系

- **作者:** Yevgeniy Achin
- **许可:** [Source-Available License](LICENSE) — Source-Available — 重用须经作者书面许可
- **联系:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 一体化打包脚本 (`statusline-bundle.sh`)

不想管理 40+ 个文件?使用**单一打包脚本** `statusline-bundle.sh` — 它在一个文件中包含所有主题、所有块和 CLI 配置器。

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

配置保存在 `~/.claude/statusline.conf` 中,跨重启持久化。同一个文件既是**渲染器**(当 Claude Code 通过 stdin 传入 JSON)又是**配置器**(当你带参数调用它)。

### 斜杠命令 `/statusline`

把 `commands/statusline.md` 放到 `~/.claude/commands/` 中 — Claude Code 中会出现 `/statusline` 命令:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

然后在任何 Claude Code 会话中你可以输入:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Shell 别名(可选)

```bash
alias statusline='~/.claude/statusline.sh'
```

然后 `statusline cyberpunk` 可以在任何终端中使用。

---

## ⚡ 快速开始

最快路径 — 一体化打包脚本,内置 CLI:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
~/.claude/statusline.sh use cyberpunk          # 或: anime, hacker, minimal, …
```

然后添加到 `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<你>/.claude/statusline.sh" } }
```

重启 Claude Code(或 `/config` reload)。完成。

## 🆚 与 Claude Code 默认状态栏对比

| 功能 | 默认 | 本项目 |
|---|---|---|
| 当前模型名 | ✅ | ✅(1M 上下文带 `(1M)` 标识)|
| 上下文窗口:已用 % | ❌ | ✅ 实时,精度 1.25 % |
| 上下文进度条 | ❌ | ✅(vertical, quadrant, rainbow, sparkline 等)|
| 会话费用(USD)| ❌ | ✅ 每次渲染更新 |
| 输入/输出 token 计数 | ❌ | ✅ |
| 会话总 token(API 模式回退)| ❌ | ✅ |
| 5h / 7d 速率限制指示器(>50% 显示 ⚠️)| ❌ | ✅ |
| Git 分支 + dirty + ahead/behind | ❌ | ✅ |
| 任务用时(active vs wall)| ❌ | ✅ |
| Thinking / effort 等级 | ❌ | ✅ |
| 预设主题 | ❌ | ✅ 20 主题 × 2 变体 = **40 现成** |
| 从命名块组合 | ❌ | ✅ 18 块,见 [BLOCKS.md](BLOCKS.md) |
| 内置 CLI 配置器 | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` 斜杠命令 | ❌ | ✅ 可选,见 [`commands/`](commands/) |
| 依赖 | — | `bash` 4+ 和 `jq`(无 Node、Python、守护进程)|

## 💡 使用场景

- **「我的 1 M 上下文用了多少?」** — 每次提示前显示实时 % 和进度条。
- **「这次 Claude Code 会话花了多少钱?」** — 实时 USD 总额,每次渲染更新。
- **「今天我会触发限制吗?」** — 5h / 7d 指示器,>50% 时显示 ⚠️。
- **「我在正确的分支上吗?」** — 状态栏显示 git 分支 + dirty + ahead/behind。
- **「我在这个特性上实际花了多少小时?」** — 时间跟踪(`active` vs `wall`)。
- **「我想要好玩的终端。」** — anime, cyberpunk, hacker, retro, weather, ocean, fire 等主题。
- **「我需要简洁的纯 ASCII 状态栏用于录屏。」** — `zen` 主题。

## ❓ 常见问题 (FAQ)

### 什么是 Claude Code Status Line?

[Claude Code](https://claude.com/claude-code)(Anthropic 的 CLI)默认状态栏的 bash 替代品。把底部状态行变成真正的仪表盘:模型、上下文 %、进度条、会话费用、限制、git、时间等。

### 如何安装?

把 `statusline-bundle.sh` 复制到 `~/.claude/statusline.sh`,执行 `chmod +x`,把 `~/.claude/settings.json` → `statusLine.command` 指向该路径。

### 支持 1 M 上下文模型吗?

支持。脚本检测 model id 中的 `[1m]` 和 display name 中的 `1M`,把分母调整为 1 000 000 token。

### 与哪些模型兼容?

兼容 Claude Code 支持的任何模型 — Opus 4.7、Sonnet 4.6、Haiku 4.5、Opus 4.6 等。

### 可以自定义颜色、主题或添加自己的吗?

可以,有三种方式:(1)从 [`examples/`](examples/) 中**40 个现成变体**选择,(2)从命名块组合自己的 — 见 [BLOCKS.md](BLOCKS.md),(3)直接编辑 `statusline.sh` 中的颜色常量。

### 会拖慢 Claude Code 吗?

不会。典型渲染 ≤ 50 ms。

### 没有 `jq` 能用吗?

`jq` 是必需的。安装:`brew install jq`(macOS)或 `apt install jq`(Debian/Ubuntu)。

### 在 Windows / macOS / Linux 上能用吗?

都能用。Windows 上通过 Git Bash、WSL、MSYS2 或 Cygwin。

### 可以直接用 Anthropic API(不通过 Claude Code)吗?

部分支持。限制指示器自动切换到会话总 token 显示(`tokens: NNN K`)。

### 配置存在哪里?

`~/.claude/statusline.conf` — 一个小型 shell-source 文件。跨重启持久化。

### 是免费的吗?可以商用吗?

个人本地使用免费(见 [Source-Available License](LICENSE))。任何重用都需要作者(amazopic@gmail.com)的**事先书面许可**。

### 如何恢复 Claude Code 默认状态栏?

从 `~/.claude/settings.json` 中删除 `statusLine` 块,或运行 `~/.claude/statusline.sh reset`。

## 🏷️ 推荐的 GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
