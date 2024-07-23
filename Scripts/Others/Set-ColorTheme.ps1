$DarkOrLight = Read-Host "Want to change the theme to Dark [D] or Light [L]"

if ($DarkOrLight -eq "d".ToUpper()) {
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
}
elseif ($DarkOrLight -eq "l".ToUpper()) {
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
}
else {
    Write-Host "Invalid decision" -ForegroundColor Red
}

