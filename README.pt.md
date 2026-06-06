# 🛰️ Claude Code Status Line — 79 temas, blocos configuráveis, CLI

> Substituição direta para a status line padrão do **Claude Code**: uso da **janela de contexto** ao vivo com uma barra de progresso suave, **custo da sessão** em USD, avisos de **limite de uso 5h / 7d**, **branch do git** com contagem de dirty / ahead / behind, **rastreamento de tempo em tarefa** e o **nome do modelo** ativo (com indicador `(1M)` para variantes de contexto 1M) — tudo em uma única linha colorida em Bash. Vem com **79 temas prontos** — destaques (cyberpunk, hacker, dragonball, naruto, pokemon, ironman, spiderman, einstein, tesla, ferrari), clássicos (minimal, developer, time, zen, rainbow, anime, love, cat, christmas, space, retro, fire, ocean, weather, coffee, music, game, pirate), marcas de carros (porsche, mercedes, bmw, volvo, ford, chevy, jeep, cadillac, toyota, honda, nissan, hyundai, kia, byd, nio, geely), mais cientistas (newton, curie, darwin, hawking, galileo, feynman, turing, davinci), mais anime (onepiece, ghibli), mais Marvel (hulk, thor, captain-america, wolverine, deadpool, blackwidow, strange, wanda), temas de SO (macos, windows, linux, ubuntu, arch, debian, fedora, kali, mint, nixos) e religiões do mundo (christianity, islam, hinduism, buddhism, judaism, sikhism, shinto) e uma **biblioteca de 26 blocos** para compor a sua. Inclui um configurador CLI tudo-em-um e um comando slash `/statusline` para o Claude Code.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#-158-variantes-prontas--escolha-uma-e-comece)
[![Bash + jq](https://img.shields.io/badge/runs%20on-bash%20%2B%20jq-yellow.svg)](#requisitos)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)

**Languages:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · Português · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ 🤖 xhigh
```

> 💡 **Dica pro — Controle de contexto**: quanto mais cheia a sua janela de contexto, **menos eficaz** se torna a sua conversa com o Claude — e **mais rápido** você queima seus limites de 5h/7d. Limpe ou use `/compact` sempre que ultrapassar os **60%** para continuar trabalhando com eficiência.

### ⏳ Contagem regressiva de reset — planeje em torno dos seus limites

Os medidores de 5h / 7d incluem uma contagem regressiva ao vivo até o momento em que cada janela é resetada: `5h{1.1h}: 1%` — a janela de 5 horas reseta em 1,1 horas; `7d{1.1d}: 0%` — a janela semanal reseta em 1,1 dias. Você sempre sabe quando volta a 0%, então pode agendar o trabalho pesado logo após um reset e distribuir sua produtividade em vez de bater no limite no meio de uma tarefa. Funciona graças a `rate_limits.*.resets_at` enviado pelo Claude Code; se a sua build não enviar os timestamps de reset, os medidores recorrem com elegância ao simples `5h: 1%`.

```text
… ⎇ main │ 5h{1.1h}: 1% 7d{1.1d}: 0% │ 🤖 xhigh
```

**Previsível por design** — cada medidor faz contagem regressiva até o seu reset, então você controla o ritmo do trabalho em vez de bater no muro.

## ⚡ Início rápido

O caminho mais rápido — script tudo-em-um empacotado com CLI integrado:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # ou: anime, hacker, minimal, …
```

Depois adicione ao `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<you>/.claude/status-line.sh" } }
```

Reinicie o Claude Code (ou execute o reload com `/config`). Pronto.

### ou método vibe-chill · deixe o Claude fazer

Por que mexer no terminal quando você tem o Claude Code? Cole este único prompt na sua sessão do Claude Code — o Claude cuida de cada etapa e pergunta antes de cada comando.

```text
Install claude-code-statusline by amazopic for me. First make sure jq is installed (run `which jq`) — if missing, install it for the platform: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Then read ~/.claude/settings.json — if it has a statusLine.command pointing to an existing file (e.g. ~/.claude/status-line.sh or another path), back up that file by appending .bak (overwrite any existing .bak). Also if ~/.claude/status-line.sh already exists, back it up the same way. Then clone github.com/amazopic/claude-code-statusline, copy statusline-bundle.sh to ~/.claude/status-line.sh and make it executable, also copy commands/statusline.md to ~/.claude/commands/. Update ~/.claude/settings.json so statusLine is { type: "command", command: "<absolute path to ~/.claude/status-line.sh>" }. Finally run ~/.claude/status-line.sh use developer to test the developer theme and tell me to restart Claude Code.
```

> Basta dizer `y` (sim) em cada solicitação de permissão. Pronto.


## Por que uma status line / barra de status personalizada para o Claude Code?

A status line padrão do Claude Code é minimalista. Esta substituição direta transforma a barra de status inferior em um **dashboard de relance** para cada sessão:

- 🔋 Quanto contexto já consumi? (barras fracionárias suaves a passo de 1,25%)
- 💰 Quanto está me custando esta sessão?
- 🚦 Quão perto estou dos meus limites de uso?
- 🧠 Em que nível de thinking / modelo estou?
- 🌿 Em qual branch do git estou?

Tudo em **uma linha**, com código de cores e ícones inteligentes que sinalizam urgência.

## ✨ Recursos

- 🪐 **Barra de contexto ao vivo** — barra de progresso de 10 células com precisão sub-célula (glifos fracionários de quadrante ou verticais)
- 🧠 **Nome do modelo** — com indicador `(1M)` para variantes de contexto 1M
- 💸 **Custo da sessão** em USD, atualizado a cada render
- ⬆️⬇️ **Contadores de tokens por mensagem** (entrada / saída)
- 🚦 **Limites de uso** — 5h / 7d com aviso ⚠️ quando > 50%
- 🔄 **Fallback em modo API** — quando nenhum limite de uso é enviado, mostra o total de tokens da sessão (`tokens: NNN K`) com espaço fino como separador de milhares
- 🚀 **Ícone de status inteligente** — 🚀 < 40%, 🚗 40–49%, ⚠️ ≥ 50% de preenchimento de contexto
- 🎨 **ANSI 256 cores** — cor brilhante e distinta por segmento
- 🧩 **Estilos de barra plugáveis** — escolha `quadrant` (▖▄▙█) ou `vertical` (▏▎▍▌▋▊▉█), ou crie o seu em 10 linhas de bash
- ⚡ **Leve** — `bash` + `jq` puros. Sem Node, sem Python, sem daemon, sem telemetria

## 🎨 158 variantes prontas — escolha uma e comece

Cada tema vem em **duas variantes**:

- **Detailed** — conjunto completo de recursos (modelo, barra de contexto, custo, tokens, git, tempo, ícone de humor, …)
- **Compact** — apenas `model · context % + bar · branch`

Aplique com `~/.claude/status-line.sh use <name>` (acrescente `-compact` para a variante compacta).

### 🔝 Destaques (10) — os mais pedidos, multiculturais

| Tema | Vibe |
|---|---|
| `cyberpunk`  | distopia neon · `//CTX:12% //₵RED:0.42 ▐ JACK-IN` |
| `hacker`     | terminal Matrix verde-fósforo · `[SYS] :: ROOT@matrix#` |
| `dragonball` | escala do Goku: base → super-saiyajin → ssj-blue → ultra instinto |
| `naruto`     | laranja folha de Konoha · medidor de chakra · 🌀 rasengan |
| `pokemon`    | amarelo Pikachu + vermelho pokébola · barra de HP |
| `ironman`    | 🦾 vermelho Stark + dourado do reator de arco |
| `spiderman`  | 🕷 vermelho + azul cabeça-de-teia · com grande contexto vem grande custo |
| `einstein`   | verdes de quadro-negro · `Ψ Einstein · E=mc²` |
| `tesla`      | ⚡ roxo elétrico + amarelo relâmpago · `AC ~` |
| `ferrari`    | 🐎 rosso corsa + amarelo Modena |

### 🛠 Práticos / Clássicos (19 temas)

| Tema | Arquivo / Aplicar |
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

> Nota: `cyberpunk` e `hacker` ficam em **Destaques** acima — eles também
> estão na pasta `examples/` se você quiser uma instalação de tema único.

```bash
cp examples/statusline-cyberpunk-compact.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

### 🚗 Marcas de carros (mais 15, os destaques incluem `ferrari`)

Disponíveis apenas no `statusline-bundle.sh` — escolha qualquer um com `~/.claude/status-line.sh use <name>`.

| Região | Temas |
|---|---|
| 🇪🇺 Europa  | `porsche` · `mercedes` · `bmw` · `volvo` |
| 🇺🇸 América | `ford` · `chevy` · `jeep` · `cadillac` |
| 🇯🇵 Japão   | `toyota` · `honda` · `nissan` |
| 🇰🇷 Coreia  | `hyundai` · `kia` |
| 🇨🇳 China   | `byd` · `nio` · `geely` |

### 🔬 Grandes cientistas (mais 8, os destaques incluem `einstein` e `tesla`)

| Tema | Vibe |
|---|---|
| `newton`   | tinta sobre pergaminho, `🍎`, `F=ma` |
| `curie`    | verde rádio, `☢`, medidor de meia-vida |
| `darwin`   | verde naturalista, `🐢`, HMS Beagle |
| `hawking`  | violeta do espaço profundo, `🌌`, `t → ∞` |
| `galileo`  | dourado solar, `🔭`, *eppur si muove* |
| `feynman`  | giz sobre verde, `〰`, `ψ → ψ'` |
| `turing`   | verde de terminal, `Ⓣ`, barra de parada `1/0` |
| `davinci`  | códex sépia, `✎`, *Vitruviano* |

### ✨ Anime (mais 3, os destaques incluem `dragonball`, `naruto`, `pokemon`)

`onepiece` · `ghibli`

### 🦸 Super-heróis da Marvel (mais 8, os destaques incluem `ironman` e `spiderman`)

`hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Sistemas operacionais (10 temas)

| Tema | Vibe |
|---|---|
| `macos`   | 🍎 arco-íris de seis cores da Apple sobre cinza-cromo |
| `windows` | ⊞ azulejo Fluent de quatro cores + ciano WINDOWS 11 |
| `linux`   | 🐧 Tux preto + bico laranja |
| `ubuntu`  | ⊕ círculo de amigos — laranja + roxo berinjela |
| `arch`    | ▲ pacman ciano · btw, I use arch |
| `debian`  | 🌀 espiral vermelha · stable / sid / testing |
| `fedora`  | 🎩 azul chapéu Fedora · liberdade + recursos |
| `kali`    | 🐉 azul Kali + vermelho offsec · modo pwn |
| `mint`    | 🌿 verde menta cinnamon · o shell mais amigável |
| `nixos`   | ❄ floco de neve azul Nix · declarativo, reproduzível |

### 🕊 Religiões do mundo (as 7 com mais adeptos)

| Tema | Vibe |
|---|---|
| `christianity` | ✝ vermelho vinho + azul mariano + dourado papal · medidor de fé, € esmolas |
| `islam`        | ☪ verde islâmico + branco + caligrafia dourada · taqwa, ﷼ sadaqah |
| `hinduism`     | 🕉 açafrão + calêndula + vermelhão · dharma, ₹ seva |
| `buddhism`     | ☸ açafrão de monge + dourado + marrom · karma, ฿ dāna |
| `judaism`      | ✡ azul talit + branco + dourado menorá · mitzvah, ₪ tzedakah |
| `sikhism`      | ☬ azul profundo Khalsa + açafrão + branco · sewa, daswandh |
| `shinto`       | ⛩ torii vermelhão + branco de santuário + dourado · kami, ¥ saisen |

```bash
~/.claude/status-line.sh use macos            # detailed
~/.claude/status-line.sh use porsche-compact  # compact
~/.claude/status-line.sh use einstein         # qualquer um dos 79 temas funciona
```

**Veja todos no seu terminal primeiro** — cada variante tem uma
pré-visualização já renderizada em [`screenshots/`](screenshots/):

```bash
# visualize um único
cat screenshots/statusline-cyberpunk.ansi

# ou navegue por toda a galeria (158 variantes + principal)
for f in screenshots/*.ansi; do
  printf "\n=== %s ===\n" "$(basename "$f" .ansi)"
  cat "$f"
done
```

Veja [`examples/README.md`](examples/README.md) para a tabela completa com
descrições, e [`screenshots/README.md`](screenshots/README.md) para
como as pré-visualizações são geradas.

## 🧱 Construa a sua a partir de blocos

Não quer usar um preset? Componha uma status line personalizada a partir de uma
biblioteca de blocos nomeados — `model`, `context-bar`, `cost`, `git`, `tokens-msg`,
`time-active`, `thinking`, …

Veja o [**BLOCKS.md**](BLOCKS.md) para:

- o **catálogo de blocos** (cada um é um trecho de bash pronto para copiar e colar)
- os **pacotes de estilo** (paletas de cores e separadores de `classic`,
  `compact`, `anime`, `hacker`, `cyberpunk`, `zen`)
- uma **receita de 3 passos** para construir a sua linha: escolha um estilo → liste os blocos
  → cole

```
┌─────────────────────────────────────────────────────────┐
│  Step 1 — pick a STYLE pack    (colors, separator)      │
│  Step 2 — pick the BLOCKS you want   (in order)         │
│  Step 3 — paste shared HEADER + chosen BLOCKS + FOOTER  │
└─────────────────────────────────────────────────────────┘
```

## 📦 Pacote tudo-em-um (`statusline-bundle.sh`)

Se você não quer gerenciar mais de 40 arquivos, pegue o **script único
empacotado** [`statusline-bundle.sh`](statusline-bundle.sh) — ele contém
todos os temas + todos os blocos + um configurador CLI em um só arquivo.

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

A configuração é salva em `~/.claude/statusline.conf` e persiste
entre reinicializações. O mesmo arquivo atua tanto como **o renderizador** (quando
chamado pelo Claude Code com JSON via stdin) quanto como **o configurador**
(quando você o chama com argumentos).

### Comando slash `/statusline`

Coloque [`commands/statusline.md`](commands/statusline.md) em
`~/.claude/commands/` para habilitar um comando slash `/statusline` dentro do
Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Depois, em qualquer sessão do Claude Code você pode digitar:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

O Claude executará a CLI do bundle para você, reportará o resultado e lembrará
você de recarregar.

### Alias de shell opcional

```bash
alias statusline='~/.claude/status-line.sh'
```

Então `statusline cyberpunk` funciona de qualquer terminal.

## 🚀 Instalação

### Instalação manual (3 passos)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Depois adicione ao `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<you>/.claude/status-line.sh"
  }
}
```

Reinicie o Claude Code (ou execute o reload com `/config`).

### Instalação via agente Claude Code (com backup automático)

Quer que o Claude Code instale com segurança para você? Cole este prompt:

> "Instale a status line deste repositório como a minha status line do Claude Code:
> 1. Se `~/.claude/status-line.sh` já existir, faça backup em
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (escolha um sufixo `-N`
>    livre se já existir um backup com esse nome).
> 2. Copie `statusline.sh` deste repositório para `~/.claude/status-line.sh` e `chmod +x`.
> 3. Leia `~/.claude/settings.json`. Se ele não tiver a chave `statusLine`, adicione um
>    bloco `statusLine` apontando para o caminho absoluto do script. Se
>    `statusLine` já existir e apontar para outro lugar, primeiro faça backup do
>    `settings.json` em `.bak.<timestamp>`.
> 4. Faça um smoke-test do script:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Peça-me para reiniciar o Claude Code e reporte os backups criados."

### Atualizando para a versão mais recente

```bash
~/.claude/status-line.sh update
```

Busca o bundle mais recente no GitHub, cria um backup com marca de tempo
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) e preserva a sua
configuração de tema (`~/.claude/statusline.conf`). Reinicie o Claude Code depois.

Verifique o que você tem instalado: `~/.claude/status-line.sh version`.

### Requisitos

- `bash` 4+ (o script usa arrays indexados em 0 — **não execute sob `zsh`**)
- `jq` para parsing de JSON — `apt-get install jq` (Debian/Ubuntu), `brew install jq` (macOS), `dnf install jq` (Fedora)
- `curl` (necessário apenas para `statusline update`; pré-instalado na maioria dos sistemas)
- Um terminal de 256 cores (basicamente qualquer um moderno)

## ⚙️ Configuração

Edite as constantes próximas ao topo de `statusline.sh`:

| Variável / função | O que controla |
|---|---|
| `BAR_STYLE` | `"quadrant"` (padrão, passo de 2,5%) ou `"vertical"` (passo de 1,25%) |
| `pct_icon()` | Limiares para os ícones 🚀 / 🚗 / ⚠️ antes da barra |
| `pct_color()` | Limiares de cor para porcentagem / barra |
| Constantes de cor ANSI | Recolora qualquer segmento (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🆚 vs a status line padrão do Claude Code

| Capacidade | Padrão | Este projeto |
|---|---|---|
| **Nome do modelo** ativo | ✅ | ✅ (com flag `(1M)` para variantes de contexto 1M) |
| % da **janela de contexto** usada | ❌ | ✅ ao vivo, precisão de 1,25% |
| **Barra de progresso** para contexto | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| **Custo da sessão** em USD | ❌ | ✅ atualizado a cada render |
| Contadores de tokens de entrada/saída **por mensagem** | ❌ | ✅ |
| **Total de tokens da sessão** (fallback em modo API) | ❌ | ✅ |
| Indicadores de **limite de uso 5h / 7d** com ⚠️ a > 50% | ❌ | ✅ |
| Contagem regressiva de reset nos medidores de limite (`5h{1.1h}`) | ❌ | ✅ |
| **Branch do git** + dirty + ahead/behind | ❌ | ✅ |
| **Tempo em tarefa** (ativo vs relógio de parede) | ❌ | ✅ |
| Exibição de **nível de thinking / effort** | ❌ | ✅ |
| Presets temáticos | ❌ | ✅ 79 temas × 2 variantes = **158 prontos** |
| Composição a partir de blocos nomeados | ❌ | ✅ 26 blocos, veja [BLOCKS.md](BLOCKS.md) |
| Configurador CLI integrado | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Comando slash `/statusline` do Claude Code | ❌ | ✅ opcional, veja [`commands/`](commands/) |
| Dependências externas | — | `bash` 4+ e `jq` (sem Node, sem Python, sem daemon) |
| Licença | — | Source-Available (reutilização por permissão) |

## 💡 Casos de uso

Cenários concretos em que este projeto se paga:

- **"Quanto do meu contexto de 1 M já consumi?"** — veja um percentual + barra ao vivo antes de cada prompt.
- **"Quanto está me custando esta sessão do Claude Code?"** — total em USD em andamento, atualizado a cada render.
- **"Vou bater num limite de uso hoje?"** — indicadores de 5 h / 7 d com ⚠️ quando > 50%.
- **"Estou na branch certa?"** — branch do git + dirty + ahead/behind na sua status line.
- **"Quantas horas reais eu gastei nesta feature?"** — rastreador de tempo em tarefa (`active` vs `wall`).
- **"Quero que meu terminal seja divertido."** — temas anime, cyberpunk, hacker, retro, weather, ocean, fire e outros.
- **"Quero uma status line mínima, só ASCII, para gravações de tela."** — tema `zen`.
- **"Quero distribuir uma status line que todo o meu time use."** — script único empacotado + configurador CLI + comando slash.

## ❓ FAQ

### O que é a "Claude Code Status Line"?

Uma substituição em bash para a status line padrão do [Claude Code](https://claude.com/claude-code) (a CLI da Anthropic). Ela transforma a linha do rodapé da tela em um dashboard de verdade: modelo, contexto %, barra de progresso, custo da sessão, limites de uso, status do git, tempo em tarefa e mais.

### O que significa `5h{1.1h}: 1%`?

Você usou 1% da janela de 5 horas, e `{1.1h}` é uma contagem regressiva ao vivo — a janela reseta em 1,1 horas (`7d{1.1d}`: a janela semanal reseta em 1,1 dias). Lido de `rate_limits.*.resets_at` a cada render. Sem timestamp de reset na sua build? O medidor recorre ao simples `5h: 1%`.

### Como ele é instalado?

Copie `statusline-bundle.sh` para `~/.claude/status-line.sh`, faça `chmod +x`, depois aponte o `statusLine.command` do `~/.claude/settings.json` do Claude Code para esse caminho. Instruções completas nas seções [Início rápido](#-início-rápido) e [Instalação](#-instalação).

### Ele suporta os modelos de janela de contexto de 1 M?

Sim. O script detecta `[1m]` no id do modelo e `1M` no display name e ajusta o denominador da barra para 1 000 000 tokens. Você verá `Opus 4.7 (1M) … 12 % █▌░░░░░░░░ 121.4K/1000K`.

### Com quais modelos ele funciona?

Qualquer modelo que o Claude Code suporta — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, etc. O script lê `model.display_name` e `model.id` do JSON via stdin que o Claude Code fornece; ele não fixa nomes de modelo no código.

### Posso personalizar cores, temas, ou adicionar os meus?

Sim — de três formas:

1. Escolha um dos **79 temas** (158 variantes no total) — use `~/.claude/status-line.sh use <name>` ou navegue por [`examples/`](examples/) para os scripts independentes.
2. Componha o seu próprio a partir de **blocos nomeados** — veja o [BLOCKS.md](BLOCKS.md).
3. Edite as constantes de cor e o estilo da barra diretamente em `statusline.sh`.

### Ele vai deixar o Claude Code mais lento?

Não. Cada render roda uma vez por redesenho da status line, faz o parse do JSON enviado com `jq`, opcionalmente faz `grep` na última linha do transcript, e imprime. Um render típico leva ≤ 50 ms mesmo com o rastreador de tempo habilitado.

### Funciona sem `jq`?

`jq` é obrigatório — ele faz o parse do JSON que o Claude Code envia via stdin. Instale com `brew install jq` (macOS), `apt install jq` (Debian/Ubuntu), ou `choco install jq` (Windows).

### Funciona no Windows?

Sim, em qualquer ambiente que execute `bash` 4+ e `jq` — Git Bash, WSL, MSYS2, Cygwin. CMD/PowerShell puros não são suportados.

### Funciona no Linux / macOS?

Sim, em ambos. O macOS usa o `date` BSD, o Linux usa o `date` GNU — o rastreador de tempo lida com os dois de forma transparente.

### Posso usar isto com a API bruta da Anthropic em vez do Claude Code?

Parcialmente. A status line foi projetada para o formato JSON via stdin do Claude Code. Para uso da API bruta, os indicadores de limite de uso recorrem automaticamente a uma exibição do **total de tokens da sessão** (`tokens: NNN K`).

### Onde fica armazenada a configuração?

`~/.claude/statusline.conf` — um pequeno arquivo sourced pelo shell, escrito pela CLI do bundle (`statusline.sh use <theme>` etc.). Persiste entre reinicializações.

### Como reverto para a status line padrão do Claude Code?

Remova o bloco `statusLine` do `~/.claude/settings.json`, ou execute `~/.claude/status-line.sh reset` e mude para um tema `minimal` que se aproxima bastante do padrão.

### É grátis? Posso usar comercialmente?

Uso pessoal e local é grátis — veja a [Licença Source-Available](LICENSE). Qualquer reutilização, redistribuição, fork ou inclusão em outro projeto requer **permissão prévia por escrito** do autor (Yevgeniy Achin · amazopic@gmail.com). Pedidos razoáveis costumam ser concedidos.

### Como funciona o rastreador de "horas-humanas"?

O tema `time` lê os timestamps do transcript JSONL e reporta duas durações: **active** (soma dos intervalos entre mensagens menores que 5 minutos) e **wall** (intervalo total da primeira à última mensagem). O limiar de ociosidade de 5 minutos é configurável.

## 🏷️ Tópicos sugeridos no GitHub

Ao publicar este repositório, adicione estes tópicos para maximizar a descoberta:

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`

## 🤝 Contribuindo

Issues e PRs são bem-vindos — mas observe a licença:

- **Ler, abrir issues, enviar PRs**: livre.
- **Fazer fork, copiar para outro projeto, redistribuir**: requer
  permissão prévia por escrito do autor.

Para solicitar permissão de reutilização, entre em contato:
**Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com)

Pedidos razoáveis para uso pessoal, educacional e não comercial
costumam ser concedidos sem custo.

## 📜 Licença

[**Source-Available License (Reuse-by-Permission)**](LICENSE)

O código-fonte deste projeto está publicamente disponível para leitura, estudo e
uso pessoal na sua própria máquina. Qualquer reutilização — copiar, redistribuir,
modificar ou incluir em outro projeto — requer **permissão prévia por escrito**
do autor (Yevgeniy Achin · amazopic@gmail.com).

Esta **não** é uma licença open-source aprovada pela OSI. É uma escolha
deliberada para manter a distribuição e os trabalhos derivados sob o controle do
autor, ao mesmo tempo em que permite que a comunidade leia, estude e contribua.

## ⭐ Achou útil?

Se você passa horas olhando para o Claude Code, é melhor olhar para uma status line bonita. **Dê uma ⭐ ao repositório** para ajudar outros a descobrirem!

---

Feito por **Yevgeniy Achin** · ✉ [amazopic@gmail.com](mailto:amazopic@gmail.com) · para a comunidade do Claude Code.
