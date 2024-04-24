$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'thorium';
$fileType     = 'exe';
$urlsse       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M123.0.6312.133/thorium_SSE3_mini_installer.exe';
$urlavx       = 'https://github.com/Alex313031/Thorium-Win/releases/download/M123.0.6312.133/thorium_AVX_mini_installer.exe';
$url          = 'https://github.com/Alex313031/Thorium-Win/releases/download/M123.0.6312.133/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum     = 'f44363f17d48dcfd2fd132148e7b39c3ce3cd9fdadef6ff79e10cb7deae5abfd';
$checksumsse3 = '6e73d7aa7413fc3d49bc309717470606254812cc87d8dd6ef8031a9853333800';
$checksumavx  = 'd04a63fd2fef140dc4f33dac281fd41d508da068bd6a855a283c77bf80bc4380';
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
