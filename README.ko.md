# 🛰️ Claude Code Status Line

> Claude Code를 위한 세련되고 해킹 가능한 상태 표시줄 — 컨텍스트 바, 사용량 한도, 비용, 모델 등을 아름답게 색상 코딩된 한 줄에 모두 담았습니다.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-기여)

**언어:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · 한국어 · [العربية](README.ar.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## 🎨 158개 변형 — 선택해서 적용

79개 테마 × 2개 변형 (`detailed` + `-compact`). `~/.claude/status-line.sh use <name>`로 적용.

### 🔝 Top 10 — 가장 많이 요청되는, 국제적
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 클래식 (19): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

### 🚗 자동차 브랜드 (15)
- 🇪🇺 유럽: `porsche` · `mercedes` · `bmw` · `volvo`
- 🇺🇸 미국: `ford` · `chevy` · `jeep` · `cadillac`
- 🇯🇵 일본: `toyota` · `honda` · `nissan`
- 🇰🇷 한국: `hyundai` · `kia`
- 🇨🇳 중국: `byd` · `nio` · `geely`

### 🔬 위대한 과학자 (8): `newton` · `curie` · `darwin` · `hawking` · `galileo` · `feynman` · `turing` · `davinci`

### ✨ 애니메이션 (3 + top): `onepiece` · `ghibli`

### 🦸 마블 (8 + top): `hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 운영 체제 (10): `macos` · `windows` · `linux` · `ubuntu` · `arch` · `debian` · `fedora` · `kali` · `mint` · `nixos`

```bash
~/.claude/status-line.sh use cyberpunk        # detailed
~/.claude/status-line.sh use macos-compact    # compact
```


### 🕊 세계 종교 (신자 수 상위 7): `christianity` · `islam` · `hinduism` · `buddhism` · `judaism` · `sikhism` · `shinto`

## 왜 사용하나요?

Claude Code의 기본 상태 표시줄은 단조롭습니다. 이 드롭인 교체본은 매 세션을 **한눈에 보는 대시보드** 로 바꿔줍니다:

- 🔋 컨텍스트를 얼마나 썼나? (1.25% 단위의 매끄러운 분수 진행 바)
- 💰 이번 세션 비용은 얼마인가?
- 🚦 사용량 한도에 얼마나 가까운가?
- 🧠 현재 thinking 레벨 / 모델은?
- 🌿 현재 git 브랜치는?

모두 **한 줄** 에, 색상 코딩과 긴급도를 알리는 스마트 아이콘과 함께.

## ✨ 기능

- 🪐 **실시간 컨텍스트 바** — 셀 내부 정밀도를 가진 10셀 진행 바 (quadrant 또는 vertical 분수 글리프)
- 🧠 **모델명** — 1M 컨텍스트 변종에는 `(1M)` 표시
- 💸 **세션 비용** (USD), 매 렌더링마다 갱신
- ⬆️⬇️ **메시지별 토큰 카운터** (입력 / 출력)
- 🚦 **사용량 한도** — 5h / 7d, 50% 초과 시 ⚠️ 경고
- 🔄 **API 모드 폴백** — 한도가 전달되지 않을 때, 세션 총 토큰을 (`tokens: NNN K`) 가는 공백을 천 단위 구분자로 사용해 표시
- 🚀 **스마트 상태 아이콘** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50%
- 🎨 **256색 ANSI** — 세그먼트마다 밝고 또렷한 색상
- 🧩 **플러그인식 바 스타일** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), 또는 10줄짜리 bash로 직접 작성
- ⚡ **가벼움** — 순수 `bash` + `jq`. Node 없음, Python 없음, 데몬 없음, 텔레메트리 없음

> 💡 **프로 팁 — 컨텍스트 제어**: 컨텍스트 창이 차 있을수록 Claude와의 대화는 **덜 효과적**이 되고, 5시간 / 7일 한도가 **더 빨리 소진**됩니다. **60%**를 넘을 때마다 정리하거나 `/compact`해서 효율적으로 작업하세요.

## 🚀 설치

### ⚡ 또는 vibe-chill 방법 · Claude에게 맡기기

Claude Code가 있는데 왜 터미널을 만져요? 이 한 프롬프트를 Claude Code 세션에 붙여넣으세요 — Claude가 모든 단계를 처리하고 각 명령 전에 물어봅니다.

