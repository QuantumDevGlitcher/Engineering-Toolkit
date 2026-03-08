#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   scripts/bootstrap.sh --template backend-service --profile app --cleanup
#
# Templates live in: project-templates/<template>/
# Docs profiles: app | lib | research | game

TEMPLATE=""
PROFILE=""
CLEANUP="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --template) TEMPLATE="${2:-}"; shift 2 ;;
    --profile) PROFILE="${2:-}"; shift 2 ;;
    --cleanup) CLEANUP="true"; shift 1 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

if [[ -z "$TEMPLATE" || -z "$PROFILE" ]]; then
  echo "Usage: scripts/bootstrap.sh --template <backend-service|machine-learning|cli-tool|library|gamedev/unity|gamedev/unreal|gamedev/godot> --profile <app|lib|research|game> [--cleanup]"
  exit 1
fi

SRC_DIR="project-templates/$TEMPLATE"
if [[ ! -d "$SRC_DIR" ]]; then
  echo "Template not found: $SRC_DIR"
  exit 1
fi

echo "→ Applying template: $TEMPLATE"
echo "→ Docs profile: $PROFILE"

# Copy template files into repo root (but do NOT overwrite existing files)
if command -v rsync >/dev/null 2>&1; then
  rsync -av --ignore-existing "$SRC_DIR"/ ./
else
  echo "rsync not found. Install rsync or use bootstrap.ps1 on Windows."
  exit 1
fi

# Merge .gitignore snippet if present
if [[ -f "$SRC_DIR/.gitignore.snippet" ]]; then
  bash scripts/merge-gitignore.sh "$SRC_DIR/.gitignore.snippet"
fi

# Apply docs profile switch (creates optional docs folders only)
bash scripts/docs-profile.sh "$PROFILE"

echo "✅ Bootstrap complete."

if [[ "$CLEANUP" == "true" ]]; then
  echo "→ Cleanup: removing project-templates/ folder"
  rm -rf project-templates/
  echo "✅ Cleanup complete."
fi
