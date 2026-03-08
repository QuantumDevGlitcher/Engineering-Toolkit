# Releasing

This repository follows **Semantic Versioning (SemVer)**.

## Versioning

- MAJOR — breaking changes
- MINOR — new features
- PATCH — bug fixes

## Release Steps

1. Ensure `main` is green (CI passing).
2. Update `CHANGELOG.md`.
3. Tag the release:
```bash
git tag vX.Y.Z
git push origin vX.Y.Z
```
4. Optionally create a GitHub Release from the tag.