```text
amazopic의 claude-code-statusline을 설치해줘. 먼저 jq가 설치되어 있는지 확인해줘(`which jq` 실행) — 없으면 플랫폼에 맞게 설치: `sudo apt-get install -y jq`(Ubuntu/Debian), `sudo dnf install -y jq`(Fedora), `brew install jq`(macOS), `sudo apk add jq`(Alpine). 그다음 ~/.claude/settings.json을 읽고 — statusLine.command가 기존 파일(예: ~/.claude/status-line.sh 등)을 가리키면, 그 파일에 .bak를 붙여 백업해(기존 .bak는 덮어씀). ~/.claude/status-line.sh도 이미 있으면 같은 방식으로 백업. 그다음 github.com/amazopic/claude-code-statusline을 클론하고, statusline-bundle.sh를 ~/.claude/status-line.sh에 복사한 뒤 실행 가능하게 만들고, commands/statusline.md도 ~/.claude/commands/에 복사. ~/.claude/settings.json을 업데이트해서 statusLine = { type: "command", command: "<~/.claude/status-line.sh의 절대 경로>" }로 만들어줘. 마지막으로 ~/.claude/status-line.sh use developer를 실행해 developer 테마를 테스트하고 Claude Code 재시작하라고 알려줘.
```

> 권한 프롬프트마다 `y`(yes)라고만 답하면 됩니다. 끝.


### 수동 설치 (3단계)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

그런 다음 `~/.claude/settings.json`에 추가:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<당신>/.claude/status-line.sh"
  }
}
```

Claude Code를 재시작 (또는 `/config` 리로드).

### Claude Code 에이전트로 설치 (자동 백업 포함)

Claude Code가 안전하게 설치하길 원하시나요? 이 프롬프트를 붙여넣으세요:

> "이 저장소의 상태 표시줄을 내 Claude Code 상태 표시줄로 설치해줘:
> 1. `~/.claude/status-line.sh`가 이미 존재하면
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`로 백업해줘
>    (그 이름의 백업이 이미 있으면 비어 있는 `-N` 접미사를 사용).
> 2. 저장소의 `statusline.sh`를 `~/.claude/status-line.sh`로 복사하고
>    `chmod +x` 실행.
> 3. `~/.claude/settings.json`을 읽어. `statusLine` 키가 없으면
>    스크립트의 절대 경로를 가리키는 `statusLine` 블록을 추가.
>    `statusLine`이 이미 다른 곳을 가리키면, 먼저 `settings.json`을
>    `.bak.<timestamp>`로 백업.
> 4. 스모크 테스트:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. 나에게 Claude Code 재시작을 알리고 만든 백업을 보고해줘."

### 최신 버전으로 업데이트

```bash
~/.claude/status-line.sh update
```

GitHub에서 최신 bundle을 가져오고, 타임스탬프 백업
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`)을 만들며, 테마 설정
(`~/.claude/statusline.conf`)을 보존합니다. 그 후 Claude Code를 재시작
하세요.

설치된 버전 확인: `~/.claude/status-line.sh version`.

### 요구사항

- `bash` 4+ (스크립트는 0-인덱스 배열 사용 — **`zsh`에서 실행 금지**)
- `jq` (JSON 파싱용)
- 256색 터미널 (사실상 모든 최신 터미널)

## ⚙️ 설정

`statusline.sh` 상단의 상수들을 편집:

| 변수 / 함수 | 제어 대상 |
|---|---|
| `BAR_STYLE` | `"quadrant"` (기본, 2.5% 단위) 또는 `"vertical"` (1.25% 단위) |
| `pct_icon()` | 바 앞의 🚀 / 🚗 / ⚠️ 아이콘 임계값 |
| `pct_color()` | 퍼센트 / 바의 색상 임계값 |
| ANSI 색상 상수 | 임의 세그먼트 재색상화 (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 플러그인 방법론 — 10줄로 자신만의 바 스타일

각 스타일은 `bar_<name>(pct)`라는 자체 완결적 함수로, 정확히 10개의 보이는
셀로 된 문자열을 반환합니다:

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

그리고 `bar()` 디스패처에 등록:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

이게 전부입니다. 함수 계약:

- 입력: 정수 `pct` `0..100` (이미 클램핑됨)
- 출력: 정확히 10개의 보이는 셀
- **가장 가까운** 하위 단계로 반올림 (floor 아님) — 깔끔한 값에서 바가 멈추는 것 방지

새 스타일을 추가하는 PR은 매우 환영합니다.

### 더 많은 프롬프트 예시

<details>
<summary>스타일, 세그먼트, 조정을 추가하는 프롬프트 템플릿</summary>

#### `shaded` 스타일 (4 레벨: `░ ▒ ▓ █`)

> "`shaded` 바 스타일 추가: 셀당 4 레벨 — `░ ▒ ▓ █`
> (light → medium → dark → full), 단위 2.5%. `bar_quadrant`와 동일한
> 반올림 규칙. `BAR_STYLE=\"shaded\"`로 활성화."

