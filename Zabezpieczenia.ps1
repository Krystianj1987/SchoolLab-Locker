# OSTATECZNA WERSJA - Skrypt zabezpieczajacy pracownie (z blokada tapety)
Write-Host "Rozpoczynam konfiguracje zabezpieczen systemu..." -ForegroundColor Cyan

# 1. Konfiguracja UAC (Wymuszenie hasla dla standardowych uzytkownikow)
Write-Host "KROK 1: Konfiguracja UAC..."
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Set-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorUser" -Value 1 -Force 
Set-ItemProperty -Path $uacPath -Name "EnableInstallerDetection" -Value 1 -Force 

# 2. Wylaczenie Microsoft Store
Write-Host "KROK 2: Wylaczanie Microsoft Store..."
$storePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
if (!(Test-Path $storePath)) { New-Item -Path $storePath -Force | Out-Null }
Set-ItemProperty -Path $storePath -Name "RemoveWindowsStore" -Value 1 -Force

# 3. Restrykcje Oprogramowania (SRP) - Odporne na rozne nazwy kont
Write-Host "KROK 3: Konfiguracja SRP (Blokada folderow instalacyjnych)..."
$srpBasePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"

if (!(Test-Path $srpBasePath)) { New-Item -Path $srpBasePath -Force | Out-Null }
Set-ItemProperty -Path $srpBasePath -Name "AuthenticodeEnabled" -Value 0 -Force
Set-ItemProperty -Path $srpBasePath -Name "DefaultLevel" -Value 262144 -Force 
Set-ItemProperty -Path $srpBasePath -Name "TransparentEnabled" -Value 1 -Force
Set-ItemProperty -Path $srpBasePath -Name "PolicyScope" -Value 1 -Force # Wyjatek dla Administratorow

$srpPathsPath = "$srpBasePath\0\Paths"
if (!(Test-Path $srpPathsPath)) { New-Item -Path $srpPathsPath -Force | Out-Null }

$pathsToBlock = @(
    "%USERPROFILE%\Downloads",
    "%USERPROFILE%\Desktop",
    "%Temp%",
    "%LocalAppData%\Roblox",
    "%LocalAppData%\Programs"
)

foreach ($path in $pathsToBlock) {
    $guid = "{" + [guid]::NewGuid().ToString().ToUpper() + "}"
    $rulePath = "$srpPathsPath\$guid"
    New-Item -Path $rulePath -Force | Out-Null
    # Uzycie ExpandString zapewnia poprawne tlumaczenie %USERPROFILE% dla kazdego ucznia
    New-ItemProperty -Path $rulePath -Name "ItemData" -Value $path -PropertyType ExpandString -Force | Out-Null
    Set-ItemProperty -Path $rulePath -Name "SaferFlags" -Value 0 -Force
    Set-ItemProperty -Path $rulePath -Name "Description" -Value "Blokada pracowni: $path" -Force
}

# 4. Blokada zmiany tapety (Nowa funkcja)
Write-Host "KROK 4: Blokowanie mozliwosci zmiany tapety..."
$wallpaperPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"
if (!(Test-Path $wallpaperPath)) { New-Item -Path $wallpaperPath -Force | Out-Null }
Set-ItemProperty -Path $wallpaperPath -Name "NoChangingWallPaper" -Value 1 -Force

# 5. Odswiezenie
Write-Host "KROK 5: Odswiezanie zasad grupy..."
gpupdate /force | Out-Null

Write-Host "--------------------------------------------------------"
Write-Host "Gotowe! Komputer zabezpieczony. Uruchom ponownie system." -ForegroundColor Green
Write-Host "--------------------------------------------------------"
Start-Sleep -Seconds 4