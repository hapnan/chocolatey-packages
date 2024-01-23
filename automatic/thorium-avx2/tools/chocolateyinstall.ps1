$ErrorActionPreference = 'Stop'


$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'thorium-avx2';
$fileType    = 'exe';
$url        = 'https://github.com/Alex313031/Thorium-Win-AVX2/releases/download/M119.0.6045.214/thorium_AVX2_mini_installer.exe'; # download url, HTTPS preferred
$checksum   = 'a60fdd2b00f2267484362676faa8a1a4377dc89421a4fb6fefde5187b01be147';
$checksumType= 'sha256';
$softwareName   = 'thorium-avx2*';
$silentArgs = '--do-not-launch-chrome';


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

Install-ChocolateyPackage @packageArgs;
