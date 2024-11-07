###########################################   File Information   #############################################
# Author     : Hakan Sahin
# Version    : 1.3.2
# Description: Powershell script for customize Windows 11 24H2
# Date       : 16-10-2024
##############################################################################################################

#########################################   Global Variables   ###############################################
$currDate = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
# set path for logfiles
$log = "C:\tmp\log.txt"
##############################################################################################################

#########################################   Functions   ######################################################
function logm([string]$loglevel, [string]$text){
    $tmp = "[$loglevel]|$currDate|:$text"
    Add-Content -Path $log -Value $tmp -Encoding UTF8
}
##############################################################################################################

# check if tmp directory and log file exists and create if not
if(-not (Test-Path -Path "C:\tmp") ){
    New-Item -Path "C:\tmp" -ItemType Directory -Force
    New-Item -Path "C:\tmp\log.txt" -ItemType File
}

##############################################################################################################
###################################   Removing Provisioned Apps   ############################################
##############################################################################################################
# apps to remove
$apps = @("Clipchamp.Clipchamp",
"Microsoft.BingNews",
"Microsoft.BingSearch",
"Microsoft.BingWeather",
"Microsoft.GamingApp",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.Paint",
"Microsoft.Todos",
"Microsoft.Windows.DevHome",
"Microsoft.Windows.Photos",
"Microsoft.WindowsCalculator",
"Microsoft.WindowsCamera",
"Microsoft.WindowsFeedbackHub",
"Microsoft.WindowsNotepad",
"Microsoft.WindowsSoundRecorder",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.YourPhone",
"MicrosoftCorporationII.QuickAssist",
"MicrosoftWindows.Client.WebExperience",
"MSTeams")

# length of array
$length = $apps.Length
# counter for progress bar
$counter = 1
logm "LOG" "Total Apps to remove: $length"

# start removing
foreach($app in $apps){
    $progress = [math]::Floor($counter/$length * 100)
    Write-Progress -Activity "Removing Provisioned Apps" -Status "Removing $app - $progress%" -PercentComplete $progress
    $counter++
    try{
        Get-AppxProvisionedPackage -Online | ? {$_.DisplayName -eq $app} | Remove-AppxProvisionedPackage -Online
        logm "LOG" "Removed: $app"
    }catch{
        logm "ERROR" $($_.Expection.Message)
    }
}

##############################################################################################################
###################################   Removing Optional Windows Features   ###################################
##############################################################################################################
# optional windows features to remove
$feautes = @("WorkFolders-Client", "Recall")
# length of array
$length = $feautes.Length
# counter for progress bar
$counter = 1
logm "LOG" "Total Features to remove: $length"

# start removing
foreach($feature in $feautes){
    $progress = [math]::Floor($counter/$length * 100)
    Write-Progress -Activity "Removing Optional Windows Features" -Status "Removing $feature - $progress%" -PercentComplete $progress
    $counter++
    
    try{
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
        logm "LOG" "Removed: $feature"
    }catch{
        logm "ERROR" $($_.Expection.Message)
    }
}


##############################################################################################################
#########################################   Registry Hacks   #################################################
##############################################################################################################
$totalRegs = 23
$counter = 1
$status = [math]::Floor( ($counter / $totalRegs)*100)

Write-Progress -Activity "Customization" -Status "Enable Numlock - $status%" -PercentComplete $status
# enable numlock before login
reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d 2147483650 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Disable Fastboot - $status%" -PercentComplete $status
# disable Fastboot
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Disable Telemetry - $status%" -PercentComplete $status
# disable Telemetrie
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v DOTNET_CLI_TELEMETRY_OPTOUT /d 1 /t REG_SZ /F
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Disable Capslock - $status%" -PercentComplete $status
# CAPS Lock deaktivieren
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "ScanCode Map" /t REG_BINARY /d 00000000000000000200000000003A0000000000 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Dateierweiterungen anzeigen - $status%" -PercentComplete $status
# Dateierweiterungen anzeigen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Versteckte Dateien anzeigen - $status%" -PercentComplete $status
# Versteckte Dateien anzeigen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Autom. auf aktuellen Ordner erweitern - $status%" -PercentComplete $status
#Autom. auf aktuellen Ordner erweitern 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v NavPaneExpandToCurrentFolder /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Elementkontrollkästchen deaktivieren - $status%" -PercentComplete $status
# Elementkontrollkaestchen deaktivieren
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v AutoCheckSelect /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Taskleiste Suchen ausgeblendet - $status%" -PercentComplete $status
# Taskleiste Suchen - Ausgeblendet (Aus = 0, Lupe/Cortana = 1, Suchfeld = 2) 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Kontakte ausblenden - $status%" -PercentComplete $status
# Schaltfläche "Kontakte" ausblenden
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Shortcut 'Dieser PC' - $status%" -PercentComplete $status
# ShortCut Windows+E "Dieser PC" (1) oder "Start" (2) oder OneDrive "4" empfohlen: 1, Performance, wenn ShowRecent/ShowFrequent aktiv 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Microsoft Store von Taskbar entfernen - $status%" -PercentComplete $status
# Store von Taskbar entfernen
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoPinningStoreToTaskbar /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Alle Systemsteuerungselemente - $status%" -PercentComplete $status
# Beim  ffnen der Systemsteuerung immer alle Systemsteuerungselemente  ffnen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v ForceClassicControlPanel /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Cortana Schaltfläche ausblenden - $status%" -PercentComplete $status
# 2004 Taskleiste Cortana-Schaltfl che anzeigen - Ausblenden
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCortanaButton /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Taskleiste Chat aus - $status%" -PercentComplete $status
# 11 21h2 - Personalisierung - Taskleiste - Chat aus
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Klassisches Explorerkontextmenü - $status%" -PercentComplete $status
# 11 - Klassisches (altes) Explorer Kontext Menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Gallery in Start ausblenden - $status%" -PercentComplete $status
# 11 - Katalog (Gallery) unterhalb Start ausblenden
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\NonEnum" /V "{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Startelemente ausblenden (Empfohlen, Favoriten) - $status%" -PercentComplete $status
# 11 - Start (mit Empfohlen + Favoriten) ausblenden
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\NonEnum" /V "{F874310E-B6B7-47DC-BC84-B9E6B38F5903}" /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "3D Objekte ausblenden - $status%" -PercentComplete $status
# 11/10 - 3D-Objekte ausblenden
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\NonEnum" /V "{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Recall deaktivieren - $status%" -PercentComplete $status
# Windows 11 24H2, RECALL (Screenshots alle 5 Sekunden
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Disable Widget Icon from Taskbar - $status%" -PercentComplete $status
# Disable Wiget Icon from Taskbar
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Write-Progress -Activity "Customization" -Status "Enable Game Mode - $status%" -PercentComplete $status
# Windows 11 24H2, RECALL (Screenshots alle 5 Sekunden
reg add "HKCU\SOFTWARE\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f
$counter++
$status = [math]::Floor( ($counter / $totalRegs)*100)
Start-Sleep -Seconds 1

Restart-Computer -Force