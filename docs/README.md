# Landing — `claude-code-statusline`

Editorial type-specimen × live terminal landing for the project. Vanilla
HTML / CSS / vanilla JS — **zero build step, zero dependencies**.

## Local preview

The landing uses ES modules (`type="module"`) and `fetch()` — both need an
HTTP server (won't work via `file://`). Pick any of these:

```bash
# Python 3 (built into macOS/Linux)
cd docs && python3 -m http.server 4321
# → open http://localhost:4321/

# Or with npx (if Node is around)
cd docs && npx serve -l 4321 .

# Or PHP (built into macOS, often elsewhere)
cd docs && php -S localhost:4321
```

## Deploy to GitHub Pages

The `docs/` folder is the entire site. To publish:

1. Push to GitHub.
2. **Settings → Pages → Source → Deploy from a branch → `main` / `/docs`.**
3. After ~30s your site is live at
   `https://<your-username>.github.io/claude-code-statusline/`.

## Before publishing, replace `amazopic`

The HTML, sitemap, robots, and JSON-LD reference `amazopic` as a placeholder.
Run from the repo root:

```bash
sed -i '' 's|amazopic|<your-github-username>|g' docs/index.html docs/sitemap.xml docs/robots.txt
```

(On Linux, drop the `''` after `-i`.)

## Custom domain (optional)

1. Buy a domain (e.g. `claudecodestatusline.com`).
2. Create `docs/CNAME` containing the bare domain.
3. In your DNS, point `CNAME` for the chosen subdomain (or `A` records for
   apex) to `<your-username>.github.io`.
4. **Settings → Pages → Custom domain** → set the domain → enable HTTPS.

## File structure

```
docs/
├── index.html              entry, JSON-LD, OG, Twitter, FAQ schemas
├── README.md               this file
├── favicon.svg             animated terminal cursor favicon
├── apple-touch-icon.png
├── og-image.png            1200×630 social card
├── og-image.svg            source for og-image.png
├── robots.txt              welcomes GPTBot, ClaudeBot, PerplexityBot
├── sitemap.xml
├── llms.txt                AI-crawler index (copy of repo-root file)
├── llms-full.txt           AI-ingestion corpus (copy of repo-root file)
├── css/
│   ├── tokens.css          CSS custom properties (colors, type, motion)
│   ├── base.css            reset, grain texture, page-load reveal
│   └── sections.css        per-section styles for all 10 sections
├── js/
│   ├── ansi.js             ANSI escape → HTML span renderer
│   ├── themes.js           themes / blocks / FAQ / compare / captions data
│   └── main.js             orchestrator: hero, specimens, recipe, FAQ
└── assets/
    └── specimens/          41 .ansi files (one per theme + main)
```

## What you should know

- **Fonts:** Editorial New + Neue Montreal from Fontshare (CDN), Geist
  Mono from Google Fonts. To self-host, download from
  [Fontshare](https://www.fontshare.com/) and [Vercel](https://vercel.com/font),
  drop into `assets/fonts/`, and update the `<link>` tags in `index.html`.
- **Analytics:** Google Analytics 4 only (measurement id `G-GN8ZDLTY1D`),
  loaded `async` so it doesn't block render. Tracks pageviews +
  `language_change` events. No other telemetry.
- **Lighthouse target:** 100 / 100 / 100 / 100. HTML + ~12 KB CSS + ~10 KB JS
  + GA4 (~50 KB, deferred). No framework, no other trackers.
- **AI-friendly:** JSON-LD for SoftwareApplication, FAQPage, HowTo. Plus
  `llms.txt` and `llms-full.txt` accessible at site root.
- **Reduced-motion:** all animations honor `prefers-reduced-motion`.
- **Dark mode:** light-mode primary; the dark sections (Numbers, Recipe
  preview, Hero terminal, Colophon) are inverted intentionally for
  contrast, not theme.

## Updating specimens

When you change theme scripts in `examples/`, regenerate the ANSI files
and copy them here:

```bash
# (from repo root)
FIXTURE="$(pwd)/screenshots/fixture.jsonl"
INPUT='{"model":{"display_name":"Opus 4.7 (1M context)","id":"claude-opus-4-7[1m]"},"workspace":{"current_dir":"'"$(pwd)"'"},"cost":{"total_cost_usd":0.42},"transcript_path":"'"$FIXTURE"'"}'
for f in examples/*.sh; do
  name=$(basename "$f" .sh)
  echo "$INPUT" | bash "$f" > "screenshots/${name}.ansi"
done
echo "$INPUT" | bash statusline.sh > screenshots/statusline.ansi

# Then sync to docs/
cp screenshots/*.ansi docs/assets/specimens/
```

## Author / license

- **Author:** Yevgeniy Achin · [amazopic@gmail.com](mailto:amazopic@gmail.com)
- **License:** [Source-Available](../LICENSE) — reuse only with prior
  written permission.
