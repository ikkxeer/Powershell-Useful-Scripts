Add-Type -AssemblyName "System.Windows.Forms"

function Show-OpenFileDialog {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "HTML Files (*.html)|*.html"
    $dialog.Title = "Select HTML File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

function Show-SaveFileDialog {
    $dialog = New-Object System.Windows.Forms.SaveFileDialog
    $dialog.Filter = "DOCX Documents (*.docx)|*.docx"
    $dialog.Title = "Save DOCX File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

$inputFile = Show-OpenFileDialog
if (-not $inputFile) {
    Write-Host "No HTML file selected. The script will be canceled."
    exit
}

$outputFile = Show-SaveFileDialog
if (-not $outputFile) {
    Write-Host "No DOCX file selected. The script will be canceled."
    exit
}

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $doc = $word.Documents.Add()
    $doc.Content.InsertFile($inputFile)
    $doc.SaveAs([ref] $outputFile, [ref] 16)  # 16: wdFormatXMLDocument
} catch {
    Write-Error "Error processing the file: $_"
} finally {
    if ($doc -ne $null) { $doc.Close() }
    if ($word -ne $null) { $word.Quit() }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
