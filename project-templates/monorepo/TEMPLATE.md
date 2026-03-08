# Monorepo Template

A **polyglot monorepo** skeleton designed to scale from a few packages to many.

## Governance and docs
This template assumes the repository already includes:
- Governance (.github templates, labels, CODEOWNERS, policies) — Bundles 1–2
- Universal docs system (`docs/`) — Bundle 4
- Universal automation scripts (`scripts/`) — Bundle 7
- CI/CD workflows — Bundle 8

## Structure
- `apps/` — deployable applications/services
- `packages/` — shared JS/TS packages (optional)
- `crates/` — Rust crates (optional)
- `python/` — Python packages (optional)
- `shared/` — shared schemas/configs (language-agnostic)
- `workspace/` — workspace configs (choose what you actually use)

## How to use
1) Apply the template:
``bash
bash scripts/bootstrap.sh --template monorepo --profile app --cleanup
``

2. Choose ONE workspace ecosystem per language:
- JS/TS: Nx or Turborepo
- Rust: Cargo workspace
- Python: Poetry workspace
- Polyglot: combine as needed (keep files under workspace/)

3. Remove folders you won’t use (optional).

## CI strategy

Default CI runs repo-wide via `scripts/lint.sh` and `scripts/run-tests.sh`.
You can optionally enable “affected-only” mode for Nx/Turbo later.

## Versioning strategy (recommended default)

Hybrid:

- apps can follow a shared release cadence
- libraries can version independently if they’re reusable externally

Record the decision in an ADR early:
`docs/architecture/adr/ADR-0001-versioning-strategy.md`
