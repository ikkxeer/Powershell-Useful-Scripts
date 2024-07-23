$tempDirectories = @(
    "$env:LOCALAPPDATA\Temp",
    "$env:windir\Temp"
)

foreach ($path in $tempDirectories) {
    try {
        $items = Get-ChildItem -Path $path -Recurse -Force -ErrorAction Stop
        $items | Remove-Item -Force -Recurse -ErrorAction Stop
        Write-Host "El directorio $path ha sido limpiado!" -ForegroundColor Yellow
    }
    catch {
        if ($_.Exception -is [System.UnauthorizedAccessException]) {
            Write-Host "ERROR: Permiso denegado al intentar acceder a $path" -ForegroundColor Red
        }
        else {
            Write-Host "ERROR: Ocurrió un problema al intentar limpiar $path. Mensaje de error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host " "
Write-Host "¡Todos los archivos temporales han sido eliminados!" -ForegroundColor Green
