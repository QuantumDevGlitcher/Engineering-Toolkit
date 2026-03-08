#!/usr/bin/env bash
set -euo pipefail

has_python() { [[ -f "requirements.txt" || -f "pyproject.toml" ]]; }
has_node()   { [[ -f "package.json" ]]; }
has_rust()   { [[ -f "Cargo.toml" ]]; }
has_go()     { [[ -f "go.mod" ]]; }

ran_any=false

if has_python; then
  ran_any=true
  if command -v ruff >/dev/null 2>&1; then
    echo "→ ruff check"
    ruff check .
  elif command -v flake8 >/dev/null 2>&1; then
    echo "→ flake8"
    flake8 .
  else
    echo "Python lint tool not found (install ruff or flake8)."
    exit 1
  fi
fi

if has_node; then
  ran_any=true
  echo "→ npm run lint"
  npm run lint
fi

if has_rust; then
  ran_any=true
  echo "→ cargo clippy"
  cargo clippy -- -D warnings
fi

if has_go; then
  ran_any=true
  if command -v golangci-lint >/dev/null 2>&1; then
    echo "→ golangci-lint run"
    golangci-lint run
  else
    echo "golangci-lint not found."
    exit 1
  fi
fi

if [[ "$ran_any" == "false" ]]; then
  echo "No lint runner detected."
  exit 0
fi
