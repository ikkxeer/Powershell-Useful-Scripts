Add-Type -AssemblyName "System.Windows.Forms"

function Show-OpenFileDialog {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "Excel Files (*.xlsx)|*.xlsx"
    $dialog.Title = "Select Excel File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

function Show-SaveFileDialog {
    $dialog = New-Object System.Windows.Forms.SaveFileDialog
    $dialog.Filter = "CSV Files (*.csv)|*.csv"
    $dialog.Title = "Save CSV File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

$inputFile = Show-OpenFileDialog
if (-not $inputFile) {
    Write-Host "No Excel file selected. The script will be canceled."
    exit
}

$outputFile = Show-SaveFileDialog
if (-not $outputFile) {
    Write-Host "No CSV file selected. The script will be canceled."
    exit
}

$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Open($inputFile)
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.UsedRange | Export-Csv -Path $outputFile -NoTypeInformation
$workbook.Close($false)
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
