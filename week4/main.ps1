. (Join-Path $PScriptRoot Apache-Logs.ps1)
. (Join-Path $PScriptRoot ApacheLogs1.ps1)

clear

$ips = Get-ApacheLogIPs -Page "index.html" -HttpCode "404" -Browser "Chrome"


$counts = $ips.IP | Group-Object
$counts | Select-Object Count, Name

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap