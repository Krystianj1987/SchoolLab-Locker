# 🛡️ Pracownia-Zabezpieczenia (SchoolLab-Locker)

Zestaw skryptów automatyzujących zabezpieczanie komputerów w pracowniach szkolnych (Windows 10/11) opartych na lokalnych kontach użytkowników (bez środowiska Active Directory). 

Narzędzie zostało stworzone z myślą o administratorach pracujących w modelu "sneaker-net" (zarządzanie z pendrive'a). Pozwala na błyskawiczne zablokowanie, odblokowanie lub sprawdzenie statusu stacji roboczej za pomocą jednego, wygodnego menu.

## 🎯 Główny cel projektu
Standardowe konta użytkowników w systemie Windows nie mogą instalować oprogramowania w folderze `Program Files`. Jednak wiele aplikacji (np. **Roblox, Opera, Discord, Spotify**) obchodzi to zabezpieczenie, instalując się bezpośrednio w folderze profilowym ucznia (np. w `AppData` lub `Temp`). 

Ten zestaw skryptów rozwiązuje ten problem, uszczelniając system i blokując możliwość uruchamiania instalatorów z tych lokalizacji, niezależnie od nazwy konta ucznia.

## ✨ Główne funkcje
* **Blokada instalacji "per-user" (SRP):** Uniemożliwia uruchamianie plików `.exe` z folderów `%AppData%`, `%LocalAppData%`, `%Temp%`, `%USERPROFILE%\Downloads` oraz `%USERPROFILE%\Desktop`.
* **Uszczelnienie UAC:** Wymusza na systemie każdorazowe wyświetlanie monitu o hasło administratora przy próbie ingerencji w system przez ucznia.
* **Blokada Microsoft Store:** Zapobiega pobieraniu gier i aplikacji z wbudowanego sklepu Windows.
* **Blokada zmiany tapety:** Zapobiega zmianie tła pulpitu przez standardowych użytkowników.
* **Wyjątek dla Administratorów:** Nałożone restrykcje ścieżek omijają konta z uprawnieniami administratora.
* **Dynamiczne ścieżki:** Skrypty wykorzystują rozwijalne zmienne środowiskowe (ExpandString), dzięki czemu działają w 100% poprawnie bez względu na to, czy konto ucznia nazywa się "Uczeń", "Student", czy "Stanowisko_01".

## 📦 Zawartość repozytorium
Projekt składa się z 4 zintegrowanych plików:
1. `MENU.bat` - Główny interfejs dla administratora (omija domyślne blokady wykonywania skryptów PS w systemie).
2. `Zabezpieczenia.ps1` - Skrypt wykonawczy nakładający restrykcje.
3. `Odblokowanie.ps1` - Skrypt wykonawczy cofający wszystkie zmiany (tryb serwisowy).
4. `Status.ps1` - Skrypt analityczny, który w ułamku sekundy sprawdza rejestr i wyświetla czytelny raport o stanie zabezpieczeń.

## 🚀 Instrukcja użycia
1. Pobierz wszystkie 4 pliki i umieść je w **jednym folderze** (np. na swoim pendrive'zie serwisowym).
2. Zaloguj się na docelowym komputerze na konto z uprawnieniami **Administratora**.
3. Kliknij prawym przyciskiem myszy na plik `MENU.bat` i wybierz **Uruchom jako administrator**.
4. Z poziomu menu wpisz odpowiednią cyfrę (1, 2, 3 lub 4), aby zarządzać stacją.

## 💡 Ważna wskazówka dla administratorów (Instalacja oprogramowania)
Po nałożeniu blokady (Opcja 1), system operacyjny działa w rygorystycznym trybie. Jeśli będąc na koncie Administratora spróbujesz kliknąć dwukrotnie instalator pobrany np. do folderu *Pobrane*, system zablokuje akcję. 

**Jak instalować programy bez zdejmowania blokady?**
* Kliknij na instalator prawym przyciskiem myszy i wybierz **Uruchom jako administrator**. Pozwoli to pominąć nałożone restrykcje ścieżek.
* Alternatywnie: przenieś plik instalacyjny do folderu nieobjętego blokadą (np. bezpośrednio na dysk `C:\Instalki\`) i uruchom go normalnie. Do większych prac serwisowych używaj opcji *Odblokuj* (Opcja 2) z poziomu `MENU.bat`.

---
*Stworzone przez szkolnego admina, dla szkolnych adminów.*
