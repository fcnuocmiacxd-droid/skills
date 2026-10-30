#requires -Version 5.1
<#
.SYNOPSIS
    Guided, opt-in installation of the upstream Archify skill for Codex CLI on Windows.
.DESCRIPTION
    Only runs when invoked manually. Checks the upstream skill listing, asks for
    confirmation, then installs a global copy for Codex. Does not modify this
    Git repository or any production project. Requires Node.js/npx.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command node.exe -ErrorAction SilentlyContinue)) {
    throw 'Node.js is required. Install Node.js and reopen PowerShell.'
}
if (-not (Get-Command npx.cmd -ErrorAction SilentlyContinue)) {
    throw 'npx.cmd not found. Install npm (bundled with Node.js) and reopen PowerShell.'
}

Write-Host 'Inspect upstream skill discovery. Confirm EXACTLY one skill named archify.' -ForegroundColor Cyan
& npx.cmd -y skills add tt-a1i/archify --list --full-depth
if ($LASTEXITCODE -ne 0) {
    throw 'Upstream skill discovery failed. Nothing was installed.'
}

$confirmation = Read-Host "If the list contains exactly one skill named archify, type archify to install globally for Codex"
if ($confirmation -cne 'archify') {
    Write-Host 'Cancelled; no installation was attempted.'
    exit 0
}

Write-Host 'Installing the optional upstream Archify skill for Codex CLI...' -ForegroundColor Cyan
& npx.cmd -y skills add tt-a1i/archify --skill archify --agent codex --global --copy
if ($LASTEXITCODE -ne 0) {
    throw 'Archify installer returned a failure. Review the output; installation may be partial.'
}

$skillFile = Join-Path $HOME '.agents\skills\archify\SKILL.md'
if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
    Write-Warning "Installer completed, but expected file not found: $skillFile. Confirm the install location in the output."
    exit 1
}
Write-Host "Archify skill file present: $skillFile" -ForegroundColor Green
Write-Host 'Start a new Codex CLI session and verify skill discovery before using Archify.'
