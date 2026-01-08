$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$packageName = 'thorium'
$fileType = 'exe'
$softwareName = 'thorium*'
$checksumType = 'sha256'

# URLs + checksums are maintained by AU via automatic\thorium\update.ps1
$variantUrls = @{
    SSE3 = 'https://github.com/Alex313031/Thorium-Win/releases/download/M138.0.7204.300/thorium_SSE3_mini_installer.exe'
    SSE4 = 'https://github.com/Alex313031/Thorium-Win/releases/download/M138.0.7204.300/thorium_SSE4_mini_installer.exe'
    AVX  = 'https://github.com/Alex313031/Thorium-Win/releases/download/M138.0.7204.300/thorium_AVX2_mini_installer.exe'
    AVX2 = 'https://github.com/Alex313031/Thorium-Win/releases/download/M138.0.7204.300/thorium_AVX2_mini_installer.exe'
}

$variantChecksums = @{
    SSE3 = 'db38e1a19c9a113e18047a651486ca741a18752154cfe71511f2c1797466e533'
    SSE4 = 'e304b930199e4db7ef1cbcbd243cfc4b64f06ecff78aa576fde11f45d014e62a'
    AVX  = '8ddc33a6e18c481268c269e52983979fdd618d4191e8fd14ccf6b11754f5d04a'
    AVX2 = '8ddc33a6e18c481268c269e52983979fdd618d4191e8fd14ccf6b11754f5d04a'
}

# Determine installation scope automatically
# Priority:
# 1) If user explicitly sets -Params 'SystemInstall=true|false', honor it (back-compat)
# 2) If already installed, reuse the existing scope from registry uninstall args
# 3) Otherwise default to system-level when running elevated
$requestedSystemInstall = $null
if ($pp.ContainsKey('SystemInstall')) {
    $raw = [string]$pp['SystemInstall']
    if ($raw -match '^(?i:true|1|yes)$') {
        $requestedSystemInstall = $true
    }
    elseif ($raw -match '^(?i:false|0|no)$') {
        $requestedSystemInstall = $false
    }
}

$existingSystemInstall = $null
try {
    $existing = @(Get-UninstallRegistryKey -SoftwareName $softwareName -ErrorAction SilentlyContinue) | Select-Object -First 1
    if ($existing) {
        $existingUninstall = [string](@($existing.QuietUninstallString, $existing.UninstallString) | Where-Object { $_ } | Select-Object -First 1)
        if ($existingUninstall -match '(?i)\s--system-level(\s|$)') {
            $existingSystemInstall = $true
        }
        else {
            $existingSystemInstall = $false
        }
    }
}
catch {
    $existingSystemInstall = $null
}

$isAdmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$useSystemInstall = $false
if ($null -ne $requestedSystemInstall) {
    $useSystemInstall = $requestedSystemInstall
}
elseif ($null -ne $existingSystemInstall) {
    $useSystemInstall = $existingSystemInstall
}
else {
    $useSystemInstall = $isAdmin
}

$silentArgs = '--silent --install'
if ($useSystemInstall) {
    $silentArgs += ' --system-level'
}
$validExitCodes = @(0, 1, 101, 105, 107, 108, 109, 110, 111, 112, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124)

# Determine URL and checksum based on package parameters
$variant = 'AVX2'
if ($pp['SSE3'] -eq 'true') {
    $variant = 'SSE3'
}
elseif ($pp['SSE4'] -eq 'true') {
    $variant = 'SSE4'
}
elseif ($pp['AVX'] -eq 'true') {
    $variant = 'AVX'
}

$url = $variantUrls[$variant]
$checksum = $variantChecksums[$variant]

# Build package arguments
$packageArgs = @{
    packageName    = $packageName
    fileType       = $fileType
    url            = $url
    softwareName   = $softwareName
    checksum       = $checksum
    checksumType   = $checksumType
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
}

Install-ChocolateyPackage @packageArgs
