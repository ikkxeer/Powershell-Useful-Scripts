unction Show-Message {
    param (
        [string]$Message,
        [string]$Color
    )
    
    # Verificar que el color sea válido
    if ([Enum]::IsDefined([System.ConsoleColor], $Color)) {
        Write-Host $Message -ForegroundColor $Color
    } else {
        Write-Host "ERROR: Color inválido especificado: $Color" -ForegroundColor Red
    }
}

$registroClaves = @(
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($clave in $registroClaves) {
    try {
        if (Test-Path $clave) {
            Remove-Item -Path $clave -Recurse -Force -ErrorAction Stop
            Show-Message "La clave del registro $clave ha sido eliminada." "Yellow"
        } else {
            Show-Message "La clave del registro $clave no existe." "Cyan"
        }
    }
    catch {
        if ($_.Exception -is [System.UnauthorizedAccessException]) {
            Show-Message "ERROR: Permiso denegado al intentar eliminar la clave del registro $clave" "Red"
        }
        else {
            Show-Message "ERROR: Ocurrió un problema al intentar eliminar la clave del registro $clave. Mensaje de error: $($_.Exception.Message)" "Red"
        }
    }
}

function Clean-RegistryValues {
    param (
        [string]$SubKey,
        [string[]]$ValuesToRemove
    )
    
    foreach ($value in $ValuesToRemove) {
        try {
            if (Get-ItemProperty -Path $SubKey -ErrorAction SilentlyContinue) {
                Remove-ItemProperty -Path $SubKey -Name $value -ErrorAction Stop
                Show-Message "El valor $value en $SubKey ha sido eliminado." "Yellow"
            } else {
                Show-Message "La clave del registro $SubKey no existe." "Blue"
            }
        }
        catch {
            if ($_.Exception -is [System.UnauthorizedAccessException]) {
                Show-Message "ERROR: Permiso denegado al intentar eliminar el valor $value en $SubKey" "Red"
            }
            else {
                Show-Message "ERROR: Ocurrió un problema al intentar eliminar el valor $value en $SubKey. Mensaje de error: $($_.Exception.Message)" "Red"
            }
        }
    }
}

$registryValues = @{
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" = @("FileNameMRUList", "FolderNameMRUList")
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" = @("a", "b", "c")
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" = @("Publisher", "DisplayVersion")
}

foreach ($key in $registryValues.Keys) {
    Clean-RegistryValues -SubKey $key -ValuesToRemove $registryValues[$key]
}

Show-Message " "
Show-Message "¡Optimización del registro completada!" "Green"
