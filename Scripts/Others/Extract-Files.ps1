Add-Type -AssemblyName "System.Windows.Forms"

function Show-OpenFileDialog {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "ZIP Archive (*.zip)|*.zip"
    $dialog.Title = "Select ZIP File"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }
    return $null
}

function Show-FolderBrowserDialog {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "Select Destination Folder"
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.SelectedPath
    }
    return $null
}

$zipFile = Show-OpenFileDialog
if (-not $zipFile) {
    Write-Host "No ZIP file selected. The script will be canceled."
    exit
}

$destinationFolder = Show-FolderBrowserDialog
if (-not $destinationFolder) {
    Write-Host "No destination folder selected. The script will be canceled."
    exit
}

Expand-Archive -Path $zipFile -DestinationPath $destinationFolder
