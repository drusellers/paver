$ErrorActionPreference = "Stop"

$isWindowsVariable = Get-Variable -Name IsWindows -ErrorAction SilentlyContinue
if ($isWindowsVariable -and -not $IsWindows) {
    throw "Windows install can only run on Windows hosts."
}

$repoUrl = if ($env:BOOTSTRAP_REPO_URL) {
    $env:BOOTSTRAP_REPO_URL
} else {
    "https://github.com/drusellers/bootstrap.git"
}

$bootstrapDir = if ($env:BOOTSTRAP_DIR) {
    $env:BOOTSTRAP_DIR
} else {
    Join-Path $HOME ".bootstrap"
}

Write-Host ""
Write-Host "Installing bootstrap for Windows"

$gitDir = Join-Path $bootstrapDir ".git"
if (Test-Path $gitDir) {
    Write-Host "Updating $bootstrapDir"
    git -C $bootstrapDir pull --ff-only
} else {
    if (Test-Path $bootstrapDir) {
        throw "ERROR: $bootstrapDir exists but is not a git repository."
    }

    Write-Host "Cloning $repoUrl into $bootstrapDir"
    git clone $repoUrl $bootstrapDir
}

$setupScript = Join-Path $bootstrapDir "setup/windows.ps1"
& $setupScript
