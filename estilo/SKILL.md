---
name: estilo
description: "Guía de estilo de prosa para todo texto publicable — sitios, landings, docs de research, papers, READMEs, cursos, informes y copy comercial, en español y en inglés. Usala antes de escribir o editar cualquier texto que vaya a leer una persona — hero, landing, página, artículo, blog, abstract, resumen ejecutivo, brochure, propuesta, MDX de curso, docs de MkDocs. También al reescribir, acortar, traducir o revisar texto existente. Palabras que la disparan — escribir, redactar, reescribir, copy, texto, prosa, landing, hero, informe, paper, artículo, guía de estilo, tono, voz, write, draft, rewrite, prose, landing page, report, style guide, tone of voice."
---

# Guía de estilo — prosa publicable

Dos capas. **Capa 1 (Mecánica)** aplica a todo, incluidos proyectos de marca ajena. **Capa 2
(Voz)** aplica solo a research y sitios propios.

## Alcance

Aplica a: `docs/*.md` de los sitios MkDocs, `src/pages/*.html` de podeley.ar y `sat-*`,
`src/content/*.mdx` de los cursos, `*.njk`, READMEs públicos, drafts de papers, informes,
brochures, propuestas.

No aplica a: comentarios de código, mensajes de commit, notas internas, planes, CLAUDE.md,
prompts. Ahí escribí como quieras.

Los papers académicos siguen la norma de su venue cuando choca con esta guía. La norma del venue
gana siempre.

### Perfiles

Mirá el `identity.json` del repo si existe, o inferí por el tipo de proyecto:

| perfil de prosa | `identity.json` | proyectos | qué cambia |
|---|---|---|---|
| `demo` | `demo`, `portfolio` | `sat-*`, `podeley.ar` | hero de una oración; cero jerga sin traducir; bloque de límite obligatorio |
| `research` | `mkdocs` | los 14 MkDocs de `research/`, `sat-subsidencia`, papers | tolera notación y densidad técnica; sección de límites obligatoria; pasiva refleja permitida en método |
| `didactico` | — | `curso-ia-energia`, `satelites-eo`, `interpretabilidad-mecanicista`, el curso de `estado-red-gas` | segunda persona con voseo; siglas siempre expandidas; metáforas que no mienten |
| `ajena` | — | `nomadaligners-v2` y futuros clientes | **solo Capa 1**. La voz la define el CLAUDE.md del repo, no esta guía |

Ante la duda entre `demo` y `research`: si el texto termina en un CTA, es `demo`.

---

## Capa 1 — Mecánica

Aplica a todos los perfiles, sin excepción.

1. **Una sola convención numérica en los dos idiomas: la inglesa.** Decimal con punto, miles con
   coma — `19,671`, `66.4%`, `1.5 mm/año`. También en español.
2. Esto se aparta de la norma RAE a propósito. La decisión es que un número se escriba igual en
   la página `.es` y en la `.en`, para que no haya que reformatear al traducir ni convivan dos
   sistemas en un mismo sitio bilingüe. Consecuencia asumida: en español, `19.671` ya no
   significa diecinueve mil — significa diecinueve coma seiscientos setenta y uno.
3. Porcentaje pegado a la cifra en ambos idiomas: `15%`.
4. Unidad separada de la cifra por un espacio: `282 km²`, `20 mm`, `48 × 35 km`. Signo `×` real
   para dimensiones, no la letra `x`.
5. Fechas en prosa española: `27 de mayo de 2026`. El mes va **siempre** en minúscula.
6. Fechas en prosa inglesa: `May 27, 2026`.
7. Fechas en datos, metadata, front-matter y nombres de archivo: ISO `2026-05-27`.
8. Rangos con en dash y sin espacios: `2014–2026`, `El Indio–Pascua`, `páginas 12–18`.
9. Em dash espaciado como inciso: `texto — inciso — texto`. Nunca `--`, nunca pegado.
   Máximo uno por párrafo en `research`, dos en `demo`.
