function readConfiguration {
    $content = Get-Content "C:\Users\champuser\SYS320-01\week7\configuration.txt"
    $days = $content[0]
    $time = $content[1]
    
    $config = [PSCustomObject]@{
        Days = $days
        ExecutionTime = $time
    }
    
    return $config
}


function changeConfiguration {
    Write-Host "Enter new configuration:"
    
    $days = Read-Host "Number of days"
    if ($days -notmatch '\d+') {
        Write-Host "Invalid input, enter only digits."
        return
    }

    $time = Read-Host "Execution time (format: H:MM AM/PM)"
    if ($time -notmatch '^\d{1,2}:\d{2}\s?(AM|PM)$') {
        Write-Host "Invalid input, use the format: X:XX AM/PM"
        return
    }

    Set-Content "C:\Users\champuser\SYS320-01\week7\configuration.txt" -Value $days
    Add-Content "C:\Users\champuser\SYS320-01\week7\configuration.txt" -Value $time
    
    Write-Host "Configuration updated"
}

function configurationMenu {
    $Prompt = "`n"
    $Prompt += "Welcome to the Configuration Menu`n"
    $Prompt += "1 - Show configuration`n"
    $Prompt += "2 - Change configuration`n"
    $Prompt += "3 - Exit`n"


    $operation = $true

    while($operation){
        Write-Host $Prompt | Out-String
        $choice = Read-Host 
        

        if($choice -eq 1){
            Write-Host "Current Configuration:"
            $config = readConfiguration
            $config | Format-List
            continue
            }

        if($choice -eq 2){
                changeConfiguration
                continue
            }

        if($choice -eq 3){
                Write-Host "Goodbye"
                exit
            }

        else{
                Write-Host "Invalid input, enter a number between 1 and 3" | Out-String
    }

}
}

#configurationMenu