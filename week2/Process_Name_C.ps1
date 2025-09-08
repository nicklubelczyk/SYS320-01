Get-Process | Where-Object ProcessName -like "C*" `
| Select-Object ProcessName | Format-Table -HideTableHeaders