#### 제한된 터미널용 `dotted` 스타일

> "블록 문자를 지원하지 않는 터미널용 `dotted` 스타일 추가:
> 10 셀, 채워짐 = `●`, 비어있음 = `·`, 하위 레벨 없음 (단위 10%)."

#### 임계값 기반 바 색상화

> "`bar()` 내에서 문자열 생성 후 퍼센트에 따라 색상으로 감싸기:
> < 50% 녹색 (`$GR`), 50–69% 노란색 (`$Y`), ≥ 70% 빨간색 (`$R`).
> 모든 `BAR_STYLE`에서 동작해야 함."

#### 새 세그먼트: Python virtualenv

> "`${git_part}` 앞에 새 세그먼트 추가: `$VIRTUAL_ENV`에서 현재 Python
> virtualenv 이름 (basename), 색상 magenta (`$M`).
> 비어있으면 세그먼트와 그 `${SEP}` 모두 생략."

#### 아이콘 임계값 조정

> "`pct_icon`에 네 번째 임계값 추가: ≥ 80%일 때 `🔥` 반환. 기존
> 아이콘 유지하고 재배치: < 40% 🚀, 40–59% 🚗, 60–79% ⚠️, ≥ 80% 🔥."

</details>

## 🤝 기여

PR은 매우 환영합니다! 특히:

- 🎨 새 `bar_<style>` 변형 (스파크라인, 게이지, ASCII 아트…)
- 🧱 새 세그먼트 (kubectl 컨텍스트, Python venv, AWS 프로필, 배터리, 날씨…)
- 🌍 추가 README 번역
- 🐛 엣지 케이스 버그 수정 (거대한 트랜스크립트, 이국적인 터미널)

큰 변경을 계획하고 있다면 먼저 issue를 열어주세요.

## 📜 라이선스

[Source-Available](LICENSE) — 자유롭게 사용하세요. 출처 표기는 환영하지만 필수는 아닙니다.

## ⭐ 유용했나요?

Claude Code를 몇 시간씩 응시하신다면, 차라리 아름다운 상태 표시줄을 응시하세요. **저장소에 ⭐를 눌러** 다른 사람들도 발견할 수 있게 해주세요!

---

Claude Code 커뮤니티를 위해 ❤️로 만들었습니다.

---

## 저자 / 라이선스 / 연락처

- **저자:** Yevgeniy Achin
- **라이선스:** [Source-Available License](LICENSE) — Source-Available — 재사용은 저자의 서면 허가가 필요
- **연락처:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 올인원 번들 (`statusline-bundle.sh`)

40+ 파일을 관리하고 싶지 않나요? **단일 번들 스크립트** `statusline-bundle.sh`를 사용하세요 — 모든 테마, 모든 블록, CLI 설정 도구가 하나의 파일에 들어 있습니다.

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

설정은 `~/.claude/statusline.conf`에 저장되며 재시작 후에도 유지됩니다. 동일한 파일이 **렌더러**(Claude Code가 stdin으로 JSON을 전달할 때)와 **설정 도구**(인자와 함께 호출할 때) 모두로 작동합니다.

### 슬래시 명령 `/statusline`

`commands/statusline.md`를 `~/.claude/commands/`에 두면 Claude Code 내부에서 `/statusline` 명령을 사용할 수 있습니다:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

그 다음 어떤 Claude Code 세션에서나 입력할 수 있습니다:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### 셸 별칭 (선택)

```bash
alias statusline='~/.claude/status-line.sh'
```

그러면 `statusline cyberpunk`을 어떤 터미널에서든 사용할 수 있습니다.

---

## ⚡ 빠른 시작

가장 빠른 경로 — CLI가 내장된 올인원 번들 스크립트:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # 또는: anime, hacker, minimal, …
```

그런 다음 `~/.claude/settings.json`에 추가:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<당신>/.claude/status-line.sh" } }
```

Claude Code를 재시작 (또는 `/config` reload). 완료.

## 🆚 Claude Code 기본 상태 표시줄과의 비교

