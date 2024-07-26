Add-Type -AssemblyName "System.Windows.Forms"

function Show-OpenFileDialog {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "DOCX Documents (*.docx)|*.docx"
    $dialog.Title = "Select DOCX File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

function Show-SaveFileDialog {
    $dialog = New-Object System.Windows.Forms.SaveFileDialog
    $dialog.Filter = "HTML File (*.html)|*.html"
    $dialog.Title = "Save HTML File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

# Select input DOCX file
$inputFile = Show-OpenFileDialog
if (-not $inputFile) {
    Write-Host "No DOCX file was selected. The script will be canceled."
    exit
}

# Select output HTML file
$outputFile = Show-SaveFileDialog
if (-not $outputFile) {
    Write-Host "No HTML file was selected. The script will be canceled."
    exit
}

# Verify that the input file exists
if (-not (Test-Path $inputFile)) {
    Write-Error "The input file does not exist."
    exit
}

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false  # Hides the Word application window
    $doc = $word.Documents.Open($inputFile)
    $doc.SaveAs([ref] $outputFile, [ref] 8)  # 8: wdFormatHTML
    Write-Host "File saved in: $outputFile" -ForegroundColor Green
} catch {
    Write-Error "Error processing the file: $_"
} finally {
    if ($doc -ne $null) { $doc.Close() }
    if ($word -ne $null) { $word.Quit() }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