10. Comillas rectas `"` en todo. No migres a `«»` ni a `“”`.
11. Siglas: primera mención expandida con la sigla entre paréntesis, después solo la sigla.
    Excepción en `research` y `demo` para las del dominio (InSAR, DEM, ASTER, SWIR, MAPE).
    En `didactico` se expanden siempre, sin excepción.
12. Títulos y encabezados en sentence case, en los dos idiomas: "Cómo se procesa", no "Cómo Se
    Procesa". Sin punto final.
13. Negrita: un énfasis por idea, máximo dos por párrafo. Nunca una oración entera en negrita.
    Cinco negritas en un párrafo no enfatizan nada.
14. Nada de léxico de relleno. La lista con reemplazos está en `references/antislop.md`.

---

## Capa 2 — Voz

Solo `research`, `demo` y `didactico`. **No** aplica a `ajena`.

1. Media de oración por debajo de 25 palabras. En `demo`, ninguna supera 40.
2. Un tema por párrafo. Máximo cinco oraciones.
3. Voz activa por defecto. La pasiva refleja ("se mide", "se promedia la serie") está permitida
   solo en la sección de método de `research`.
4. Cifra antes que adjetivo. Un adjetivo evaluativo sin un número que lo sostenga se borra:
   no "resultados muy precisos" sino "a 20 y 80 metros de la huella mapeada".
5. Todo texto publicable declara sus límites, y el límite dice qué **no** se puede afirmar —
   no qué falta hacer.
6. La primera oración dice qué es la cosa. No por qué importa, no a quién le sirve.
7. Cero emoji. Glifos tipográficos sí: `→ ↓ · ×`.
8. Sin metadiscurso. Nada de "en este artículo veremos", "como mencionamos antes", "es
   importante destacar", "a continuación", "vale la pena señalar".

---

## Anti-molde

Esta es la parte que más importa acá, porque es el problema real del corpus: no hay palabras de
IA, hay **plantillas repetidas**. Siete sitios que corren el riesgo de leerse como el mismo molde
rellenado con datos distintos.

**No reuses la estructura "2 hallazgos + 1 límite".** Las cinco landings `sat-*` la tienen
idéntica. La cantidad de bloques `finding` la fija lo que el caso da: dos, tres o cuatro.
Obligatorio es el límite, no su posición ni su cantidad.

**No reuses frases entre sitios.** "Cuatro casos, todos en línea" está verbatim en `ep.es.html:21`
y `mineria.es.html:21`. El bloque `<h2>Tres reglas.</h2>` está triplicado palabra por palabra en
podeley.ar. Si una frase ya existe en otro sitio, escribí otra.

**Un header-fórmula por sitio, no más.** "Qué es X (en una línea)" aparece en cuatro `metodo.md`
distintos; "Por qué importa" en cinco archivos. Preferí headers que digan algo:

> `sat-exploracion/src/pages/index.es.html:34` — "Re-encuentra las minas conocidas, a ciegas"

Ese header ya carga el hallazgo. "Por qué importa" no carga nada.

**La bio es la única excepción a todo lo anterior.** Tiene que ser idéntica en todos lados. Hay
dos variantes canónicas, y son distintas a propósito:

*Comercial* (ep, minería, energía):
> Matías Podeley. Dieciocho años en energía — ingeniería de reservorios, después desarrollo de
> negocio, casi siempre del lado que contrata a los especialistas. Estas herramientas las
> construyo yo, con datos públicos e IA. Buenos Aires.

*Research* (research.es.html):
> Matías Podeley. Dieciocho años en energía en Argentina — ingeniería de reservorios, después
> desarrollo de negocio. Hoy, investigación independiente en interpretabilidad. Buenos Aires.

Sus versiones en inglés están en `podeley.ar/src/pages/*.en.html:79` y `research.en.html:49`.
Siempre "Dieciocho años en energía", nunca "18 años en la industria del petróleo y gas" — esa
forma quedó solo en `curso-ia-energia/docs/` y hay que corregirla cuando se toque ese repo.

---

## Qué preservar

La prosa de este corpus ya hace bien cinco cosas difíciles. La guía no está para pisarlas.

**Cifras concretas en lugar de adjetivos.** "19.671 derechos, 22 millones de hectáreas". "135
fechas entre 2014 y 2026, con el 85% del área coherente". Vende con números verificables.

