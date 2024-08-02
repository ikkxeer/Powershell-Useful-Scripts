function Connect-To-Graph {
    param (
        [string]$TenantId,
        [string]$ClientId,
        [string]$ClientSecret
    )

    Write-Host " "
    Write-Host "Connecting to Microsoft Graph with the provided credentials..." -ForegroundColor Yellow
    Start-Sleep -Seconds 1

    try {
        $ClientSecretPass = ConvertTo-SecureString -String $ClientSecret -AsPlainText -Force
        $ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $ClientSecretPass
        Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $ClientSecretCredential -NoWelcome

        # Verify the connection
        $me = Get-MgUser
        Write-Host " "
        Write-Host "Successfully connected to Microsoft Graph!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host " "
        Write-Host "ERROR: An error occurred while connecting to Microsoft Graph..." -ForegroundColor Red
        Write-Host "Error details: $_" -ForegroundColor Red
        Write-Host " "
        return $false
    }
}

$connected = Connect-To-Graph -TenantId "" -ClientId "" -ClientSecret ""