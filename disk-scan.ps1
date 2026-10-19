<#
  disk-scan.ps1  --  READ-ONLY disk space report. Deletes NOTHING.

  Run in PowerShell (right-click Start > Terminal (Admin) for the fullest picture):
      powershell -ExecutionPolicy Bypass -File .\disk-scan.ps1

  Writes the same output to disk-report.txt next to this script.
#>

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference    = 'SilentlyContinue'
$root = $PSScriptRoot; if (-not $root) { $root = (Get-Location).Path }
$report = Join-Path $root 'disk-report.txt'
Start-Transcript -Path $report -Force | Out-Null

function Size-Of([string]$path) {
    if (-not (Test-Path -LiteralPath $path)) { return -1 }
    $sum = (Get-ChildItem -LiteralPath $path -Recurse -Force -File -ErrorAction SilentlyContinue |
            Measure-Object -Property Length -Sum).Sum
    if ($null -eq $sum) { return 0 }
    return [int64]$sum
}
function GB([int64]$b) { '{0,9:N2} GB' -f ($b / 1GB) }

function Show-Row($label, $path) {
    $s = Size-Of $path
    if ($s -lt 0)      { return }
    if ($s -lt 50MB)   { return }   # ignore anything under 50 MB
    '{0}  {1,-34} {2}' -f (GB $s), $label, $path
}

Write-Host ""
Write-Host "==================== DRIVES ====================" -ForegroundColor Cyan
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    '{0}  free {1,9:N2} GB  of {2,9:N2} GB' -f $_.DeviceID, ($_.FreeSpace/1GB), ($_.Size/1GB)
}

Write-Host ""
Write-Host "============ BIG SYSTEM FILES ============" -ForegroundColor Cyan
foreach ($f in 'C:\hiberfil.sys','C:\pagefile.sys','C:\swapfile.sys','C:\Windows\MEMORY.DMP') {
    $i = Get-Item -LiteralPath $f -Force -ErrorAction SilentlyContinue
    if ($i) { '{0}  {1}' -f (GB $i.Length), $f }
}

Write-Host ""
Write-Host "======== TOP-LEVEL FOLDERS ON C:\ (>1 GB) ========" -ForegroundColor Cyan
Get-ChildItem C:\ -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
    $s = Size-Of $_.FullName
    if ($s -gt 1GB) { [pscustomobject]@{ Bytes=$s; Path=$_.FullName } }
} | Sort-Object Bytes -Descending | ForEach-Object { '{0}  {1}' -f (GB $_.Bytes), $_.Path }

Write-Host ""
Write-Host "==== FOLDERS IN YOUR PROFILE (>1 GB) ====" -ForegroundColor Cyan
Get-ChildItem $env:USERPROFILE -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
    $s = Size-Of $_.FullName
    if ($s -gt 1GB) { [pscustomobject]@{ Bytes=$s; Path=$_.FullName } }
} | Sort-Object Bytes -Descending | ForEach-Object { '{0}  {1}' -f (GB $_.Bytes), $_.Path }

