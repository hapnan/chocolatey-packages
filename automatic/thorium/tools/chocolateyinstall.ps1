$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'thorium';
$fileType     = 'exe';
$urlsse       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M124.0.6367.218/thorium_SSE3_mini_installer.exe';
$urlavx       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M124.0.6367.218/thorium_AVX_mini_installer.exe';
$url          = 'https://github.com/Alex313031/Thorium-Win/releases/download/M124.0.6367.218/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum     = 'c3ad8d0232982da72d0a377d7e4701bbb73c336dde92809d07e3a411c05992dd';
$checksumsse3 = '9021dc35ef9e2174d57d74b880e42bb236eb9e33f2193258ab8d9624d38c9f19';
$checksumavx  = '4921865e8aa34a5f79df8bee830bd6dc0cbd3711d0ae580f0276fa60abae6eaa';
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
