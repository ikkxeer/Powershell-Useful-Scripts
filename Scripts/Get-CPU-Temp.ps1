$temperatureInfo = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
foreach ($temp in $temperatureInfo.CurrentTemperature)
{
$tempKelvin = $temp / 10
$tempCelsius = $tempKelvin - 273.15
$finalTemp = "CPU Temperature: $tempCelsius"+"º"
}

Write-Host $finalTemp