$Password = Get-Content -Path ".\Password.txt"
$DecryptProcess = $Password | ConvertTo-SecureString
$Code = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DecryptProcess))
Write-Host $Code