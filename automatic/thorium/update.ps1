import-module au

$releases = "https://api.github.com/repos/Alex313031/Thorium-Win/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-RestMethod -Method GET -Uri $releases
  $filenamePattern = "*.exe"
  $version = $download_page.tag_name -replace '[a-zA-Z]', '' 
  $url = ($download_page.assets | Where-Object name -like $filenamePattern ).browser_download_url | select -First 1
  

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
