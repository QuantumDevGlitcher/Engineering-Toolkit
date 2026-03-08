# Engineering-Toolkit Guide 101

This is the onboarding guide for the Engineering-Toolkit template ecosystem.

If you’re new here: read this first.

---

## ✅ The Golden Rule (do not skip)

There are **two types of repos**:

1) **FACTORY repo** = the template itself (Engineering-Toolkit / Engineering-Toolkit-Pro)
2) **PRODUCT repo** = a repo created *from* the template (your real projects)

**Golden Rule:**
- In the **FACTORY repo**, you **must NOT** run bootstrap with `-Cleanup`.
- In **PRODUCT repos**, you **should** run bootstrap with `-Cleanup`.

Why:
- `-Cleanup` removes `project-templates/` (by design).  
  That is correct for products, but it destroys the factory.

---

## 0) What is this repo?

Engineering-Toolkit is an enterprise-grade **project factory**:
- Governance (issues, PR templates, policies, CODEOWNERS, labels)
- Automation (bootstrap + scripts)
- CI/CD workflows
- Universal documentation system (docs + ADRs)
- A library of project templates (backend, ML, CLI, library, gamedev, monorepo, ai-agent)

The template lets you start any new repo with a professional baseline in minutes.

---

## 1) Public vs Pro (why 2 repos)

### Engineering-Toolkit (Public)
- Intended for open-source / forks
- Uses safer automation patterns for untrusted PRs

### Engineering-Toolkit-Pro (Private)
- Intended for trusted collaborators
- Allows stronger automations safely

**Important:** both repos share the same structure, but some workflows differ.

---

## 2) How to create a new repo

### Option A — GitHub UI (recommended)
1) Open the template repo on GitHub
2) Click **Use this template**
3) Create your new repository (PRODUCT repo)

Then clone it locally and continue with bootstrap.

---

## 3) Bootstrap (choose only what you need)

This template contains many project templates. In a PRODUCT repo you pick one and apply it.

### Windows (recommended)
```powershell
.\scripts\bootstrap.ps1 -Template "backend-service" -Profile "app" -Cleanup
```

### Git Bash / Linux / macOS
```bash
bash scripts/bootstrap.sh --template backend-service --profile app --cleanup
```

### Common templates

- backend service:
    - `--template backend-service --profile app`
- machine learning:
    - `--template machine-learning --profile research`
- ai/agent:
    - `--template ai-agent --profile research`
- monorepo:
    - `--template monorepo --profile app`
- library:
    - `--template library --profile lib`
- cli:
    - `--template cli-tool --profile lib`
- gamedev:
    - `--template gamedev/unity --profile game` (or unreal/godot)

---

## 4) What each top-level folder does

### `.github/`

GitHub-native governance:

- Issue templates (bug/feature/architecture + docs/research/task/epic)
- PR templates
- CODEOWNERS
- Workflows (CI, docs, release, security, labels, dependabot)

### `scripts/`

Automation layer:

- bootstrap (apply project templates)
- docs profile switch (app/lib/research/game)
- lint/test/docs runners used by CI

### `docs/`

Universal documentation system:

- overview, architecture, ADRs, diagrams
- optional modules enabled by profile: design/operations/research

### `project-templates/`

The factory’s template library (what bootstrap copies from).
This folder should exist in the FACTORY repo.

---

## 5) CI/CD and what blocks merges

- CI runs lint + tests based on detected stack files.
- Docs pipeline builds MkDocs only if `mkdocs.yml` exists.
- Releases run on semver tags `vX.Y.Z`.

Branch protections should require:

- PRs
- approvals
- CI status checks
- conversation resolution
- linear history
- no force pushes / deletions
- CODEOWNERS review (especially for architecture/docs)

---

## 6) Labels system

- `labels.yml` is the source of truth.
- `sync-labels.yml` syncs labels into GitHub.
- `auto-label.yml` applies `area/*` labels based on changed paths.

If labels don’t exist yet, run “Sync GitHub Labels” in Actions.

---

## 7) Safe cleanup vs factory cleanup

### Safe cleanup (always OK)

- removes caches/build outputs/logs only
```bash
make clean
```

### Factory cleanup (DANGEROUS)

This removes factory-only assets like `project-templates/`.

Only run this inside PRODUCT repos (or if you really know what you are doing).
```bash
make factory-clean
```

It requires typing `YES` to continue.

---

## 8) How to modify / extend the toolkit
   
### Add a new project template

1. Create a folder under `project-templates/<new-template>/`
2. Add `TEMPLATE.md` and optional `.gitignore.snippet`
3. Test bootstrap in a throwaway repo
4. Document it here (this 101)

### Change governance rules

- Update policies, PR templates, issue forms
- Keep workflows fork-safe in public template
- Update branch rulesets manually in GitHub UI

---

## 9) Troubleshooting
   
### “bootstrap says WSL not found”
Use the PowerShell bootstrap (`bootstrap.ps1`) which does not require WSL.

### “I ran -Cleanup in the FACTORY repo”
Restore `project-templates/` from a clean copy (zip, git, or backup).

### “auto-label not working”

- Check Actions is enabled
- Check `labeler.yml` exists
- Confirm workflow permissions in repo settings

---

## 10) Checklist (this guide is complete only if )

- [x] Golden Rule is understood
- [x] Public vs Pro differences documented
- [x] Bootstrap commands verified on Windows + Git Bash
- [x] Folder purpose explained (.github/scripts/docs/project-templates)
- [x] CI/CD and branch protection steps clear
- [x] Labels sync explained
- [x] Safe cleanup vs factory cleanup documented
- [x] How to add/modify templates described
- [x] Troubleshooting section covers common issues