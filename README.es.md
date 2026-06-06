# 🛰️ Claude Code Status Line — 79 temas, bloques configurables, CLI

> Una barra de estado pulida y hackeable para Claude Code — barra de contexto, límites de uso, costos, modelo y más, todo en una sola línea bellamente coloreada. 79 temas y una biblioteca de 26 bloques para componer la tuya.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 158](https://img.shields.io/badge/variants-158-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-contribuir)

**Idiomas:** [English](README.md) · [Русский](README.ru.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · Español · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [العربية](README.ar.md) · [Português](README.pt.md) · [Türkçe](README.tr.md) · [Bahasa Indonesia](README.id.md) · [Tiếng Việt](README.vi.md) · [हिन्दी](README.hi.md) · [繁體中文](README.zh-tw.md) · [Polski](README.pl.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ 5h{1.1h}: 15% 7d{1.1d}: 4% │ project │ ⎇ main │ 🤖 xhigh
```

### ⏳ Reset countdown — planifica en torno a tus límites

**Predecible por diseño — cada medidor cuenta atrás hasta su reinicio, para que dosifiques tu trabajo en lugar de chocar contra el muro.**

Predecibilidad del trabajo: distribuye tu productividad. Los medidores de 5h / 7d incluyen una cuenta atrás en vivo hasta el momento en que cada ventana se reinicia: `5h{1.1h}: 1%` — la ventana de 5 horas se reinicia en 1,1 horas; `7d{1.1d}: 0%` — la ventana semanal se reinicia en 1,1 días. Siempre sabes cuándo vuelves a 0 %, así que puedes programar el trabajo pesado justo después de un reinicio y distribuir tu productividad en vez de estrellarte contra el tope a mitad de tarea. Funciona gracias a `rate_limits.*.resets_at` enviado por Claude Code; si tu build no envía marcas de tiempo de reinicio, los medidores recurren con elegancia al simple `5h: 1%`.

## ¿Por qué?

La barra de estado predeterminada de Claude Code es escasa. Este reemplazo la convierte en un **dashboard de un vistazo** para cada sesión:

- 🔋 ¿Cuánto contexto he gastado? (barras fraccionarias suaves a paso 1,25 %)
- 💰 ¿Cuánto me cuesta esta sesión?
- 🚦 ¿Qué tan cerca estoy de mis límites?
- 🧠 ¿Qué nivel de thinking / modelo está activo?
- 🌿 ¿En qué rama de git estoy?

Todo en **una sola línea**, con código de colores e iconos inteligentes que indican urgencia.

## ✨ Características

- 🪐 **Barra de contexto en vivo** — barra de 10 celdas con precisión sub-celda (glifos cuadrantes o verticales fraccionarios)
- 🧠 **Nombre del modelo** — con indicador `(1M)` para variantes de contexto 1M
- 💸 **Costo de sesión** en USD, actualizado en cada render
- ⬆️⬇️ **Contadores de tokens** del último mensaje (entrada / salida)
- 🚦 **Límites de uso** — 5h / 7d con alerta ⚠️ cuando > 50 %
- 🔄 **Fallback en modo API** — cuando los límites no se transmiten, muestra los tokens totales de la sesión (`tokens: NNN K`) con espacio fino como separador de miles
- 🚀 **Icono de estado inteligente** — 🚀 < 40 %, 🚗 40–49 %, ⚠️ ≥ 50 %
- 🎨 **ANSI 256 colores** — colores brillantes y distintos por segmento
- 🧩 **Estilos de barra como plugins** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), o crea el tuyo en 10 líneas de bash
- ⚡ **Ligero** — `bash` + `jq` puros. Sin Node, sin Python, sin daemon, sin telemetría

> 💡 **Consejo pro — Control del contexto**: cuanto más llena esté tu ventana de contexto, **menos eficaz** será tu conversación con Claude — y **más rápido** se queman tus límites de 5h / 7d. Limpia o `/compact` cuando cruces el **60%** para trabajar eficientemente.

## 🎨 158 variantes listas — elige y aplica

79 temas × 2 variantes (`detailed` + `-compact`). Aplica con `~/.claude/status-line.sh use <name>`.

### 🔝 Top 10 — los más pedidos, interculturales
`cyberpunk` · `hacker` · `dragonball` · `naruto` · `pokemon` · `ironman` · `spiderman` · `einstein` · `tesla` · `ferrari`

### 🛠 Clásicos (18): `minimal` `developer` `time` `zen` `rainbow` `anime` `love` `cat` `christmas` `space` `retro` `fire` `ocean` `weather` `coffee` `music` `game` `pirate`

### 🚗 Marcas de coches (15)
- 🇪🇺 Europa: `porsche` · `mercedes` · `bmw` · `volvo`
- 🇺🇸 América: `ford` · `chevy` · `jeep` · `cadillac`
- 🇯🇵 Japón: `toyota` · `honda` · `nissan`
- 🇰🇷 Corea: `hyundai` · `kia`
- 🇨🇳 China: `byd` · `nio` · `geely`

### 🔬 Grandes científicos (8): `newton` · `curie` · `darwin` · `hawking` · `galileo` · `feynman` · `turing` · `davinci`

### ✨ Anime (3 + top): `onepiece` · `ghibli`

### 🦸 Marvel (8 + top): `hulk` · `thor` · `captain-america` · `wolverine` · `deadpool` · `blackwidow` · `strange` · `wanda`

### 💻 Sistemas operativos (10): `macos` · `windows` · `linux` · `ubuntu` · `arch` · `debian` · `fedora` · `kali` · `mint` · `nixos`

```bash
~/.claude/status-line.sh use cyberpunk        # detailed
~/.claude/status-line.sh use macos-compact    # compact
```


### 🕊 Religiones del mundo (top 7): `christianity` · `islam` · `hinduism` · `buddhism` · `judaism` · `sikhism` · `shinto`

## 🚀 Instalación

### Manual (3 pasos)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Luego añade a `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<tu>/.claude/status-line.sh",
    "refreshInterval": 30
  }
}
```

> 💡 `refreshInterval: 30` vuelve a ejecutar la línea cada 30 segundos incluso mientras la sesión está inactiva — mantiene en vivo la cuenta atrás de reinicio (5h{1.1h}), el tracker de tiempo y los cambios posteriores al reinicio. 30 es un valor por defecto sensato; 60 ahorra batería; omítelo para refrescar solo en eventos (nuevo mensaje del asistente, /compact, toggle de vim).

Reinicia Claude Code (o ejecuta `/config` reload).

### Instalación vía agente Claude Code (con backup automático)

¿Quieres que Claude Code lo instale por ti de forma segura? Pega este prompt:

> «Instala la barra de estado de este repo como mi barra de estado activa de Claude Code:
> 1. Si `~/.claude/status-line.sh` ya existe, haz un backup en
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (usa un sufijo
>    `-N` libre si ya existe un backup con ese nombre).
> 2. Copia `statusline.sh` desde el repo a `~/.claude/status-line.sh` y `chmod +x`.
> 3. Lee `~/.claude/settings.json`. Si no tiene la clave `statusLine`,
>    añade un bloque `statusLine` apuntando a la ruta absoluta del
>    script e incluye `"refreshInterval": 30`. Si `statusLine` ya existe
>    pero apunta a otro lugar, primero haz backup de `settings.json` en
>    `.bak.<timestamp>`.
> 4. Smoke test:
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Pídeme reiniciar Claude Code y reporta los backups creados.»

### Actualizar a la última versión

```bash
~/.claude/status-line.sh update
```

Descarga el último bundle desde GitHub, crea una copia de seguridad con
marca de tiempo (`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) y
conserva tu configuración de tema (`~/.claude/statusline.conf`).
Reinicia Claude Code después.

