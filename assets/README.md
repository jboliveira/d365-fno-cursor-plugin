# Plugin assets

Branding for the **xpp-fno** Cursor plugin and marketplace submission.

## Files

| File | Size / format | Use |
|------|---------------|-----|
| `logo.svg` | 128×128 SVG | Full-bleed icon (README display) |
| `logo-padded.svg` | SVG + ~25% padding | **Primary plugin icon** (`plugin.json` → `logo`) |
| `logo-icon.svg` | 128×128 SVG | Mark only — transparent background |
| `logo-dark.svg` | Padded SVG | Dark UI / GitHub dark mode |
| `logo-light.svg` | Padded SVG | Light UI / documentation |
| `banner.svg` | 1200×630 SVG | Marketplace listing / social preview |
| `avatar.png` | 512×512 PNG | Marketplace avatar (PNG fallback) |
| `logo-128.png` | 128×128 PNG | README, small UI |
| `logo-256.png` | 256×256 PNG | Medium displays |
| `logo-512.png` | 512×512 PNG | High-DPI / store listings |
| `banner.png` | 1200×630 PNG | Raster banner export |

## Regenerate PNGs

From repo root (requires Node.js):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/export-logo-pngs.ps1
```

## Marketplace submission

- Commit all assets to the repository.
- Reference `assets/logo.svg` in `.cursor-plugin/plugin.json` (already set).
- Optional: attach `banner.png` or `logo-512.png` when submitting at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish).
- Prefer `logo-padded.svg` if the marketplace crops icons tightly.

## Brand colors

| Token | Hex | Usage |
|-------|-----|-------|
| Dynamics blue | `#0078D4` | Primary |
| Deep blue | `#004578` | Gradient end, text on light |
| Cyan accent | `#00BCF2` | X++ badge, brackets |
