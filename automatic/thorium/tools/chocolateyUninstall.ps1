$registry = Get-UninstallRegistryKey -SoftwareName "thorium*"
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$chromiumArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ $Arg_chk ]
$silentArgs = @{$true = '--uninstall --system-level --force-uninstall'; $false = '--uninstall --force-uninstall'}[ $Arg_chk ]
$myfile = $file -replace ( $chromiumArgs )
# All arguments for the Uninstallation of this package
$packageArgs = @{
  PackageName    = 'Thorium'
  FileType       = 'exe'
  SilentArgs     = $silentArgs
  validExitCodes = @(19, 20, 21)
  File           = $myfile
}
# Now to Uninstall the Package
Uninstall-ChocolateyPackage @packageArgs
# This at the moment does not remove the libs\Chromium folder
