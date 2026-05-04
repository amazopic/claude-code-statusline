# 🛰️ Claude Code Status Line

> Claude Code 用の洗練された、ハック可能なステータスライン — コンテキストバー、レート制限、コスト、モデルなどを、美しく色分けされた 1 行に。

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-コントリビュート)

**言語:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · 日本語 · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## なぜ?

Claude Code 標準のステータスラインは控えめです。このドロップイン置換は、毎セッションを **一目でわかるダッシュボード** に変えます:

- 🔋 コンテキストはどれくらい使った?(1.25% 刻みのなめらかな分数バー)
- 💰 このセッションでいくらかかった?
- 🚦 レート制限にどれくらい近い?
- 🧠 どの thinking レベル / モデルを使っている?
- 🌿 どの git ブランチにいる?

すべて **1 行** に、色分けされ、緊急度を示すスマートなアイコン付き。

## ✨ 機能

- 🪐 **ライブコンテキストバー** — サブセル精度の 10 セルプログレスバー(quadrant または vertical の分数グリフ)
- 🧠 **モデル名** — 1M コンテキスト版には `(1M)` 表示
- 💸 **セッションコスト**(USD)、レンダリングごとに更新
- ⬆️⬇️ **メッセージ単位のトークン数**(入力 / 出力)
- 🚦 **レート制限** — 5h / 7d、50% 超で ⚠️ 警告
- 🔄 **API モードでのフォールバック** — 制限値が渡されない場合、セッション総トークン(`tokens: NNN K`)を細い空白の 3 桁区切りで表示
- 🚀 **スマートステータスアイコン** — 🚀 < 40%、🚗 40–49%、⚠️ ≥ 50%
- 🎨 **256 色 ANSI** — セグメントごとに鮮やかで明確な色
- 🧩 **プラガブルなバー スタイル** — `quadrant`(▖▄▙█)、`vertical`(▏▎▍▌▋▊▉█)、または 10 行の bash で自作
- ⚡ **軽量** — `bash` + `jq` のみ。Node 不要、Python 不要、デーモン不要、テレメトリなし

> 💡 **プロのコツ — コンテキスト制御**：コンテキストウィンドウが満杯に近いほど、Claude との会話は**効果が落ち**、5時間 / 7日のリミットも**速く燃え尽きる**。**60%** を超えたら整理または `/compact` で、効率的な作業を維持。

## 🚀 インストール

### 手動インストール(3 ステップ)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

次に `~/.claude/settings.json` に追加:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<あなた>/.claude/status-line.sh"
  }
}
```

Claude Code を再起動(または `/config` reload)。

### Claude Code エージェント経由でのインストール(自動バックアップ付き)

Claude Code に安全にインストールしてもらいたい?このプロンプトを貼り付け:

> 「このリポジトリのステータスラインを私の Claude Code ステータスラインとしてインストールして:
> 1. `~/.claude/status-line.sh` がすでに存在する場合は
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` にバックアップ
>    (同名のバックアップが既にある場合は空いている `-N` サフィックスを使用)。
> 2. リポジトリの `statusline.sh` を `~/.claude/status-line.sh` にコピーし
>    `chmod +x` を実行。
> 3. `~/.claude/settings.json` を読み込み。`statusLine` キーがなければ、
>    スクリプトの絶対パスを指す `statusLine` ブロックを追加。
>    すでに別の場所を指している場合は、まず `settings.json` を
>    `.bak.<timestamp>` にバックアップ。
> 4. スモークテスト:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. 私に Claude Code の再起動を促し、作成したバックアップを報告。」

### 最新バージョンへの更新

```bash
~/.claude/status-line.sh update
```

GitHub から最新の bundle を取得し、タイムスタンプ付きバックアップ
（`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`）を作成、テーマ設定
（`~/.claude/statusline.conf`）を保持します。完了後 Claude Code を再
起動してください。

