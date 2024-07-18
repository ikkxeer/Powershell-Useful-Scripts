Add-Type -AssemblyName System.Windows.Forms

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "Word Files (*.docx)|*.docx";
$OpenFileDialog.Multiselect = $false

if ($OpenFileDialog.ShowDialog() -eq 'OK') {
    $wordPath = $OpenFileDialog.FileName
    Write-Host "File selected: $wordPath" -ForegroundColor Green
    Write-Host " "
    
    $pdfPath = [System.IO.Path]::ChangeExtension($wordPath, ".pdf")
    Write-Host "Ruta del PDF: $pdfPath" -ForegroundColor Green
    Write-Host " "
} else {
    Write-Host "No file selected." -ForegroundColor Yellow
    Write-Host " "
}

$wordObject =new-object -ComObject "Word.Application"
$wordObject.Visible = $True

Write-Host "Exporting $wordPath to $pdfPath" -ForegroundColor Yellow
Write-Host " "
$wordFile = $wordObject.Documents.Open($wordPath)
$wordFile.SaveAs([ref] $pdfPath, [ref] 17)
$wordFile.Close()
$wordObject.Quit()
Write-Host "Exporting completed!" -ForegroundColor Green