Write-Host "`n=== WINDOWS CLEANING SCRIPT ===`n" -ForegroundColor Cyan

# 1. Suppression des fichiers temporaires
Write-Host "[*] Suppression des fichiers temporaires..." -ForegroundColor Yellow
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# 2. Nettoyage du cache Windows Update
Write-Host "[*] Nettoyage du cache Windows Update..." -ForegroundColor Yellow
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

# 3. Analyse de l’intégrité système (SFC)
Write-Host "[*] Exécution de sfc /scannow..." -ForegroundColor Yellow
sfc /scannow | Out-Host

# 4. Réparation de l’image système (DISM)
Write-Host "[*] Exécution de DISM /RestoreHealth..." -ForegroundColor Yellow
dism /online /cleanup-image /restorehealth | Out-Host

# 5. Liste des programmes au démarrage
Write-Host "`n[*] Programmes configurés au démarrage :" -ForegroundColor Magenta
Get-CimInstance Win32_StartupCommand |
    Select-Object Name, Command, Location |
    Format-Table -AutoSize | Out-Host

Write-Host "`n✅ Nettoyage et optimisation terminés. Redémarrage recommandé." -ForegroundColor Green
Pause
