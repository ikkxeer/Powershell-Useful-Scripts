$HighProcess = Get-Process | Select-Object CPU,Id,ProcessName | Sort-Object CPU -Descending | Select -first 10

Write-Host "PROCESSES WITH MORE CONSUMPTION" -BackgroundColor Green -ForegroundColor Black

$HighProcess