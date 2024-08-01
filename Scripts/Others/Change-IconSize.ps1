# 10 - Extra small
# 36 - Small
# 48 - Medium
# 100 - Large
# 500 - Extra large
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop -name IconSize -value 48 
Stop-Process -name explorer