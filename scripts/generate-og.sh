#!/usr/bin/env bash
# Generates public/og.png (1200x630) used for social/link previews.
# Edit the config block below, then run: npm run og
# Requires: rsvg-convert, curl, fc-cache
set -euo pipefail

# --- Edit for each site ----------------------------------------------------
WORDMARK="your brand"
EYEBROW="SMALL BUSINESS WEBSITES"
LINE1="A clear headline"
LINE2="that converts."
DOMAIN="example.com"
ACCENT="#111111"
# --------------------------------------------------------------------------

root="$(cd "$(dirname "$0")/.." && pwd)"
fontdir="$root/.cache/og-fonts"
out="$root/public/og.png"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$fontdir"
fraunces="$fontdir/Fraunces.ttf"
inter="$fontdir/Inter.ttf"

[ -f "$fraunces" ] || curl -sL -o "$fraunces" \
  "https://raw.githubusercontent.com/google/fonts/main/ofl/fraunces/Fraunces%5BSOFT%2CWONK%2Copsz%2Cwght%5D.ttf"
[ -f "$inter" ] || curl -sL -o "$inter" \
  "https://raw.githubusercontent.com/google/fonts/main/ofl/inter/Inter%5Bopsz%2Cwght%5D.ttf"

cat > "$tmp/fonts.conf" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>$fontdir</dir>
  <cachedir>$tmp/fontcache</cachedir>
</fontconfig>
EOF

export FONTCONFIG_FILE="$tmp/fonts.conf"
fc-cache -f >/dev/null 2>&1

cat > "$tmp/og.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <rect width="1200" height="630" fill="#FFFFFF"/>

  <text x="80" y="122" font-family="Fraunces" font-size="42" fill="#111111">$WORDMARK</text>

  <text x="78" y="330" font-family="Fraunces" font-size="100" letter-spacing="-1.5" fill="#111111">$LINE1</text>
  <text x="78" y="436" font-family="Fraunces" font-size="100" letter-spacing="-1.5" fill="#111111">$LINE2</text>

  <rect x="80" y="506" width="56" height="4" fill="$ACCENT"/>
  <text x="80" y="566" font-family="Inter" font-size="16" letter-spacing="3" fill="#6B6B6B">$EYEBROW</text>
  <text x="1120" y="566" text-anchor="end" font-family="Fraunces" font-size="22" fill="$ACCENT">$DOMAIN</text>
</svg>
SVG

rsvg-convert -w 1200 -h 630 "$tmp/og.svg" -o "$out"
echo "wrote $out"
