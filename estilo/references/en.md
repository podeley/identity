# English

US spelling. The audience for the research sites and papers is international, and American
spelling dominates ML and geoscience publishing.

## Spelling

`-ize` not `-ise`: analyze, normalize, organize, recognize, prioritize.
`-or` not `-our`: color, behavior, favor, labor.
`-er` not `-re`: meter, center, fiber, liter.
`-og` not `-ogue`: catalog, dialog (but `analogue` when contrasting with digital).

Single `l` in past tenses: modeled, labeled, traveled, canceled.
`defense`, `license` (verb and noun), `practice` (both), `program`, `gray`, `aluminum`, `sulfur`.

## Write it, don't translate it

This is the rule that matters most. English written from Spanish reads like a translation even
when every word is correct. There is good precedent in the corpus —
`podeley.ar/src/pages/mineria.en.html:79` doesn't calque the bio, it rewrites it.

**False friends that show up when writing from Spanish:**

| Spanish | wrong | right |
|---|---|---|
| actualmente | actually | currently |
| eventualmente | eventually | possibly, if needed |
| realizar | realize | carry out, perform |
| asistir a | assist | attend |
| pretender | pretend | intend, aim to |
| sensible | sensible | sensitive |
| eficiente / eficaz | efficient (for both) | efficient vs effective |
| constatar | constate | confirm, verify |
| a partir de | starting from | from, based on |
| en base a | in base to | based on |
| permite + inf. | allows to do X | lets you do X, makes X possible |

**Calqued structures to avoid:**

- "In this work we present…" → say what it is. "Every correlational comparison is null under controls."
- "It is worth mentioning that…" → delete the clause, keep the fact.
- "The same allows us to…" (calque of *el mismo*) → name the thing again.
- "In the case of X…" (calque of *en el caso de*) → "For X…" or restructure.
- "Due to the fact that" → "because".
- Long pre-verbal subjects. Spanish tolerates them; English doesn't. Move the verb up.

**Watch the article.** Spanish drops and adds articles differently. "Data shows" not "the data
shows" when generic; "the Sentinel-1 archive" needs its article.

## Mechanics

- Decimal point, thousands comma: `19,671`, `66.4%`, `1.5 mm/year`.
- Percent tight: `15%`.
- These are the numeric conventions for **both** languages — the Spanish side follows English
  here on purpose, so a figure needs no reformatting when a page is translated. See `es.md`.
- Dates in prose: `May 27, 2026`. In data and front-matter: ISO `2026-05-27`.
- Ranges with en dash, no spaces: `2014–2026`.
- Oxford comma, always: "reservoir engineering, business development, and research".
- Sentence case in headings, same as Spanish.
- Units with a space: `282 km²`, `48 × 35 km`.

## Register by profile

**`demo`** — contractions are fine and make it sound human: "it doesn't find the ore", "here's
what it can't do". Second person direct.

**`research`** — no contractions in papers and abstracts; they're fine in lab notebooks and
findings docs, which are deliberately informal. First person plural for methods ("we intervene on
the workspace") is standard in ML papers and reads better than the passive.

**`didactico`** — second person, contractions, every acronym expanded on first use.

## Terms that stay as they are

Don't translate industry vocabulary into English when it's already English in Spanish:
`upstream`, `midstream`, `screening`, `dataset`, `pipeline`, `shale`, `pad`, `workover`.

Don't translate Spanish proper nouns: `Vaca Muerta`, `Puna`, `El Indio–Pascua`, `Mina Pirquitas`.
Gloss on first mention if the reader needs it: "the Puna, the high-altitude plateau of
northwestern Argentina".
