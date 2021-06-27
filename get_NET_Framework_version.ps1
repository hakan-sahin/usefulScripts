# Get the Version of NET-Framework on curren system
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Net Framework Setup\NDP\v4\Full" | Get-ItemProperty -Name Version | Select-Object -ExpandProperty Version