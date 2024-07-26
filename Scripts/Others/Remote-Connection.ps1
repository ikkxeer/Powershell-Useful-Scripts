Enable-PSRemoting -Force

$ComputerName = Read-Host "Enter the computer name"
$Cred = Get-Credential

Enter-PSSession -ComputerName $ComputerName -Credential $Cred