インストール済みバージョンの確認: `~/.claude/status-line.sh version`。

### 必要要件

- `bash` 4+(スクリプトは 0-indexed 配列を使用 — **`zsh` で実行しないこと**)
- `jq`(JSON パース用)
- 256 色対応ターミナル(基本的に最近のものなら何でも)

## ⚙️ 設定

`statusline.sh` の上部にある定数を編集:

| 変数 / 関数 | 制御内容 |
|---|---|
| `BAR_STYLE` | `"quadrant"`(デフォルト、2.5% 刻み)または `"vertical"`(1.25% 刻み)|
| `pct_icon()` | バー前の 🚀 / 🚗 / ⚠️ アイコンのしきい値 |
| `pct_color()` | パーセンテージ / バーのカラーしきい値 |
| ANSI カラー定数 | 任意のセグメントを再カラーリング(`G`、`Y`、`R`、`B`、`C`、`M`、…)|

## 🧩 プラグイン手法 — 10 行で独自のバー スタイル

各スタイルは独立した関数 `bar_<name>(pct)` で、ちょうど 10 個の可視セルを返します:

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

そして `bar()` ディスパッチャに登録:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

これだけ。関数の契約:

- 入力: 整数 `pct` `0..100`(クランプ済み)
- 出力: ちょうど 10 個の可視セル
- **最近接** のサブステップへ丸める(floor ではなく)— バーが整数値で止まるのを防ぐため

新スタイルの PR は大歓迎です。

### その他のプロンプト例

<details>
<summary>スタイル、セグメント、調整を追加するプロンプトテンプレート</summary>

#### `shaded` スタイル(4 レベル: `░ ▒ ▓ █`)

> 「`shaded` バー スタイルを追加して: セルあたり 4 レベル — `░ ▒ ▓ █`
> (light → medium → dark → full)、刻み 2.5%。`bar_quadrant` と同じ
> 丸めルール。`BAR_STYLE=\"shaded\"` で有効化。」

#### 制限のあるターミナル向け `dotted` スタイル

> 「ブロック文字非対応のターミナル用に `dotted` スタイルを追加:
> 10 セル、塗り = `●`、空 = `·`、サブレベルなし(刻み 10%)。」

#### しきい値ベースのバー カラーリング

> 「`bar()` 内で文字列生成後、パーセンテージに応じて色で包む:
> < 50% 緑 (`$GR`)、50–69% 黄 (`$Y`)、≥ 70% 赤 (`$R`)。
> 任意の `BAR_STYLE` で動作すること。」

#### 新セグメント: Python virtualenv

> 「`${git_part}` の前に新セグメントを追加: `$VIRTUAL_ENV` から
> 現在の Python virtualenv 名(basename)、色は magenta (`$M`)。
> 空の場合はセグメントとその `${SEP}` を省略。」

#### アイコンのしきい値調整

> 「`pct_icon` に 4 番目のしきい値を追加: ≥ 80% で `🔥` を返す。
> 既存のアイコンを保持し、再配置: < 40% 🚀、40–59% 🚗、
> 60–79% ⚠️、≥ 80% 🔥。」

</details>

## 🤝 コントリビュート

PR は大歓迎です!特に:

- 🎨 新しい `bar_<style>` バリエーション(sparkline、ゲージ、ASCII アート…)
- 🧱 新セグメント(kubectl コンテキスト、Python venv、AWS プロファイル、バッテリー、天気…)
- 🌍 README の追加翻訳
- 🐛 エッジケースのバグ修正(巨大トランスクリプト、エキゾチックなターミナル)

大きな変更を計画している場合は先に issue を開いてください。

## 📜 ライセンス

[Source-Available](LICENSE) — 何でも自由に使えます。クレジットは歓迎しますが必須ではありません。

## ⭐ お役に立ちましたか?

