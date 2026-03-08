# Machine Learning Template

A skeleton for ML projects with reproducibility and clear separation of concerns.

## Recommended docs profile
- `research` (enables `docs/design/` + `docs/research/`)

## What this template provides
- `src/` organized by data/features/models/training/inference
- `notebooks/` for exploration (keep clean, link results into docs)
- `experiments/` structure for configs/results/logs
- `pipelines/` scripts for training/inference/evaluation
- tests split: unit/integration/regression
- `data/` and `models/` as artifact folders (usually ignored)

## Notes
- Keep raw/processed data out of git.
- Record model/metric decisions via ADRs when significant.
- Keep experiments reproducible (configs + deterministic seeds when possible).
