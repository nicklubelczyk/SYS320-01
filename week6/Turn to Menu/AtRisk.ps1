function getAtRiskUsers(){
    $days = Read-Host -Prompt "Enter the number of days to search back"
    
    $failedLogins = getFailedLogins $days
    
    $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }
    
    if($atRiskUsers.Count -eq 0){
        Write-Host "`nAt Risk Users: " | Out-String
        foreach($user in $atRiskUsers){
            Write-Host "User: $($user.Name)" | Out-String
        }
    }
}