$ErrorActionPreference = 'Stop'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'thorium';
$fileType    = 'exe';
$url        = 'https://github.com/Alex313031/Thorium-Win/releases/latest/download/thorium_mini_installer.exe'; # download url, HTTPS preferred
$checksum   = '6324808A60094A48FCEDB382ECB1125759277E1B9AF1FBBCDED0732DCE7731FD';
$checksumTypeAll= 'sha256';
$softwareName   = 'thorium*';

$registryPathThroiumAsUser = 'hkcu:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Thorium';
$isThroiumInstallAsUser    = Test-Path $registryPathThroiumAsUser;
 
if ($isThroiumInstallAsUser) {
  $silentArgs = '--do-not-launch-chrome';
} else {
  $silentArgs = '--do-not-launch-chrome';
}
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url
  softwareName  = $softwareName  #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = $checksum
  checksumType  = $checksumTypeAll #default is md5, can also be sha1, sha256 or sha512
  checksum64    = $checksum
  checksumType64= $checksumTypeAll #default is checksumType
  silentArgs    = $silentArgs 
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs;
