$PasswordSecureString = Read-Host "Write your password" -AsSecureString
$PasswordEncrypted = ConvertFrom-SecureString -SecureString $PasswordSecureString
$PasswordPath = ".\Password.txt"
$PasswordEncrypted | Out-File -FilePath $PasswordPath
