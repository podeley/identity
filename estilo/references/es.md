# Español rioplatense

Todo el material publicado usa voseo. Es deliberado y es universal en el corpus — solo estaba
documentado de pasada, en `curso-ia-energia/CLAUDE.md:36`. Acá queda escrito.

## Voseo

Imperativo con acento en la última sílaba y sin la `-d` final:

| en vez de | escribí |
|---|---|
| toca, mira, escríbeme | tocá, mirá, escribime |
| pon, ven, ten, sal, haz | poné, vení, tené, salí, hacé |
| elige, prueba, empieza | elegí, probá, empezá |
| descubre, aprende, envía | descubrí, aprendé, enviá |
| piensa, recuerda, contáctanos | pensá, acordate, escribinos |

Presente: `podés`, `querés`, `tenés`, `sabés`, `hacés`, `sos`, `vas`, `venís`, `decís`.
Nunca `puedes`, `quieres`, `tienes`, `eres`.

Pronombre `vos`, no `tú`. Posesivo `tu` / `tuyo` (eso no cambia). Nunca `vosotros`, `os`, `vuestro`.

Reflexivos e imperativos con pronombre: `acordate`, `fijate`, `quedate`, `llevátelo`, `escribime`.
No `acuérdate`, `fíjate`.

## Léxico

Rioplatense real, no neutro de doblaje:

`celular` (no móvil) · `computadora` (no ordenador) · `subte` (no metro) · `auto` (no coche) ·
`plata` (no dinero, en registro informal) · `laburo` solo en registro muy informal ·
`a pedido` (no bajo demanda) · `pileta` (no piscina) · `pozo` (no perforación, en contexto O&G)

Evitá los españolismos: `vale`, `chaval`, `ordenador`, `móvil`, `coger`, `zumo`, `gilipollas`.

Evitá también el neutro plano de traducción: `sitio web` está bien, `página de aterrizaje` no —
decí `landing`. Los términos técnicos que la industria usa en inglés se dejan en inglés
(`upstream`, `midstream`, `screening`, `dataset`, `pipeline`), sin comillas ni cursiva.

## Cómo se trata al lector

Segunda persona directa, de igual a igual, sin solemnidad:

> "¿Tenés un área que querés acotar?"
> "Tocá el gráfico para verlo en grande →"

Primera del plural solo cuando hay equipo real detrás. En trabajo individual, primera del
singular: "Estas herramientas las construyo yo".

En `research`, la pasiva refleja está bien en la sección de método ("Se mide la deformación",
"Promediando la serie…"). Pero cuando el texto explica para lector general, volvé al voseo —
`assembled-thought/docs/explained.es.md` lo hace bien: "Podés imaginarlo como…".

## Números

**Se usa la convención inglesa, también en español.** Es una decisión deliberada contra la norma
RAE: el objetivo es que un número se escriba igual en la página `.es` y en la `.en`, sin
reformatear al traducir y sin dos sistemas conviviendo en un sitio bilingüe.

- Decimal con **punto**: `66.4%`, `1.5 mm/año`, `0.94`.
- Miles con **coma**: `19,671`, `1,500`, `22,000,000`. Sin separador en años: `2026`.
- Porcentaje **pegado**: `15%`, `66.4%`.
- Unidad separada: `282 km²`, `48 × 35 km`, `20 mm/año`.
- Rangos con en dash: `2014–2026`, `1 a 2,5 mm/año` (con "a" cuando hay unidad ambigua).
- Números del uno al nueve en letras cuando no son medidas: "tres reglas", "quince blancos".
  Con unidad o precisión, siempre en cifras: `3 km`, `9,2%`.

## Fechas

- Prosa: `27 de mayo de 2026`. **El mes va en minúscula, siempre.**
- Mes y año solos: `mayo de 2026`. No `Mayo 2026` — hay 15 casos así en `edimburgo-2026`.
- Datos, metadata, front-matter, nombres de archivo: ISO `2026-05-27`.
- Nunca `6-jun-2026` ni formatos mixtos.
- Décadas: `los años noventa` o `la década de 1990`. No `los 90s`.

## Acentuación que se escapa

`sólo` ya no lleva tilde (la RAE la eliminó). El corpus tiene casos de `sólo` en
`sat-exploracion` — se corrigen cuando se toque el archivo.

`este`, `ese`, `aquel` tampoco llevan tilde como pronombres. `guion`, `truhan`, `fie` van sin
tilde. `qué`, `cómo`, `dónde`, `cuál` la llevan siempre en interrogativas e indirectas
("no sé cómo se procesa").
