function ApacheAccessLog { 
    $Table = @()
    $logsNotFormatted = Get-Content C:\Users\champuser\SYS320-01\week8\access.log
    
    for ($i = 0; $i -lt $logsNotFormatted.Count; $i++) {
        $logs = $logsNotFormatted[$i].Split(" ")
        
        $Table += [PSCustomObject]@{
            IP       = $logs[0]
            Time     = $logs[3].Trim('[')
            Method   = $logs[5].Trim('"')
            Page     = $logs[6]
            Protocol = $logs[7].Trim('"')
            Response = $logs[8]
        }
    }
    
    $Table | Format-Table -AutoSize
}

ApacheAccessLog