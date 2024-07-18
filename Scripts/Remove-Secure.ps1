Add-Type -AssemblyName System.Windows.Forms

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Filter = "All Files (*.*)|*.*"
$OpenFileDialog.Multiselect = $false

if ($OpenFileDialog.ShowDialog() -eq 'OK') {
    $SelectedFilePath = $OpenFileDialog.FileName
    Write-Host "File selected: $SelectedFilePath" -ForegroundColor Green
    Write-Host " "
} else {
    Write-Host "No file selected." -ForegroundColor Yellow
    Write-Host " "
}


function Secure-DeleteFile {
    param (
        [string]$FilePath
    )

    if (Test-Path $FilePath) {
        $size = (Get-Item $FilePath).length
        Write-Host "The file size is: $size" -ForegroundColor Yellow
        Write-Host " "
        $randomBytes = New-Object byte[] $size
        (New-Object Random).NextBytes($randomBytes)
        [System.IO.File]::WriteAllBytes($FilePath, $randomBytes)
        Write-Host "Processing file to Untraceable File..." -ForegroundColor Yellow
        Write-Host " "
        Remove-Item -Path $FilePath -Force
        Write-Host "File completely deleted from memory!" -ForegroundColor Green
        Write-Host " "
    } else {
        Write-Host "File does not exist: $FilePath" -ForegroundColor Red
        Write-Host " "
    }
}

# Call function with the file selected
Secure-DeleteFile -FilePath $SelectedFilePath