何時間も Claude Code を見つめるなら、せめて美しいステータスラインを見つめましょう。**リポジトリに ⭐ を付けて** 他の人が見つけられるようにしてください!

---

Claude Code コミュニティへ ❤️ を込めて。

---

## 作者 / ライセンス / 連絡先

- **作者:** Yevgeniy Achin
- **ライセンス:** [Source-Available License](LICENSE) — Source-Available — 再利用には作者の書面による許可が必要
- **連絡先:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 オールインワンバンドル (`statusline-bundle.sh`)

40+ ファイルを管理したくない?**単一バンドルスクリプト** `statusline-bundle.sh` を使ってください — 全テーマ、全ブロック、CLI 設定ツールを 1 ファイルに収録。

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

設定は `~/.claude/statusline.conf` に保存され、再起動を超えて永続します。同じファイルが**レンダラー**(Claude Code が stdin で JSON を渡すとき)と**設定ツール**(引数付きで呼び出すとき)の両方として機能します。

### スラッシュコマンド `/statusline`

`commands/statusline.md` を `~/.claude/commands/` に配置すると、Claude Code 内で `/statusline` コマンドが使えます:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

それから任意の Claude Code セッションで入力できます:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### シェルエイリアス(オプション)

```bash
alias statusline='~/.claude/status-line.sh'
```

その後、`statusline cyberpunk` は任意のターミナルから動作します。

---

## ⚡ クイックスタート

最速の方法 — CLI 内蔵のオールインワンバンドルスクリプト:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # または: anime, hacker, minimal, …
```

次に `~/.claude/settings.json` に追加:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<あなた>/.claude/status-line.sh" } }
```

Claude Code を再起動(または `/config` reload)。完了。

### または vibe-chill 方式 · Claude に任せる

Claude Code があるのに、なぜターミナルを触る？この 1 つのプロンプトを Claude Code セッションに貼り付け — Claude が全ステップを処理し、各コマンド前に確認します。

```text
amazopic の claude-code-statusline をインストールして。まず jq がインストールされているか確認（`which jq` を実行）— 入っていなければプラットフォームに合わせて入れて：`sudo apt-get install -y jq`（Ubuntu/Debian）、`sudo dnf install -y jq`（Fedora）、`brew install jq`（macOS）、`sudo apk add jq`（Alpine）。次に ~/.claude/settings.json を読んで — statusLine.command が既存ファイル（例：~/.claude/status-line.sh など）を指していたら、そのファイルに .bak を追加してバックアップ（既存 .bak は上書き）。~/.claude/status-line.sh が既にあれば同様にバックアップ。次に github.com/amazopic/claude-code-statusline をクローンし、statusline-bundle.sh を ~/.claude/status-line.sh にコピーして実行可能にし、commands/statusline.md も ~/.claude/commands/ にコピー。~/.claude/settings.json を更新して statusLine = { type: "command", command: "<~/.claude/status-line.sh の絶対パス>" } にして。最後に ~/.claude/status-line.sh use developer を実行して developer テーマをテストし、Claude Code を再起動するよう伝えて。
```

> 許可プロンプトには `y`（yes）と答えるだけ。完了。


## 🆚 Claude Code デフォルトのステータスラインとの比較

