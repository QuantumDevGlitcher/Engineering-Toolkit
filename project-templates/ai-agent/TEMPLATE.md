# AI/Agent Template

A skeleton for building LLM apps, agent systems, tool-calling, and RAG pipelines.

## Recommended docs profile
- `research` (enables `docs/design/` + `docs/research/`)

## What this template adds
- `src/agents/` — agent abstractions + orchestration
- `src/tools/` — tool interfaces + safe sample tools
- `src/memory/` — memory interfaces + sample memory
- `src/pipelines/` — RAG + embeddings + evaluation pipelines
- `src/api/` — optional FastAPI skeleton
- `src/cli/` — optional CLI skeleton
- `eval/` — minimal evaluation harness (smoke tests)

## Guardrails (minimum viable)
- Tools must be explicitly allow-listed
- Inputs must be validated
- No `eval()` in tools
- Secrets belong in env/config only
- Prefer deterministic evaluation datasets for regression

## Apply template
``bash
bash scripts/bootstrap.sh --template ai-agent --profile research --cleanup
``
