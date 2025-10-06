. (Join-Path $PSScriptRoot ApacheLogs1.ps1)
. (Join-Path $PSScriptRoot ChromeChamplain.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot FailedLogins.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot AtRisk.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Chrome Champlain`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $tableRecords = ApacheLogs1
        $tableRecords | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 2){
        getUserFailedLogs
    }


    elseif($choice -eq 3){ 
        getAtRiskUsers
 
    }


    elseif($choice -eq 4){
        chromeChamplain
        }


    else{
        Write-Host "Invalid input, enter a number between 1 and 5" | Out-String
    }

}