| 機能 | デフォルト | このプロジェクト |
|---|---|---|
| アクティブモデル名 | ✅ | ✅(1M コンテキスト版には `(1M)` マーク)|
| コンテキストウィンドウ:使用率 | ❌ | ✅ ライブ、精度 1.25 % |
| コンテキスト進行バー | ❌ | ✅(vertical, quadrant, rainbow, sparkline など)|
| セッションコスト(USD)| ❌ | ✅ レンダリング毎に更新 |
| 入出力トークンカウンター | ❌ | ✅ |
| セッション総トークン(API モードフォールバック)| ❌ | ✅ |
| 5h / 7d レート制限インジケーター(> 50 % で ⚠️)| ❌ | ✅ |
| Git ブランチ + dirty + ahead/behind | ❌ | ✅ |
| タスク時間(active vs wall)| ❌ | ✅ |
| Thinking / effort レベル | ❌ | ✅ |
| プリセットテーマ | ❌ | ✅ 20 テーマ × 2 バリアント = **40 種類** |
| 名前付きブロックから構成 | ❌ | ✅ 18 ブロック、[BLOCKS.md](BLOCKS.md) 参照 |
| 内蔵 CLI 設定ツール | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` スラッシュコマンド | ❌ | ✅ オプション、[`commands/`](commands/) 参照 |
| 依存関係 | — | `bash` 4+ と `jq`(Node・Python・デーモン不要)|

## 💡 ユースケース

- **「1 M コンテキストをどれだけ消費したか?」** — 各プロンプト前にライブ % とバー。
- **「この Claude Code セッションの費用は?」** — リアルタイム USD、レンダリング毎に更新。
- **「今日レート制限に引っかかるか?」** — 5h / 7d インジケーター、> 50 % で ⚠️。
- **「正しいブランチにいるか?」** — git ブランチ + dirty + ahead/behind をステータスラインに。
- **「この機能に実際何時間費やしたか?」** — 時間トラッカー(`active` vs `wall`)。
- **「楽しいターミナルが欲しい。」** — anime、cyberpunk、hacker、retro、weather、ocean、fire テーマ。
- **「画面録画用にミニマル ASCII ステータスラインが欲しい。」** — `zen` テーマ。

## ❓ よくある質問 (FAQ)

### Claude Code Status Line とは?

[Claude Code](https://claude.com/claude-code)(Anthropic の CLI)デフォルトステータスラインの bash 製代替品。下部のステータスラインを本物のダッシュボードに変えます:モデル、コンテキスト %、進行バー、セッションコスト、制限、git、時間など。

### インストール方法は?

`statusline-bundle.sh` を `~/.claude/status-line.sh` にコピーし、`chmod +x` を実行、`~/.claude/settings.json` の `statusLine.command` をそのパスに向ける。

### 1 M コンテキストモデルをサポートしていますか?

はい。スクリプトは model id の `[1m]` と display name の `1M` を検出し、バーの分母を 1 000 000 トークンに調整します。

### どのモデルで動作しますか?

Claude Code がサポートする任意のモデル — Opus 4.7、Sonnet 4.6、Haiku 4.5、Opus 4.6 など。

### 色やテーマをカスタマイズできますか?

3 つの方法があります:(1)[`examples/`](examples/) の **40 種類のプリセット**から選ぶ、(2)名前付きブロックから自作 — [BLOCKS.md](BLOCKS.md) 参照、(3)`statusline.sh` の色定数を直接編集。

### Claude Code が遅くなりませんか?

なりません。典型的なレンダリングは ≤ 50 ms。

### `jq` なしで動きますか?

`jq` は必須です。インストール:`brew install jq`(macOS)または `apt install jq`(Debian/Ubuntu)。

### Windows / macOS / Linux で動きますか?

すべてで動作。Windows 上では Git Bash、WSL、MSYS2、Cygwin 経由。

### Anthropic API を直接使う場合に使えますか?

部分的に。レート制限インジケーターは自動的にセッション総トークン表示(`tokens: NNN K`)に切り替わります。

### 設定はどこに保存されますか?

`~/.claude/statusline.conf` — 小さな shell-source ファイル。再起動を超えて永続。

### 無料ですか?商用利用できますか?

個人ローカル利用は無料([Source-Available License](LICENSE) 参照)。再利用には作者(amazopic@gmail.com)の**書面による事前許可**が必要。

### Claude Code のデフォルトステータスラインに戻すには?

`~/.claude/settings.json` から `statusLine` ブロックを削除するか、`~/.claude/status-line.sh reset` を実行。

## 🏷️ 推奨 GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
