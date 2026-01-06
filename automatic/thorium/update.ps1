import-module Chocolatey-AU

$releases = "https://api.github.com/repos/Alex313031/Thorium-Win/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?m)^(\s*SSE3\s*=\s*)'https?://[^']+\.exe'" = "`$1'$($Latest.URLSSE3)'"
      "(?m)^(\s*SSE4\s*=\s*)'https?://[^']+\.exe'" = "`$1'$($Latest.URLSSE4)'"
      "(?m)^(\s*AVX\s*=\s*)'https?://[^']+\.exe'"  = "`$1'$($Latest.URLAVX)'"
      "(?m)^(\s*AVX2\s*=\s*)'https?://[^']+\.exe'" = "`$1'$($Latest.URLAVX2)'"

      "(?m)^(\s*SSE3\s*=\s*)'[0-9a-fA-F]{64}'" = "`$1'$($Latest.ChecksumSSE3)'"
      "(?m)^(\s*SSE4\s*=\s*)'[0-9a-fA-F]{64}'" = "`$1'$($Latest.ChecksumSSE4)'"
      "(?m)^(\s*AVX\s*=\s*)'[0-9a-fA-F]{64}'"  = "`$1'$($Latest.ChecksumAVX)'"
      "(?m)^(\s*AVX2\s*=\s*)'[0-9a-fA-F]{64}'" = "`$1'$($Latest.ChecksumAVX2)'"
    }
  }
}

function global:au_BeforeUpdate() {
  $Latest.ChecksumAVX2 = Get-RemoteChecksum $Latest.URLAVX2
  $Latest.ChecksumAVX = Get-RemoteChecksum $Latest.URLAVX
  $Latest.ChecksumSSE3 = Get-RemoteChecksum $Latest.URLSSE3
  $Latest.ChecksumSSE4 = Get-RemoteChecksum $Latest.URLSSE4
}

function global:au_GetLatest {
  function Get-AssetUrl {
    param(
      [Parameter(Mandatory)]$Assets,
      [Parameter(Mandatory)][string[]]$NamePatterns
    )

    foreach ($pattern in $NamePatterns) {
      $match = $Assets | Where-Object { $_.name -match $pattern } | Select-Object -First 1
      if ($null -ne $match) {
        return $match.browser_download_url
      }
    }

    return $null
  }

  $download_page = Invoke-RestMethod -Method GET -Uri $releases
  $version = $download_page.tag_name -replace '[a-zA-Z]', '' 
  $assets = $download_page.assets

  $urlAvx2 = Get-AssetUrl -Assets $assets -NamePatterns @(
    '(?i)^thorium[_-]avx2.*mini[_-]installer\.exe$'
    '(?i)^thorium[_-]avx2_.*\.exe$'
    '(?i)^Thorium[_-]AVX2_.*\.exe$'
  )
  $urlAvx = Get-AssetUrl -Assets $assets -NamePatterns @(
    '(?i)^thorium[_-]avx.*mini[_-]installer\.exe$'
    '(?i)^thorium[_-]avx_.*\.exe$'
    '(?i)^Thorium[_-]AVX_.*\.exe$'
  )
  $urlSse3 = Get-AssetUrl -Assets $assets -NamePatterns @(
    '(?i)^thorium[_-]sse3.*mini[_-]installer\.exe$'
    '(?i)^thorium[_-]sse3_.*\.exe$'
    '(?i)^Thorium[_-]SSE3_.*\.exe$'
  )
  $urlSse4 = Get-AssetUrl -Assets $assets -NamePatterns @(
    '(?i)^thorium[_-]sse4.*mini[_-]installer\.exe$'
    '(?i)^thorium[_-]sse4_.*\.exe$'
    '(?i)^Thorium[_-]SSE4_.*\.exe$'
  )

  if ([string]::IsNullOrWhiteSpace($urlAvx2) -or [string]::IsNullOrWhiteSpace($urlAvx) -or [string]::IsNullOrWhiteSpace($urlSse3) -or [string]::IsNullOrWhiteSpace($urlSse4)) {
    throw "Failed to locate one or more Thorium release assets (AVX2/AVX/SSE3/SSE4)."
  }

  @{
    URLAVX2 = $urlAvx2
    URLAVX = $urlAvx
    URLSSE3 = $urlSse3
    URLSSE4 = $urlSse4
    Version = $version
  }
}

update -ChecksumFor none -NoReadme
