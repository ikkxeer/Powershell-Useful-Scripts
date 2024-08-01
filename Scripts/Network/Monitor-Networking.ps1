while ($true) {
    Clear-Host
    Get-NetAdapterStatistics | Format-Table -AutoSize
    Start-Sleep -Seconds 1
}
