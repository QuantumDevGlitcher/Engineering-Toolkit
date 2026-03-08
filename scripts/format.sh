#!/usr/bin/env bash
set -euo pipefail

has_python() { [[ -f "requirements.txt" || -f "pyproject.toml" ]]; }
has_node()   { [[ -f "package.json" ]]; }
has_rust()   { [[ -f "Cargo.toml" ]]; }
has_go()     { [[ -f "go.mod" ]]; }

if has_python; then
  if command -v ruff >/dev/null 2>&1; then
    echo "→ ruff format"
    ruff format .
  elif command -v black >/dev/null 2>&1; then
    echo "→ black"
    black .
  else
    echo "Python formatter not found (install ruff or black)."
  fi
fi

if has_node; then
  echo "→ npm run format (if exists)"
  npm run format || true
fi

if has_rust; then
  echo "→ cargo fmt"
  cargo fmt
fi

if has_go; then
  echo "→ gofmt"
  gofmt -w .
fi
