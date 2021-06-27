# get all usb devices which had been used on this system
$pathToDevices = "HKLM:\SYSTEM\CurrentControlSet\Enum\USBSTOR"
#check if path exists
if(-not (Test-Path $pathToDevices)){
	Write-Output "Path does not exist! Either on this system had never been used an usb story or you registry got problem..check path!"
}
$devices = Get-ChildItem $pathToDevices

foreach($item in $devices){
    $pathString = $item.ToString()
    $pathString = $pathString.Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    Get-ChildItem $pathString | Get-ItemProperty -Name FriendlyName | Select-Object -ExpandProperty FriendlyName
}
