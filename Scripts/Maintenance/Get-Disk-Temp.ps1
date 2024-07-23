$DiskTemp = Get-Disk | Get-StorageReliabilityCounter | Select-Object -ExpandProperty Temperature

$Counter = 0
foreach ($Temp in $DiskTemp) {
    $Counter += 1
    Write-Host "The temperature of the disk number $Counter is: $Temp"
}