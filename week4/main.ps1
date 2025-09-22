. (Join-Path $PScriptRoot Apache-Logs.ps1)

clear

$ips = Get-ApacheLogIPs -Page "page1.html" -HttpCode "200" -Browser "Chrome"

$counts = $ips.IP | Group-Object
$counts | Select-Object Count, Name