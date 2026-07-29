#!/usr/bin/env bash
# Enlaza esta carpeta como skill de Claude Code en ~/.claude/skills/estilo.
#
# Symlink, no copia: la fuente de verdad queda en este repo y se versiona. Editás acá, y la
# skill que usa Claude cambia sola — sin paso de sync que se olvide.

set -euo pipefail

# -f en las dos puntas: en esta máquina /home/matias es un symlink a /var/home/matias, y sin
# normalizar ambos lados la comparación de idempotencia da siempre distinto.
SRC="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
DEST="${CLAUDE_HOME:-$HOME/.claude}/skills/estilo"

mkdir -p "$(dirname "$DEST")"

if [ -L "$DEST" ]; then
  [ "$(readlink -f "$DEST")" = "$SRC" ] && { echo "ya enlazada → $SRC"; exit 0; }
  echo "reemplazando symlink previo: $(readlink "$DEST")"
  rm "$DEST"
elif [ -e "$DEST" ]; then
  echo "ERROR: $DEST existe y no es un symlink." >&2
  echo "Movelo o borralo a mano antes de correr esto — no piso archivos que no creé." >&2
  exit 1
fi

ln -s "$SRC" "$DEST"
echo "skill enlazada: $DEST → $SRC"

GLOBAL="${CLAUDE_HOME:-$HOME/.claude}/CLAUDE.md"
if [ ! -e "$GLOBAL" ]; then
  cp "$SRC/CLAUDE.global.md" "$GLOBAL"
  echo "CLAUDE.md global instalado: $GLOBAL"
else
  echo "nota: ya existe $GLOBAL — no lo toqué."
  echo "      Sin el puntero a la skill que trae CLAUDE.global.md, la guía carga solo si"
  echo "      el pedido matchea su description. Comparalos si algo no se dispara."
fi
