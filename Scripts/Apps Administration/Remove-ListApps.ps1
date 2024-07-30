$desktopAppsToRemove = @(
    "<APPNAME>",
    "<APPNAME>",
    "<APPNAME>"
)

foreach ($app in $desktopAppsToRemove) {
    Write-Output "Uninstalling $app using winget..."
    winget uninstall $app
    Write-Host "$app has been uninstalled!" -ForegroundColor Green
}
