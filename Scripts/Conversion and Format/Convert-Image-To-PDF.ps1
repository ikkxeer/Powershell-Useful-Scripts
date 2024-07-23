Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "Images|*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff;*.ico"
$OpenFileDialog.Multiselect = $false

if ($FileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $selectedImagePath = $FileDialog.FileName
    Write-Host "File selected: $selectedImagePath" -ForegroundColor Green
    Write-Host " "
} else {
    Write-Host "No File selected." -ForegroundColor Yellow
    Write-Host " "
    return
}

$printDocument = New-Object System.Drawing.Printing.PrintDocument
$printDocument.PrinterSettings = New-Object System.Drawing.Printing.PrinterSettings
$printDocument.PrinterSettings.PrinterName = "Microsoft Print to PDF"
$printDocument.PrinterSettings.PrintToFile = $true
$outputFilePath = [System.IO.Path]::ChangeExtension($selectedImagePath, ".pdf")
$printDocument.PrinterSettings.PrintFileName = $outputFilePath

$pageIndex = 0
$printDocument.add_PrintPage({
    param($sender, [System.Drawing.Printing.PrintPageEventArgs] $e)
    $image = [System.Drawing.Image]::FromFile($selectedImagePath)
    try {
        $e.Graphics.DrawImage($image, $e.PageBounds)
        $e.HasMorePages = $false
    } finally {
        $image.Dispose()
    }
})

$printDocument.PrintController = New-Object System.Drawing.Printing.StandardPrintController
$printDocument.Print()
Write-Host "File saved in $outputFilePath" -ForegroundColor Green
