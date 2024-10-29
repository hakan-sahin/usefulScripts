$currDate = Get-Date -Format "dd-MM-yyyy hh:mm:ss"
$tmp = ""
while($true){
    if(-not (Test-Connection 8.8.8.8 -Count 1 -ErrorAction SilentlyContinue)){
        Write-Host "Verbindungsabbruch! Zeit der Nichterreichbarkeit: " $currDate
        "Verbindungsabbruch! Zeit der Nichterreichbarkeit: " + $currDate + "`n" | Out-File -FilePath "C:\tmp\connection.log" -Encoding utf8 -Append -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 1
    }else{
        Write-Host "Erfolgreiche Verbindung"
        #"Erfolgreiche Verbindung: " + $currDate + "`n" | Out-File -FilePath "C:\tmp\connection.log" -Encoding utf8 -Append -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 1
        clear
    }
}
