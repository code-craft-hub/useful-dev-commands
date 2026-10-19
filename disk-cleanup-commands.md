# Disk cleanup — command sheet (Windows, ADMIN)

Nothing here runs automatically. Copy the blocks you want.

**Legend:** 🟢 zero risk · 🟡 safe, costs a re-download/rebuild · 🟠 read the note first

Open **Terminal (Admin)**: right-click Start → *Terminal (Admin)* / *Windows PowerShell (Admin)*.

---

## Tier 0 — run these first (works even at 0 bytes free) 🟢

```powershell
# Recycle Bin, all drives
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# Your temp folder + the system temp folder
Remove-Item "$env:TEMP\*"        -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*"  -Recurse -Force -ErrorAction SilentlyContinue

# Crash dumps and error reports
Remove-Item "$env:LOCALAPPDATA\CrashDumps\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\ProgramData\Microsoft\Windows\WER\ReportQueue\*"    -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\ProgramData\Microsoft\Windows\WER\ReportArchive\*"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\MEMORY.DMP" -Force -ErrorAction SilentlyContinue
```

Typical: 2–15 GB.

---

## Tier 1 — dev caches (your biggest win, you're a pnpm/node machine) 🟡

### Package manager stores

```powershell
pnpm store path          # see where it lives first
pnpm store prune         # drops packages no project references
npm  cache clean --force
yarn cache clean         # if you use yarn
pip  cache purge         # if you use python
go   clean -modcache     # if you use go
dotnet nuget locals all --clear
```

If `pnpm store prune` doesn't free enough, nuke the whole store — it fully rebuilds on the next `pnpm install`:

```powershell
Remove-Item "$env:LOCALAPPDATA\pnpm-store" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\pnpm\store" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\.npm\_cacache" -Recurse -Force -ErrorAction SilentlyContinue
```

### Downloaded browser/test binaries (these are huge and re-download on demand)

```powershell
Remove-Item "$env:LOCALAPPDATA\ms-playwright"   -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\.cache\puppeteer" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Cypress\Cache"   -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\electron"        -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\electron-builder" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\node-gyp"        -Recurse -Force -ErrorAction SilentlyContinue
```

### node_modules across your projects

You have 6 project trees under `Documents\PNPM`: `clear-arch-frontend`, `cverai-ui`, `env`, `extension`, `nodejs-nextjs-firebase`, `v2-cverai`. Each `node_modules` is usually 300 MB – 2 GB.

**Preview first (deletes nothing):**

```powershell
Get-ChildItem "$env:USERPROFILE\Documents\PNPM" -Recurse -Directory -Force -Depth 4 -EA SilentlyContinue |
  Where-Object { $_.Name -in @('node_modules','.next','dist','build','.turbo','.vite') -and
                 ($_.FullName -split '\\node_modules\\').Count -le 1 } |
  ForEach-Object {
    [pscustomobject]@{
      GB   = [math]::Round((Get-ChildItem $_.FullName -Recurse -File -Force -EA SilentlyContinue |
                            Measure-Object Length -Sum).Sum / 1GB, 2)
      Path = $_.FullName } } |
  Sort-Object GB -Descending | Format-Table -AutoSize
```

**Then delete.** Windows `Remove-Item` chokes on deep node_modules paths — `robocopy` mirroring an empty folder is far faster and never fails:

```powershell
$empty = "$env:TEMP\__empty__"; New-Item -ItemType Directory -Path $empty -Force | Out-Null

# EDIT this list to only the projects you are NOT actively working on
$kill = @(
  "$env:USERPROFILE\Documents\PNPM\clear-arch-frontend\node_modules",
  "$env:USERPROFILE\Documents\PNPM\cverai-ui\node_modules",
  "$env:USERPROFILE\Documents\PNPM\extension\node_modules",
  "$env:USERPROFILE\Documents\PNPM\nodejs-nextjs-firebase\node_modules",
  "$env:USERPROFILE\Documents\PNPM\v2-cverai\frontend\node_modules"
)
foreach ($p in $kill) {
  if (Test-Path -LiteralPath $p) {
    Write-Host "Removing $p"
    robocopy $empty $p /MIR /NFL /NDL /NJH /NJS /NC /NS | Out-Null
    Remove-Item -LiteralPath $p -Recurse -Force -EA SilentlyContinue
  }
}
Remove-Item $empty -Recurse -Force
```

Restore any one of them later with `pnpm install` in that folder.

### Git repacking

