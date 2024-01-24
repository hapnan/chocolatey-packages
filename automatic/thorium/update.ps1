import-module au

$releases = "https://api.github.com/repos/Alex313031/Thorium-Win/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(^[$]urlsse\s*=\s*)('.*')"       = "`$1'$($Latest.URLSSE3)'"
      "(^[$]urlavx\s*=\s*)('.*')"       = "`$1'$($Latest.URLAVX)'"
      "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksumsse3\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32sse3)'"
      "(^[$]checksumavx\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32avx)'"
    }
  }
}

function global:au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum32avx = Get-RemoteChecksum $Latest.URLAVX
  $Latest.Checksum32sse3 = Get-RemoteChecksum $Latest.URLSSE3
}

function global:au_GetLatest {
  $download_page = Invoke-RestMethod -Method GET -Uri $releases
  $version = $download_page.tag_name -replace '[a-zA-Z]', '' 
  $url = ($download_page.assets | Where-Object name -like "Thorium_AVX2_*.exe").browser_download_url
  $urlavx = ($download_page.assets | Where-Object name -like "Thorium_AVX_*.exe").browser_download_url
  $urlsse = ($download_page.assets | Where-Object name -like "Thorium_SSE3_*.exe").browser_download_url

  

  @{
    URL32 = $url
    URLAVX = $urlavx
    URLSSE3 = $urlsse
    Version = $version
  }
}

update -ChecksumFor none -NoReadme
