$iplist = @("192.168.1.1", "google.com", "8.8.8.8", "1.1.1.1", "192.168.224.222")

foreach ($ip in $iplist) {
    $result = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($result) {
        Write-Host "$ip - CONNECTED" -ForegroundColor Green
    } else {
        Write-Host "$ip - NO CONNECTION" -ForegroundColor Red
    }
}
