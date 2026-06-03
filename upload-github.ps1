param(
  [string]$CommitMessage = ""
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SettingsPath = Join-Path $ProjectRoot ".upload-settings.json"
$LinksPath = Join-Path $ProjectRoot "upload-links.txt"

function Read-SettingValue($Label, $DefaultValue) {
  if ($DefaultValue) {
    $value = Read-Host "$Label [$DefaultValue]"
    if ([string]::IsNullOrWhiteSpace($value)) { return $DefaultValue }
    return $value.Trim()
  }
  return (Read-Host $Label).Trim()
}

function Convert-GitHubRemoteToWebBase($RemoteUrl) {
  $url = $RemoteUrl.Trim()
  if ($url -match '^git@github\.com:(.+?)/(.+?)(\.git)?$') {
    return "https://github.com/$($Matches[1])/$($Matches[2] -replace '\.git$','')"
  }
  if ($url -match '^https://github\.com/(.+?)/(.+?)(\.git)?$') {
    return "https://github.com/$($Matches[1])/$($Matches[2] -replace '\.git$','')"
  }
  return ""
}

function Get-GitHubOwner($RemoteUrl) {
  $url = $RemoteUrl.Trim()
  if ($url -match '^git@github\.com:(.+?)/(.+?)(\.git)?$') { return $Matches[1] }
  if ($url -match '^https://github\.com/(.+?)/(.+?)(\.git)?$') { return $Matches[1] }
  return "gfield-upload"
}

function Invoke-Git {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
  )
  & git @Arguments | Out-Host
  if ($LASTEXITCODE -ne 0) {
    throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
  }
}

function Load-Or-CreateSettings {
  if (Test-Path -LiteralPath $SettingsPath) {
    return Get-Content -LiteralPath $SettingsPath -Raw -Encoding UTF8 | ConvertFrom-Json
  }

  Write-Host ""
  Write-Host "First-time GitHub upload setup."
  Write-Host "Example remote URL: https://github.com/user/repo.git"
  Write-Host ""

  $remoteUrl = Read-SettingValue "GitHub repository URL" ""
  if ([string]::IsNullOrWhiteSpace($remoteUrl)) {
    throw "GitHub repository URL is required."
  }

  $branch = Read-SettingValue "Upload branch" "main"
  $repoFolder = Read-SettingValue "Folder inside repository, blank for root" ""
  $pagesUrl = Read-SettingValue "GitHub Pages or Netlify public URL, blank if unknown" ""

  $settings = [ordered]@{
    remoteUrl = $remoteUrl
    branch = $branch
    repoFolder = $repoFolder
    pagesUrl = $pagesUrl
  }
  $settings | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $SettingsPath -Encoding UTF8
  return [pscustomobject]$settings
}

function Copy-ProjectFiles($SourceRoot, $TargetRoot) {
  if (Test-Path -LiteralPath $TargetRoot) {
    Get-ChildItem -LiteralPath $TargetRoot -Force | Where-Object {
      $_.Name -ne ".git"
    } | Remove-Item -Recurse -Force
  } else {
    New-Item -ItemType Directory -Path $TargetRoot | Out-Null
  }

  $exclude = @(".git", ".upload-settings.json", "upload-links.txt", "업로드_링크_정리.txt")
  Get-ChildItem -LiteralPath $SourceRoot -Force | Where-Object {
    $exclude -notcontains $_.Name
  } | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $TargetRoot -Recurse -Force
  }
}

