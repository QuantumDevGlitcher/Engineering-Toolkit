# CLI Tool Template

A skeleton for building robust CLI tools with a thin CLI layer and testable core.

## Recommended docs profile
- `lib` (enables `docs/design/` only)

## What this template provides
- `src/cli/` — entrypoint + argument parsing
- `src/commands/` — command implementations (thin)
- `src/core/` — business logic (testable)
- `src/utils/` — helpers
- tests split: unit + integration

## Notes
- Keep CLI thin. Put logic in `src/core/`.
- Provide usage examples in root README and/or docs.
