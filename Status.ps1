# OSTATECZNA WERSJA - Skrypt sprawdzajacy status zabezpieczen
Clear-Host
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "            STATUS ZABEZPIECZEN PRACOWNI           " 
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

# Zmienne przechowujace stan
$isUacBlocked = $false
$isStoreBlocked = $false
$isSrpBlocked = $false
$isWallpaperBlocked = $false

# 1. Sprawdzanie UAC
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$uacValue = (Get-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorUser" -ErrorAction SilentlyContinue).ConsentPromptBehaviorUser
if ($uacValue -eq 1) { $isUacBlocked = $true }

# 2. Sprawdzanie Microsoft Store
$storePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
$storeValue = (Get-ItemProperty -Path $storePath -Name "RemoveWindowsStore" -ErrorAction SilentlyContinue).RemoveWindowsStore
if ($storeValue -eq 1) { $isStoreBlocked = $true }

# 3. Sprawdzanie SRP (Blokady instalatorow)
$srpPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
if (Test-Path $srpPath) { $isSrpBlocked = $true }

# 4. Sprawdzanie Tapety
$wallpaperPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"
$wallpaperValue = (Get-ItemProperty -Path $wallpaperPath -Name "NoChangingWallPaper" -ErrorAction SilentlyContinue).NoChangingWallPaper
if ($wallpaperValue -eq 1) { $isWallpaperBlocked = $true }

# WYSWIETLANIE WYNIKOW GLOBALNYCH
if ($isUacBlocked -and $isStoreBlocked -and $isSrpBlocked -and $isWallpaperBlocked) {
    Write-Host " OGOLNY STATUS: " -NoNewline
    Write-Host "[ ZABLOKOWANY ]" -ForegroundColor Red
    Write-Host " Komputer jest w pelni zabezpieczony przed uczniami." -ForegroundColor DarkGray
} elseif (-not $isUacBlocked -and -not $isStoreBlocked -and -not $isSrpBlocked -and -not $isWallpaperBlocked) {
    Write-Host " OGOLNY STATUS: " -NoNewline
    Write-Host "[ ODBLOKOWANY ]" -ForegroundColor Green
    Write-Host " Komputer jest w trybie serwisowym (brak restrykcji)." -ForegroundColor DarkGray
} else {
    Write-Host " OGOLNY STATUS: " -NoNewline
    Write-Host "[ MIESZANY / NIEPELNY ]" -ForegroundColor Yellow
    Write-Host " Uwaga: Tylko czesc zabezpieczen jest aktywna!" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host " SZCZEGOLY:"
if ($isSrpBlocked) { Write-Host " - Blokada instalatorow (AppData/Pobrane): AKTYWNA" -ForegroundColor Red } 
else { Write-Host " - Blokada instalatorow (AppData/Pobrane): BRAK" -ForegroundColor Green }

if ($isUacBlocked) { Write-Host " - UAC (Wymuszenie hasla administratora) : AKTYWNE" -ForegroundColor Red } 
else { Write-Host " - UAC (Wymuszenie hasla administratora) : DOMYSLNE" -ForegroundColor Green }

if ($isStoreBlocked) { Write-Host " - Sklep Microsoft Store                 : ZABLOKOWANY" -ForegroundColor Red } 
else { Write-Host " - Sklep Microsoft Store                 : DOSTEPNY" -ForegroundColor Green }

if ($isWallpaperBlocked) { Write-Host " - Zmiana tapety na pulpicie             : ZABLOKOWANA" -ForegroundColor Red } 
else { Write-Host " - Zmiana tapety na pulpicie             : DOSTEPNA" -ForegroundColor Green }

Write-Host ""
Write-Host "===================================================" -ForegroundColor Cyan