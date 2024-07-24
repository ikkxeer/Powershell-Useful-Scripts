function Sincronize-NTP {
    param (
        [int]$Wait = 4,
        [switch]$Confirm
    )
    if ($Confirm) {
        $ConfirmCommand = Read-Host 'Are you sure to sync NTP Server? ("Y" or "N")'
        if ($ConfirmCommand.Tolower() -eq "y") {
            Write-Host "Starting sync..." -Foregroundcolor Yellow
            Start-Sleep -Seconds $Wait
            W32tm /resync /force        
        }
        else {
            Write-host "The sync has been canceled!" -Foregroundcolor Red
        }
    }
    else {
        # Perform sync without confirmation if Confirm switch is not used
        Write-Host "Starting sync..." -ForegroundColor Yellow
        Start-Sleep -Seconds $Wait
        W32tm /resync /force
    }
}
