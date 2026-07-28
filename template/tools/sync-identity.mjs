/* sync-identity.mjs — vendors the podeley identity kit into this repo.
   Zero dependencies. Copy this file to tools/sync-identity.mjs in each site.

   The kit lives in the PUBLIC repo podeley/identity precisely so that private
   repos can pull it over plain HTTPS with no token. Files are vendored and
   committed, so a build never depends on the network.

     node tools/sync-identity.mjs            # pull and write
     node tools/sync-identity.mjs --check    # fail if out of date (for CI)
     node tools/sync-identity.mjs --profile=app

   Profile comes from identity.json ({"profile":"demo"}) or --profile:
     demo       one-page demo on the kit build   → styles + demo.css + build + layout + fonts
     portfolio  podeley.ar itself                → styles + build + layout + fonts
     app        a Vite/React app keeping its own shell → styles + fonts only
*/

import { readFile, writeFile, mkdir, access } from 'node:fs/promises'
import { dirname, join } from 'node:path'

const BASE = process.env.IDENTITY_BASE ||
  'https://raw.githubusercontent.com/podeley/identity/main/kit'

const FONTS = [
  'ibm-plex-mono-400.woff2',
  'ibm-plex-mono-500.woff2',
  'ibm-plex-sans-400.woff2',
  'space-grotesk-500.woff2',
]

const PROFILES = {
  demo: { styles: ['tokens.css', 'chrome.css', 'demo.css'], fonts: 'static/fonts', shell: true },
  portfolio: { styles: ['tokens.css', 'chrome.css'], fonts: 'static/fonts', shell: true },
  app: { styles: ['tokens.css', 'chrome.css'], fonts: 'src/fonts', shell: false },
}

const args = process.argv.slice(2)
const check = args.includes('--check')
const flag = args.find((a) => a.startsWith('--profile='))?.split('=')[1]

let profile = flag
if (!profile) {
  try {
    profile = JSON.parse(await readFile('identity.json', 'utf8')).profile
  } catch {
    /* fall through to the error below */
  }
}
if (!PROFILES[profile]) {
  console.error(
    `Unknown profile ${JSON.stringify(profile)}. Set {"profile":"demo"} in identity.json ` +
      `or pass --profile=<${Object.keys(PROFILES).join('|')}>.`,
  )
  process.exit(2)
}
const spec = PROFILES[profile]

/* what → where */
const plan = [
  ...spec.styles.map((f) => [`${f}`, `src/styles/${f}`]),
  ...FONTS.map((f) => [`fonts/${f}`, `${spec.fonts}/${f}`]),
]
if (spec.shell) plan.push(['build.mjs', 'build.mjs'], ['layout.html', 'src/layout.html'])

/* raw.githubusercontent caches for ~5 min, so a sync run right after a kit push
   silently vendors the previous version. A query param busts it; the files are
   small and we compare bytes, so re-downloading costs nothing. */
const CACHE_BUST = `?cb=${process.hrtime.bigint().toString(36)}`

async function pull(remote) {
  const res = await fetch(`${BASE}/${remote}${CACHE_BUST}`, { cache: 'no-store' })
  if (!res.ok) throw new Error(`${remote}: HTTP ${res.status} from ${BASE}`)
  return Buffer.from(await res.arrayBuffer())
}

const changed = []
const stale = []

for (const [remote, local] of plan) {
  const next = await pull(remote)
  let current = null
  try {
    if (await access(local).then(() => true, () => false)) current = await readFile(local)
  } catch {
    /* treat as missing */
  }
  const same = current && current.equals(next)
  if (same) continue

  if (check) {
    stale.push(local)
    continue
  }
  await mkdir(dirname(local), { recursive: true })
  await writeFile(local, next)
  changed.push(`${current ? 'updated' : 'added  '}  ${local}`)
}

if (check) {
  if (stale.length) {
    console.error(`identity kit out of date (${stale.length}):\n  ${stale.join('\n  ')}`)
    console.error('\nrun: node tools/sync-identity.mjs')
    process.exit(1)
  }
  console.log(`identity kit up to date (profile: ${profile})`)
} else {
  console.log(changed.length ? changed.join('\n') : 'already up to date')
  console.log(`\nprofile: ${profile} · ${plan.length} files checked`)
  if (changed.length) console.log('remember to commit the vendored files')
}
