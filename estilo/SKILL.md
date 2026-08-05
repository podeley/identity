---
name: estilo
description: "Guía de estilo de prosa para texto publicable — sitios, landings, papers, docs, cursos, informes y copy comercial, en español e inglés. Usala antes de escribir, reescribir, acortar, traducir o revisar cualquier texto que lea una persona."
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
| `demo` | `demo`, `portfolio` | `sat-*`, `podeley.ar` | hero de una oración; léxico del dominio sin traducir (Capa 2, regla 10); bloque de límite obligatorio; registro impersonal en ES (Capa 2, regla 9) |
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
9. **Nada de em dash en prosa, en ningún idioma ni perfil.** Es el tic más reconocible de la
   redacción con IA (decisión del 2026-08-03; antes la guía lo permitía espaciado). El inciso
   va entre comas, entre paréntesis o después de dos puntos. El `—` sobrevive solo como
   separador en `<title>` y metadata ("CV — Matías Podeley"); el en dash de rangos (regla 8)
   no cambia. Nunca `--`.
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
9. **Registro por perfil, en español** (decisión del 2026-08-03: el público de petróleo y
   minería es mayor y formal). En `demo` comercial — podeley.ar y los `sat-*` — el lector no
   se conjuga: construcciones con "se", CTAs en infinitivo ("Escribir", "Agendar 20 minutos"),
   posesivo "su" donde haga falta. Nada de "podés", "escribime", "tu equipo". Sin usted
   explícito. Bios y CV en estilo nominal: "simulación de yacimientos", no "simulé
   yacimientos". `didactico` mantiene el voseo. Excepción explícita: la página research de
   podeley.ar conserva el voseo — su público es otro. Los `sat-*` se migran al tocarlos,
   como la convención numérica. En inglés no cambia nada: "you" es neutro. Segunda
   excepción (decisión del 2026-08-04): el hero de /perfil/ va en primera persona del
   singular ("Trabajé", "aplico") — suena humano y es su página. La bio canónica sigue
   nominal, y el lector sigue sin conjugarse.
10. **El lector trabaja en el dominio** (decisión del 2026-08-04; antes `demo` pedía "cero
    jerga sin traducir"). Cada página se escribe para el que ya entiende del tema: EUR,
    linepack, parent-child, screening, nominación van sin traducir en `demo` y `research`.
    Se expande solo lo que ese lector no maneja. La perífrasis divulgativa ("cuánta roca se
    movió" por "volumen excavado") se tolera en el H1 como gancho; en el cuerpo va el
    término del rubro.

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

**El argumento no se subraya.** Se dice una vez por página, donde más pesa. El mensaje
"fuentes a la vista / auditables / para rehacer la cuenta" aparece entre 3 y 6 veces en cada
página de podeley.ar (contado el 2026-08-04). A la tercera repetición el lector ya no lee el
argumento: lee el pedido de prompt que ordenó enfatizarlo.

**El remate se raciona.** "Mide movimiento, no causa", "está declarado, no corregido". Cada
uno vale; cuando cada tarjeta y cada párrafo cierran con sentencia, la página suena a
percusión de copy. Presupuesto: un giro "no X sino Y" y dos remates por página, y solo para
los que cargan un dato o un límite. Tres familias se van enteras (decisión del 2026-08-04,
segunda pasada de podeley.ar): la promesa de método ("lo que no alcance para una conclusión
se avisa antes de que salga la campaña"), el cierre de credencial en copetes ("del lado que
toma las decisiones") y el aforismo de cierre ("Nadie lo conoce como quien lo opera").

**El título-fórmula de tarjeta.** Infinitivo + beneficio + "sin / antes de" + costo evitado:
"Comparar declinación y EUR sin comprar datos", "Priorizar blancos antes de pagar la campaña",
"Seguir la expansión de un salar sin pisar el terreno". Las diez tarjetas de podeley.ar salen
de ese molde (2026-08-04). La fórmula es buena; diez veces es formulario. Que al menos la
mitad de los títulos diga otra cosa: el hallazgo, el número, la herramienta.

**La bio es la única excepción a todo lo anterior.** Tiene que ser idéntica en todos lados. Hay
dos variantes canónicas, y son distintas a propósito:

*Comercial* (home, ep, minería, energía, ciber — nominal e impersonal desde 2026-08-03; el
cierre carga el oficio desde 2026-08-04, cuando él bajó la etiqueta "consultoría de datos e IA"
por under sell: lo que vende es criterio, no información):
> Matías Podeley. Ingeniero del ITBA, dieciocho años en energía: cuatro de operación en
> Neuquén, simulación de yacimientos gigantes como Camisea, evaluación de proyectos
> petroquímicos, respaldo técnico a compras de activos por más de US$ 300 millones y cinco
> años de docencia en evaluación de proyectos. El oficio detrás de este sitio: entender la
> necesidad de negocio, y armar el proyecto o la herramienta que la resuelve, con IA y
> fuentes auditables. Buenos Aires.

*Research* (research.es.html — conserva el tono propio de esa página):
> Matías Podeley. Dieciocho años en energía en Argentina: ingeniería de reservorios, después
> desarrollo de negocio. Hoy, investigación independiente en interpretabilidad. Buenos Aires.

Sus versiones en inglés viven en las páginas `.en` correspondientes de `podeley.ar/src/pages/`.
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

> "El Capítulo IV se publica con 13.5 meses de rezago, y lo que pasa abajo no se publica
> nunca."

(El ejemplo anterior acá era "Argentina no tiene catastro minero nacional". Se retiró del
corpus el 2026-08-05: era demasiado absoluto — SIGAM publica una vista con ese nombre — y lo
factual gana a lo retórico. Chequeá el hecho antes de preservar la apertura.)

Una por página. El mismo giro repetido en cada párrafo deja de ser apertura y pasa a ser
molde: el presupuesto está en Anti-molde.

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
- ¿Cuántas veces repite la página su argumento de venta? Una.
- ¿Cuántas tarjetas o párrafos cierran con remate o giro "no X sino Y"? Más de dos es percusión.
- ¿Hay algún término del dominio perifraseado para lego? Devolvé el término.
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

Calibración de referencia, para saber cuándo el que está mal es el linter: podeley.ar ya migró
(em dash y voseo en cero); los research todavía no, y ahí EMDASH marca cada guion largo desde que
la regla pasó de "densidad" a "prohibido" (2026-08-03) — decenas de hallazgos por sitio es lo
esperable hasta que se migren, al tocarlos. En los `demo` viejos lo que queda es casi todo
numérico: el corpus en español está escrito con la convención vieja (`19.671`, `66,4%`, `15 %`)
y se migra a la inglesa a medida que se toca cada sitio. VOSEO corre solo con `--perfil demo` y
no aplica a las páginas research de podeley.ar.

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
