param()

$ErrorActionPreference = "Stop"

function Is-FactoryRepo {
  $hasIssueTemplates = Test-Path ".github/ISSUE_TEMPLATE"
  $hasTemplates = Test-Path "project-templates"
  $hasReadme = Test-Path "README.md"
  if (-not ($hasIssueTemplates -and $hasTemplates -and $hasReadme)) { return $false }

  $readme = Get-Content "README.md" -Raw -ErrorAction SilentlyContinue
  return ($readme -match "(?i)engineering-toolkit")
}

Write-Host "DANGER: factory-clean will remove factory-only assets (e.g., project-templates/)."
Write-Host "Intended for PRODUCT repos created from the template."
Write-Host ""

if (Is-FactoryRepo) {
  Write-Host "⚠️  FACTORY repo detected (this looks like the template repo)."
  Write-Host "Running factory-clean here is usually a mistake."
  Write-Host ""
  $confirmFactory = Read-Host "Type I_UNDERSTAND to continue anyway"
  if ($confirmFactory -ne "I_UNDERSTAND") {
    Write-Host "Aborted."
    exit 1
  }
  Write-Host ""
}

$confirm = Read-Host "Type YES to continue"
if ($confirm -ne "YES") {
  Write-Host "Aborted."
  exit 1
}

if (Test-Path "project-templates") {
  Remove-Item -Recurse -Force "project-templates"
}

Write-Host "✅ factory-clean complete (project-templates/ removed)."