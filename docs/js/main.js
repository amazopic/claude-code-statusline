// ─────────────────────────────────────────────────────────────────────
// MAIN — orchestrates page-load, hero animation, specimens, recipe, FAQ,
//        i18n (23 locales), language switcher, hero limits visualization
// ─────────────────────────────────────────────────────────────────────

import { themes, blocks, faq, compare } from './themes.js?v=25';
import { ansiToHtml, specimenHtml, loadSpecimen } from './ansi.js?v=25';
import { supportedLocales, defaultLocale, t as tBase, detectLocale, persistLocale, ensureLocale, registerEnCanon } from './i18n.js?v=25';

document.documentElement.classList.add('has-cursor');

const $  = (sel, root = document) => root.querySelector(sel);
const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

const REPO_URL = 'https://github.com/amazopic/claude-code-statusline';
const REPO_BLOB = `${REPO_URL}/blob/main`;
// English uses README.md; everyone else uses README.<lang>.md
const readmeUrl = (locale) =>
  locale === 'en' ? `${REPO_BLOB}/README.md` : `${REPO_BLOB}/README.${locale}.md`;
const exampleUrl = (themeId) => `${REPO_BLOB}/examples/statusline-${themeId}.sh`;

// ═════════════════════════════════════════════════════════════════════
//  Locale state
// ═════════════════════════════════════════════════════════════════════

let currentLocale = ((() => {
  // URL ?lang=xx wins on first load (for shareable hreflang variants)
  const url = new URL(window.location.href);
  const fromQuery = url.searchParams.get('lang');
  if (fromQuery && supportedLocales.some(l => l.code === fromQuery)) {
    persistLocale(fromQuery);
    return fromQuery;
  }
  return detectLocale();
})());

const t = (key) => tBase(key, currentLocale);

// ─────────────────────────────────────────────────────────────────────
//  English-canon fallbacks for newly added keys (refreshInterval feature).
//  Registered on the resident en dict so t() resolves them everywhere via
//  i18n.js's `?? en[key]` fallback chain, without editing i18n.js's shipped
//  dictionary. Localized strings can be backfilled into chunks later.
// ─────────────────────────────────────────────────────────────────────
registerEnCanon({
  'install.refreshTip': 'refreshInterval: 30 re-runs the line every 30 seconds even while the session is idle — keeps the reset countdown (5h{1.1h}), the time tracker and post-reset flips live. 30 is a sensible default; 60 is battery-frugal; omit to refresh on events only (new assistant message, /compact, vim toggle).',
  'faq.q.refresh': 'Does the status line update by itself? My {1.1h} countdown looks frozen.',
  'faq.a.refresh': 'Claude Code re-renders on events — new assistant message, /compact, permission-mode or vim-mode change (debounced at 300 ms) — so between events the line freezes. Add "refreshInterval": 30 to the statusLine block in ~/.claude/settings.json and it also re-runs on a fixed 30-second timer, keeping the countdown and time tracker ticking while idle. A render costs ~0.1 s, so 30 s is negligible; use 60 on battery or in huge repos (git status runs each render); minimum is 1.',
});

// ═════════════════════════════════════════════════════════════════════
//  i18n application
// ═════════════════════════════════════════════════════════════════════

function applyTranslations() {
  // Plain text nodes
  $$('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (!key) return;
    el.textContent = t(key);
  });
  // HTML nodes (where translation contains markup)
  $$('[data-i18n-html]').forEach(el => {
    const key = el.getAttribute('data-i18n-html');
    if (!key) return;
    el.innerHTML = t(key);
  });
  // aria-labels
  $$('[data-i18n-aria-label]').forEach(el => {
    const key = el.getAttribute('data-i18n-aria-label');
    if (!key) return;
    el.setAttribute('aria-label', t(key));
  });
  // <html lang=""> + dir="rtl|ltr"
  document.documentElement.lang = currentLocale;
  const localeMeta = supportedLocales.find(l => l.code === currentLocale);
  document.documentElement.dir = (localeMeta && localeMeta.rtl) ? 'rtl' : 'ltr';
  // README links — point to the language-appropriate README on GitHub
  $$('[data-readme-link]').forEach(a => a.setAttribute('href', readmeUrl(currentLocale)));
  // <title>
  document.title = t('meta.title');
  // <meta description>
  const metaDesc = document.querySelector('meta[name="description"]');
  if (metaDesc) metaDesc.setAttribute('content', t('meta.description'));
  // OpenGraph title/description
  const ogTitle = document.querySelector('meta[property="og:title"]');
  if (ogTitle) ogTitle.setAttribute('content', t('meta.title'));
  const ogDesc = document.querySelector('meta[property="og:description"]');
  if (ogDesc) ogDesc.setAttribute('content', t('meta.description'));
  // Twitter
  const twTitle = document.querySelector('meta[name="twitter:title"]');
  if (twTitle) twTitle.setAttribute('content', t('meta.title'));
  const twDesc = document.querySelector('meta[name="twitter:description"]');
  if (twDesc) twDesc.setAttribute('content', t('meta.description'));
}

