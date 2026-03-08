# ===========================
# Engineering-Toolkit Makefile (company-grade)
# ===========================

# Defaults for bootstrap-ps (Windows)
TEMPLATE ?= backend-service
PROFILE  ?= app
CLEANUP  ?= 0

.PHONY: help doctor bootstrap bootstrap-ps setup dev test lint format docs docs-build clean factory-clean

help:
	@echo "Targets:"
	@echo "  doctor        Repo sanity check (missing files, mode, warnings)"
	@echo "  bootstrap     Apply a project template + docs profile (bash/rsync)"
	@echo "  bootstrap-ps  Apply a project template via PowerShell (Windows, no WSL)"
	@echo "               Usage: make bootstrap-ps TEMPLATE=backend-service PROFILE=app CLEANUP=1"
	@echo "  setup         Setup dev environment (best-effort)"
	@echo "  dev           Run dev command (best-effort, stack-aware)"
	@echo "  test          Run tests (FAILS on failure)"
	@echo "  lint          Run linters (FAILS on failure)"
	@echo "  format        Run formatters (best-effort)"
	@echo "  docs          Serve docs (if mkdocs present)"
	@echo "  docs-build    Build docs (if mkdocs present)"
	@echo "  clean         Cleanup common artifacts (safe)"
	@echo "  factory-clean DANGEROUS: removes factory-only assets (requires YES)"

doctor:
	@bash scripts/doctor.sh

bootstrap:
	@bash scripts/bootstrap.sh

bootstrap-ps:
	@powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1 -Template "$(TEMPLATE)" -Profile "$(PROFILE)" $(if $(filter 1,$(CLEANUP)),-Cleanup,)

setup:
	@bash scripts/setup-dev.sh

dev:
	@bash scripts/detect.sh dev

test:
	@bash scripts/run-tests.sh

lint:
	@bash scripts/lint.sh

format:
	@bash scripts/format.sh

docs:
	@bash scripts/build-docs.sh serve

docs-build:
	@bash scripts/build-docs.sh build

clean:
	@bash scripts/detect.sh clean

factory-clean:
	@bash scripts/factory-clean.sh