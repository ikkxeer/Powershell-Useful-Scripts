$origen = "C:\ruta\de\origen"
$destino = "C:\ruta\de\destino"

Copy-Item -Path $origen\* -Destination $destino -Recurse
