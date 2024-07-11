# Obtener información de los componentes
$BIOS = Get-CimInstance -ClassName CIM_BIOSElement | Select-Object Manufacturer, Version, ReleaseDate
$Procesador = Get-CimInstance -ClassName CIM_Processor | Select-Object Name, MaxClockSpeed
$RAM = Get-CimInstance -ClassName CIM_PhysicalMemory | Select-Object Capacity, Speed
$TarjetaGrafica = Get-CimInstance -ClassName CIM_VideoController | Select-Object Name, AdapterRAM, DriverVersion
$Almacenamiento = Get-CimInstance -ClassName CIM_DiskDrive | Select-Object Model, MediaType, Size
$AdaptadoresRed = Get-CimInstance -ClassName CIM_NetworkAdapter | Select-Object Name, MACAddress, Speed

$ListaHW = @()

$HWInformacionOrganizada = [PSCustomObject]@{
    BiosInfo         = $BIOS
    Procesador       = $Procesador
    RAM              = $RAM
    TarjetaGrafica   = $TarjetaGrafica
    Almacenamiento   = $Almacenamiento
    AdaptadoresRed   = $AdaptadoresRed
}

# Objetos en la lista
$ListaHW += $HWInformacionOrganizada

Clear-Host

# Lista final
foreach ($HW in $ListaHW) {
    Write-Host "BIOS Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($bios in $HW.BiosInfo) {
        Write-Host "  Manufacturer: $($bios.Manufacturer)"
        Write-Host "  Version: $($bios.Version)"
        Write-Host "  Release Date: $($bios.ReleaseDate)"
    }

    Write-Host " "

    Write-Host "Processor Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($proc in $HW.Procesador) {
        Write-Host "  Name: $($proc.Name)"
        Write-Host "  Max Clock Speed: $($proc.MaxClockSpeed)"
    }

    Write-Host " "

    Write-Host "RAM Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($ram in $HW.RAM) {
        Write-Host "  Capacity: $($ram.Capacity)"
        Write-Host "  Speed: $($ram.Speed)"
        Write-Host " "
    }

    Write-Host " "

    Write-Host "Graphics Card Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($gpu in $HW.TarjetaGrafica) {
        Write-Host "  Name: $($gpu.Name)"
        Write-Host "  Adapter RAM: $($gpu.AdapterRAM)"
        Write-Host "  Driver Version: $($gpu.DriverVersion)"
    }
    
    Write-Host " "

    Write-Host "Storage Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($almacenaje in $HW.Almacenamiento) {
        Write-Host "  Model: $($almacenaje.Model)"
        Write-Host "  Media Type: $($almacenaje.MediaType)"
        Write-Host "  Size: $($almacenaje.Size)"
        Write-Host " "
    }

    Write-Host " "

    Write-Host "Network Adapter Information:" -ForegroundColor Green
    Write-Host "---------------------"
    foreach ($int in $HW.AdaptadoresRed) {
        Write-Host "  Name: $($int.Name)"
        Write-Host "  MAC Address: $($int.MACAddress)"
        Write-Host "  Speed: $($int.Speed)"
        Write-Host " "
    }
}