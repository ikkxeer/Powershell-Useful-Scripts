$desktopAppsToRemove = @(
    "APP1",
    "APP2",
    "APP3",
    "APP4"
)

foreach ($app in $desktopAppsToRemove) {
    Write-Output "Uninstalling $app using winget..."
    winget uninstall $app
    Write-Host "$app has been uninstalled!" -ForegroundColor Green
}
