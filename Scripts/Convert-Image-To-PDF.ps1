Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Filter = "Images (*.jpg)|*.jpg"
$OpenFileDialog.Multiselect = $false

if ($OpenFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $imgPath = $OpenFileDialog.FileName
    Write-Host "File selected: $imgPath" -ForegroundColor Green
    Write-Host " "
} else {
    Write-Host "No file selected." -ForegroundColor Yellow
    Write-Host " "
    return
}

$doc = New-Object System.Drawing.Printing.PrintDocument
$doc.PrinterSettings = New-Object System.Drawing.Printing.PrinterSettings
$doc.PrinterSettings.PrinterName = "Microsoft Print to PDF"
$doc.PrinterSettings.PrintToFile = $true
$outFile = [System.IO.Path]::ChangeExtension($imgPath, ".pdf")
$doc.PrinterSettings.PrintFileName = $outFile

$script:_pageIndex = 0
$doc.add_PrintPage({
    param($sender, [System.Drawing.Printing.PrintPageEventArgs] $e)
    $image = [System.Drawing.Image]::FromFile($imgPath)
    try {
        $e.Graphics.DrawImage($image, $e.PageBounds)
        $e.HasMorePages = $false
    } finally {
        $image.Dispose()
    }
})

$doc.PrintController = New-Object System.Drawing.Printing.StandardPrintController

$doc.Print()
Write-Host "File printed to $outFile" -ForegroundColor Green