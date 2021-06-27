# get all usb devices which had been used on this system
$pathToDevices = "HKLM:\SYSTEM\CurrentControlSet\Enum\USBSTOR"
$devices = Get-ChildItem $pathToDevices

foreach($item in $devices){
    $pathString = $item.ToString()
    $pathString = $pathString.Replace("HKEY_LOCAL_MACHINE", "HKLM:")
    Get-ChildItem $pathString | Get-ItemProperty -Name FriendlyName | Select-Object -ExpandProperty FriendlyName
}