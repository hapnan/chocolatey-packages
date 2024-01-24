$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'thorium';
$fileType     = 'exe';
$urlsse       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M120.0.6099.235/thorium_SSE3_mini_installer.exe';
$urlavx       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M120.0.6099.235/thorium_AVX_mini_installer.exe';
$url          = 'https://github.com/Alex313031/Thorium-Win/releases/download/M120.0.6099.235/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum     = '59779527a74730d607385d3edbe98755467f69336445ef0d6b610461dc7322e6';
$checksumsse3 = '8dee0b7b34f4de0e024b9297e6514a0466776f99b35686be38bc709921aca533';
$checksumavx  = 'a2f5e77a586169ad73b594de0d877f275edb3258f5009abeae4f94ac376394a7';
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
