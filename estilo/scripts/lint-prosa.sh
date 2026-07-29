#!/usr/bin/env bash
# lint-prosa.sh — chequeo mecánico de la guía de estilo (Capa 1 + parte de Capa 2).
#
#   lint-prosa.sh <ruta> [--perfil demo|research|didactico|ajena] [--no-dup]
#
# Sale con código 1 si encuentra algo. Solo revisa lo que un grep puede ver: números, fechas,
# emoji, densidad, léxico y frases repetidas. Lo estructural (moldes, tics) lo audita la skill.

set -uo pipefail

TARGET="${1:-.}"
PERFIL="research"
CHECK_DUP=1
DUP_INTERNO=0

shift || true
while [ $# -gt 0 ]; do
  case "$1" in
    --perfil) PERFIL="${2:-research}"; shift 2 ;;
    --no-dup) CHECK_DUP=0; shift ;;
    --dup-interno) DUP_INTERNO=1; shift ;;
    -h|--help) sed -n '2,8p' "$0" | sed 's/^# \?//'; exit 0 ;;
    *) echo "opción desconocida: $1" >&2; exit 2 ;;
  esac
done

[ -e "$TARGET" ] || { echo "no existe: $TARGET" >&2; exit 2; }
case "$PERFIL" in
  demo|research|didactico|ajena) ;;
  *) echo "perfil inválido: $PERFIL (demo|research|didactico|ajena)" >&2; exit 2 ;;
esac

OUT=$(mktemp) || exit 2
TMP=$(mktemp) || exit 2
trap 'rm -f "$OUT" "$TMP"' EXIT

# ── archivos con prosa ────────────────────────────────────────────────────────
mapfile -t FILES < <(
  find "$TARGET" \
    \( -name node_modules -o -name .git -o -name .venv -o -name _site -o -name site \
       -o -name dist -o -name build -o -name .cache -o -name __pycache__ \
       -o -name vendor -o -name static -o -name assets -o -name _assets \) -prune -o \
    \( -name '*.md' -o -name '*.mdx' -o -name '*.html' -o -name '*.njk' \) -type f -print \
  | grep -vE '/(CLAUDE|AGENTS)\.md$' \
  | grep -vE '/(paper|preprint|abstract|PREREGISTRATION)\.md$' \
  | grep -vE '/(drafts|paper)/' \
  | sort
)
# Los papers siguen la norma de su venue, no esta guía — ver "Alcance" en SKILL.md.

# Descarta HTML generado por librerías de gráficos (Plotly, Bokeh, Leaflet): es código,
# no prosa, y un solo demo_pozos.html llega a producir miles de falsos positivos.
keep=()
for f in "${FILES[@]}"; do
  [ "$(stat -c%s "$f" 2>/dev/null || echo 0)" -gt 300000 ] && continue
  case "$f" in
    *.html|*.njk) head -c 4000 "$f" | grep -qiE 'plotly|bokeh|leaflet\.js|mapboxgl' && continue ;;
  esac
  keep+=("$f")
done
FILES=("${keep[@]}")

[ ${#FILES[@]} -eq 0 ] && { echo "sin archivos de prosa en $TARGET"; exit 0; }

# Texto plano: saca front-matter, bloques de código, código inline, tags HTML y URLs.
plain() {
  sed -e '1{/^---$/,/^---$/d}' \
      -e '/^[[:space:]]*```/,/^[[:space:]]*```/d' \
      -e 's/`[^`]*`//g' \
      -e 's/<[^>]*>//g' \
      -e 's|(https\?://[^)]*)||g' \
      -e 's/\[\([^]]*\)\]([^)]*)/\1/g' "$1"
}

# Idioma: por sufijo si lo hay, si no por frecuencia de palabras funcionales.
lang_of() {
  case "$(basename "$1")" in
    *.en.*|*_en.*) echo en; return ;;
    *.es.*|*_es.*) echo es; return ;;
  esac
  local t es en
  t=$(plain "$1" | tr '[:upper:]' '[:lower:]')
  es=$(grep -oE '\b(que|de|la|el|los|las|para|con|una|por|se)\b' <<<"$t" | wc -l)
  en=$(grep -oE '\b(the|of|and|to|is|are|that|with|for|from|this)\b' <<<"$t" | wc -l)
  [ "$en" -gt "$es" ] && echo en || echo es
}

# Umbrales por párrafo. El em dash espaciado es rasgo de estilo del corpus, no un defecto:
# se marca recién cuando se acumula. Research tolera una negrita más porque marca términos.
case "$PERFIL" in
  research) MAXDASH=3; MAXNEG=3 ;;
  ajena)    MAXDASH=4; MAXNEG=3 ;;
  *)        MAXDASH=2; MAXNEG=2 ;;
esac

# Glifos funcionales: marcadores de tabla y signos técnicos. No son emoji decorativo.
GLIFOS='✓✔✗✘⚠→←↑↓·×≈±§°⌀…'