// ═════════════════════════════════════════════════════════════════════
//  Language switcher
// ═════════════════════════════════════════════════════════════════════

function buildLangSwitcher() {
  const wrap = $('[data-lang-switcher]');
  if (!wrap) return;
  const toggle = wrap.querySelector('.lang-switcher__toggle');
  const menu = wrap.querySelector('[data-lang-menu]');
  const current = wrap.querySelector('[data-current-lang]');

  // Build menu items
  menu.innerHTML = supportedLocales.map(loc => `
    <li>
      <button class="lang-switcher__opt" type="button" data-lang="${loc.code}" role="option" aria-selected="${loc.code === currentLocale}">
        <span class="lang-switcher__opt-native">${loc.native}</span>
        <span class="lang-switcher__opt-code">${loc.code.toUpperCase()}</span>
      </button>
    </li>
  `).join('');

  current.textContent = currentLocale.toUpperCase();

  const open = () => { menu.hidden = false; toggle.setAttribute('aria-expanded', 'true'); };
  const close = () => { menu.hidden = true;  toggle.setAttribute('aria-expanded', 'false'); };
  const isOpen = () => toggle.getAttribute('aria-expanded') === 'true';

  toggle.addEventListener('click', (e) => {
    e.stopPropagation();
    isOpen() ? close() : open();
  });

  document.addEventListener('click', (e) => {
    if (!wrap.contains(e.target) && isOpen()) close();
  });
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && isOpen()) close();
  });

  menu.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-lang]');
    if (!btn) return;
    const code = btn.getAttribute('data-lang');
    if (code === currentLocale) { close(); return; }
    setLocale(code);
    close();
  });
}

async function setLocale(code) {
  if (!supportedLocales.some(l => l.code === code)) return;
  await ensureLocale(code);
  currentLocale = code;
  persistLocale(code);

  // Reflect in switcher
  const current = $('[data-current-lang]');
  if (current) current.textContent = code.toUpperCase();
  $$('.lang-switcher__opt').forEach(b => {
    b.setAttribute('aria-selected', b.getAttribute('data-lang') === code ? 'true' : 'false');
  });

  // Update URL ?lang=xx without reload (for shareability)
  const url = new URL(window.location.href);
  url.searchParams.set('lang', code);
  window.history.replaceState({}, '', url);

  // Re-apply
  applyTranslations();
  // Sections that build content dynamically
  buildCompare();
  buildFaq();
  buildRecipePalette();
  // refresh specimen labels
  showSpecimen(currentSpecimen);
  showToast(`✓ ${supportedLocales.find(l => l.code === code).native}`);
  // Analytics: track language switches as custom events
  if (typeof gtag === 'function') {
    gtag('event', 'language_change', { locale: code });
  }
}

// ═════════════════════════════════════════════════════════════════════
//  Toast helper
// ═════════════════════════════════════════════════════════════════════

const toast = $('.toast');
function showToast(msg) {
  if (!toast) return;
  toast.textContent = msg;
  toast.classList.add('show');
  clearTimeout(showToast._t);
  showToast._t = setTimeout(() => toast.classList.remove('show'), 1800);
}

