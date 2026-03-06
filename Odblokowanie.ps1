# OSTATECZNA WERSJA - Skrypt zdejmujacy zabezpieczenia pracowni
Write-Host "Rozpoczynam usuwanie restrykcji systemu (Tryb Serwisowy)..." -ForegroundColor Cyan

# 1. Przywrocenie domyslnych ustawien UAC
Write-Host "KROK 1: Przywracanie domyslnych ustawien UAC..."
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Set-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorUser" -Value 3 -Force 

# 2. Odblokowanie Microsoft Store
Write-Host "KROK 2: Odblokowywanie Microsoft Store..."
$storePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
if (Test-Path $storePath) { 
    Remove-ItemProperty -Path $storePath -Name "RemoveWindowsStore" -ErrorAction SilentlyContinue
}

# 3. Usuniecie Zasad Ograniczen Oprogramowania (SRP)
Write-Host "KROK 3: Usuwanie regul blokujacych instalatory (SRP)..."
$srpBasePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
if (Test-Path $srpBasePath) { 
    Remove-Item -Path $srpBasePath -Recurse -Force 
}

# 4. Odblokowanie zmiany tapety
Write-Host "KROK 4: Odblokowywanie mozliwosci zmiany tapety..."
$wallpaperPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"
if (Test-Path $wallpaperPath) {
    Remove-ItemProperty -Path $wallpaperPath -Name "NoChangingWallPaper" -ErrorAction SilentlyContinue
}

# 5. Aktualizacja zasad grupy w tle
Write-Host "KROK 5: Odswiezanie zasad grupy systemu Windows..."
gpupdate /force | Out-Null

Write-Host "========================================================"
Write-Host "Gotowe! Restrykcje zostaly zdjete. Mozesz instalowac." -ForegroundColor Green
Write-Host "========================================================"
Start-Sleep -Seconds 3