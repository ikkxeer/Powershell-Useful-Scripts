$URL = Read-Host "Enter the URL of the website you want to monitor"
[int]$Interval = Read-Host "Set the interval seconds"

$Request = [System.Net.WebRequest]::Create($URL)
$Response = $Request.GetResponse()
$QueryStatus = [int]$Response.StatusCode

Clear-Host

Write-Host "Starting Monitoring to: $URL" -ForegroundColor Yellow
Write-Host " "

while ($true) {
    $Date = Get-Date -UFormat "%m/%d/%Y %T"
    $StateMessage = "$Date | The site status is:"

    if ($QueryStatus -eq 200) {
        Write-Host "$StateMessage UP!" -ForegroundColor Green
    }
    else {
        Write-Host "$StateMessage DOWN!" -ForegroundColor Red
    }
    Start-Sleep -Seconds $Interval
}


# Finally, we clean up the http request by closing it.
if ($Response -ne $null) { $Response.Close() }