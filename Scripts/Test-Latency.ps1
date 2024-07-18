Write-Host "GENERATING LATENCY REPORT..." -ForegroundColor Yellow
Write-Host "--------------------------------" -ForegroundColor Yellow

# Save powershell version in a variable
$psVersion = $PSVersionTable.PSVersion.Major

# Function to determine latency status
function GetLatencyStatus {
    param($Latency)
    if ($Latency -lt 50) {
        return @{
            Status = "OK"
            Color = "Green"
        }  # OK
    } elseif ($Latency -lt 100) {
        return @{
            Status = "Regular"
            Color = "Yellow"
        }  # Regular
    } else {
        return @{
            Status = "Poor"
            Color = "Red"
        }  # Poor
    }
}

# Function to handle connection errors
function HandleConnectionError {
    Write-Host "Not accessible" -ForegroundColor Red
}

# Latency measurement to Google
Write-Host "Google:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyGoogle = Test-Connection 8.8.8.8 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency
    } else {
        $LatencyGoogle = Test-Connection 8.8.8.8 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }
    $LatencyGoogleAverage = ($LatencyGoogle | Measure-Object -Average).Average
    $StatusGoogle = GetLatencyStatus $LatencyGoogleAverage
    Write-Host "Average Latency: $LatencyGoogleAverage ms ($($StatusGoogle.Status))" -ForegroundColor $StatusGoogle.Color
} catch {
    HandleConnectionError
}
Write-Host ""

# Latency measurement to Cloudflare DNS
Write-Host "Cloudflare DNS:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyCloudflare = Test-Connection 1.1.1.1 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency
    } else {
        $LatencyCloudflare = Test-Connection 1.1.1.1 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }
    $LatencyCloudflareAverage = ($LatencyCloudflare | Measure-Object -Average).Average
    $StatusCloudflare = GetLatencyStatus $LatencyCloudflareAverage
    Write-Host "Average Latency: $LatencyCloudflareAverage ms ($($StatusCloudflare.Status))" -ForegroundColor $StatusCloudflare.Color
} catch {
    HandleConnectionError
}
Write-Host ""

# Latency measurement to OpenDNS
Write-Host "OpenDNS:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyOpenDNS = Test-Connection 208.67.222.222 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency
    } else {
        $LatencyOpenDNS = Test-Connection 208.67.222.222 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }   
    $LatencyOpenDNSAverage = ($LatencyOpenDNS | Measure-Object -Average).Average
    $StatusOpenDNS = GetLatencyStatus $LatencyOpenDNSAverage
    Write-Host "Average Latency: $LatencyOpenDNSAverage ms ($($StatusOpenDNS.Status))" -ForegroundColor $StatusOpenDNS.Color
} catch {
    HandleConnectionError
}
Write-Host ""

# Latency measurement to Verizon DNS
Write-Host "Verizon DNS:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyVerizon = Test-Connection 151.197.0.38 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency
    } else {
        $LatencyVerizon = Test-Connection 151.197.0.38 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }
    $LatencyVerizonAverage = ($LatencyVerizon | Measure-Object -Average).Average
    $StatusVerizon = GetLatencyStatus $LatencyVerizonAverage
    Write-Host "Average Latency: $LatencyVerizonAverage ms ($($StatusVerizon.Status))" -ForegroundColor $StatusVerizon.Color
} catch {
    HandleConnectionError
}
Write-Host ""

# Latency measurement to Amazon AWS
Write-Host "Amazon AWS:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyAWS = Test-Connection 18.216.200.189 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency

    } else {
        $LatencyAWS = Test-Connection 18.216.200.189 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }
    $LatencyAWSAverage = ($LatencyAWS | Measure-Object -Average).Average
    $StatusAWS = GetLatencyStatus $LatencyAWSAverage
    Write-Host "Average Latency: $LatencyAWSAverage ms ($($StatusAWS.Status))" -ForegroundColor $StatusAWS.Color
} catch {
    HandleConnectionError
}
Write-Host ""

# Latency measurement to Microsoft Azure
Write-Host "Microsoft Azure:" -ForegroundColor Yellow
try {
    if ($psVersion -ge 7) {
        $LatencyAzure = Test-Connection 18.216.200.189 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty Latency
    } else {
        $LatencyAzure = Test-Connection 18.216.200.189 -Count 5 -ErrorAction Stop | Select-Object -ExpandProperty ResponseTime
    }
    $LatencyAzureAverage = ($LatencyAzure | Measure-Object -Average).Average
    $StatusAzure = GetLatencyStatus $LatencyAzureAverage
    Write-Host "Average Latency: $LatencyAzureAverage ms ($($StatusAzure.Status))" -ForegroundColor $StatusAzure.Color
} catch {
    HandleConnectionError
}
Write-Host ""