function Publish-ToGitHub($Settings, $Message) {
  $safeName = ($Settings.remoteUrl -replace "[^a-zA-Z0-9]", "_")
  if ($safeName.Length -gt 70) { $safeName = $safeName.Substring(0, 70) }
  $workRoot = Join-Path $env:TEMP ("gfield-github-upload-" + $safeName)

  if (Test-Path -LiteralPath $workRoot) {
    Remove-Item -LiteralPath $workRoot -Recurse -Force
  }

  Invoke-Git clone $Settings.remoteUrl $workRoot

  Push-Location $workRoot
  try {
    Invoke-Git checkout -B $Settings.branch

    $owner = Get-GitHubOwner $Settings.remoteUrl
    Invoke-Git config user.name $owner
    Invoke-Git config user.email "$owner@users.noreply.github.com"

    $folder = ([string]$Settings.repoFolder).Trim().Trim("/")
    if ([string]::IsNullOrWhiteSpace($folder)) {
      $targetRoot = $workRoot
    } else {
      $targetRoot = Join-Path $workRoot ($folder -replace "/", [IO.Path]::DirectorySeparatorChar)
    }

    Copy-ProjectFiles $ProjectRoot $targetRoot

    Invoke-Git add .
    $changes = (& git status --porcelain)
    if ($LASTEXITCODE -ne 0) {
      throw "git status failed with exit code $LASTEXITCODE"
    }
    if ([string]::IsNullOrWhiteSpace($changes)) {
      Write-Host "No file changes found. Checking remote sync."
    } else {
      Invoke-Git commit -m $Message
    }
    Invoke-Git push -u origin $Settings.branch
  } finally {
    Pop-Location
  }
}

function Write-UploadLinks($Settings) {
  $webBase = Convert-GitHubRemoteToWebBase $Settings.remoteUrl
  $folder = [string]$Settings.repoFolder
  $branch = [string]$Settings.branch
  $treePath = if ([string]::IsNullOrWhiteSpace($folder)) { "" } else { "/" + ($folder.Trim("/") -replace "\\","/") }
  $pagesBase = ([string]$Settings.pagesUrl).Trim().TrimEnd("/")

  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("G-FIELD upload links")
  $lines.Add("")
  $lines.Add("Uploaded at: " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
  if ($webBase) {
    $lines.Add("GitHub repository: $webBase")
    $lines.Add("GitHub folder: $webBase/tree/$branch$treePath")
    $lines.Add("index.html: $webBase/blob/$branch$treePath/index.html")
    $lines.Add("config.js: $webBase/blob/$branch$treePath/config.js")
    $lines.Add("students.js: $webBase/blob/$branch$treePath/students.js")
    $lines.Add("book PDF: $webBase/blob/$branch$treePath/assets/book.pdf")
  }
  if ($pagesBase) {
    $publicFolder = if ([string]::IsNullOrWhiteSpace($folder)) { "" } else { "/" + $folder.Trim("/") }
    $lines.Add("")
    $lines.Add("Student URL: $pagesBase$publicFolder/")
  }
  $lines.Add("")
  $lines.Add("Run upload.cmd again after edits.")
  $lines | Set-Content -LiteralPath $LinksPath -Encoding UTF8
}

$settings = Load-Or-CreateSettings

$bookPath = Join-Path $ProjectRoot "assets\book.pdf"
if (-not (Test-Path -LiteralPath $bookPath)) {
  Write-Host ""
  Write-Host "Warning: assets\book.pdf was not found."
  Write-Host "Upload can continue, but the viewer will show a missing PDF message."
  Write-Host ""
} else {
  $bookSize = (Get-Item -LiteralPath $bookPath).Length
  $bookMiB = [math]::Round($bookSize / 1MB, 2)
  Write-Host "Book PDF size: $bookMiB MiB"
  if ($bookSize -gt 100MB) {
    throw "GitHub blocks ordinary files over 100MiB. Compress or split the PDF."
  }
  if ($bookSize -gt 50MB) {
    Write-Host "Warning: GitHub may warn for files over 50MiB."
  }
}

if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
  $CommitMessage = Read-SettingValue "Commit message" ("update gfield library " + (Get-Date -Format "yyyy-MM-dd HH:mm"))
}

Publish-ToGitHub $settings $CommitMessage
Write-UploadLinks $settings

Write-Host ""
Write-Host "Upload complete."
Write-Host "Links file: $LinksPath"
Write-Host ""
Get-Content -LiteralPath $LinksPath -Encoding UTF8 | Out-Host
