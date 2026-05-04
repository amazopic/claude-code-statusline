# 🛰️ Claude Code Status Line

> Une ligne d'état soignée et hackable pour Claude Code — barre de contexte, limites, coûts, modèle et bien plus, le tout sur une seule ligne colorée.

[![License: Source-Available](https://img.shields.io/badge/license-Source--Available-orange.svg)](LICENSE)
[![Variants: 40](https://img.shields.io/badge/variants-40-brightgreen.svg)](#)
[![Author](https://img.shields.io/badge/author-Yevgeniy%20Achin-blue.svg)](mailto:amazopic@gmail.com)
[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-7c3aed.svg)](https://claude.com/claude-code)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-contribuer)

**Langues :** [English](README.md) · [Русский](README.ru.md) · Français · [Deutsch](README.de.md) · [Українська](README.uk.md) · [Slovenščina](README.sl.md) · [Italiano](README.it.md) · [Español](README.es.md) · [中文](README.zh.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

```text
Opus 4.7 (1M) │ 🚀 12% █▌░░░░░░░░ 121.4K/1000K │ 0.42$ │ ↑0.5K ↓1.2K │ project │ ⎇ main │ tokens: 87 K │ 🤖 xhigh
```

## Pourquoi ?

La ligne d'état par défaut de Claude Code est minimaliste. Ce remplacement la transforme en un **tableau de bord d'un coup d'œil** pour chaque session :

- 🔋 Combien de contexte ai-je consommé ? (barres fractionnaires fluides à 1,25 %)
- 💰 Combien me coûte cette session ?
- 🚦 Suis-je proche de mes limites ?
- 🧠 Quel niveau de réflexion / quel modèle est actif ?
- 🌿 Sur quelle branche git suis-je ?

Le tout en **une seule ligne**, avec code couleur et icônes intelligentes signalant l'urgence.

## ✨ Fonctionnalités

- 🪐 **Barre de contexte en direct** — barre de 10 cellules avec précision sub-cellulaire
- 🧠 **Nom du modèle** — avec indicateur `(1M)` pour les variantes à 1M de contexte
- 💸 **Coût de session** en USD, mis à jour à chaque rendu
- ⬆️⬇️ **Compteurs de tokens** par message (entrée / sortie)
- 🚦 **Limites** — 5h / 7d avec avertissement ⚠️ au-delà de 50 %
- 🔄 **Repli en mode API** — quand les limites ne sont pas transmises, affiche le total des tokens (`tokens: NNN K`) avec espace fine comme séparateur de milliers
- 🚀 **Icône d'état intelligente** — 🚀 < 40 %, 🚗 40–49 %, ⚠️ ≥ 50 %
- 🎨 **ANSI 256 couleurs** — couleurs vives et distinctes par segment
- 🧩 **Styles de barre enfichables** — `quadrant` (▖▄▙█), `vertical` (▏▎▍▌▋▊▉█), ou créez le vôtre en 10 lignes de bash
- ⚡ **Léger** — `bash` + `jq` purs. Pas de Node, pas de Python, pas de démon, pas de télémétrie

> 💡 **Astuce — Contrôle du contexte** : plus votre fenêtre de contexte est pleine, **moins** votre conversation avec Claude est efficace — et **plus vite** vos limites 5h / 7j brûlent. Videz ou `/compact` dès que vous dépassez les **60%** pour rester productif.

## 🚀 Installation

### ⚡ ou méthode vibe-chill · laissez Claude faire

Pourquoi toucher un terminal quand on a Claude Code ? Collez ce prompt unique dans votre session Claude Code — Claude gère chaque étape et demande avant chaque commande.

```text
Installe claude-code-statusline d'amazopic pour moi. D'abord vérifie que jq est installé (lance `which jq`) — sinon installe-le selon la plateforme : `sudo apt-get install -y jq` (Ubuntu/Debian), `sudo dnf install -y jq` (Fedora), `brew install jq` (macOS), `sudo apk add jq` (Alpine). Puis lis ~/.claude/settings.json — s'il y a statusLine.command pointant vers un fichier existant (ex: ~/.claude/status-line.sh ou autre), sauvegarde ce fichier en ajoutant .bak (écrase tout .bak existant). Aussi si ~/.claude/status-line.sh existe déjà, sauvegarde-le pareillement. Puis clone github.com/amazopic/claude-code-statusline, copie statusline-bundle.sh vers ~/.claude/status-line.sh et rends-le exécutable, copie aussi commands/statusline.md vers ~/.claude/commands/. Mets à jour ~/.claude/settings.json pour que statusLine = { type: "command", command: "<chemin absolu vers ~/.claude/status-line.sh>" }. Enfin exécute ~/.claude/status-line.sh use developer pour tester le thème developer et dis-moi de redémarrer Claude Code.
```

> Dis simplement `y` (oui) à chaque demande d'autorisation. Voilà.


### Installation manuelle (3 étapes)

```bash
git clone https://github.com/amazopic/claude-code-statusline.git
cp REPO/statusline.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
```

Puis ajoutez à `~/.claude/settings.json` :

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/<vous>/.claude/status-line.sh"
  }
}
```

Redémarrez Claude Code (ou exécutez `/config` pour recharger).

### Installation via un agent Claude Code (avec sauvegarde automatique)

Vous voulez que Claude Code l'installe en toute sécurité ? Collez ce prompt :

> « Installe la ligne d'état de ce dépôt comme ma ligne d'état Claude Code :
> 1. Si `~/.claude/status-line.sh` existe déjà, sauvegarde-le dans
>    `~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>` (utilise un suffixe
>    `-N` libre si une sauvegarde de ce nom existe déjà).
> 2. Copie `statusline.sh` du dépôt vers `~/.claude/status-line.sh` et `chmod +x`.
> 3. Lis `~/.claude/settings.json`. S'il n'a pas de clé `statusLine`,
>    ajoute un bloc `statusLine` pointant vers le chemin absolu du script.
>    Si `statusLine` existe déjà mais pointe ailleurs, sauvegarde d'abord
>    `settings.json` en `.bak.<timestamp>`.
> 4. Test rapide :
>    `echo '{\"model\":{\"display_name\":\"Test\"},\"transcript_path\":\"\"}' | bash ~/.claude/status-line.sh`
> 5. Demande-moi de redémarrer Claude Code et liste les sauvegardes créées. »

### Mise à jour vers la dernière version

```bash
~/.claude/status-line.sh update
```

Récupère le dernier bundle depuis GitHub, crée une sauvegarde horodatée
(`~/.claude/status-line.sh.bak.<YYYYMMDD-HHMMSS>`) et préserve votre
config de thème (`~/.claude/statusline.conf`). Redémarrez Claude Code
après.

Voir la version installée : `~/.claude/status-line.sh version`.

### Prérequis

- `bash` 4+ (le script utilise des tableaux indexés à 0 — **ne pas exécuter sous `zsh`**)
- `jq` pour le parsing JSON
- Un terminal 256 couleurs (essentiellement tous les terminaux modernes)

## ⚙️ Configuration

Modifiez les constantes en haut de `statusline.sh` :

| Variable / fonction | Ce qu'elle contrôle |
|---|---|
| `BAR_STYLE` | `"quadrant"` (par défaut, pas 2,5 %) ou `"vertical"` (pas 1,25 %) |
| `pct_icon()` | Seuils des icônes 🚀 / 🚗 / ⚠️ avant la barre |
| `pct_color()` | Seuils de couleur pour le pourcentage / la barre |
| Constantes de couleur ANSI | Recolorer n'importe quel segment (`G`, `Y`, `R`, `B`, `C`, `M`, …) |

## 🧩 Méthodologie plugin — votre style de barre en 10 lignes

Chaque style est une fonction autonome `bar_<nom>(pct)` qui retourne
exactement 10 cellules visibles. Ajout :

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

Puis enregistrez dans le dispatcher `bar()` :

```bash
case "$BAR_STYLE" in
  vertical) bar_vertical "$pct" ;;
  dotted)   bar_dotted   "$pct" ;;
  *)        bar_quadrant "$pct" ;;
esac
```

C'est tout. Contrat de la fonction :

- Entrée : entier `pct` `0..100` (déjà borné)
- Sortie : exactement 10 cellules visibles
- Arrondi au sous-pas **le plus proche** (pas floor) pour éviter que la barre ne reste figée

Les PR ajoutant de nouveaux styles sont les bienvenues.

### Plus d'exemples de prompts

<details>
<summary>Modèles de prompts pour ajouter styles, segments et ajustements</summary>

#### Style `shaded` (4 niveaux : `░ ▒ ▓ █`)

> « Ajoute un style `shaded` : 4 niveaux par cellule — `░ ▒ ▓ █`
> (light → medium → dark → full), pas 2,5 %. Même règle d'arrondi
> que `bar_quadrant`. Activation via `BAR_STYLE="shaded"`. »

#### Style `dotted` pour terminaux limités

> « Ajoute un style `dotted` pour terminaux sans support des blocs :
> 10 cellules, plein = `●`, vide = `·`, pas de sous-niveaux (pas 10 %). »

#### Coloration de la barre par seuils

> « Dans `bar()`, après génération de la chaîne, enrobe-la d'une couleur
> selon le pourcentage : < 50 % vert (`$GR`), 50–69 % jaune (`$Y`),
> ≥ 70 % rouge (`$R`). Doit marcher pour tout `BAR_STYLE`. »

#### Nouveau segment : virtualenv Python

> « Ajoute un segment avant `${git_part}` : nom du virtualenv Python
> courant depuis `$VIRTUAL_ENV` (basename), en magenta (`$M`). Si
> vide, omettre le segment et son `${SEP}`. »

#### Ajustement des seuils d'icône

> « Dans `pct_icon`, ajoute un quatrième seuil : ≥ 80 % renvoie `🔥`.
> Garde les icônes existantes mais réorganise : < 40 % 🚀, 40–59 % 🚗,
> 60–79 % ⚠️, ≥ 80 % 🔥. »

</details>

## 🤝 Contribuer

Les PR sont très bienvenues ! En particulier :

- 🎨 Nouvelles variantes `bar_<style>` (sparklines, jauges, ASCII art…)
- 🧱 Nouveaux segments (contexte kubectl, virtualenv Python, profil AWS, batterie, météo…)
- 🌍 Plus de traductions du README
- 🐛 Corrections pour cas particuliers (transcripts énormes, terminaux exotiques)

Ouvrez d'abord une issue pour les changements importants.

## 📜 Licence

[Source-Available](LICENSE) — faites ce que vous voulez, attribution appréciée mais non requise.

## ⭐ Utile ?

Si vous passez des heures à fixer Claude Code, autant fixer une jolie ligne d'état. **Mettez une ⭐** au dépôt pour aider les autres à le découvrir !

---

Fait avec ❤️ pour la communauté Claude Code.

---

## Auteur / Licence / Contact

- **Auteur:** Yevgeniy Achin
- **Licence:** [Source-Available License](LICENSE) — Source-Available — réutilisation uniquement avec l'autorisation écrite préalable de l'auteur
- **Contact:** [amazopic@gmail.com](mailto:amazopic@gmail.com)

## 🎨 40 variants · 🧱 [BLOCKS.md](BLOCKS.md)

→ Each theme ships in **detailed** + **compact** variants (40 total) — see
[`examples/`](examples/).
→ Build your own line from named blocks — see [`BLOCKS.md`](BLOCKS.md).
→ Pre-rendered ANSI previews of every variant — see [`screenshots/`](screenshots/).

---

## 📦 Pack tout-en-un (`statusline-bundle.sh`)

Vous ne voulez pas gérer 40+ fichiers ? Prenez le **script unique** `statusline-bundle.sh` — il contient tous les thèmes, tous les blocs et un configurateur CLI dans un seul fichier.

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

La configuration est sauvegardée dans `~/.claude/statusline.conf` et persiste entre les redémarrages. Le même fichier sert à la fois de **rendu** (quand Claude Code lui envoie du JSON via stdin) et de **configurateur** (quand vous l'appelez avec des arguments).

### Commande slash `/statusline`

Placez `commands/statusline.md` dans `~/.claude/commands/` — la commande `/statusline` sera disponible dans Claude Code :

```bash
mkdir -p ~/.claude/commands
cp commands/statusline.md ~/.claude/commands/statusline.md
```

Ensuite, dans n'importe quelle session Claude Code, tapez :

```
/statusline cyberpunk
/statusline cyberpunk-compact
/statusline custom model context-bar git cost
/statusline list
/statusline preview anime
```

### Alias shell (facultatif)

```bash
alias statusline='~/.claude/status-line.sh'
```

Ensuite `statusline cyberpunk` fonctionne depuis n'importe quel terminal.

---

## ⚡ Démarrage rapide

Le chemin le plus rapide — script bundle tout-en-un avec CLI intégré :

```bash
git clone https://github.com/amazopic/claude-code-statusline.git claude-code-statusline
cp claude-code-statusline/statusline-bundle.sh ~/.claude/status-line.sh
chmod +x ~/.claude/status-line.sh
~/.claude/status-line.sh use cyberpunk          # ou : anime, hacker, minimal, …
```

Puis ajoutez à `~/.claude/settings.json` :

```json
{ "statusLine": { "type": "command",
  "command": "/Users/<vous>/.claude/status-line.sh" } }
```

Redémarrez Claude Code (ou `/config` reload). Terminé.

## 🆚 vs ligne d'état Claude Code par défaut

| Capacité | Par défaut | Ce projet |
|---|---|---|
| Nom du modèle actif | ✅ | ✅ (avec indicateur `(1M)` pour les variantes 1M) |
| Fenêtre de contexte : % utilisé | ❌ | ✅ live, précision 1,25 % |
| Barre de progression du contexte | ❌ | ✅ (vertical, quadrant, rainbow, sparkline, …) |
| Coût de session en USD | ❌ | ✅ mis à jour à chaque rendu |
| Compteurs de tokens entrée/sortie | ❌ | ✅ |
| Total de tokens de session (fallback mode API) | ❌ | ✅ |
| Indicateurs de limites 5h / 7j avec ⚠️ à > 50 % | ❌ | ✅ |
| Branche git + dirty + ahead/behind | ❌ | ✅ |
| Temps sur tâche (actif vs wall) | ❌ | ✅ |
| Niveau de thinking / effort | ❌ | ✅ |
| Thèmes prédéfinis | ❌ | ✅ 20 thèmes × 2 variantes = **40 prêts à l'emploi** |
| Composition à partir de blocs nommés | ❌ | ✅ 18 blocs, voir [BLOCKS.md](BLOCKS.md) |
| Configurateur CLI intégré | ❌ | ✅ `statusline-bundle.sh use / custom / list / preview` |
| Commande slash `/statusline` Claude Code | ❌ | ✅ optionnel, voir [`commands/`](commands/) |
| Dépendances | — | `bash` 4+ et `jq` (pas de Node, pas de Python, pas de daemon) |

## 💡 Cas d'usage

- **« Combien de mon contexte 1 M ai-je consommé ? »** — pourcentage et barre en direct avant chaque prompt.
- **« Combien me coûte cette session Claude Code ? »** — total USD en cours, mis à jour à chaque rendu.
- **« Vais-je atteindre une limite aujourd'hui ? »** — indicateurs 5h / 7j avec ⚠️ à > 50 %.
- **« Suis-je sur la bonne branche ? »** — branche git + dirty + ahead/behind dans la status line.
- **« Combien d'heures réelles ai-je passées sur cette feature ? »** — tracker temps (`active` vs `wall`).
- **« Je veux que mon terminal soit fun. »** — thèmes anime, cyberpunk, hacker, retro, weather, ocean, fire et autres.
- **« Je veux une status line ASCII minimale pour les enregistrements. »** — thème `zen`.

## ❓ Questions fréquemment posées (FAQ)

### Qu'est-ce que Claude Code Status Line ?

Un remplacement bash de la ligne d'état par défaut de [Claude Code](https://claude.com/claude-code) (CLI d'Anthropic). Transforme la ligne du bas en un véritable dashboard : modèle, contexte %, barre de progression, coût de session, limites, git, temps et plus.

### Comment l'installer ?

Copier `statusline-bundle.sh` vers `~/.claude/status-line.sh`, faire `chmod +x`, pointer `~/.claude/settings.json` → `statusLine.command` vers ce chemin. Instructions complètes dans [Démarrage rapide](#-démarrage-rapide) et Installation.

### Supporte-t-il les modèles à contexte 1 M ?

Oui. Le script détecte `[1m]` dans le model id et `1M` dans le display name, ajuste le dénominateur de la barre à 1 000 000 tokens.

### Avec quels modèles fonctionne-t-il ?

Avec tout modèle supporté par Claude Code — Opus 4.7, Sonnet 4.6, Haiku 4.5, Opus 4.6, etc. Le script lit `model.display_name` et `model.id` depuis le JSON, sans hardcoder de noms.

### Puis-je personnaliser couleurs, thèmes, ou ajouter les miens ?

Oui — trois façons : (1) choisir parmi **40 variantes prêtes** dans [`examples/`](examples/), (2) composer la sienne à partir de **blocs nommés** — voir [BLOCKS.md](BLOCKS.md), (3) éditer les constantes de couleur dans `statusline.sh` directement.

### Va-t-il ralentir Claude Code ?

Non. Chaque rendu typique est ≤ 50 ms.

### Fonctionne-t-il sans `jq` ?

`jq` est requis — il parse le JSON envoyé sur stdin. Installer via `brew install jq` (macOS) ou `apt install jq` (Debian/Ubuntu).

### Fonctionne-t-il sur Windows / macOS / Linux ?

Oui sur tous. Sur Windows — via Git Bash, WSL, MSYS2 ou Cygwin.

### Puis-je l'utiliser avec l'API Anthropic brute ?

Partiellement. Les indicateurs de limites basculent automatiquement sur l'affichage des tokens totaux de session (`tokens: NNN K`).

### Où est stockée la configuration ?

`~/.claude/statusline.conf` — petit fichier sourcé par shell. Persiste entre redémarrages.

### Est-ce gratuit ? Puis-je l'utiliser commercialement ?

L'usage personnel local est gratuit (voir la [Source-Available License](LICENSE)). Toute réutilisation requiert l'**autorisation écrite préalable** de l'auteur (amazopic@gmail.com).

### Comment revenir à la ligne d'état Claude Code par défaut ?

Supprimer le bloc `statusLine` de `~/.claude/settings.json` ou exécuter `~/.claude/status-line.sh reset`.

## 🏷️ Topics GitHub recommandés

`claude-code` · `claude-code-statusline` · `statusline` · `status-bar` · `terminal-prompt` · `anthropic-claude` · `ai-coding` · `developer-tools` · `bash-script` · `terminal-customization` · `prompt-customization` · `claude-4` · `opus-4` · `sonnet-4` · `dotfiles` · `terminal-dashboard` · `context-window-monitor` · `token-counter` · `rate-limit-monitor`
