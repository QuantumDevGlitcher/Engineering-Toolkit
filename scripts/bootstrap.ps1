param(
  [Parameter(Mandatory=$true)]
  [string]$Template,

  [Parameter(Mandatory=$true)]
  [ValidateSet("app","lib","research","game")]
  [string]$Profile,

  [switch]$Cleanup
)

$ErrorActionPreference = "Stop"

function Ensure-Dir([string]$Path) {
  New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Apply-DocsProfile([string]$ProfileName) {
  # Core docs folder should exist, but ensure anyway
  Ensure-Dir "docs"

  switch ($ProfileName) {
    "app" {
      Ensure-Dir "docs/design"
      Ensure-Dir "docs/operations"
    }
    "lib" {
      Ensure-Dir "docs/design"
    }
    "research" {
      Ensure-Dir "docs/design"
      Ensure-Dir "docs/research"
    }
    "game" {
      Ensure-Dir "docs/design"
    }
  }
}

function Merge-GitignoreSnippet([string]$SnippetPath, [string]$TemplateName) {
  $target = ".gitignore"
  if (-not (Test-Path $target)) {
    New-Item -ItemType File -Path $target | Out-Null
  }

  $markerStart = "# --- template snippet start: $TemplateName ---"
  $markerEnd   = "# --- template snippet end ---"

  $content = Get-Content $target -Raw
  if ($content -match [regex]::Escape($markerStart)) {
    Write-Host "Snippet already merged."
    return
  }

  Add-Content $target ""
  Add-Content $target $markerStart
  Get-Content $SnippetPath | Add-Content $target
  Add-Content $target $markerEnd

  Write-Host "Merged .gitignore snippet."
}

# --- Validate template path
$srcDir = Join-Path "project-templates" $Template
if (-not (Test-Path $srcDir)) {
  throw "Template not found: $srcDir"
}

Write-Host "→ Applying template: $Template"
Write-Host "→ Docs profile: $Profile"

# --- Copy template into repo root without overwriting existing files
Get-ChildItem -Path $srcDir -Recurse -Force | ForEach-Object {
  $relative = $_.FullName.Substring($srcDir.Length).TrimStart('\','/')
  if ($relative -eq "") { return }

  $dest = Join-Path "." $relative

  if ($_.PSIsContainer) {
    Ensure-Dir $dest
  } else {
    if (-not (Test-Path $dest)) {
      Ensure-Dir (Split-Path $dest)
      Copy-Item $_.FullName $dest
    }
  }
}

# --- Merge .gitignore snippet if present
$snippet = Join-Path $srcDir ".gitignore.snippet"
if (Test-Path $snippet) {
  Merge-GitignoreSnippet -SnippetPath $snippet -TemplateName $Template
}

# --- Apply docs profile (PowerShell-native, no WSL)
Apply-DocsProfile -ProfileName $Profile

Write-Host "✅ Bootstrap complete."

if ($Cleanup) {
  if (Test-Path "project-templates") {
    Remove-Item -Recurse -Force "project-templates"
  }
  Write-Host "✅ Cleanup complete."
}