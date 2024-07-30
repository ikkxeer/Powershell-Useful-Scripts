function W10_TrayNotify {
    Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer EnableAutoTray 0
    Get-Process explorer | Stop-Process -Force
}

function W11_TrayNotify {
    foreach ($GUID in (Get-ChildItem -Path 'HKCU:\Control Panel\NotifyIconSettings' -Name)) {
        $ChildPath = "HKCU:\Control Panel\NotifyIconSettings\$($GUID)"
        Set-ItemProperty -Path $ChildPath -Name IsPromoted -Value 1
    }
}

$WinVer = [System.Environment]::OSVersion.Version.Build
if ($WinVer -ge 22000) {
    W11_TrayNotify
} else {
    W10_TrayNotify
}
