#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
if [[ -z "$PROFILE" ]]; then
  echo "Usage: scripts/docs-profile.sh <app|lib|research|game>"
  exit 1
fi

enable_dir() { mkdir -p "$1"; }

case "$PROFILE" in
  app)
    enable_dir docs/design
    enable_dir docs/operations
    ;;
  lib)
    enable_dir docs/design
    ;;
  research)
    enable_dir docs/design
    enable_dir docs/research
    ;;
  game)
    enable_dir docs/design
    ;;
  *)
    echo "Unknown profile: $PROFILE"
    exit 1
    ;;
esac

echo "Docs profile applied: $PROFILE"
