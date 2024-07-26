Add-Type -AssemblyName "System.Windows.Forms"

function Show-OpenFileDialog {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "CSV Files (*.csv)|*.csv"
    $dialog.Title = "Select CSV File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

function Show-SaveFileDialog {
    $dialog = New-Object System.Windows.Forms.SaveFileDialog
    $dialog.Filter = "Excel Workbook (*.xlsx)|*.xlsx"
    $dialog.Title = "Save Excel File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

$inputFile = Show-OpenFileDialog
if (-not $inputFile) {
    Write-Host "No CSV file selected. The script will be canceled."
    exit
}

$outputFile = Show-SaveFileDialog
if (-not $outputFile) {
    Write-Host "No Excel file selected. The script will be canceled."
    exit
}

Install-Module -Name ImportExcel -Scope CurrentUser -Force -AllowClobber
Import-Csv $inputFile | Export-Excel -Path $outputFile -WorksheetName "Sheet1"
