# AGENTS.md — Zuvo Astro Starter

Reusable Astro starter for small-business websites (concept and client work) built by
Zuvo Web Studio. It provides **structure and a design system — not a brand**. Every site
sets its own palette, fonts, and content.

## Creating a new site

```bash
gh repo create concept-<name> --template parwaizjan/zuvo-astro-starter --private --clone
cd concept-<name> && npm install
```

Then work through this checklist:

1. `src/consts.ts` — business name, short name, domain, URL, email, WhatsApp number.
2. `astro.config.mjs` — set `site` to the production URL.
3. `src/styles/global.css` — set the palette and fonts for this brand.
4. `src/components/Nav.astro` — nav links and CTA label.
5. `scripts/generate-og.sh` — edit the config block, then run `npm run og`.
6. `public/favicon.svg` — replace with the site's mark.
7. `src/pages/index.astro` — replace the placeholder home page.
8. Add pages under `src/pages/` as needed.

## Stack

- Astro 7 (static output) + Tailwind CSS v4 via `@tailwindcss/vite`
- Fonts: `@fontsource-variable/fraunces` (display), `@fontsource-variable/inter` (body)
- `@astrojs/sitemap` → `sitemap-index.xml`
- `src/pages/robots.txt.ts` generates robots.txt from `site`
- TypeScript strict; Node >= 22.12

## Commands

- `npm run dev` — dev server (http://localhost:4321)
- `npm run build` — production build to `dist/`
- `npm run preview` — preview the build
- `npm run check` — Astro/TypeScript diagnostics
- `npm run og` — regenerate `public/og.png` (1200×630)

Always run `npm run check` and `npm run build` after changes.

## Structure

```
src/
  consts.ts                 site metadata + WHATSAPP_URL
  layouts/BaseLayout.astro  SEO/OG tags, fonts, Nav + Footer
  components/
    Nav.astro               header with mobile menu
    Footer.astro
    Section.astro           section wrapper (border + max-w-6xl + padding)
    Hero.astro              page hero with eyebrow, title, description, CTAs
    CtaBand.astro           closing call-to-action band
  pages/
    index.astro             home page (placeholder)
    robots.txt.ts           dynamic robots.txt
  styles/global.css         design tokens + base + reusable classes
scripts/generate-og.sh      OG image generator
public/                     favicon.svg, og.png
```

## Design system

Tokens live in `src/styles/global.css` under `@theme`. Use semantic names so each site
only changes values, not markup:

| Token | Use |
|---|---|
| `canvas` | Page background |
| `surface` | Cards / subtle sections |
| `ink` | Primary text |
| `muted` | Secondary text |
| `line` | Hairline borders |
| `accent` | Buttons, links, highlights |
| `accent-dark` | Accent hover/active |

- Utilities: `bg-canvas`, `bg-surface`, `text-ink`, `text-muted`, `border-line`, `bg-accent`.
- Type: `font-display`, `font-sans`. Radius: `rounded-brand`. No shadows.
- Reusable classes: `.eyebrow`, `.btn-primary`, `.btn-secondary`.

## Conventions

- **Mobile-first.** Test at 375px.
- **WhatsApp-first CTA.** Primary action is always WhatsApp (`WHATSAPP_URL`).
- Use `<Section id="...">` for page sections to keep spacing and borders consistent.
- **No code comments** unless they explain non-obvious intent.
- **Copy:** specific and concrete. No generic AI filler.
- Replace placeholder contact details before shipping anything public.

## Concept vs client sites

- **Concept sites** (spec work for a real business): keep them `noindex` and add a small
  "unofficial concept" notice. Never register a domain using the business's trademark.
  Use licensed stock or placeholder images unless you have permission to use theirs.
- **Client sites:** go live on the client's domain; remove all concept framing.

## Business context

Read `docs/strategy.md` in the `zuvo-studio` repo for niche, offer, pricing, and GTM.

## Do NOT

- Do not commit `node_modules/`, `dist/`, `.cache/`, or `.env` files.
- Do not ship placeholder contact details (WhatsApp number, email, domain).
