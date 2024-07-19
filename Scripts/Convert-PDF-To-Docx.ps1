Add-Type -AssemblyName System.Windows.Forms

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "PDF Files (*.pdf)|*.pdf";
$OpenFileDialog.Multiselect = $false

if ($OpenFileDialog.ShowDialog() -eq 'OK') {
    $pdfPath = $OpenFileDialog.FileName
    Write-Host "File selected: $pdfPath" -ForegroundColor Green
    Write-Host " "
    
    $wordPath = [System.IO.Path]::ChangeExtension($pdfPath, ".docx")
    Write-Host "Ruta del PDF: $wordPath" -ForegroundColor Green
    Write-Host " "
} else {
    Write-Host "No file selected." -ForegroundColor Yellow
    Write-Host " "
}

$wordObject =new-object -ComObject "Word.Application"
$wordObject.Visible = $True
Write-Host "Exporting $pdfPath to $wordPath" -ForegroundColor Yellow
Write-Host " "
$txt = $wordObject.Documents.Open(
    $pdfPath,
    $false,
    $false,
    $false)
$wordObject.Documents[1].SaveAs($wordPath)
$wordObject.Documents[1].Close()    
$wordObject.Quit()
Write-Host "Exporting completed!" -ForegroundColor Green