Comprueba la versión instalada: `~/.claude/status-line.sh version`.

### Requisitos

- `bash` 4+ (el script usa arrays indexados a 0 — **no ejecutar bajo `zsh`**)
- `jq` para parseo JSON
- Una terminal de 256 colores (básicamente cualquier moderna)

## ⚙️ Configuración

Edita las constantes al inicio de `statusline.sh`:

| Variable / función | Qué controla |
|---|---|
| `BAR_STYLE` | `"quadrant"` (default, paso 2,5 %) o `"vertical"` (paso 1,25 %) |
| `pct_icon()` | Umbrales para iconos 🚀 / 🚗 / ⚠️ antes de la barra |
| `pct_color()` | Umbrales de color para porcentaje / barra |
| Constantes de color ANSI | Recolorea cualquier segmento (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Metodología de plugins — tu propio estilo de barra en 10 líneas

Cada estilo es una función autocontenida `bar_<nombre>(pct)` que retorna
una cadena de exactamente 10 celdas visibles:

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

Luego regístrala en el dispatcher `bar()`:

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

Eso es todo. Contrato de la función:

- Entrada: entero `pct` `0..100` (ya recortado)
- Salida: exactamente 10 celdas visibles
- Redondeo al sub-paso **más cercano** (no floor) para que la barra no se atasque

PRs con nuevos estilos son muy bienvenidos.

### Más ejemplos de prompts

<details>
<summary>Plantillas de prompts para añadir estilos, segmentos y ajustes</summary>

#### Estilo `shaded` (4 niveles: `░ ▒ ▓ █`)

> «Añade un estilo de barra `shaded`: 4 niveles por celda — `░ ▒ ▓ █`
> (light → medium → dark → full), paso 2,5 %. Misma regla de redondeo
> que `bar_quadrant`. Activación vía `BAR_STYLE="shaded"`.»

#### Estilo `dotted` de fallback

> «Añade un estilo `dotted` para terminales sin soporte de bloques:
> 10 celdas, lleno = `●`, vacío = `·`, sin sub-niveles (paso 10 %).»

#### Coloreado de barra por umbrales

> «En `bar()`, después de generar la cadena, envuélvela en un color
> según el porcentaje: < 50 % verde (`$GR`), 50–69 % amarillo (`$Y`),
> ≥ 70 % rojo (`$R`). Debe funcionar para cualquier `BAR_STYLE`.»

#### Nuevo segmento: virtualenv de Python

> «Añade un segmento antes de `${git_part}`: nombre del virtualenv
> de Python actual desde `$VIRTUAL_ENV` (basename), color magenta (`$M`).
> Si está vacío, omite el segmento y su `${SEP}`.»

#### Ajustar umbrales del icono

> «En `pct_icon` añade un cuarto umbral: ≥ 80 % retorna `🔥`. Conserva
> los iconos existentes, reorganiza: < 40 % 🚀, 40–59 % 🚗, 60–79 % ⚠️,
> ≥ 80 % 🔥.»

</details>

## 🤝 Contribuir

¡Los PRs son muy bienvenidos! Especialmente:

- 🎨 Nuevas variantes `bar_<style>` (sparklines, medidores, ASCII art…)
- 🧱 Nuevos segmentos (contexto kubectl, virtualenv Python, perfil AWS, batería, clima…)
- 🌍 Más traducciones del README
- 🐛 Bugfixes para casos límite (transcripts enormes, terminales exóticas)

Para cambios grandes, abre primero un issue.

## 📜 Licencia

[Source-Available](LICENSE) — haz lo que quieras, atribución apreciada pero no requerida.

## ⭐ ¿Te resulta útil?

Si pasas horas mirando Claude Code, mejor que mires una barra de estado bonita. **Dale una ⭐ al repo** para ayudar a otros a descubrirlo.

---

Hecho con ❤️ para la comunidad Claude Code.

---

## Autor / Licencia / Contacto

- **Autor:** Yevgeniy Achin
- **Licencia:** [Source-Available License](LICENSE) — Source-Available — reutilización solo con permiso escrito del autor
- **Contacto:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 Paquete todo-en-uno (`statusline-bundle.sh`)

¿No quieres manejar 40+ archivos? Toma el **script único empaquetado** `statusline-bundle.sh` — contiene todos los temas, todos los bloques y un configurador CLI en un solo archivo.

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

La configuración se guarda en `~/.claude/statusline.conf` y persiste entre reinicios. El mismo archivo actúa como **renderer** (cuando Claude Code le pasa JSON por stdin) y como **configurador** (cuando lo invocas con argumentos).

### Comando slash `/statusline`

Coloca `commands/statusline.md` en `~/.claude/commands/` — el comando `/statusline` estará disponible en Claude Code:

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Después, en cualquier sesión de Claude Code puedes escribir:

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Alias de shell (opcional)

```bash
alias statusline='~/.claude/status-line.sh'
```

Entonces `statusline cyberpunk` funciona desde cualquier terminal.

---

## ⚡ Inicio rápido

El camino más rápido — script todo-en-uno con CLI integrado:

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # o: anime, hacker, minimal, …
```

Luego añade a `~/.claude/settings.json`:

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<tu>/.claude/status-line.sh",
  "refreshInterval": 30 } }
```

> 💡 `refreshInterval: 30` vuelve a ejecutar la línea cada 30 segundos incluso mientras la sesión está inactiva — mantiene en vivo la cuenta atrás de reinicio (5h{1.1h}), el tracker de tiempo y los cambios posteriores al reinicio. 30 es un valor por defecto sensato; 60 ahorra batería; omítelo para refrescar solo en eventos (nuevo mensaje del asistente, /compact, toggle de vim).

Reinicia Claude Code (o `/config` reload). Listo.

### o método vibe-chill · deja que Claude lo haga

¿Para qué tocar un terminal si tienes Claude Code? Pega este único prompt en tu sesión de Claude Code — Claude maneja cada paso y pregunta antes de cada comando.

```text
Instálame claude-code-statusline de amazopic. Primero asegúrate de que jq esté instalado (ejecuta `which jq`) — si falta, instálalo según la plataforma: `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Luego lee ~/.claude/settings.json — si hay statusLine.command apuntando a un archivo existente (ej: ~/.claude/status-line.sh u otra ruta), haz una copia de seguridad de ese archivo añadiendo .bak (sobrescribe cualquier .bak existente). También si ~/.claude/status-line.sh ya existe — hazle backup igual. Luego clona github.com/amazopic/claude-code-statusline, copia statusline-bundle.sh a ~/.claude/status-line.sh y hazlo ejecutable, copia también commands/statusline.md a ~/.claude/commands/. Actualiza ~/.claude/settings.json para que statusLine = { type: "command", command: "<ruta absoluta a ~/.claude/status-line.sh>", "refreshInterval": 30 }. Por último ejecuta ~/.claude/status-line.sh use developer para probar el tema developer y dime que reinicie Claude Code.
```

> Solo di `y` (sí) en cada petición de permiso. Listo.


## 🆚 Comparación con la barra de estado predeterminada de Claude Code

| Capacidad | Predeterminado | Este proyecto |
|---|---|---|
| Nombre del modelo activo | ✅ | ✅ (con marca `(1M)` para variantes 1M) |
| Ventana de contexto: % usado | ❌ | ✅ live, precisión 1,25 % |
| Barra de progreso de contexto | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Costo de sesión en USD | ❌ | ✅ actualizado en cada render |
| Contadores de tokens entrada/salida | ❌ | ✅ |
| Total de tokens de sesión (fallback en modo API) | ❌ | ✅ |
| Indicadores de límites 5h / 7d con ⚠️ a > 50 % | ❌ | ✅ |
| Cuenta atrás de reinicio en los medidores de límites (5h{1.1h}) | ❌ | ✅ |
| Rama git + dirty + ahead/behind | ❌ | ✅ |
| Tiempo en tarea (active vs wall) | ❌ | ✅ |
| Nivel de thinking / effort | ❌ | ✅ |
| Temas predefinidos | ❌ | ✅ 79 temas × 2 variantes = **158 listos** |
| Composición desde bloques nombrados | ❌ | ✅ 26 bloques, ver [BLOCKS.md](BLOCKS.md) |
| Configurador CLI integrado | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Comando slash `/statusline` Claude Code | ❌ | ✅ opcional, ver [`commands/`](commands/) |
| Dependencias | — | `bash` 4+ y `jq` (sin Node, Python, daemon) |

## 💡 Casos de uso

- **«¿Cuánto de mi contexto 1 M he gastado?»** — porcentaje y barra en vivo antes de cada prompt.
- **«¿Cuánto me cuesta esta sesión de Claude Code?»** — total USD actualizado en cada render.
- **«¿Llegaré a un límite hoy?»** — indicadores 5h / 7d con ⚠️ a > 50 %.
- **«¿Estoy en la rama correcta?»** — rama git + dirty + ahead/behind en la barra de estado.
- **«¿Cuántas horas reales pasé en esta feature?»** — tracker de tiempo (`active` vs `wall`).
- **«Quiero un terminal divertido.»** — temas anime, cyberpunk, hacker, retro, weather, ocean, fire.
- **«Necesito una barra ASCII mínima para grabaciones.»** — tema `zen`.

## ❓ Preguntas frecuentes (FAQ)

### ¿Qué es Claude Code Status Line?

Un reemplazo bash de la barra de estado predeterminada en [Claude Code](https://claude.com/claude-code) (CLI de Anthropic). Convierte la línea inferior en un dashboard real: modelo, contexto %, barra de progreso, costo de sesión, límites, git, tiempo y más.

### ¿Qué significa `5h{1.1h}: 1%`?

Has usado el 1 % de la ventana de 5 horas, y `{1.1h}` es una cuenta atrás en vivo: la ventana se reinicia en 1,1 horas (`7d{1.1d}`: la ventana semanal se reinicia en 1,1 días). Se lee de `rate_limits.*.resets_at` en cada render. ¿Tu build no incluye marca de tiempo de reinicio? El medidor recurre al simple `5h: 1%`.

### ¿La barra de estado se actualiza sola? Mi cuenta atrás {1.1h} parece congelada.

Claude Code re-renderiza en eventos — nuevo mensaje del asistente, /compact, cambio de modo de permisos o de modo vim (con debounce de 300 ms) — así que entre eventos la línea se queda congelada. Añade `"refreshInterval": 30` al bloque `statusLine` en `~/.claude/settings.json` y también se volverá a ejecutar con un temporizador fijo de 30 segundos, manteniendo la cuenta atrás y el tracker de tiempo en marcha mientras está inactiva. Un render cuesta ~0,1 s, así que 30 s es insignificante; usa 60 con batería o en repos enormes (`git status` se ejecuta en cada render); el mínimo es 1.

### ¿Cómo se instala?

Copiar `statusline-bundle.sh` a `~/.claude/status-line.sh`, hacer `chmod +x`, apuntar `~/.claude/settings.json` → `statusLine.command` a esa ruta.

### ¿Soporta los modelos de contexto 1 M?

Sí. El script detecta `[1m]` en model id y `1M` en display name, ajusta el denominador de la barra a 1 000 000 tokens.

### ¿Con qué modelos funciona?

Con cualquier modelo soportado por Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, etc.

### ¿Puedo personalizar colores, temas o añadir los míos?

Sí, de tres formas: (1) elegir entre **40 variantes listas** en [`examples/`](examples/), (2) componer la propia desde bloques nombrados — ver [BLOCKS.md](BLOCKS.md), (3) editar las constantes de color en `statusline.sh` directamente.

### ¿Ralentizará Claude Code?

No. Render típico ≤ 50 ms.

### ¿Funciona sin `jq`?

`jq` es obligatorio. Instalar: `brew install jq` (macOS) o `apt install jq` (Debian/Ubuntu).

### ¿Funciona en Windows / macOS / Linux?

Sí en todos. En Windows — vía Git Bash, WSL, MSYS2 o Cygwin.

### ¿Puedo usar esto con la API Anthropic directamente?

Parcialmente. Los indicadores de límites cambian automáticamente al display de tokens totales de sesión (`tokens: NNN K`).

### ¿Dónde se guarda la configuración?

`~/.claude/statusline.conf` — pequeño archivo source de shell. Persiste entre reinicios.

### ¿Es gratis? ¿Puedo usarlo comercialmente?

Uso personal local es gratis (ver [Source-Available License](LICENSE)). Cualquier reutilización requiere **permiso escrito previo** del autor (amazopic@gmail.com).

### ¿Cómo vuelvo a la barra de estado predeterminada de Claude Code?

Eliminar el bloque `statusLine` de `~/.claude/settings.json` o ejecutar `~/.claude/status-line.sh reset`.

## 🏷️ Topics GitHub recomendados

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
