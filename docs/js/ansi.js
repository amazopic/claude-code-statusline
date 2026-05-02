// ─────────────────────────────────────────────────────────────────────
// ANSI → HTML renderer
// Converts ANSI escape sequences (256-color SGR + reset) into styled spans.
// ─────────────────────────────────────────────────────────────────────

const xterm256 = (() => {
  // Build the standard xterm 256-color palette as hex strings.
  const colors = new Array(256);
  // Standard 16
  const std = [
    '000000','800000','008000','808000','000080','800080','008080','c0c0c0',
    '808080','ff0000','00ff00','ffff00','0000ff','ff00ff','00ffff','ffffff'
  ];
  for (let i = 0; i < 16; i++) colors[i] = '#' + std[i];
  // 6×6×6 cube (16-231)
  const ramp = [0, 95, 135, 175, 215, 255];
  for (let i = 0; i < 216; i++) {
    const r = ramp[Math.floor(i / 36)];
    const g = ramp[Math.floor((i / 6) % 6)];
    const b = ramp[i % 6];
    colors[16 + i] = '#' + [r, g, b].map(x => x.toString(16).padStart(2, '0')).join('');
  }
  // Grayscale (232-255)
  for (let i = 0; i < 24; i++) {
    const v = 8 + i * 10;
    colors[232 + i] = '#' + [v, v, v].map(x => x.toString(16).padStart(2, '0')).join('');
  }
  return colors;
})();

const escapeHtml = (s) => s
  .replace(/&/g, '&amp;')
  .replace(/</g, '&lt;')
  .replace(/>/g, '&gt;');

/**
 * Convert an ANSI string to HTML (a sequence of <span> with inline styles).
 * Supports: 0 (reset), 1 (bold), 38;5;N (256 fg), 48;5;N (256 bg),
 * basic 30-37 / 90-97 fg, 40-47 / 100-107 bg.
 */
export function ansiToHtml(input) {
  // Strip trailing newline (terminals add one)
  const text = input.replace(/\n$/, '');
  const parts = text.split(/(\x1b\[[0-9;]*m)/g);
  let html = '';
  let style = { fg: null, bg: null, bold: false };

  const openSpan = () => {
    const props = [];
    if (style.fg)   props.push(`color:${style.fg}`);
    if (style.bg)   props.push(`background:${style.bg}`);
    if (style.bold) props.push('font-weight:600');
    return props.length ? `<span style="${props.join(';')}">` : '';
  };

  let openStr = '';
  for (const part of parts) {
    if (!part) continue;
    if (part.startsWith('\x1b[')) {
      // Close any currently open span
      if (openStr) { html += '</span>'; openStr = ''; }
      // Parse SGR codes
      const codes = part.slice(2, -1).split(';').map(Number);
      let i = 0;
      while (i < codes.length) {
        const c = codes[i];
        if (c === 0 || isNaN(c)) {
          style = { fg: null, bg: null, bold: false };
        } else if (c === 1) {
          style.bold = true;
        } else if (c === 22) {
          style.bold = false;
        } else if (c === 39) {
          style.fg = null;
        } else if (c === 49) {
          style.bg = null;
        } else if (c >= 30 && c <= 37) {
          style.fg = xterm256[c - 30];
        } else if (c >= 90 && c <= 97) {
          style.fg = xterm256[c - 90 + 8];
        } else if (c >= 40 && c <= 47) {
          style.bg = xterm256[c - 40];
        } else if (c >= 100 && c <= 107) {
          style.bg = xterm256[c - 100 + 8];
        } else if (c === 38 && codes[i + 1] === 5) {
          style.fg = xterm256[codes[i + 2]];
          i += 2;
        } else if (c === 48 && codes[i + 1] === 5) {
          style.bg = xterm256[codes[i + 2]];
          i += 2;
        }
        i++;
      }
      openStr = openSpan();
      html += openStr;
    } else {
      html += escapeHtml(part);
    }
  }
  if (openStr) html += '</span>';
  return html;
}

/** Cache for fetched specimen ANSI files. */
const specimenCache = new Map();

export async function loadSpecimen(name) {
  if (specimenCache.has(name)) return specimenCache.get(name);
  const url = new URL(`../assets/specimens/statusline-${name}.ansi`, import.meta.url);
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Failed to load specimen: ${name}`);
  const text = await res.text();
  specimenCache.set(name, text);
  return text;
}

export async function specimenHtml(name) {
  const ansi = await loadSpecimen(name);
  return ansiToHtml(ansi);
}
