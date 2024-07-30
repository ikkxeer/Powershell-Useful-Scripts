# Script para desocultar todos los iconos en la bandeja del sistema de Windows

function W10_TrayNotify {
    $TrayNotifyKey = 'HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify'
    $HeaderSize = 20
    $BlockSize = 1640
    $SettingOffset = 528

    $Restart = $false

    function GetStreamData {
        param([byte[]] $stream)
        $builder = New-Object System.Text.StringBuilder
        $stream | ForEach-Object { [void]$builder.Append(('{0:x2}' -f $_)) }
        return $builder.ToString()
    }

    function BuildItemTable {
        param([byte[]] $stream)
        $table = @{}
        for ($x = 0; $x -lt (($stream.Count - $HeaderSize) / $BlockSize); $x++) {
            $offset = $HeaderSize + ($x * $BlockSize)
            $table.Add($offset, $stream[$offset..($offset + ($BlockSize - 1))])
        }
        return $table
    }

    function rot13 {
        param (
            [parameter(valueFromPipeline = $true, mandatory = $true)]
            [string] $text
        )
        [string] $r = ''
        foreach ($c in $text.ToCharArray()) {
            [int] $n = $c
            if (($n -ge 97 -and $n -le 109) -or ($n -ge 65 -and $n -le 77)) { $r += [char] ($n + 13) }
            elseif (($n -ge 110 -and $n -le 122) -or ($n -ge 78 -and $n -le 90)) { $r += [char] ($n - 13) }
            else { $r += $c }
        }
        return $r
    }

    $TrayNotifyPath = (Get-Item $TrayNotifyKey).PSPath
    $stream = (Get-ItemProperty $TrayNotifyPath).IconStreams
    $table = BuildItemTable $stream

    foreach ($key in $table.Keys) {
        $item = [Text.Encoding]::Unicode.GetString($table[$key]).ToLower()
        # Desocultar todos los iconos
        $Setting = 2
        $stream[$key + $SettingOffset] = $Setting
        Set-ItemProperty $TrayNotifyPath -Name IconStreams -Value $stream
        $Restart = $true
    }

    if ($Restart) {
        Get-Process -Name explorer | Stop-Process
    }
}

function W11_TrayNotify {
    foreach ($GUID in (Get-ChildItem -Path 'HKCU:\Control Panel\NotifyIconSettings' -Name)) {
        $ChildPath = "HKCU:\Control Panel\NotifyIconSettings\$($GUID)"
        $Exec = (Get-ItemProperty -Path $ChildPath -Name ExecutablePath -ErrorAction SilentlyContinue).ExecutablePath
        # Desocultar todos los iconos
        Set-ItemProperty -Path $ChildPath -Name IsPromoted -Value 1
    }
}

# Detectar la versión de Windows y ejecutar la función correspondiente
$WinVer = [System.Environment]::OSVersion.Version.Build
if ($WinVer -ge 22000) {
    W11_TrayNotify
} else {
    W10_TrayNotify
}
