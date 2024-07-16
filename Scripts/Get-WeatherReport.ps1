$Location = Read-Host "What location you want to set"

Invoke-RestMethod https://wttr.in/$Location
