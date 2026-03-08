#!/usr/bin/env bash
set -euo pipefail

echo "Setting up development environment (best-effort)..."

if [[ -f "requirements.txt" || -f "pyproject.toml" ]]; then
  if [[ ! -d ".venv" ]]; then
    python3 -m venv .venv
  fi
  # shellcheck disable=SC1091
  source .venv/bin/activate || true
  python3 -m pip install -U pip
  if [[ -f "requirements.txt" ]]; then
    pip install -r requirements.txt
  fi
fi

if [[ -f "package.json" ]]; then
  npm install
fi

if [[ -f "Cargo.toml" ]]; then
  cargo build
fi

echo "Environment setup complete."
