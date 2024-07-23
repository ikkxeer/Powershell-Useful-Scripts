$PublicAddress = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
$PrivateAddress = Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet' } | Select-Object -ExpandProperty IPAddress
$AddressFamily = Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet' } | Select-Object -ExpandProperty AddressFamily
$Submask =  Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet' } | Select-Object -ExpandProperty PrefixLength
$MAC = Get-NetIPConfiguration | Where-Object { $_.InterfaceAlias -eq 'Ethernet' } | select @{n='IPv4Address';e={$_.IPv4Address[0]}}, @{n='MacAddress'; e={$_.NetAdapter.MacAddress}}
$ipInfo = Invoke-RestMethod -Uri "http://ipinfo.io/json"

Write-Host " "
Write-Host "GENERATING IP ADDRESS REPORT..." -ForegroundColor Yellow
Write-Host "---------------------------------" -ForegroundColor Yellow

$counter = 1
Write-Host "Public IP Address" -ForegroundColor Yellow
Write-Host $PublicAddress -ForegroundColor Green
Write-Host " "

Write-Host "Hostname Public IP" -ForegroundColor Yellow
Write-Host "Hostname: $($ipInfo.hostname)" -ForegroundColor Green
Write-Host " "

Write-Host "City of Public IP" -ForegroundColor Yellow
Write-Host "City: $($ipInfo.city)" -ForegroundColor Green
Write-Host " "

Write-Host "Organization of Public IP" -ForegroundColor Yellow
Write-Host "Organization: $($ipInfo.org)" -ForegroundColor Green
Write-Host " "

Write-Host "Postal Code of Public IP" -ForegroundColor Yellow
Write-Host "Postal Code: $($ipInfo.postal)" -ForegroundColor Green
Write-Host " "

Write-Host "TimeZone of Public IP" -ForegroundColor Yellow
Write-Host "Timezone: $($ipInfo.TimeZone)" -ForegroundColor Green
Write-Host " "

Write-Host "Private IP Address" -ForegroundColor Yellow
$PrivateAddress | ForEach-Object {
    Write-Host "$counter. $_" -ForegroundColor Green
    $counter++
}
Write-Host " "

$counter = 1
Write-Host "Sumbask of IP Address" -ForegroundColor Yellow
$Submask | ForEach-Object {
    Write-Host "$counter. $_" -ForegroundColor Green
    $counter++
}
Write-Host " "

$counter = 1
Write-Host "Address Family Private IPs" -ForegroundColor Yellow
$AddressFamily | ForEach-Object {
    Write-Host "$counter. $_" -ForegroundColor Green
    $counter++
}
Write-Host " "



Write-Host "MAC Address" -ForegroundColor Yellow
$MAC | ForEach-Object {
    Write-Host ("IPv4 Address: " + $_.IPv4Address.IPAddress) -ForegroundColor Green
    Write-Host ("MAC Address: " + $_.MacAddress) -ForegroundColor Green
}
Write-Host " "
