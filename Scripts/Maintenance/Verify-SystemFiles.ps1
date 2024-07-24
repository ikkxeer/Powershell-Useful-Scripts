function Comprobar-ArquivosSistema {
    [CmdletBinding()]
    param (
        [switch]$VerboseOutput
    )

    $sfcCommand = "sfc /scannow"
    $logPath = "$env:SystemRoot\Logs\CBS\CBS.log"
    
    Write-Host "Iniciando comprobación de archivos del sistema..." -ForegroundColor Cyan

    try {
        $process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $sfcCommand" -NoNewWindow -Wait -PassThru
        $exitCode = $process.ExitCode
                if ($exitCode -eq 0) {
            Write-Host "La comprobación se completó con éxito. No se encontraron problemas." -ForegroundColor Green
        } elseif ($exitCode -eq 1) {
            Write-Host "Se encontraron problemas que no se pudieron reparar automáticamente." -ForegroundColor Yellow
            
            if ($VerboseOutput) {
                Write-Host "Detalles del archivo de registro: $logPath" -ForegroundColor Green
                $logContent = Get-Content $logPath -Raw
                if ($logContent -match "Cannot repair") {
                    Write-Host "Se encontraron errores que no se pudieron reparar." -ForegroundColor Red
                } else {
                    Write-Host "No se encontraron errores críticos en el registro." -ForegroundColor Green
                }
            }
        } else {
            Write-Host "Se produjo un error durante la comprobación. Código de salida: $exitCode" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error al ejecutar el comando SFC: $_" -ForegroundColor Red
    }
}

Comprobar-ArquivosSistema -VerboseOutput