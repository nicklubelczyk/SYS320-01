function getUserFailedLogs(){
    $days = Read-Host -Prompt "Please enter the number of days to search back"
    $userLogins = getFailedLogins $days
    Write-Host ($userLogins | Select-Object -Last 10 | Format-Table | Out-String)
}