**El límite como sección fija, no como disclaimer.** El bloque `finding--limit` y los admonitions
"Lo que NO se puede afirmar todavía". Y su mejor versión, en `podeley.ar/src/pages/mineria.es.html:50`:
"La deformación existe pero es chica, cerca del piso de ruido. Se publica igual."

**Metáforas que explican sin mentir**, bajo el lema declarado en
`assembled-thought/docs/explained.es.md:3` — *"Simple, pero sin mentir"*. Si la metáfora obliga a
decir algo falso, no sirve.

**Aperturas que niegan la expectativa.** Problema → giro → consecuencia, sin muletilla previa:

> "La espectrometría satelital no encuentra la mena: encuentra la huella de alteración que dejan
> los sistemas que forman yacimientos."

> "Argentina no tiene catastro minero nacional: cada provincia publica el suyo con formato
> distinto, y varias no publican nada."

**Voz auto-consciente sobre el género del texto.** Decirle al lector qué está por leer calibra
expectativas y es lo más humano que hay: *"This is the chronological lab notebook — technical and
unpolished by design."*

---

## Antes de entregar

Un grep no puede ver nada de esto. Auditalo a mano:

- ¿Esta estructura ya la usé en otro sitio? Si sí, cambiala.
- ¿Alguna oración de este texto existe verbatim en otro proyecto? (Salvo la bio.)
- ¿Cada adjetivo evaluativo tiene su número al lado? Si no, borralo.
- ¿El límite dice qué **no** se puede afirmar, o solo qué falta hacer?
- ¿La primera oración define, o promociona?
- ¿Cuántas negritas hay en el párrafo más cargado?
- Si es inglés: ¿está escrito, o traducido? Leelo buscando estructuras del español.

Después corré el chequeo mecánico:

```bash
~/.claude/skills/estilo/scripts/lint-prosa.sh <ruta> [--perfil demo|research|didactico|ajena]
```

Flags: `--dup-interno` busca frases repetidas entre páginas del **mismo** sitio (por defecto solo
marca las que cruzan de un proyecto a otro, que es lo que importa — repetir el CTA o el footer
entre páginas de un sitio es normal). `--no-dup` saltea ese chequeo.

El linter ignora por diseño: papers (`paper.md`, `drafts/`, `preprint.md` — mandan las normas de
su venue), HTML generado por Plotly o Leaflet, `assets/`, y los glifos funcionales `✓ ✗ ⚠ → ·`
que no son emoji decorativo. Un `README.md` se revisa pero no entra al chequeo de frases
repetidas, porque los repos hermanos comparten skeleton a propósito.

Calibración de referencia, para saber cuándo el que está mal es el linter: los sitios `demo` dan
entre 2 y 3 hallazgos, los de research entre 24 y 40. En research domina NEGRITA y EMDASH, que es
la densidad que la guía quiere bajar. En los `demo` lo que queda es casi todo numérico: el corpus
en español está escrito con la convención vieja (`19.671`, `66,4%`, `15 %`) y se migra a la
inglesa a medida que se toca cada sitio.

`[MILES]` es la única regla ambigua por diseño: bajo la convención inglesa `19.671` es un decimal
legítimo, así que el linter solo puede señalar el patrón y pedir revisión. Por eso solo corre en
archivos en español, y descarta lo que nunca es un separador de miles: números que arrancan en
`0.` (p-values y correlaciones — `0.043`, `0.697`), longitudes de onda (`2.165 µm`), DOIs y URLs.

**Al convertir números de un texto viejo, mirá el idioma primero.** Un archivo en inglés ya usa
esta convención: aplicarle una conversión da vuelta el significado de cada separador y corrompe
los datos en silencio. Y un `1,680 km²` con tres dígitos tras la coma es un miles correcto, no un
decimal mal escrito.

## Referencias

Cargalas solo cuando las necesites:

- `references/es.md` — voseo, rioplatense, números y fechas en español
- `references/en.md` — US spelling, cómo no calcar del español
- `references/antislop.md` — léxico prohibido ES/EN con reemplazos
