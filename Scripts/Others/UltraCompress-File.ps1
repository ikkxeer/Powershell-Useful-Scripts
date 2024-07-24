$FilePath = Read-Host 'Please enter the file path (Without double quotes)'
$TestPathExists = Test-Path $FilePath
$DestinationPath = [io.path]::ChangeExtension($FilePath, ".zip")

if ($TestPathExists) {
    $CompressFileProcess = @{
        LiteralPath= $FilePath
        CompressionLevel = "Optimal"
        DestinationPath = $DestinationPath
        }
    Write-Host "Compressing file..." -ForegroundColor Yellow
    Compress-Archive @CompressFileProcess
    Write-Host " "
    Write-Host " " 
    Write-Host "The File Path compressed is in: $DestinationPath" -ForegroundColor Green
}
else {
    Write-Host "The File Path is not valid or it does not exists..." -ForegroundColor Red
}
