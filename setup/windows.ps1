$ErrorActionPreference = "Stop"

$isWindowsVariable = Get-Variable -Name IsWindows -ErrorAction SilentlyContinue
if ($isWindowsVariable -and -not $IsWindows) {
    throw "Windows setup can only run on Windows hosts."
}

$repoRoot = Split-Path -Parent $PSScriptRoot

# Future work:
# - Install packages with winget/scoop/chocolatey.
# - Configure PowerShell and Windows Terminal profiles.
# - Apply config/shared and config/windows home config layers.
# - Configure language runtimes.

Write-Host ""
Write-Host "Windows setup is stubbed out."
Write-Host "Repository: $repoRoot"
Write-Host "No changes were made. Future Windows setup should live in setup/windows.ps1."