// Copy-to-clipboard for any [data-copy]
document.addEventListener('click', (e) => {
  const trigger = e.target.closest('[data-copy]');
  if (!trigger) return;
  const target = trigger.getAttribute('data-copy');
  const node = target.startsWith('#') ? $(target) : null;
  const value = node ? node.textContent.trim() : trigger.getAttribute('data-copy');
  navigator.clipboard.writeText(value).then(
    () => showToast(t('ui.copied')),
    () => showToast(t('ui.copyfail'))
  );
});

// ═════════════════════════════════════════════════════════════════════
//  HERO LIMITS — animate 5h/7d meters from low → critical → reset loop
// ═════════════════════════════════════════════════════════════════════

// Each frame carries the meter % plus a live reset countdown (eta) that
// ticks down toward 0 — 5h in decimal hours, 7d in decimal days — exactly
// like rate_limits.*.resets_at rendered by the bundle (e.g. 5h{1.1h}).
// First frame is {1.1h}/{1.1d} to match the marketing copy verbatim.
const limitsCycle = [
  { '5h': 8,  '7d': 4,  eta5: '1.1h', eta7: '1.1d' },
  { '5h': 22, '7d': 10, eta5: '3.2h', eta7: '4.6d' },
  { '5h': 35, '7d': 18, eta5: '2.7h', eta7: '4.4d' },
  { '5h': 47, '7d': 27, eta5: '2.1h', eta7: '4.2d' },
  { '5h': 62, '7d': 38, eta5: '1.6h', eta7: '3.5d' },  // first warn
  { '5h': 78, '7d': 51, eta5: '0.9h', eta7: '2.4d' },  // both warn
  { '5h': 91, '7d': 64, eta5: '0.4h', eta7: '1.3d' },
  { '5h': 10, '7d': 5,  eta5: '5.0h', eta7: '7.0d' },  // session reset (the "after restart" relief)
];

function setLimit(which, pct, eta) {
  const fill = $(`[data-fill="${which}"]`);
  const label = $(`[data-pct="${which}"]`);
  if (!fill || !label) return;
  fill.style.setProperty('--w', pct + '%');
  label.textContent = pct + '%';
  const warn = pct > 50;
  fill.dataset.state = warn ? 'warn' : 'ok';
  label.dataset.state = warn ? 'warn' : 'ok';
  const etaEl = $(`[data-eta="${which}"]`);
  if (etaEl && eta) etaEl.textContent = '{' + eta + '}';
}

function startLimitsAnimation() {
  let i = 0;
  setLimit('5h', limitsCycle[0]['5h'], limitsCycle[0].eta5);
  setLimit('7d', limitsCycle[0]['7d'], limitsCycle[0].eta7);
  setInterval(() => {
    i = (i + 1) % limitsCycle.length;
    setLimit('5h', limitsCycle[i]['5h'], limitsCycle[i].eta5);
    setLimit('7d', limitsCycle[i]['7d'], limitsCycle[i].eta7);
  }, 2200);
}

// ═════════════════════════════════════════════════════════════════════
//  HERO CONTEXT METER — animated fill→warn→critical→compact cycle
// ═════════════════════════════════════════════════════════════════════

const contextCycle = [
  { pct: 12, state: 'ok',       msgKey: 'hero.context.tip_healthy' },
  { pct: 35, state: 'ok',       msgKey: 'hero.context.tip_healthy' },
  { pct: 52, state: 'ok',       msgKey: 'hero.context.tip_approach' },
  { pct: 67, state: 'warn',     msgKey: 'hero.context.tip_clear' },
  { pct: 84, state: 'critical', msgKey: 'hero.context.tip_compact' },
  { pct: 95, state: 'critical', msgKey: 'hero.context.tip_critical' },
  { pct: 12, state: 'ok',       msgKey: 'hero.context.tip_compacted' },
];

function setContext(pct, state, msgKey) {
  const fill = $('[data-context-fill]');
  const label = $('[data-context-pct]');
  const status = $('[data-context-status]');
  if (!fill || !label || !status) return;
  fill.style.setProperty('--w', pct + '%');
  fill.dataset.state = state;
  label.textContent = pct + '%';
  label.dataset.state = state;
  status.dataset.state = state;
  status.textContent = t(msgKey);
}

