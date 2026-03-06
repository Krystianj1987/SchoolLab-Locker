@echo off
title Zarzadzanie Pracownia - Menu
color 0B

:check_admin
:: Sprawdzanie, czy plik zostal uruchomiony jako Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 4F
    echo ===================================================
    echo  BLAD: Brak uprawnien Administratora!
    echo  Kliknij na plik MENU.bat prawym przyciskiem myszy
    echo  i wybierz "Uruchom jako administrator".
    echo ===================================================
    echo.
    pause
    exit
)

:menu
cls
color 0B
echo ===================================================
echo             MENU ZARZADZANIA PRACOWNIA
echo ===================================================
echo.
echo  1. ZABLOKUJ komputer (Restrykcje wlaczone)
echo  2. ODBLOKUJ komputer (Tryb serwisowy)
echo  3. SPRAWDZ STATUS    (Czy komputer jest zablokowany?)
echo  4. Wyjscie
echo.
echo ===================================================
set /p choice="Wybierz opcje (1-4): "

if "%choice%"=="1" goto blokuj
if "%choice%"=="2" goto odblokuj
if "%choice%"=="3" goto status
if "%choice%"=="4" goto koniec

:: Jesli wpisano cos innego
echo Nieprawidlowy wybor. Sprobuj ponownie.
timeout /t 2 >nul
goto menu

:blokuj
cls
color 0E
echo ===================================================
echo       Uruchamianie procedury BLOKOWANIA...
echo ===================================================
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Zabezpieczenia.ps1"
echo.
echo Operacja zakonczona. Nacisnij dowolny klawisz, aby wrocic do menu.
pause >nul
goto menu

:odblokuj
cls
color 0A
echo ===================================================
echo       Uruchamianie procedury ODBLOKOWANIA...
echo ===================================================
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Odblokowanie.ps1"
echo.
echo Operacja zakonczona. Nacisnij dowolny klawisz, aby wrocic do menu.
pause >nul
goto menu

:status
cls
color 07
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Status.ps1"
echo.
echo Nacisnij dowolny klawisz, aby wrocic do menu.
pause >nul
goto menu

:koniec
exit