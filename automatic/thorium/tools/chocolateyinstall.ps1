$ErrorActionPreference = 'Stop'


$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'thorium';
$fileType    = 'exe';
$url        = 'https://github.com/Alex313031/Thorium-Win/releases/download/M119.0.6045.214/thorium_mini_installer.exe'; # download url, HTTPS preferred
$checksum   = '6324808a60094a48fcedb382ecb1125759277e1b9af1fbbcded0732dce7731fd';
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