Write-Host ""
Write-Host "============ KNOWN CACHE LOCATIONS (>50 MB) ============" -ForegroundColor Cyan
$caches = [ordered]@{
  'User temp'              = $env:TEMP
  'Windows temp'           = 'C:\Windows\Temp'
  'Windows Update cache'   = 'C:\Windows\SoftwareDistribution\Download'
  'Windows logs'           = 'C:\Windows\Logs'
  'CBS logs'               = 'C:\Windows\Logs\CBS'
  'Minidumps'              = 'C:\Windows\Minidump'
  'Prefetch'               = 'C:\Windows\Prefetch'
  'Windows.old'            = 'C:\Windows.old'
  'Upgrade leftovers ~BT'  = 'C:\$Windows.~BT'
  'Upgrade leftovers ~WS'  = 'C:\$Windows.~WS'
  'Error reports (WER)'    = 'C:\ProgramData\Microsoft\Windows\WER'
  'Crash dumps'            = "$env:LOCALAPPDATA\CrashDumps"
  'Delivery Optimization'  = 'C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization'
  'Thumbnail/icon cache'   = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
  'IE/WebView cache'       = "$env:LOCALAPPDATA\Microsoft\Windows\INetCache"
  'WebCache'               = "$env:LOCALAPPDATA\Microsoft\Windows\WebCache"
  'Store app data'         = "$env:LOCALAPPDATA\Packages"
  'pnpm store (a)'         = "$env:LOCALAPPDATA\pnpm-store"
  'pnpm store (b)'         = "$env:LOCALAPPDATA\pnpm"
  'npm cache (a)'          = "$env:LOCALAPPDATA\npm-cache"
  'npm cache (b)'          = "$env:APPDATA\npm-cache"
  'npm cache (c)'          = "$env:USERPROFILE\.npm"
  'yarn cache'             = "$env:LOCALAPPDATA\Yarn\Cache"
  'bun cache'              = "$env:USERPROFILE\.bun\install\cache"
  'generic ~/.cache'       = "$env:USERPROFILE\.cache"
  'Playwright browsers'    = "$env:LOCALAPPDATA\ms-playwright"
  'Puppeteer/Chromium'     = "$env:USERPROFILE\.cache\puppeteer"
  'Cypress'                = "$env:LOCALAPPDATA\Cypress\Cache"
  'Electron'               = "$env:LOCALAPPDATA\electron"
  'electron-builder'       = "$env:LOCALAPPDATA\electron-builder"
  'node-gyp headers'       = "$env:LOCALAPPDATA\node-gyp"
  'pip cache'              = "$env:LOCALAPPDATA\pip\Cache"
  'Gradle cache'           = "$env:USERPROFILE\.gradle"
  'Maven repo'             = "$env:USERPROFILE\.m2"
  'Cargo registry'         = "$env:USERPROFILE\.cargo"
  'NuGet packages'         = "$env:USERPROFILE\.nuget\packages"
  'Go module cache'        = "$env:USERPROFILE\go\pkg\mod"
  'Docker Desktop data'    = "$env:LOCALAPPDATA\Docker"
  'WSL / Docker distros'   = "$env:LOCALAPPDATA\Docker\wsl"
  'Chrome profile'         = "$env:LOCALAPPDATA\Google\Chrome\User Data"
  'Edge profile'           = "$env:LOCALAPPDATA\Microsoft\Edge\User Data"
  'Brave profile'          = "$env:LOCALAPPDATA\BraveSoftware"
  'VS Code cache'          = "$env:APPDATA\Code"
  'VS Code extensions'     = "$env:USERPROFILE\.vscode\extensions"
  'Cursor'                 = "$env:APPDATA\Cursor"
  'Cursor extensions'      = "$env:USERPROFILE\.cursor"
  'JetBrains'              = "$env:LOCALAPPDATA\JetBrains"
  'Slack'                  = "$env:APPDATA\Slack"
  'Discord'                = "$env:APPDATA\discord"
  'Teams'                  = "$env:APPDATA\Microsoft\Teams"
  'Spotify cache'          = "$env:LOCALAPPDATA\Spotify"
  'OneDrive'               = "$env:USERPROFILE\OneDrive"
  'Downloads'              = "$env:USERPROFILE\Downloads"
}
foreach ($k in $caches.Keys) { Show-Row $k $caches[$k] }

Write-Host ""
Write-Host "==== node_modules / build output IN YOUR CODE FOLDERS ====" -ForegroundColor Cyan
$roots = @(
  "$env:USERPROFILE\Documents", "$env:USERPROFILE\Desktop",
  "$env:USERPROFILE\source", "$env:USERPROFILE\Projects",
  'C:\dev', 'C:\projects', 'C:\src'
) | Where-Object { Test-Path -LiteralPath $_ }

$targets = 'node_modules','.next','dist','build','.turbo','.parcel-cache','.nuxt','.svelte-kit','target','.venv','venv','__pycache__'
$hits = foreach ($r in $roots) {
    Get-ChildItem -LiteralPath $r -Recurse -Directory -Force -Depth 6 -ErrorAction SilentlyContinue |
      Where-Object {
          $targets -contains $_.Name -and
          (($_.FullName -split '\\node_modules\\').Count -le 1)   # skip nested copies
      }
}
$sized = $hits | ForEach-Object {
    [pscustomobject]@{ Bytes = (Size-Of $_.FullName); Path = $_.FullName }
}
$sized | Sort-Object Bytes -Descending | Select-Object -First 40 |
  ForEach-Object { '{0}  {1}' -f (GB $_.Bytes), $_.Path }

$total = ($sized | Measure-Object -Property Bytes -Sum).Sum
if ($null -eq $total) { $total = 0 }
Write-Host ""
Write-Host ("TOTAL reclaimable from build/dependency folders: {0}" -f (GB ([int64]$total))) -ForegroundColor Yellow

Write-Host ""
Write-Host "==== SHADOW COPIES / SYSTEM RESTORE ====" -ForegroundColor Cyan
vssadmin list shadowstorage 2>&1 | Select-String -Pattern 'Used|Allocated|Maximum|For volume'

Write-Host ""
Write-Host "==== WINDOWS COMPONENT STORE (WinSxS) ====" -ForegroundColor Cyan
Dism /Online /Cleanup-Image /AnalyzeComponentStore 2>&1 | Select-String -Pattern 'Actual Size|Shared|Backups|Cache|Reclaimable|Recommended'

Write-Host ""
Write-Host "Report saved to: $report" -ForegroundColor Green
Stop-Transcript | Out-Null
