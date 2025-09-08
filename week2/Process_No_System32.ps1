Get-Process | Where-Object Path -notlike "*system32*" `
| Select-Object ProcessName | Format-Table -HideTableHeaders