$paths = @(
    "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3",
    "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3",
    "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Lockdown_Zones\3",
    "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Lockdown_Zones\3"
)

foreach ($path in $paths) {
    # Crear la clave si no existe
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }
    New-ItemProperty `
        -Path $path `
        -Name "180F" `
        -Value 0 `
        -PropertyType DWord `
        -Force | Out-Null
}