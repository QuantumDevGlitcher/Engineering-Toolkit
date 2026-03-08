#!/usr/bin/env bash
set -euo pipefail

SNIPPET="${1:-}"
TARGET=".gitignore"

if [[ -z "$SNIPPET" || ! -f "$SNIPPET" ]]; then
  echo "Usage: scripts/merge-gitignore.sh <path-to-.gitignore.snippet>"
  exit 1
fi

touch "$TARGET"

MARKER_START="# --- template snippet start: $(basename "$(dirname "$SNIPPET")") ---"
MARKER_END="# --- template snippet end ---"

if grep -qF "$MARKER_START" "$TARGET"; then
  echo "Snippet already merged into $TARGET"
  exit 0
fi

{
  echo ""
  echo "$MARKER_START"
  cat "$SNIPPET"
  echo "$MARKER_END"
} >> "$TARGET"

echo "Merged $SNIPPET into $TARGET"