| 기능 | 기본값 | 이 프로젝트 |
|---|---|---|
| 활성 모델 이름 | ✅ | ✅ (1M 컨텍스트 변종에는 `(1M)` 표시) |
| 컨텍스트 윈도우: 사용 % | ❌ | ✅ 실시간, 정밀도 1.25 % |
| 컨텍스트 진행 바 | ❌ | ✅ (vertical, quadrant, rainbow, sparkline 등) |
| 세션 비용 (USD) | ❌ | ✅ 매 렌더링마다 업데이트 |
| 입력/출력 토큰 카운터 | ❌ | ✅ |
| 세션 총 토큰 (API 모드 폴백) | ❌ | ✅ |
| 5h / 7d 사용량 한도 표시기 (> 50% 시 ⚠️) | ❌ | ✅ |
| Git 브랜치 + dirty + ahead/behind | ❌ | ✅ |
| 작업 시간 (active vs wall) | ❌ | ✅ |
| Thinking / effort 레벨 | ❌ | ✅ |
| 사전 설정 테마 | ❌ | ✅ 20 테마 × 2 변형 = **40개 준비** |
| 명명된 블록으로 구성 | ❌ | ✅ 18 블록, [BLOCKS.md](BLOCKS.md) 참조 |
| 내장 CLI 설정 도구 | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Claude Code `/statusline` 슬래시 명령 | ❌ | ✅ 선택, [`commands/`](commands/) 참조 |
| 의존성 | — | `bash` 4+ 및 `jq` (Node, Python, 데몬 불필요) |

## 💡 사용 사례

- **"내 1 M 컨텍스트를 얼마나 썼나?"** — 각 프롬프트 전에 실시간 % 와 바 표시.
- **"이 Claude Code 세션 비용은?"** — 실시간 USD 합계, 매 렌더링마다 업데이트.
- **"오늘 한도에 도달할까?"** — 5h / 7d 표시기, > 50% 시 ⚠️.
- **"올바른 브랜치에 있나?"** — git 브랜치 + dirty + ahead/behind를 상태 표시줄에.
- **"이 기능에 실제로 몇 시간 썼나?"** — 시간 추적 (`active` vs `wall`).
- **"재미있는 터미널을 원해."** — anime, cyberpunk, hacker, retro, weather, ocean, fire 등 테마.
- **"화면 녹화용 미니멀 ASCII 상태 표시줄이 필요해."** — `zen` 테마.

## ❓ 자주 묻는 질문 (FAQ)

### Claude Code Status Line이란?

[Claude Code](https://claude.com/claude-code) (Anthropic의 CLI) 기본 상태 표시줄의 bash 대체품. 하단 상태 줄을 진정한 대시보드로 바꿉니다: 모델, 컨텍스트 %, 진행 바, 세션 비용, 한도, git, 시간 등.

### 어떻게 설치하나요?

`statusline-bundle.sh`를 `~/.claude/status-line.sh`에 복사하고, `chmod +x`를 실행하고, `~/.claude/settings.json` → `statusLine.command`를 그 경로로 지정합니다.

### 1 M 컨텍스트 모델을 지원하나요?

네. 스크립트는 model id의 `[1m]`과 display name의 `1M`을 감지하여 분모를 1 000 000 토큰으로 조정합니다.

### 어떤 모델에서 작동하나요?

Claude Code가 지원하는 모든 모델 — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6 등.

### 색상, 테마를 커스터마이징하거나 자체 추가할 수 있나요?

세 가지 방법이 있습니다: (1) [`examples/`](examples/)에서 **40개 사전 만들어진 변형** 중 선택, (2) 명명된 블록으로 직접 구성 — [BLOCKS.md](BLOCKS.md) 참조, (3) `statusline.sh`의 색상 상수 직접 편집.

### Claude Code를 느리게 할까요?

아니요. 일반 렌더링 ≤ 50 ms.

### `jq` 없이 작동하나요?

`jq`는 필수입니다. 설치: `brew install jq` (macOS) 또는 `apt install jq` (Debian/Ubuntu).

### Windows / macOS / Linux에서 작동하나요?

모두에서 작동. Windows에서는 Git Bash, WSL, MSYS2, Cygwin을 통해.

### Anthropic API를 직접 사용해도 되나요?

부분적으로. 한도 표시기가 자동으로 세션 총 토큰 표시 (`tokens: NNN K`)로 전환됩니다.

### 설정은 어디에 저장되나요?

`~/.claude/statusline.conf` — 작은 shell-source 파일. 재시작 후에도 유지.

### 무료인가요? 상업적으로 사용할 수 있나요?

개인 로컬 사용은 무료 ([Source-Available License](LICENSE) 참조). 모든 재사용은 저자 (amazopic@gmail.com)의 **사전 서면 허가**가 필요.

### Claude Code 기본 상태 표시줄로 되돌리려면?

`~/.claude/settings.json`에서 `statusLine` 블록을 제거하거나 `~/.claude/status-line.sh reset` 실행.

## 🏷️ 추천 GitHub topics

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
