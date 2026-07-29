# Léxico prohibido

El corpus está limpio hoy. Esta lista existe para que siga así, no para corregir un problema
existente. Verificado con grep sobre todos los `.md`, `.html`, `.njk` y `.mdx`: cero ocurrencias
de casi todo lo que sigue.

La única excepción encontrada: `furthermore` en
`gravity-information-paper/research/deprecated_gemma/08_graviton_amplitudes.md:85` — carpeta
generada por un modelo y ya marcada como deprecada.

## Español

| no | sí |
|---|---|
| en el mundo actual, hoy en día, en la era de | (borralo — casi nunca aporta) |
| en un mundo cada vez más… | (borralo) |
| es importante destacar, cabe destacar, cabe mencionar | decí el hecho y ya |
| vale la pena señalar, no está de más aclarar | (borralo) |
| a continuación veremos, en este artículo | (borralo) |
| no solo… sino que también | dos oraciones, o "y" |
| en resumen (dentro de un párrafo) | como header `## En resumen` está bien |
| revolucionar, transformar radicalmente | qué hace, concretamente |
| potenciar, impulsar, empoderar | qué hace, concretamente |
| solución integral, solución robusta | qué resuelve, con qué límite |
| de vanguardia, de última generación, innovador | el dato técnico que lo prueba |
| en constante evolución | (borralo) |
| aprovechar el poder de | usar |
| sumérgete, descubrí el poder de | (borralo) |
| permite optimizar procesos | qué proceso, cuánto |
| un antes y un después | (borralo) |
| clave, fundamental, esencial (como relleno) | el número que lo justifica |
| exhaustivo, riguroso, profundo (sin evidencia) | qué se hizo exactamente |

## Inglés

| no | sí |
|---|---|
| delve into, dive into | examine, look at |
| leverage (as a verb) | use |
| harness the power of | use |
| seamless, seamlessly | qué hace sin fricción, concretamente |
| unlock, unleash | enable, allow |
| landscape (metafórico) | market, field, set of tools |
| in today's world, in today's fast-paced | (borralo) |
| it's important to note, it's worth noting | decí el hecho |
| furthermore, moreover, additionally | "and", o punto y aparte |
| at the end of the day | (borralo) |
| when it comes to X | "for X" |
| cutting-edge, state-of-the-art, game-changing | el benchmark que lo prueba |
| tapestry, testament to, treasure trove | (borralo) |
| robust (como elogio vago) | ok cuando es técnico: "statistically robust null" |
| comprehensive, holistic | qué cubre exactamente |
| empower, elevate | qué permite hacer |
| navigate the complexities of | (borralo) |
| a wide range of | el número |

`robust` y `leverage` tienen uso técnico legítimo — "causal leverage" es término estándar en
interpretabilidad, "statistically robust null" es preciso. La prohibición es para el uso
decorativo.

## Tics estructurales

Más difíciles de ver que las palabras, y más dañinos.

**La tríada obligatoria.** Tres bullets, tres reglas, tres beneficios, tres adjetivos. Si tenés
cuatro cosas que decir, decí cuatro. Si tenés dos, decí dos.

**El párrafo que abre con conector.** "Además,", "Por otro lado,", "Sin embargo," al inicio de
párrafo tras párrafo. Un conector cada tanto está bien; como patrón, delata plantilla.

**El cierre que resume lo recién dicho.** Si el párrafo tiene cuatro oraciones, la quinta no
tiene que repetirlas.

**Los headers-fórmula.** "Por qué importa", "Qué es X (en una línea)", "Cómo funciona",
"Beneficios", "Introducción" / "Conclusión". Un header debería cargar información:
"Re-encuentra las minas conocidas, a ciegas" contra "Por qué importa".

**El paralelismo forzado.** Tres bloques con la misma estructura sintáctica exacta. Suena a
formulario.

**El hedge apilado.** "podría potencialmente sugerir que quizás". Elegí un solo nivel de
incertidumbre y sosténelo.

**La simetría falsa positivo/negativo.** Dos ventajas y una limitación, siempre, en ese orden.
Es el molde de las cinco landings `sat-*`. La cantidad la fija el caso, no la plantilla.

## Emoji

Cero en `demo`, `research` y `didactico`. Glifos tipográficos sí: `→ ↓ · × ≈ ±`.

En perfil `ajena` se permiten si la marca los usa — `nomadaligners-v2` tiene 98 y le funcionan
al público de pacientes.
