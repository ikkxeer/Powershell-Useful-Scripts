param (
    [string]$IPAddress = "192.168.1.1",
    [int[]]$Ports = @(22, 80, 443)
)

foreach ($port in $Ports) {
    $tcpConnection = Test-NetConnection -ComputerName $IPAddress -Port $port
    if ($tcpConnection.TcpTestSucceeded) {
        Write-Output "Port $port in $IPAddress is open."
    } else {
        Write-Output "Port $port in $IPAddress is closed."
    }
}