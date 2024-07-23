$DiskLetters = Get-Volume | Select-Object -ExpandProperty DriveLetter

foreach ($Letter in $DiskLetters) {
    Optimize-Volume -DriveLetter $Letter -Analyze -Verbose
    Write-Host " "
}
