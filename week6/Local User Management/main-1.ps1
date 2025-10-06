. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        $userExists = checkUser $name
        if($userExists -eq $true){
            Write-Host "User $name already exists, choose a different username" | Out-String
            continue
        }

        $password = Read-Host -Prompt "Please enter the password for the new user"

        $passwordValid = checkPassword $password
        if($passwordValid -eq $false){
            Write-Host "Password doesn't meet requirements" | Out-String
            continue
        }

        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force

        createAUser $name $securePassword

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"


        $userExists = checkUser $name
        if($userExists -eq $false){
            Write-Host "User $name doesn't exist" | Out-String
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"


        $userExists = checkUser $name
        if($userExists -eq $false){
            Write-Host "User $name doesn't exist." | Out-String
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"


        $userExists = checkUser $name
        if($userExists -eq $false){
            Write-Host "User $name doesn't exist." | Out-String
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"


        $userExists = checkUser $name
        if($userExists -eq $false){
            Write-Host "User $name doesn't exist." | Out-String
            continue
        }

        $days = Read-Host -Prompt "Enter the number of days to search"

        $userLogins = getLogInAndOffs $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        $userExists = checkUser $name
        if($userExists -eq $false){
            Write-Host "User $name does not exist." | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days to search back"

        $userLogins = getFailedLogins $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    # List at Risk Users
    elseif($choice -eq 9){

        $days = Read-Host -Prompt "Please enter the number of days to search back"

        $failedLogins = getFailedLogins $days


        $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }
         Write-Host "`nAt-Risk Users (more than 10 failed logins in the last $days days):" | Out-String
         foreach($user in $atRiskUsers){
            Write-Host "User: $($user.Name) - Failed Login Count: $($user.Count)" | Out-String
        }
    }

    # Invalid input
    else{
        Write-Host "Invalid input, enter a number between 1 and 10" | Out-String
    }

}