# ── por archivo ───────────────────────────────────────────────────────────────
for f in "${FILES[@]}"; do
  lang=$(lang_of "$f")
  plain "$f" > "$TMP"

  # 1. Léxico prohibido (Capa 1 — todos los perfiles, incluido `ajena`).
  if [ "$lang" = es ]; then
    pat='en el mundo actual|en un mundo cada vez|hoy en día|en la era de|es importante destacar|cabe destacar|cabe mencionar|vale la pena señalar|sino que también|solución integral|de vanguardia|de última generación|en constante evolución|aprovechar el poder|sumérgete|descubrí el poder|un antes y un después|revolucionar'
  else
    pat='\bdelve\b|dive into|harness the power|seamless|unlock the|unleash|in today.s (world|fast)|it.s (important to note|worth noting)|\b(furthermore|moreover)\b|at the end of the day|when it comes to|cutting-edge|state-of-the-art|game-chang|tapestry|testament to|treasure trove|navigate the complexities|a wide range of'
  fi
  grep -niE "$pat" "$TMP" 2>/dev/null \
    | awk -F: -v f="$f" '{ ln = $1; sub(/^[0-9]+:[[:space:]]*/, ""); print f ":" ln ": [LEXICO] " substr($0, 1, 68) }' >> "$OUT"

  # 2. Emoji — Capa 2. `ajena` queda exento.
  if [ "$PERFIL" != ajena ]; then
    sed "s/[$GLIFOS]//g" "$TMP" \
      | grep -nP '[\x{1F000}-\x{1FAFF}\x{2600}-\x{27BF}\x{2B00}-\x{2BFF}\x{FE0F}]' 2>/dev/null \
      | cut -d: -f1 \
      | awk -v f="$f" '{ print f ":" $0 ": [EMOJI] emoji en texto publicable — usá → ↓ · × en su lugar" }' >> "$OUT"
  fi

  # 3. Decimal con coma. Misma regla en los dos idiomas: el decimal va con punto.
  #    Solo se mira cuando la cifra lleva % o unidad, para no marcar fechas ni listas.
  #    Exactamente 3 dígitos tras la coma es un separador de miles correcto (`1,680 km²`),
  #    no un decimal mal escrito — por eso se piden 1-2 decimales, o 4 o más.
  grep -nE '[0-9]+,[0-9]{1,2}([^0-9]| ?)%|[0-9]+,([0-9]{1,2}|[0-9]{4,}) ?(km|m²|km²|mm|ha|MW|MMBtu|USD)\b' "$TMP" 2>/dev/null \
    | awk -F: -v f="$f" '{ print f ":" $1 ": [DECIMAL] decimal con coma — va punto, también en español" }' >> "$OUT"

  # 3b. Miles con punto. Ambiguo por diseño: bajo la convención inglesa `19.671` también es un
  #     decimal válido, así que solo se puede señalar y pedir revisión.
  #     Dos filtros contra el falso positivo que importa — un decimal de tres cifras:
  #       · solo en archivos en español (un texto en inglés ya no usa punto de miles);
  #       · nunca si arranca en `0.`, que es decimal seguro (p-values, correlaciones).
  #     Sin esto la regla destruye resultados: `0.043` y `0.697` son p-values, no miles.
  if [ "$lang" = es ]; then
    #  Una longitud de onda (`2.165 µm`, banda Al-OH) es decimal, nunca miles.
    grep -nE '\b[1-9][0-9]{0,2}\.[0-9]{3}\b([^0-9]|$)' "$TMP" 2>/dev/null \
      | grep -vE '[0-9]\.[0-9]{3} ?(µm|um|nm)' \
      | grep -viE 'v[0-9]|versión|version|python|node|figura|tabla|sección|§|p *[=<>]|r *=|https?://|doi\.org|10\.[0-9]{4}/' \
      | awk -F: -v f="$f" '{ print f ":" $1 ": [MILES] ¿separador de miles con punto? — revisar; los miles van con coma (19,671)" }' >> "$OUT"
  fi

  # 4. Porcentaje pegado a la cifra, en los dos idiomas.
  grep -nE '[0-9] %' "$TMP" 2>/dev/null \
    | awk -F: -v f="$f" '{ print f ":" $1 ": [PORCENTAJE] porcentaje separado — va pegado (15%)" }' >> "$OUT"

  # 5. Mes capitalizado en fecha española.
  if [ "$lang" = es ]; then
    grep -nE '(Enero|Febrero|Marzo|Abril|Mayo|Junio|Julio|Agosto|Septiembre|Octubre|Noviembre|Diciembre) +(de +)?[0-9]{4}|[0-9]{1,2} +(de +)?(Enero|Febrero|Marzo|Abril|Mayo|Junio|Julio|Agosto|Septiembre|Octubre|Noviembre|Diciembre)' "$TMP" 2>/dev/null \
      | awk -F: -v f="$f" '{ print f ":" $1 ": [FECHA] mes en mayúscula — en español va minúscula" }' >> "$OUT"
  fi

  # 6. Em dash mal formado.
  grep -nE '[[:alnum:]]—|—[[:alnum:]]|[[:alnum:]] -- ' "$TMP" 2>/dev/null \
    | awk -F: -v f="$f" '{ print f ":" $1 ": [EMDASH] em dash sin espaciar o \"--\" — va \" — \"" }' >> "$OUT"

  # 7. Densidad de negrita y em dash por párrafo. Tablas, headers y citas no cuentan.
  awk -v file="$f" -v maxdash="$MAXDASH" -v maxneg="$MAXNEG" '
    function flush(   nb, nd, p) {
      if (para == "") return
      p = para
      nb = gsub(/\*\*/, "&", p) / 2
      nd = gsub(/ — /, "&", p)
      if (nb > maxneg)  printf "%s:%d: [NEGRITA] %d énfasis en un párrafo — máximo %d\n", file, start, nb, maxneg
      if (nd > maxdash) printf "%s:%d: [EMDASH] %d em dash en un párrafo — máximo %d\n", file, start, nd, maxdash
      para = ""
    }
    /^[[:space:]]*$/          { flush(); next }
    /^[[:space:]]*[|#>]/      { flush(); next }
    /^[[:space:]]*[-*+] /     { flush(); next }
    { if (para == "") start = NR; para = para " " $0 }
    END { flush() }
  ' "$TMP" >> "$OUT"

  # 8. Oraciones largas — Capa 2, solo perfil demo.
  if [ "$PERFIL" = demo ]; then
    awk -v file="$f" '
      /^[[:space:]]*[|#>]/ { next }
      {
        n = split($0, s, /[.:;?!] /)
        for (i = 1; i <= n; i++) {
          w = split(s[i], junk, /[[:space:]]+/)
          if (w > 40) printf "%s:%d: [LARGA] oración de %d palabras — máximo 40 en perfil demo\n", file, NR, w
        }
      }
    ' "$TMP" >> "$OUT"
  fi
done

# ── frases repetidas ENTRE PROYECTOS ──────────────────────────────────────────
# Repetir una frase entre páginas de un mismo sitio es chrome normal (CTA, footer, nav).
# El problema es la frase que cruza de un sitio a otro: "Cuatro casos, todos en línea".
# Por eso se agrupa por proyecto — el primer componente del path relativo al TARGET.
if [ "$CHECK_DUP" -eq 1 ] && [ ${#FILES[@]} -gt 1 ]; then
  pairs=$(mktemp); dups=$(mktemp)
  trap 'rm -f "$OUT" "$TMP" "$pairs" "$dups"' EXIT

  base="${TARGET%/}"
  # Auditando un solo sitio se tolera más ruido, así que baja el umbral y entran
  # frases cortas como "Cuatro casos, todos en línea".
  if [ "$DUP_INTERNO" -eq 1 ]; then MINW=5; MINC=25; else MINW=7; MINC=40; fi
  for f in "${FILES[@]}"; do
    # El 404 espeja el índice a propósito; los README de proyectos hermanos comparten
    # skeleton y son notas de build, no copy publicable.
    case "$(basename "$f")" in 404.*|README.md) continue ;; esac
    rel="${f#"$base"/}"
    case "$rel" in
      */*) proj="${rel%%/*}" ;;
      *)   proj="." ;;   # archivos sueltos en el target: es un solo proyecto, no uno por archivo
    esac
    [ "$DUP_INTERNO" -eq 1 ] && proj="$f"     # agrupa por archivo: audita dentro de un sitio
    plain "$f" \
    | tr '.:;!?' '\n' \
    | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/[[:space:]]\+/ /g' \
          -e 's/^[-*+#>|[:space:]]*//' \
    | awk -v file="$f" -v proj="$proj" -v minw="$MINW" -v minc="$MINC" '
        NF >= minw && length($0) >= minc {
          s = tolower($0)
          # La bio es la única repetición obligatoria — ver "Anti-molde" en SKILL.md.
          if (s ~ /años en energía|years in energy|these tools myself|herramientas las construyo/) next
          print s "\t" proj "\t" file
        }'
  done | sort -u > "$pairs"

  cut -f1,2 "$pairs" | sort -u | cut -f1 | uniq -d > "$dups"

  while IFS= read -r phrase; do
    [ -n "$phrase" ] || continue
    projs=$(awk -F'\t' -v p="$phrase" '$1 == p { print $2 }' "$pairs" | sort -u | paste -sd', ')
    first=$(awk -F'\t' -v p="$phrase" '$1 == p { print $3; exit }' "$pairs")
    printf '%s: [DUPLICADA] "%.55s…" — también en: %s\n' "$first" "$phrase" "$projs" >> "$OUT"
  done < "$dups"
fi

# ── salida ────────────────────────────────────────────────────────────────────
if [ ! -s "$OUT" ]; then
  echo "✓ ${#FILES[@]} archivos, perfil $PERFIL — sin hallazgos mecánicos."
  echo "  Falta la auditoría estructural: ver 'Antes de entregar' en SKILL.md."
  exit 0
fi

sort -t: -k1,1 -k2,2n "$OUT"
echo
echo "$(wc -l < "$OUT") hallazgos en ${#FILES[@]} archivos (perfil $PERFIL)."
exit 1
