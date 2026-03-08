# Repository Policies

## Branch Protection (Enforced)

- No direct pushes to `main`.
- PR required for all changes.
- CI status checks required.
- Force pushes and deletions blocked.
- Require conversation resolution.
- If `develop` exists, it has the same protections as `main`.

## Trunk-Based Light

- `main` is always deployable.
- Short-lived branches only.
- `develop` is optional and disabled by default.

## Pull Requests (Enforced)

- Must use a PR template.
- CI must pass.
- Tests required for code changes.
- Architecture changes require an ADR in `docs/architecture/adr/`.

## Documentation & Mixing Concerns (Guidelines)

- Update docs when relevant.
- Avoid mixing features, refactors, and docs in one PR.
