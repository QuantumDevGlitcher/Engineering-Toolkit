# Evaluation

This folder contains minimal evaluation datasets and notes.

## Dataset format (JSONL)
Each line is an object with:
- `id`: unique test id
- `input`: input string
- `expected_contains`: list of substrings expected in output

## Why this exists
- regression testing for agent behavior
- basic benchmarking harness (expand later)

Start with `datasets/smoke.jsonl`.