function startContextAnimation() {
  let i = 0;
  const step = contextCycle[0];
  setContext(step.pct, step.state, step.msgKey);
  setInterval(() => {
    i = (i + 1) % contextCycle.length;
    const s = contextCycle[i];
    setContext(s.pct, s.state, s.msgKey);
  }, 2400);
}

// ═════════════════════════════════════════════════════════════════════
//  HERO TERMINAL — auto-typing terminal that cycles through themes
// ═════════════════════════════════════════════════════════════════════

const heroOrder = ['cyberpunk','anime','hacker','fire','rainbow','space','minimal','game','christmas','ocean'];
const heroCmdLine = $('.terminal__line--cmd .text');
const heroStatusLine = $('.terminal__statusline');

async function runHeroAnimation() {
  if (!heroCmdLine || !heroStatusLine) return;
  const cache = {};
  await Promise.all(heroOrder.map(async (n) => {
    cache[n] = await specimenHtml(n);
  }));

  let idx = 0;
  const cycle = async () => {
    const themeName = heroOrder[idx];
    const fullCmd = `~/.claude/status-line.sh use ${themeName}`;
    heroCmdLine.textContent = '';
    for (let i = 0; i < fullCmd.length; i++) {
      heroCmdLine.textContent = fullCmd.slice(0, i + 1);
      await sleep(28);
    }
    await sleep(280);
    heroStatusLine.style.opacity = '0';
    await sleep(120);
    heroStatusLine.innerHTML = cache[themeName];
    heroStatusLine.style.opacity = '1';
    await sleep(2400);
    idx = (idx + 1) % heroOrder.length;
    cycle();
  };
  cycle();
}
const sleep = (ms) => new Promise(r => setTimeout(r, ms));

// ═════════════════════════════════════════════════════════════════════
//  SPECIMENS — flipbook with prev/next + dot pager
// ═════════════════════════════════════════════════════════════════════

let currentSpecimen = 0;
const specimenView = $('.specimen');
const pager = $('.specimen-pager');
const prevBtn = $('#spec-prev');
const nextBtn = $('#spec-next');

async function showSpecimen(idx) {
  if (idx < 0 || idx >= themes.length) return;
  currentSpecimen = idx;
  const theme = themes[idx];
  const [detailedHtml, compactHtml] = await Promise.all([
    specimenHtml(theme.id),
    specimenHtml(`${theme.id}-compact`).catch(() => null),
  ]);

  const swatches = theme.palette.map(c =>
    `<span style="background:${c}"></span>`
  ).join('');

  specimenView.innerHTML = `
    <header class="specimen__header">
      <div class="specimen__id">
        <span>${t('specimens.id')}</span><strong>${String(idx + 1).padStart(2, '0')} / ${themes.length}</strong>
      </div>
      <h3 class="specimen__name">${theme.name}</h3>
      <p class="specimen__vibe">${theme.vibe}</p>
    </header>
    <div class="specimen__terminals">
      <div class="specimen__terminal-label"><span>${t('specimens.detailed')}</span><span>statusline-${theme.id}.sh</span></div>
      <div class="specimen__terminal">${detailedHtml}</div>
      ${compactHtml ? `
        <div class="specimen__terminal-label"><span>${t('specimens.compact')}</span><span>statusline-${theme.id}-compact.sh</span></div>
        <div class="specimen__compact">${compactHtml}</div>
      ` : ''}
    </div>
    <footer class="specimen__meta">
      <div class="specimen__meta-col specimen__meta-col--usages">
        <div class="specimen__usages">
          <div class="specimen__usage">
            <span class="specimen__usage-label">${t('specimens.use')}</span>
            <code>~/.claude/status-line.sh use ${theme.id}</code>
          </div>
          <div class="specimen__usage specimen__usage--slash">
            <span class="specimen__usage-label">${t('specimens.in_claude')}</span>
            <code><span class="slash">/statusline</span> ${theme.id}</code>
          </div>
          <a class="specimen__usage specimen__usage--source" href="${exampleUrl(theme.id)}" target="_blank" rel="noopener">
            <span class="specimen__usage-label">${t('specimens.source')}</span>
            <code>examples/statusline-${theme.id}.sh <span class="ext">↗</span></code>
          </a>
        </div>
      </div>
      <div class="specimen__meta-col">
        <h4>${t('specimens.palette')}</h4>
        <div class="specimen__palette">${swatches}</div>
      </div>
      <div class="specimen__meta-col">
        <h4>${t('specimens.glyphs')}</h4>
        <div class="specimen__glyphs">▖ ▄ ▙ █ ▏ ▎ ▍ ▌ ▋ ▊ ▉</div>
      </div>
      <div class="specimen__meta-col">
        <h4>${t('specimens.group')}</h4>
        <p class="specimen__group">${theme.group}</p>
      </div>
    </footer>
  `;
  $$('.specimen-pager button').forEach((b, i) => {
    const isActive = i === idx;
    b.classList.toggle('active', isActive);
    b.setAttribute('aria-selected', isActive ? 'true' : 'false');
    b.tabIndex = isActive ? 0 : -1;
  });
  prevBtn.disabled = idx === 0;
  nextBtn.disabled = idx === themes.length - 1;
}

