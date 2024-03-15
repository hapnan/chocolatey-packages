$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'thorium';
$fileType     = 'exe';
$urlsse       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M122.0.6261.132/thorium_SSE3_mini_installer.exe';
$urlavx       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M122.0.6261.132/thorium_AVX_mini_installer.exe';
$url          = 'https://github.com/Alex313031/Thorium-Win/releases/download/M122.0.6261.132/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum     = '692a039a11e0df7079d0947e2dd5790f617c9c7ce277309dd7a1ea2eb6b483f0';
$checksumsse3 = '74c3ea552bc83fbcc3e0c6d579562e5d2c922d84630aa1a1d9ae72ddd8432b70';
$checksumavx  = '380c6f1bbcef878c57264b3e4473e69e3ca2f035a577cb94285737489cff7853';
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
