#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
if [[ "$MODE" != "serve" && "$MODE" != "build" ]]; then
  echo "Usage: scripts/build-docs.sh <serve|build>"
  exit 1
fi

if ! command -v mkdocs >/dev/null 2>&1; then
  echo "mkdocs not installed. Skipping docs ${MODE}."
  exit 0
fi

if [[ "$MODE" == "serve" ]]; then
  echo "→ mkdocs serve"
  mkdocs serve
else
  echo "→ mkdocs build"
  mkdocs build
fi