function buildPager() {
  if (!pager) return;
  pager.innerHTML = themes.map((t, i) =>
    `<button role="tab" aria-selected="${i === 0 ? 'true' : 'false'}" tabindex="${i === 0 ? 0 : -1}" title="${t.name}" data-i="${i}" aria-label="Show specimen ${i + 1}: ${t.name}"></button>`
  ).join('');
  pager.addEventListener('click', (e) => {
    const b = e.target.closest('button');
    if (!b) return;
    showSpecimen(parseInt(b.dataset.i, 10));
  });
}
function bindSpecimenNav() {
  if (prevBtn) prevBtn.addEventListener('click', () => showSpecimen(currentSpecimen - 1));
  if (nextBtn) nextBtn.addEventListener('click', () => showSpecimen(currentSpecimen + 1));
  document.addEventListener('keydown', (e) => {
    if (!isInViewport(specimenView)) return;
    if (e.key === 'ArrowLeft')  showSpecimen(Math.max(0, currentSpecimen - 1));
    if (e.key === 'ArrowRight') showSpecimen(Math.min(themes.length - 1, currentSpecimen + 1));
  });
}
function isInViewport(el) {
  if (!el) return false;
  const r = el.getBoundingClientRect();
  return r.top < window.innerHeight && r.bottom > 0;
}

// ═════════════════════════════════════════════════════════════════════
//  CATALOG — render all 82 themes as TOC, click to jump to specimen
// ═════════════════════════════════════════════════════════════════════

function buildCatalog() {
  const list = $('.catalog-list');
  if (!list) return;
  list.innerHTML = themes.map((t, i) => {
    const swatches = t.palette.slice(0, 4).map(c =>
      `<span style="background:${c}"></span>`
    ).join('');
    return `
      <a href="#specimens" class="catalog-list__item" data-jump-to="${i}">
        <span class="catalog-list__num">№${String(i + 1).padStart(2, '0')}</span>
        <span class="catalog-list__name">${t.name}</span>
        <span class="catalog-list__swatches">${swatches}</span>
        <span class="catalog-list__page">p.${String((i + 1) * 4).padStart(3, '0')}</span>
      </a>
    `;
  }).join('');
  list.addEventListener('click', (e) => {
    const item = e.target.closest('[data-jump-to]');
    if (!item) return;
    const i = parseInt(item.dataset.jumpTo, 10);
    showSpecimen(i);
  });
}

// ═════════════════════════════════════════════════════════════════════
//  RECIPE — drag/click block builder. The default recipe leads with limits
// ═════════════════════════════════════════════════════════════════════

const recipeBlocks = ['model','context-bar','limits','cost','git'];

