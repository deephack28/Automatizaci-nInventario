$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi 


$equipo = wmic bios get serialnumber
$SerialNumberEquipo = $equipo.SerialNumber
#$LogFile = "T:\monitors.txt"

function ToString
{
    param([array[]]$MyMessage)

    #$op = [char[]]$MyMessage

    Write-Host($MyMessage)
}


ForEach ($Monitor in $Monitors)
{
	$Manufacturer = ($Monitor.ManufacturerName -ne 0 | ForEach{[char]$_}) -join ""
	$Name = ($Monitor.UserFriendlyName -ne 0 | ForEach{[char]$_}) -join ""
	$Serial = ($Monitor.SerialNumberID -ne 0 | ForEach{[char]$_}) -join ""
	

    #Write-Host ($Monitor.SerialNumberID)
    #ToString($Monitor.SerialNumberID)


   
    
	#"$Manufacturer,$Name,$Serial" | Out-File $LogFile -append
    #$Manufacturer, $Name, $Serial, $SerialNumberEquipo
    


  $Manufacturer, $Name, $Serial 
}
$equipo 
