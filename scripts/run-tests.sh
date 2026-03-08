#!/usr/bin/env bash
set -euo pipefail

has_python() { [[ -f "requirements.txt" || -f "pyproject.toml" ]]; }
has_node()   { [[ -f "package.json" ]]; }
has_rust()   { [[ -f "Cargo.toml" ]]; }
has_go()     { [[ -f "go.mod" ]]; }
has_dotnet() { ls *.sln *.csproj >/dev/null 2>&1; }

ran_any=false

if has_python; then
  ran_any=true
  echo "→ pytest"
  python3 -m pytest -q
fi

if has_node; then
  ran_any=true
  echo "→ npm test"
  npm test
fi

if has_rust; then
  ran_any=true
  echo "→ cargo test"
  cargo test
fi

if has_go; then
  ran_any=true
  echo "→ go test ./..."
  go test ./...
fi

if has_dotnet; then
  ran_any=true
  echo "→ dotnet test"
  dotnet test
fi

if [[ "$ran_any" == "false" ]]; then
  echo "No test runner detected. (Add one of: requirements.txt/pyproject.toml, package.json, Cargo.toml, go.mod, *.sln/*.csproj)"
  exit 0
fi
