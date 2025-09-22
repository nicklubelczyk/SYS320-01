function Get-ApacheLogIPs {
    param(
        [string]$Page,
        [string]$HttpCode,
        [string]$Browser
    )
    
    $HttpLogs = Get-Content C:\xampp\apache\logs\access.log | Select-String " $HttpCode "
    
    $PageLogs = $HttpLogs | Select-String $Page
    
    $BrowserLogs = $PageLogs | Select-String $Browser
    
    $regex = [regex] "\d+\.\d+\.\d+\.\d+"
    $ipsUnorganized = $regex.Matches($BrowserLogs)
    
    $ips = @()
    for($i=0; $i -lt $ipsUnorganized.Count; $i++){
        $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
    }
    
    return $ips
}