function buildRecipePalette() {
  const palette = $('.recipe__palette');
  if (!palette) return;
  palette.innerHTML = `<h4>${t('recipe.palette.h')}</h4>`;
  blocks.forEach(b => {
    const node = document.createElement('button');
    node.className = 'recipe__block';
    node.dataset.id = b.id;
    node.innerHTML = `<span><span class="mono">${b.label}</span> <span style="color:var(--sub-2);font-size:var(--fs-xs);">${b.desc}</span></span><span class="add">+</span>`;
    node.addEventListener('click', () => addRecipeBlock(b.id));
    palette.appendChild(node);
  });
}
function addRecipeBlock(id) {
  if (recipeBlocks.includes(id)) return;
  recipeBlocks.push(id);
  renderRecipe();
}
function removeRecipeBlock(idx) {
  recipeBlocks.splice(idx, 1);
  renderRecipe();
}
function renderRecipe() {
  const line = $('.recipe__line');
  const out = $('.recipe__statusline-wrap');
  const code = $('#recipe-code');
  if (!line || !code) return;
  line.innerHTML = recipeBlocks.length === 0
    ? `<span class="empty">${t('recipe.empty.line')}</span>`
    : recipeBlocks.map((id, i) =>
        `<span class="recipe__chip"><span>${id}</span><span class="x" data-rm="${i}">×</span></span>`
      ).join('');
  $$('.recipe__chip .x', line).forEach(x => {
    x.addEventListener('click', () => removeRecipeBlock(parseInt(x.dataset.rm, 10)));
  });
  out.innerHTML = recipeBlocks.length === 0
    ? `<span class="empty">${t('recipe.empty.preview')}</span>`
    : mockRender(recipeBlocks);
  code.textContent = generateBash(recipeBlocks);
  // Reflect "already added" state on palette buttons
  $$('.recipe__block').forEach(btn => {
    const used = recipeBlocks.includes(btn.dataset.id);
    btn.classList.toggle('is-used', used);
    btn.disabled = used;
    btn.setAttribute('aria-disabled', used ? 'true' : 'false');
  });
}

function mockRender(ids) {
  const sample = {
    model: '<span style="color:#FFD700;font-weight:600">Opus 4.7 (1M)</span>',
    context: '<span style="color:#46DA46">12% █▌░░░░░░░░ 121.4K/1000K</span>',
    'context-pct': '<span style="color:#46DA46;font-weight:600">12%</span>',
    'context-bar': '<span style="color:#46DA46">█▌░░░░░░░░</span>',
    cost: '<span style="color:#FFD700">0.42$</span>',
    folder: '<span style="color:#22D3EE">project</span>',
    git: '<span style="color:#22D3EE">⎇ main</span> <span style="color:#FFD700">✚3</span>',
    'git-branch': '<span style="color:#22D3EE">⎇ main</span>',
    'tokens-msg': '<span style="color:#22D3EE">↑0.5K ↓1.2K</span>',
    'tokens-session': '<span style="color:#22D3EE">tokens: 87 K</span>',
    limits: '<span style="color:#46DA46">5h: 10%</span><span style="color:#4A4A48"> · </span><span style="color:#46DA46">7d: 5%</span>',
    thinking: '🤖 <span style="color:#22D3EE">xhigh</span>',
    'time-active': '<span style="color:#22D3EE">⏱ active 1h23m</span>',
    'time-wall': '<span style="color:#22D3EE">⏱ wall 2h45m</span>',
    turns: '<span style="color:#22D3EE">47</span> turns',
    host: '<span style="color:#22D3EE">macbook</span>',
    cups: '☕ <span style="color:#FFD700">2</span>',
    level: '<span style="color:#C04AFF">LV 1</span>',
    'mood-icon': '☀',
    lines: '<span style="color:#46DA46">+156</span> <span style="color:#EF4444">−23</span>',
    pr: '<span style="color:#22D3EE;font-weight:600">PR #1234</span> <span style="color:#7A7A78">⏳</span>',
    worktree: '<span style="color:#22D3EE">⧉ my-feature</span>',
    vim: '<span style="color:#FFD700">-- NORMAL --</span>',
    agent: '<span style="color:#C04AFF">⚙ reviewer</span>',
    repo: '<span style="color:#7A7A78">amazopic</span><span style="color:#7A7A78">/</span><span style="color:#F5F2EA;font-weight:600">statusline</span>',
    'api-time': '<span style="color:#22D3EE">⚡ api 2.3s</span>',
  };
  return ids.map(id => sample[id] || `[${id}]`).join('<span style="color:#4A4A48"> · </span>');
}

