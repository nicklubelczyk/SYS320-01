. (Join-Path $PScriptRoot startshut.ps1)

clear

$loginoutsTable = Get-LoginLogoff -Day 15
$loginoutsTable

$startshutTable = Get-StartShut -Day 25
$startshutTable