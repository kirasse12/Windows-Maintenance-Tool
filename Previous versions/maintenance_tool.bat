@echo off
chcp 65001 >nul

rem -----------------------------------------------------------------
rem Configuration des logs
set "LOGDIR=%USERPROFILE%\MaintenanceTool\Logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"
for /f "tokens=2-4 delims=/ " %%a in ("%date%") do set "FD=%%c%%b%%a"
set "LOGFILE=%LOGDIR%\%COMPUTERNAME%_%FD%.log"
echo [%date% %time%] Script démarré >> "%LOGFILE%"
rem -----------------------------------------------------------------

rem Vérification des droits administrateur
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Droits administrateur requis. >> "%LOGFILE%"
    echo Veuillez relancer en tant qu'administrateur.
    pause
    exit /b
)

:menu
cls
color 07
echo +------------------------------------------------------+
echo ^| WINDOWS MAINTENANCE TOOL V2.9 – By Lil_Batti       ^|
echo +------------------------------------------------------+
echo.
echo      === WINDOWS UPDATES ===
echo   [1] Mise à jour Windows (winget upgrade)
echo.
echo      === SANTÉ DU SYSTÈME ===
echo   [2] Scan SFC      (sfc /scannow)
echo   [3] CheckHealth   (DISM /CheckHealth)
echo   [4] RestoreHealth (DISM /RestoreHealth)
echo.
echo      === RÉSEAU ===
echo   [5] Flush DNS / config DNS
echo   [6] Afficher info réseau (ipconfig /all)
echo   [7] Redémarrer adaptateurs réseau
echo   [8] Réparation réseau automatique
echo.
echo      === NETTOYAGE & OPTIMISATION ===
echo   [9] Nettoyage disque (cleanmgr)
echo  [10] CHKDSK avancé
echo  [11] Suppression fichiers temporaires
echo  [12] Nettoyage/optimisation registre
echo  [15] Nettoyage automatique du PC (analyse + réparation)
echo.
echo      === SUPPORT & AUTRES ===
echo  [13] Contact & support (Discord)
echo  [14] Quitter
echo.
choice /c 123456789ABCDE /n /m "Entrez votre choix : "
set "choice=%ERRORLEVEL%"

rem Mapping des choix
if "%choice%"=="1"  call :UpdateWindows
if "%choice%"=="2"  call :SFC
if "%choice%"=="3"  call :DISM_CheckHealth
if "%choice%"=="4"  call :DISM_RestoreHealth
if "%choice%"=="5"  call :DNS_Menu
if "%choice%"=="6"  call :IPConfig_All
if "%choice%"=="7"  call :RestartAdapters
if "%choice%"=="8"  call :NetworkRepair
if "%choice%"=="9"  call :DiskCleanup
if "%choice%"=="10" call :CHKDSK_Advanced
if "%choice%"=="11" call :Delete_Temp
if "%choice%"=="12" call :Registry_Cleanup
if "%choice%"=="13" call :Support_Info
if "%choice%"=="15" call :choice15
if "%choice%"=="14" goto :Exit

goto :menu

rem -----------------------------------------------------------------
:UpdateWindows
echo [%date% %time%] Lancement mise à jour winget >> "%LOGFILE%"
cls & echo Mise à jour Windows...
where winget >nul 2>&1 || (echo Winget non installé.>>"%LOGFILE%" & goto :menu)
winget upgrade --all --include-unknown
goto :menu

:SFC
echo [%date% %time%] Lancement SFC >> "%LOGFILE%"
cls & echo Analyse SFC en cours...
sfc /scannow
goto :menu

:DISM_CheckHealth
echo [%date% %time%] Lancement DISM CheckHealth >> "%LOGFILE%"
cls & echo Vérification DISM...
dism /online /cleanup-image /checkhealth
goto :menu

:DISM_RestoreHealth
echo [%date% %time%] Lancement DISM RestoreHealth >> "%LOGFILE%"
cls & echo Restauration DISM...
dism /online /cleanup-image /restorehealth
goto :menu

:DNS_Menu
echo [%date% %time%] Ouverture menu DNS >> "%LOGFILE%"
cls & echo Menu DNS...
rem (Insérer ici ton code DNS refactorisé ou appel de fonction)
goto :menu

:IPConfig_All
echo [%date% %time%] Affichage ipconfig >> "%LOGFILE%"
cls & ipconfig /all & pause
goto :menu

:RestartAdapters
echo [%date% %time%] Redémarrage adaptateurs >> "%LOGFILE%"
cls & netsh interface set interface "Wi-Fi" admin=disable
netsh interface set interface "Wi-Fi" admin=enable
pause
goto :menu

:NetworkRepair
echo [%date% %time%] Réparation réseau >> "%LOGFILE%"
cls
echo Réparation réseau automatique...
ipconfig /release >nul
ipconfig /renew   >nul
ipconfig /flushdns >nul
netsh winsock reset  >nul
netsh int ip reset  >nul
echo Réparation terminée. Redémarrage recommandé.
pause
goto :menu

:DiskCleanup
echo [%date% %time%] Lancement cleanmgr >> "%LOGFILE%"
cls & cleanmgr
goto :menu

:CHKDSK_Advanced
echo [%date% %time%] Lancement CHKDSK avancé >> "%LOGFILE%"
cls
wmic logicaldisk get caption | findstr : > drives.txt
for /f %%d in (drives.txt) do chkdsk %%d /f /r /x
del drives.txt
pause
goto :menu

:Delete_Temp
echo [%date% %time%] Suppression temporaires >> "%LOGFILE%"
cls & (
    del /s /f /q "%TEMP%\*.*"
    del /s /f /q "C:\Windows\Temp\*.*"
    del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*.*"
)
echo Fichiers temporaires supprimés.
pause
goto :menu

:Registry_Cleanup
echo [%date% %time%] Nettoyage registre >> "%LOGFILE%"
cls & rem (Insérer ici ton module registre refactorisé)
pause
goto :menu

:Support_Info
cls
echo Contact & support :
echo Discord : https://discord.gg/bCQqKHGxja
pause
goto :menu

:choice15
echo [%date% %time%] Lancement nettoyage auto >> "%LOGFILE%"
cls
echo ===============================================
echo   Nettoyage automatique du PC [Admin]
echo ===============================================
call :RunPSScript optimize.ps1
pause
goto :menu

:RunPSScript
rem Appelle un script PowerShell (%~1)
powershell -ExecutionPolicy Bypass -File "%~dp0%~1"
if %ERRORLEVEL% neq 0 (
    echo [%date% %time%] Erreur lors de %~1 (code %ERRORLEVEL%) >> "%LOGFILE%"
)
exit /b

:Exit
echo [%date% %time%] Script terminé >> "%LOGFILE%"
exit /b
