$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '
$regex = [regex] "\d+\.\d+\.\d+\.\d+"
$ipsUnorganized = $regex.Matches($notfounds)
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
   $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens.IP | Group-Object
$counts | Select-Object Count, Name