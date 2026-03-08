# Backend Service Template

A skeleton for building production-grade backend services (REST/GraphQL/gRPC/WebSockets).

## Recommended docs profile
- `app` (enables `docs/design/` + `docs/operations/`)

## What this template provides
- `src/api/` — transport layer (controllers, routes, handlers)
- `src/core/` — core business logic (domain/use-cases)
- `src/services/` — service layer (orchestration, integrations)
- `src/models/` — DTOs / schemas / persistence models (project-dependent)
- `src/utils/` — shared utilities
- `config/` — environment-based configuration
- `tests/` — unit + integration layout
- `docker/` — optional containerized local dev

## Notes
- Never commit secrets. Use `.env.example` and `config/secrets.example.yaml`.
- Major architecture decisions must have ADRs (`docs/architecture/adr/`).
- Prefer small PRs, fast CI, and clear acceptance criteria.

## Quick start (example)
- Fill `.env` from `.env.example`
- Implement app entrypoint in your stack (not provided here)
- Add CI test command in your chosen language
