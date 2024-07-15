Clear-Host

$driveLetters = Get-Volume | Select-Object -ExpandProperty DriveLetter
$counter = 1

Write-Host "Seleccione un volumen:"
Write-Host "----------------------"
$driveLetters | ForEach-Object {
    Write-Host "$counter. $_"
    $counter++
}
$selection = Read-Host "Ingrese el número del volumen que desea seleccionar"
Write-Host " "

if ($selection -ge 1 -and $selection -le $driveLetters.Count) {
    $selectedDrive = $driveLetters[$selection - 1]
    Write-Host "Ha seleccionado el volumen $selectedDrive" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500
    Write-Host " "
    Write-Host "Obteniendo informacion del volumen..." -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor Yellow
    Write-Host " "
    Start-Sleep -Milliseconds 500
    $fileSystem = Get-Volume | Where-Object DriveLetter -eq $selectedDrive | Select-Object -ExpandProperty FileSystemType
    Write-Host "Tipo de Sistema de archivos: " -ForegroundColor Green
    Write-Host "$fileSystem" -ForegroundColor Yellow
    Write-Host " "
    Start-Sleep -Milliseconds 500
    $healthState = Get-Volume | Where-Object DriveLetter -eq $selectedDrive | Select-Object -ExpandProperty HealthStatus
    Write-Host "Estado del volumen: " -ForegroundColor Green
    Write-Host "$healthState" -ForegroundColor Yellow
    Write-Host " "
    Start-Sleep -Milliseconds 500
    $totalSize = Get-Volume | Where-Object DriveLetter -eq $selectedDrive | Select-Object -ExpandProperty Size
    $totalSizeGB = $totalSize / 1GB
    $totalSizeGBRounded = [math]::Round($totalSizeGB,2)
    Write-Host "Tamaño total del volumen: " -ForegroundColor Green
    Write-Host "$totalSizeGBRounded GB" -ForegroundColor Yellow
    Write-Host " "
    Start-Sleep -Milliseconds 500
    $sizeRemaining = Get-Volume | Where-Object DriveLetter -eq $selectedDrive | Select-Object -ExpandProperty SizeRemaining
    $sizeRemainingGB = $sizeRemaining / 1GB
    $sizeRemainingGBRounded = [math]::Round($sizeRemainingGB,2)
    Write-Host "Tamaño disponible del volumen: " -ForegroundColor Green
    Write-Host "$sizeRemainingGBRounded GB" -ForegroundColor Yellow
    Write-Host " "
} else {
    Write-Host "Selección inválida. Por favor, ingrese un número válido." -ForegroundColor Red
}