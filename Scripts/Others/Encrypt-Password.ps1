$PassowrdInput = Read-Host "Write your password"

$PasswordText = $PassowrdInput
$PasswordSecureString = ConvertTo-SecureString $PasswordText -AsPlainText -Force
$PasswordEncrypted = ConvertFrom-SecureString -SecureString $PasswordSecureString
$PasswordPath = ".\Password.txt"
$PasswordEncrypted | Out-File -FilePath $PasswordPath
Write-Host "The Encrypted password have been saved in $PasswordPath!" -ForegroundColor Green
