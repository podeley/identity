# podeley/identity

Capa de identidad compartida por los sitios de [podeley.ar](https://podeley.ar): tipografía,
tokens, el shell (masthead / footer / regla) y el build sin dependencias.

**Este repo es público a propósito.** Los sitios que lo consumen son privados, y un repo
privado no puede bajar archivos de otro repo privado sin token. Acá no hay nada de negocio:
CSS, fuentes y un generador estático.

## Las capas

| archivo | qué trae | quién lo usa |
|---|---|---|
| `kit/tokens.css` | `@font-face` + variables `--pd-*` | todos |
| `kit/chrome.css` | base, `.wrap`, masthead, hero, botones, secciones, footer, la regla | todos |
| `kit/demo.css` | `.figure`, `.findings`, `.datanote`, `.cta`, `.backlink` | demos de una página |
| `kit/layout.html` | el shell HTML con slots `{{...}}` | sitios sobre el build del kit |
| `kit/build.mjs` | generador estático, cero dependencias | sitios sobre el build del kit |
| `kit/fonts/*.woff2` | IBM Plex Sans/Mono + Space Grotesk, subset latino | todos |

Cascada: `tokens` → `chrome` → `demo` → el CSS propio del sitio. `build.mjs` arma los `<link>`
leyendo `src/styles/`, así que agregar una capa no requiere tocar el layout.

## Perfiles

Cada sitio declara uno en `identity.json`:

```json
{ "profile": "demo" }
```

| perfil | qué vendorea | para |
|---|---|---|
| `demo` | tokens + chrome + demo + layout + build + fuentes → `static/fonts` | demos de una página |
| `portfolio` | tokens + chrome + layout + build + fuentes → `static/fonts` | podeley.ar |
| `app` | tokens + chrome + fuentes → `src/fonts` | apps Vite/React que tienen su propio shell |

## Usarlo en un sitio

```bash
cp <este-repo>/kit/sync-identity.mjs tools/sync-identity.mjs
echo '{ "profile": "demo" }' > identity.json
node tools/sync-identity.mjs
```

Los archivos se **vendorean y se commitean**: el build nunca depende de la red. Cuando el kit
cambia, se corre `npm run sync` en cada sitio y se commitea el diff. `npm run sync:check`
falla si el sitio quedó atrasado — sirve para CI.

## Arrancar una demo nueva

Copiá `template/`, que ya viene armado y funcionando:

```bash
cp -r template ../mi-demo && cd ../mi-demo
$EDITOR site.config.json          # origin, repo, backlink al segmento que corresponda
$EDITOR src/pages/index.es.html   # el copy
npm run serve                     # http://localhost:8080
```

`site.config.json` es lo único que difiere entre sitios:

```json
{
  "origin": "https://vm.podeley.ar",
  "repo": "https://github.com/podeley/vm",
  "langs": ["es"],
  "nav": [],
  "backlink": { "href": "https://podeley.ar/ep/", "es": "← podeley.ar" }
}
```

El primer idioma de `langs` se sirve en la raíz; los demás bajo `/<lang>/`. Con un solo idioma
no hay prefijo ni selector.

## La forma de una demo

Una página, siempre igual:

```
hero → regla → figura → tres hallazgos → nota de corte de datos → CTA
```

- **La figura** es lo único pesado. Imagen, `<iframe>` o `<div class="figure-mount">`; el CSS
  le da caja 16:10 en desktop y 3:4 en teléfono.
- **Tres hallazgos**, uno por columna. El tercero suele ser el límite honesto
  (`.finding--limit`): es lo que hace creíbles a los otros dos.
- **La nota de corte** es obligatoria. Sin la fecha a la vista, un dato de 2024 parece un dato
  malo en vez de una invitación a pedir el actualizado.
- **El CTA** es para lo que existe la página. El `subject` del mailto identifica de qué demo
  vino la consulta — es la métrica del funnel.

Presupuesto: **≤ 5 MB de payload publicado**, para que abra con datos móviles.
