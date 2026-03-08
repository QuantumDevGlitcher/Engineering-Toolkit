# Contributing Guide

This repository uses a **trunk-based light workflow** with short-lived branches and strong governance.

## Branching Model

- `main` — always protected and deployable
- Short-lived branches:
  - `feature/*`
  - `fix/*`
  - `docs/*`
  - `refactor/*`
  - `research/*`

Optional:
- `develop` — **disabled by default**
  - Only enable for multi-dev integration or planned releases.
  - If enabled, it must have the **same protections as `main`**.

## Workflow

1. Open an issue using the correct template.
2. Create a short-lived branch from `main`.
3. Use Conventional Commits.
4. Open a PR using the correct PR template.
5. Ensure CI passes and respond to review feedback.

## Architecture Changes

- Use the **Architecture Proposal** issue form.
- Add an ADR under `docs/architecture/adr/`.
- Get approval from code owners before merging.

## Guidelines (Non-blocking)

- Keep PRs small and focused.
- Avoid mixing concerns.
- Update documentation when behavior changes.
