Start-Transcript -Path C:\tmp\usb\log1.log

$sticks = Get-PnpDevice -Class 'USB'

foreach($stick in $sticks){
    Write-Host $stick
}



Stop-Transcript