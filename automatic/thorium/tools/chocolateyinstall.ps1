$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'thorium';
$fileType     = 'exe';
$urlsse       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M130.0.6723.174/thorium_SSE3_mini_installer.exe';
$urlavx       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M130.0.6723.174/thorium_AVX_mini_installer.exe';
$url          = 'https://github.com/Alex313031/Thorium-Win/releases/download/M130.0.6723.174/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum     = '661eb05bb2cce9e5371f2477f3f1c94ac15a569f8cae12079809e9189c7c8e48';
$checksumsse3 = 'f2ce7c91b68647ac5de1a0a4d251f9978aa186636d299ed8a5e50abee7cf6516';
$checksumavx  = '87fa1a2abdcca57bd5c0f3a34cd93816da272b6cb38517f50dfc2b7c1ab88727';
$checksumType = 'sha256';
$softwareName = 'thorium*';
$silentArgs   = '--do-not-launch-chrome';


if ($pp['SSE3'] -eq 'true') {
  $packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = $fileType 
    url           = $urlsse
    softwareName  = $softwareName
    checksum      = $checksumsse3
    checksumType  = $checksumType
    silentArgs    = $silentArgs 
    validExitCodes= @(0)
  }
}elseif ($pp['AVX'] -eq 'true') {
  $packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = $fileType 
    url           = $urlavx
    softwareName  = $softwareName
    checksum      = $checksumavx
    checksumType  = $checksumType
    silentArgs    = $silentArgs 
    validExitCodes= @(0)
  }
}else {
  $packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = $fileType 
    url           = $url
    softwareName  = $softwareName
    checksum      = $checksum
    checksumType  = $checksumType
    silentArgs    = $silentArgs 
    validExitCodes= @(0)
  }
}

Install-ChocolateyPackage @packageArgs;
