#!/usr/bin/env bash
set -euo pipefail

is_factory_repo() {
  [[ -d ".github/ISSUE_TEMPLATE" ]] && \
  [[ -d "project-templates" ]] && \
  [[ -f "README.md" ]] && \
  grep -qi "engineering-toolkit" README.md
}

echo "DANGER: factory-clean will remove factory-only assets (e.g., project-templates/)."
echo "Intended for PRODUCT repos created from the template."
echo ""

if is_factory_repo; then
  echo "⚠️  FACTORY repo detected (this looks like the template repo)."
  echo "Running factory-clean here is usually a mistake."
  echo ""
  read -r -p "Type I_UNDERSTAND to continue anyway: " CONFIRM_FACTORY
  if [[ "$CONFIRM_FACTORY" != "I_UNDERSTAND" ]]; then
    echo "Aborted."
    exit 1
  fi
  echo ""
fi

read -r -p "Type YES to continue: " CONFIRM
if [[ "$CONFIRM" != "YES" ]]; then
  echo "Aborted."
  exit 1
fi

rm -rf project-templates || true
echo "✅ factory-clean complete (project-templates/ removed)."