function generateBash(ids) {
  const lines = [
    '#!/usr/bin/env bash',
    '# Generated by Claude Code Status Line — Recipe',
    `# Blocks: ${ids.join(' · ')}`,
    '#',
    '# Drop into ~/.claude/status-line.sh and chmod +x.',
    '',
    'set -uo pipefail',
    'input=$(cat)',
    '',
    "j() { jq -r \"$1 // empty\" 2>/dev/null <<<\"$input\"; }",
    '',
    '# … parsing setup omitted (see statusline-bundle.sh for the full version) …',
    '',
    `BLOCKS="${ids.join(' ')}"`,
    '',
    '# Or use the bundle and switch in one command:',
    `~/.claude/status-line.sh custom ${ids.join(' ')}`,
  ];
  return lines.join('\n');
}

// ═════════════════════════════════════════════════════════════════════
//  COMPARE — render the table (uses i18n keys for feature names)
// ═════════════════════════════════════════════════════════════════════

function buildCompare() {
  const tbody = $('#compare-body');
  if (!tbody) return;
  tbody.innerHTML = compare.map(({ fKey, def, ours, highlight }) => {
    const cellDef = def === true ? `<span class="yes">${t('compare.yes')}</span>`
                  : def === false ? `<span class="no">${t('compare.no')}</span>`
                  : def;
    const cellOurs = ours === true ? `<span class="yes">${t('compare.yes')}</span>`
                   : ours === false ? `<span class="no">${t('compare.no')}</span>`
                   : `<span class="yes">${ours}</span>`;
    return `
      <tr${highlight ? ' class="cmp-highlight"' : ''}>
        <td class="feature">${t(fKey)}</td>
        <td>${cellDef}</td>
        <td>${cellOurs}</td>
      </tr>`;
  }).join('');
}

// ═════════════════════════════════════════════════════════════════════
//  FAQ — collapsible (uses i18n keys)
// ═════════════════════════════════════════════════════════════════════

function buildFaq() {
  const list = $('.faq-list');
  if (!list) return;
  list.innerHTML = faq.map((item, i) => `
    <details class="faq-item"${i === 0 ? ' open' : ''}>
      <summary class="faq-q">
        <span class="num">${String(i + 1).padStart(2, '0')}</span>
        <span>${t(item.qKey)}</span>
        <span class="toggle" aria-hidden="true">+</span>
      </summary>
      <div class="faq-a">${t(item.aKey)}</div>
    </details>
  `).join('');
}

// ═════════════════════════════════════════════════════════════════════
//  Reveal-on-scroll
// ═════════════════════════════════════════════════════════════════════

function bindRevealOnScroll() {
  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('reveal');
        io.unobserve(e.target);
      }
    });
  }, { rootMargin: '0px 0px -10% 0px' });
  $$('[data-reveal]').forEach(el => io.observe(el));
}

// ═════════════════════════════════════════════════════════════════════
//  Smooth scroll for anchor links
// ═════════════════════════════════════════════════════════════════════

document.addEventListener('click', (e) => {
  const a = e.target.closest('a[href^="#"]');
  if (!a) return;
  const id = a.getAttribute('href').slice(1);
  const target = document.getElementById(id);
  if (!target) return;
  e.preventDefault();
  target.scrollIntoView({ behavior: 'smooth', block: 'start' });
});

// ═════════════════════════════════════════════════════════════════════
//  BOOT
// ═════════════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', async () => {
  // 0) Ensure the active locale's chunk is loaded before any text renders
  await ensureLocale(currentLocale);
  // 1) Apply translations FIRST so all static text reflects the locale
  applyTranslations();
  // 2) Build the language switcher
  buildLangSwitcher();
  // 3) Build dynamic sections
  buildCatalog();
  buildPager();
  bindSpecimenNav();
  buildRecipePalette();
  buildCompare();
  buildFaq();
  bindRevealOnScroll();
  // 4) Default specimen = cyberpunk (#11) for impact
  const defaultIdx = themes.findIndex(theme => theme.id === 'cyberpunk');
  showSpecimen(defaultIdx >= 0 ? defaultIdx : 0);
  renderRecipe();
  // 5) Hero animations after settle
  await sleep(400);
  runHeroAnimation();
  startLimitsAnimation();
  startContextAnimation();
});
