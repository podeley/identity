#!/usr/bin/env python3
"""Shrink the standalone Leaflet/Folium maps exported by the case pipelines.

Those exports are heavy for one reason only: every raster the map draws is a
matplotlib PNG inlined as base64. Two shapes show up in practice —

    "png": "iVBORw0KGgo..."              # one entry per slider frame
    "data:image/png;base64,iVBORw0..."   # a single ImageOverlay

Re-encoding those rasters as WebP cuts the documents by ~5x. The base64 payload
is replaced in place, so the surrounding JavaScript keeps working; the only
other edit is the `data:image/png` media type literal, which has to follow the
payload.

Quality defaults to 85, picked by measuring both shapes against the originals:
alpha survives untouched at every setting, and the RGB error is symmetric noise
(no colour shift) that reads as a loss of speckle texture. q80 left the maps
visibly paler — 11.5% of rendered pixels off by more than 8/255. q85 halves
that to 6.2% and still lands the worst case, a 31-frame slider, at 4.5 MB.
q90 looks the same as q85 and pushes that slider past 5 MB.

GeoJSON coordinates are written at full float precision (15+ decimals). They
are rounded to 5, which is ~1 m — well below what any of these maps resolve.

Usage:
    slim-map.py MAP.html [MAP.html ...] [-i] [-q 85]

Without -i the result goes to MAP.slim.html and the input is left alone.
"""

import argparse
import base64
import io
import re
import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    sys.exit("Falta Pillow: pip install Pillow")

PNG_MAGIC = b"\x89PNG\r\n\x1a\n"

# base64 payload behind an explicit media type
DATA_URI = re.compile(r"data:image/png;base64,([A-Za-z0-9+/]+={0,2})")
# a bare JSON string long enough to be a raster; the key it hangs off varies
BARE_B64 = re.compile(r'"([A-Za-z0-9+/]{500,}={0,2})"')
# folium writes coordinates at full float repr; nothing else in these files does
LONG_FLOAT = re.compile(r"-?\d+\.\d{7,}")


def to_webp(payload: str, quality: int) -> str | None:
    """Re-encode a base64 PNG as base64 WebP. None if it isn't a PNG."""
    try:
        raw = base64.b64decode(payload, validate=True)
    except Exception:
        return None
    if not raw.startswith(PNG_MAGIC):
        return None
    buf = io.BytesIO()
    Image.open(io.BytesIO(raw)).convert("RGBA").save(
        buf, "WEBP", quality=quality, method=4
    )
    return base64.b64encode(buf.getvalue()).decode("ascii")


def slim(html: str, quality: int) -> tuple[str, int]:
    """Return the shrunk document and how many rasters were converted."""
    converted = 0

    def swap(match: re.Match) -> str:
        nonlocal converted
        webp = to_webp(match.group(1), quality)
        if webp is None:
            return match.group(0)
        converted += 1
        # keep whatever wrapped the payload, replace only the payload itself
        return match.group(0).replace(match.group(1), webp)

    html = DATA_URI.sub(swap, html)
    html = BARE_B64.sub(swap, html)

    # Only safe once every raster above is WebP, which is why it comes last.
    if converted:
        html = html.replace("data:image/png;base64,", "data:image/webp;base64,")

    html = LONG_FLOAT.sub(lambda m: f"{float(m.group(0)):.5f}", html)
    return html, converted


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("maps", nargs="+", type=Path)
    ap.add_argument("-i", "--in-place", action="store_true")
    ap.add_argument("-q", "--quality", type=int, default=85)
    args = ap.parse_args()

    failed = False
    for path in args.maps:
        if not path.is_file():
            print(f"  {path}: no existe", file=sys.stderr)
            failed = True
            continue

        html = path.read_text(encoding="utf8", errors="replace")
        if "data:image/webp;base64," in html:
            print(f"  {path.name}: ya convertido, se saltea")
            continue

        before = len(html)
        html, converted = slim(html, args.quality)
        after = len(html)

        out = path if args.in_place else path.with_suffix(".slim.html")
        out.write_text(html, encoding="utf8")

        ratio = before / after if after else 1
        print(
            f"  {path.name}: {before / 1e6:.2f} MB → {after / 1e6:.2f} MB "
            f"(x{ratio:.1f}, {converted} raster{'s' if converted != 1 else ''}"
            f" a WebP q{args.quality})"
            + ("" if args.in_place else f" → {out.name}")
        )

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
