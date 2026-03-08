#!/usr/bin/env bash
set -euo pipefail

CMD="${1:-}"
if [[ -z "$CMD" ]]; then
  echo "Usage: scripts/detect.sh <dev|clean>"
  exit 1
fi

has_python() { [[ -f "requirements.txt" || -f "pyproject.toml" ]]; }
has_node()   { [[ -f "package.json" ]]; }
has_rust()   { [[ -f "Cargo.toml" ]]; }
has_go()     { [[ -f "go.mod" ]]; }
has_dotnet() { ls *.sln *.csproj >/dev/null 2>&1; }

run() {
  echo "→ $*"
  bash -lc "$*"
}

case "$CMD" in
  dev)
    if has_python && [[ -f "src/main.py" ]]; then run "python3 src/main.py"; fi
    if has_node; then run "npm run dev"; fi
    if has_rust; then run "cargo run"; fi
    if has_go; then run "go run ./..."; fi
    if has_dotnet; then run "dotnet run"; fi
    ;;
  clean)
    rm -rf __pycache__ .pytest_cache .mypy_cache .ruff_cache .coverage \
      dist build out site .venv node_modules target bin obj \
      *.log logs || true
    ;;
  *)
    echo "Unknown command: $CMD"
    exit 1
    ;;
esac
