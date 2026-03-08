#!/usr/bin/env bash
set -euo pipefail

# Engineering-Toolkit doctor
# - Exits 1 if it finds errors (missing critical files)
# - Exits 0 if only warnings

RED="\033[31m"; YELLOW="\033[33m"; GREEN="\033[32m"; NC="\033[0m"

errors=()
warnings=()

has() { [[ -e "$1" ]]; }

add_error() { errors+=("$1"); }
add_warn() { warnings+=("$1"); }

is_factory_repo() {
  [[ -d ".github/ISSUE_TEMPLATE" ]] && [[ -d ".github/workflows" ]] && [[ -d "scripts" ]] && [[ -d "docs" ]] && [[ -d "project-templates" ]]
}

is_public_repo_hint() {
  # Heuristic: public template usually has CODE_OF_CONDUCT.md
  [[ -f "CODE_OF_CONDUCT.md" ]]
}

check_required() {
  local path="$1"
  if ! has "$path"; then add_error "Missing: $path"; fi
}

check_optional() {
  local path="$1"
  if ! has "$path"; then add_warn "Missing (optional): $path"; fi
}

echo "=== Engineering-Toolkit Doctor ==="
echo

# Mode detection
if is_factory_repo; then
  echo -e "Mode: ${GREEN}FACTORY${NC} (template repo)"
else
  echo -e "Mode: ${YELLOW}PRODUCT${NC} (project repo)"
fi

# Basic hygiene
if [[ -d ".idea" ]]; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1 && git check-ignore -q .idea/ 2>/dev/null; then
    add_warn "Found .idea/ but it is ignored (OK). Consider deleting it in the FACTORY repo for cleanliness."
  else
    add_warn "Found .idea/ and it is NOT ignored (do NOT commit IDE settings; add to .gitignore or remove before push)"
  fi
fi

# rsync check (bootstrap.sh uses rsync)
if ! command -v rsync >/dev/null 2>&1; then
  add_warn "rsync not found. On Windows use bootstrap.ps1; on Linux/mac use bootstrap.sh"
fi

# Required root files (governance core)
check_required "README.md"
check_required "CONTRIBUTING.md"
check_required "REPOSITORY_POLICIES.md"
check_required "REVIEW_GUIDELINES.md"
check_required "SECURITY.md"
check_required "RELEASING.md"
check_required "SUPPORT.md"
check_required "labels.yml"
check_required "Makefile"

# Required GitHub dirs/files
check_required ".github/ISSUE_TEMPLATE"
check_required ".github/PULL_REQUEST_TEMPLATE"
check_required ".github/workflows"
check_required ".github/CODEOWNERS"
check_required ".github/labeler.yml"
check_required ".github/dependabot.yml"

# Required workflows (Bundle 8 + labels)
check_required ".github/workflows/ci.yml"
check_required ".github/workflows/docs.yml"
check_required ".github/workflows/release.yml"
check_required ".github/workflows/codeql.yml"
check_required ".github/workflows/dependency-audit.yml"
check_required ".github/workflows/auto-label.yml"
check_required ".github/workflows/sync-labels.yml"

# Required scripts (Bundle 7 + our additions)
check_required "scripts/bootstrap.ps1"
check_required "scripts/bootstrap.sh"
check_required "scripts/detect.sh"
check_required "scripts/run-tests.sh"
check_required "scripts/lint.sh"
check_required "scripts/format.sh"
check_required "scripts/build-docs.sh"
check_required "scripts/setup-dev.sh"
check_required "scripts/docs-profile.sh"
check_required "scripts/merge-gitignore.sh"
check_required "scripts/factory-clean.sh"
check_required "scripts/doctor.sh"

# Docs system (Bundle 4) – core checks (some are optional depending on your bundle content)
check_required "docs/README.md"
check_required "docs/architecture/adr"
check_optional "docs/architecture/adr/adr-template.md"
check_optional "docs/architecture/adr/index.md"
check_optional "docs/overview/project-overview.md"
check_optional "docs/architecture/architecture-overview.md"

# Template library checks (only for FACTORY mode)
if is_factory_repo; then
  check_required "project-templates/backend-service"
  check_required "project-templates/machine-learning"
  check_required "project-templates/cli-tool"
  check_required "project-templates/library"
  check_required "project-templates/gamedev"
  check_required "project-templates/monorepo"
  check_required "project-templates/ai-agent"
else
  # In PRODUCT repos it's fine if templates are gone
  if [[ -d "project-templates" ]]; then
    add_warn "project-templates/ exists in PRODUCT repo. If this is a real project, consider running bootstrap with -Cleanup or make factory-clean."
  fi
fi

# Auto-label trigger sanity (public vs pro heuristic)
if has ".github/workflows/auto-label.yml"; then
  if is_public_repo_hint; then
    if ! grep -q "pull_request_target" ".github/workflows/auto-label.yml"; then
      add_warn "Public repo hint detected (CODE_OF_CONDUCT.md exists) but auto-label.yml does not use pull_request_target."
    fi
  else
    if ! grep -q "pull_request" ".github/workflows/auto-label.yml"; then
      add_warn "Pro/private repo hint detected (no CODE_OF_CONDUCT.md) but auto-label.yml may not use pull_request."
    fi
  fi
fi

echo
if ((${#errors[@]} > 0)); then
  echo -e "${RED}Errors:${NC}"
  for e in "${errors[@]}"; do echo "  - $e"; done
fi

if ((${#warnings[@]} > 0)); then
  echo -e "${YELLOW}Warnings:${NC}"
  for w in "${warnings[@]}"; do echo "  - $w"; done
fi

echo
if ((${#errors[@]} > 0)); then
  echo -e "${RED}Doctor result: FAIL${NC}"
  exit 1
else
  echo -e "${GREEN}Doctor result: OK${NC} (warnings: ${#warnings[@]})"
  exit 0
fi