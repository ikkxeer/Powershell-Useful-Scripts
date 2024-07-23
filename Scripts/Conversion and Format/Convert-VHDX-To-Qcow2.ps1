Add-Type -AssemblyName System.Windows.Forms
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'VHDX Files (*.vhdx)|*.vhdx'
}

Write-Host "Downloading necessary utilities..." -ForegroundColor Yellow
Write-Host " "

$QemuPath = ".\qemu-img"
if (Test-Path -Path $QemuPath) {
    Write-Host "Utilities already downloaded, continuing with the process..." -ForegroundColor Yellow
    Write-Host " "
    Set-Location -Path $QemuPath
    Write-Host "Select the .VHDX file to convert..." -ForegroundColor Yellow
    Write-Host " "
    Start-Sleep -Seconds 2
    $FileDialogResult = $FileDialog.ShowDialog()
    if ($FileDialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        $VhdxFile = $FileDialog.FileName
        $Extension = ".qcow2"
        # Get the file name without extension
        $FileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($VhdxFile)
        $FileDirectory = [System.IO.Path]::GetDirectoryName($VhdxFile)
        # Create the new path with the new extension
        $Qcow2File = [System.IO.Path]::Combine($FileDirectory, "$FileNameWithoutExtension$Extension")
        $FinalCommand = "& .\qemu-img.exe convert '$VhdxFile' -O qcow2 '$Qcow2File'"
        Write-Host "Converting file..." -ForegroundColor Yellow
        Write-Host " "
        Invoke-Expression $FinalCommand
        Write-Host "File successfully converted to: $Qcow2File" -ForegroundColor Green
    } else {
        Write-Host "No file selected, ending the process." -ForegroundColor Red
    }
}
else {
    try {
        Write-Host "Downloading utilities..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri "https://cloudbase.it/downloads/qemu-img-win-x64-2_3_0.zip" -OutFile "qemu-img.zip"
        Expand-Archive -LiteralPath ".\qemu-img.zip" -DestinationPath ".\qemu-img"
        Remove-Item -Path ".\qemu-img.zip"
        Write-Host "Utilities downloaded successfully!" -ForegroundColor Green
        Write-Host " "
        Set-Location -Path $QemuPath
        Write-Host "Select the .VHDX file to convert..." -ForegroundColor Yellow
        Write-Host " "
        Start-Sleep -Seconds 2
        $FileDialogResult = $FileDialog.ShowDialog()
        if ($FileDialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
            $VhdxFile = $FileDialog.FileName
            $Extension = ".qcow2"
            $FileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($VhdxFile)
            $FileDirectory = [System.IO.Path]::GetDirectoryName($VhdxFile)
            $Qcow2File = [System.IO.Path]::Combine($FileDirectory, "$FileNameWithoutExtension$Extension")
            $FinalCommand = "& .\qemu-img.exe convert '$VhdxFile' -O qcow2 '$Qcow2File'"
            Write-Host "Converting file..." -ForegroundColor Yellow
            Write-Host " "
            Invoke-Expression $FinalCommand
            Write-Host "File successfully converted to: $Qcow2File" -ForegroundColor Green
            Write-Host " "
        } else {
            Write-Host "No file selected, ending the process." -ForegroundColor Red
            Write-Host " "
        }
    }
    catch {
        Write-Host "ERROR: An error occurred during the utility download process..." -ForegroundColor Red
        Write-Host " "
    }
}

cd ..
Write-Host "Cleaning up downloaded resources..." -ForegroundColor Yellow
Write-Host " "
try {
    Remove-Item -LiteralPath ".\qemu-img" -Force -Recurse
    Write-Host "Resources cleaned up successfully!" -ForegroundColor Green
}
catch {
    Write-Host "ERROR: Unable to clean up resources..." -ForegroundColor Red
}
