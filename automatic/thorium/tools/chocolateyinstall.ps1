$ErrorActionPreference = 'Stop'


$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'thorium';
$fileType    = 'exe';
$url        = 'https://github.com/Alex313031/Thorium-Win/releases/latest/download/thorium_mini_installer.exe'; # download url, HTTPS preferred
$checksum   = '6324808A60094A48FCEDB382ECB1125759277E1B9AF1FBBCDED0732DCE7731FD';
$checksumType= 'sha256';
$softwareName   = 'thorium*';
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