```powershell
Get-ChildItem "$env:USERPROFILE\Documents\PNPM" -Directory -Depth 2 -Force |
  Where-Object { Test-Path "$($_.FullName)\.git" } |
  ForEach-Object { git -C $_.FullName gc --prune=now --aggressive }
```

---

## Tier 2 — Windows system 🟡 / 🟠

```powershell
# Windows Update download cache — stop the services first
Stop-Service wuauserv, bits -Force
Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -EA SilentlyContinue
Start-Service wuauserv, bits

# Delivery Optimization peer cache
Delete-DeliveryOptimizationCache -Force

# Old logs
Remove-Item "C:\Windows\Logs\CBS\*" -Recurse -Force -EA SilentlyContinue

# Thumbnail / icon cache (Explorer rebuilds it)
Stop-Process -Name explorer -Force
Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db" -Force -EA SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache_*.db"  -Force -EA SilentlyContinue
Start-Process explorer
```

🟠 **Hibernation file** — frees roughly 40–75% of your RAM size (often 4–12 GB). Turns off Fast Startup and hibernate:

```powershell
powercfg /h off
```

🟠 **System Restore points / shadow copies** — can be 5–20 GB. You lose the ability to roll back:

```powershell
vssadmin list shadowstorage          # check size first
vssadmin delete shadows /for=C: /all /quiet
```

🟠 **Windows component store (WinSxS)** — `/ResetBase` means installed updates can no longer be uninstalled:

```powershell
Dism /Online /Cleanup-Image /AnalyzeComponentStore
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
```

🟠 **`C:\Windows.old`** — 15–30 GB if it exists (left by a Windows upgrade). Don't `rmdir` it; use Disk Cleanup, which handles the permissions:

```powershell
cleanmgr /sageset:65    # tick "Previous Windows installation(s)", "Windows Update Cleanup", etc.
cleanmgr /sagerun:65
```

---

## Tier 3 — apps 🟢

```powershell
# Close Chrome/Edge completely first
foreach ($base in @("$env:LOCALAPPDATA\Google\Chrome\User Data","$env:LOCALAPPDATA\Microsoft\Edge\User Data")) {
  foreach ($sub in 'Cache','Code Cache','GPUCache','Service Worker\CacheStorage','DawnGraphiteCache','DawnWebGPUCache') {
    Get-ChildItem $base -Directory -EA SilentlyContinue | ForEach-Object {
      Remove-Item (Join-Path $_.FullName $sub) -Recurse -Force -EA SilentlyContinue
    }
  }
}

# VS Code / Cursor
foreach ($app in "$env:APPDATA\Code", "$env:APPDATA\Cursor") {
  foreach ($sub in 'Cache','CachedData','Code Cache','GPUCache','logs','User\workspaceStorage') {
    Remove-Item (Join-Path $app $sub) -Recurse -Force -EA SilentlyContinue
  }
}

# Store app caches
Get-ChildItem "$env:LOCALAPPDATA\Packages" -Directory | ForEach-Object {
  Remove-Item "$($_.FullName)\LocalCache\*" -Recurse -Force -EA SilentlyContinue
}
```

---

## Tier 4 — Docker / WSL 🟠

If Docker Desktop is installed this is often the single biggest item on the disk. Pruning inside Docker does **not** shrink the virtual disk — you have to compact it afterwards.

```powershell
docker system prune -a --volumes      # inside Docker
wsl --shutdown                        # required before compacting
```

Then compact the virtual disk (find the real path first with `dir $env:LOCALAPPDATA\Docker\wsl -Recurse -Filter *.vhdx`):

```
diskpart
select vdisk file="C:\Users\ADMIN\AppData\Local\Docker\wsl\disk\docker_data.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
exit
```

On Windows 11 you can instead make WSL disks auto-shrink: `wsl --manage <distro> --set-sparse true`.

---

## Do NOT delete

- `C:\Windows\System32`, `C:\Program Files*`, `pagefile.sys`, `swapfile.sys`
- Anything in `AppData\Roaming` wholesale — that's app settings and logins, not cache
- `.env` files in your projects (your `auth-server\.env` holds real secrets and is not in git)
- `src`, `drizzle`, `tests`, `docs`, `postman`, `.git` in any project
- `%LOCALAPPDATA%\Packages\...\LocalState` (app data, unlike `LocalCache`)

---

## Keep it from filling up again

```powershell
# Storage Sense: auto-clean temp files and Recycle Bin
Start-Process ms-settings:storagesense
```

Then set the pnpm store on a different drive if you have one, so dependency caches never touch C: — put `store-dir=D:\pnpm-store` in `%USERPROFILE%\.npmrc`.
