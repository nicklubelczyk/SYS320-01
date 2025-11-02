. "C:\Users\champuser\SYS320-01\week8\IOC.ps1"

function ApacheAccessLog { 
    param(
        [string]$LogPath,
        [array]$Indicators
    )
    
    $Table = @()
    $logsNotFormatted = Get-Content $LogPath
    
    for ($i = 0; $i -lt $logsNotFormatted.Count; $i++) {
        $logs = $logsNotFormatted[$i].Split(" ")
        
        $Table += [PSCustomObject]@{
            IP       = $logs[0]
            Time     = $logs[3].Trim('[')
            Method   = $logs[5].Trim('"')
            Page     = $logs[6]
            Protocol = $logs[7].Trim('"')
            Response = $logs[8]
            Referrer = $logs[10]
       }
     }

    return $Table | Where-Object { 
        $currentPage = $_.Page
        ($Indicators | Where-Object { $currentPage -like "*$_*" }).Count -gt 0
   }
}

$IOC = gatherIOC
$IOC = $IOC.Pattern

ApacheAccessLog -LogPath "C:\Users\champuser\SYS320-01\week8\access.log" -Indicators $Indicators | Format-Table

