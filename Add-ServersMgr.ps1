Get-Process ServerManager -ErrorAction SilentlyContinue | Stop-Process –force -ErrorAction SilentlyContinue

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

$SelectedUser = Select-User -userList $Users
Write-Host " " 
Write-Host "Selected User: $SelectedUser" -ForegroundColor Green
Write-Host " " 

$ProfilePath = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath -match "\\$SelectedUser$" }).LocalPath

Write-Output "Profile Path: $ProfilePath"
Write-Host " " 
$PathCheck = Test-Path $ProfilePath

if ($PathCheck -eq $true) {
    Write-Host "The selected path is correct and verified, continuing..." -ForegroundColor Yellow
    Write-Host " "
    Pause
    Write-Host " "
    $Config_file = get-item "$ProfilePath\AppData\Roaming\Microsoft\Windows\ServerManager\ServerList.xml"

    # Format XML File
    [xml]$xmlContent = Get-Content $Config_file
    $settings = New-Object System.Xml.XmlWriterSettings
    $settings.Indent = $true
    $settings.IndentChars = "  "
    $settings.NewLineOnAttributes = $false
    $writer = [System.Xml.XmlWriter]::Create($Config_file, $settings)
    $xmlContent.WriteTo($writer)
    $writer.Close()

    [xml]$xmlDocument = Get-Content -Path $Config_file
    $newServerName = Read-Host "Enter the server name to add"
    $namespaceURI = $xmlDocument.DocumentElement.NamespaceURI
    $serverInfo = $xmlDocument.CreateElement("ServerInfo", $namespaceURI)
    $serverInfo.SetAttribute("name", $newServerName)
    $serverInfo.SetAttribute("status", "1")
    $serverInfo.SetAttribute("lastUpdateTime", (Get-Date).ToString("o"))
    $serverInfo.SetAttribute("locale", "en-US")

    $xmlDocument.ServerList.AppendChild($serverInfo)
    $xmlDocument.Save($Config_file)

    Write-Host "Server added successfully!" -ForegroundColor Green
    Write-Host " "
    Pause

} else {
    Write-Host "The selected path does not exist!" -ForegroundColor Red
    Write-Host " "
    Pause
    Exit
}
