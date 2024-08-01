w32tm /unregister
w32tm /register
net start w32time
w32tm /config /manualpeerlist:"time.windows.com,0x1" /syncfromflags:manual /update
w32tm /resync
