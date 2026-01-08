$ErrorActionPreference = 'Stop'

# Prefer the actual installed scope from the registry, but fall back to the
# package parameter used by chocolateyinstall.ps1 (SystemInstall=true).
$registryKeys = @(Get-UninstallRegistryKey -SoftwareName 'thorium*' -ErrorAction SilentlyContinue)
$registry = $registryKeys | Select-Object -First 1

if (-not $registry -or (-not $registry.UninstallString -and -not $registry.QuietUninstallString)) {
  throw "Unable to locate Thorium uninstall information in the registry (SoftwareName='thorium*')."
}

$uninstallString = [string](@($registry.QuietUninstallString, $registry.UninstallString) | Where-Object { $_ } | Select-Object -First 1)

# UninstallString is typically like:
#   "C:\Path\thorium_installer.exe" --uninstall [--system-level]
# Extract EXE path safely even when quoted / contains spaces.
$match = [regex]::Match($uninstallString, '^\s*"?(?<exe>[^\"]+?\.exe)"?\s*(?<args>.*)$')
if (-not $match.Success) {
  throw "Unable to parse UninstallString: $uninstallString"
}

$uninstallExe = $match.Groups['exe'].Value.Trim()
$uninstallArgs = $match.Groups['args'].Value

$uninstallExeName = (Split-Path -Leaf $uninstallExe)

$isSystemLevel = $false
if ($uninstallArgs -match '(?i)\s--system-level(\s|$)') {
  $isSystemLevel = $true
}

$validExitCodes = @(0, 19, 20, 21)

# If this looks like a Chromium-style uninstaller (setup.exe / --uninstall),
# enforce --force-uninstall and optionally --system-level.


$silentArgs = '--uninstall --force-uninstall'
if ($isSystemLevel) {
  $silentArgs += ' --system-level'
}

Start-ChocolateyProcessAsAdmin -ExeToRun $uninstallExe -Statements $silentArgs -ValidExitCodes $validExitCodes


# Note: This does not remove profile/data folders (e.g. libs\Chromium) by design.
