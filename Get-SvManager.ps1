$Users = Get-WmiObject -Class Win32_UserProfile | Where-Object { 
    $_.Special -eq $false -and $_.LocalPath -match "^C:\\Users\\" 
} | ForEach-Object {
    $username = $_.LocalPath.Split("\")[-1]
    $username
}

for ($i = 0; $i -lt $Users.Count; $i++) {
    Write-Output "$($i + 1): $($Users[$i])"
}

function Select-User {
    param (
        [array]$userList
    )
    
    while ($true) {
        $selection = Read-Host "Select the user to apply"
        
        if ($selection -match '^\d+$' -and [int]$selection -gt 0 -and [int]$selection -le $userList.Count) {
            return $userList[[int]$selection - 1]
        } else {
            Write-Output "Invalid selection, please try again."
        }
    }
}

$UserSelected = Select-User -userList $Users
Write-Host " " 
Write-Host "Selected User: $UserSelected" -ForegroundColor Green
Write-Host " " 

$ProfilePath = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath -match "\\$UserSelected$" }).LocalPath

Write-Output "Profile path $ProfilePath"
Write-Host " " 

$CheckPath = Test-Path $ProfilePath

if ($CheckPath -eq $true) {
	Write-Host "The selected route is correct and verified, continue..." -ForegroundColor Yellow
	Write-Host " "
	Pause
	$Config_file = get-item "$ProfilePath\AppData\Roaming\Microsoft\Windows\ServerManager\ServerList.xml"

[xml]$xmlDocument = Get-Content -Path $Config_file

$xmlDocument.ServerList.ServerInfo | ForEach-Object {
    $TimeNotFormated = $_.LastUpdateTime
    $DateTime = [DateTimeOffset]::Parse($TimeNotFormated).DateTime
    $ReadableDate = $dateTime.ToString('dddd, MMMM dd, yyyy hh:mm tt')
    [PSCustomObject]@{
        'Server Name' = $_.Name
        'Status'    = $_.Status
        'Last Update Time' = $ReadableDate
    }
}

}

else {
	Write-Host "The selected route does not exist!" -ForegroundColor Red
	Write-Host " "
	Pause
	Exit
}