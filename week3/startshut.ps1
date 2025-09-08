function Get-LoginLogoff {
    param(
        [int]$Day
    )
    
    $loginlogoffs = Get-Eventlog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Day)

    $loginlogoffsTable = @()
    for($i=0; $i -lt $loginlogoffs.Count; $i++){

    $event = ""
    if($loginlogoffs[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginlogoffs[$i].InstanceId -eq 7002) {$event="Logoff"}

    $user = (New-Object System.Security.Principal.SecurityIdentifier($loginlogoffs[$i].ReplacementStrings[1])).Translate([System.Security.Principal.NTAccount]).Value

    $loginlogoffsTable += [PSCustomObject] @{"Time" = $loginlogoffs[$i].TimeGenerated;
                             "Id" = $loginlogoffs[$i].InstanceId;
                              "Event" = $event;   
                             "User" = $user; 
                           }
    }

    return $loginlogoffsTable
}

function Get-StartShut {
    param(
        [int]$Day
    )
    
    $startshut = Get-Eventlog System -After (Get-Date).AddDays(-$Day) | Where-Object {$_.EventId -eq 6005 -or $_.EventId -eq 6006}
    $startshutTable = @()
    for($i=0; $i -lt $startshut.Count; $i++){
    $event = ""
    if($startshut[$i].EventId -eq 6005) {$event="Start"}
    if($startshut[$i].EventId -eq 6006) {$event="Shutdown"}
    $startshutTable += [PSCustomObject] @{"Time" = $startshut[$i].TimeGenerated;
                             "Id" = $startshut[$i].EventId;
                              "Event" = $event;   
                             "User" = "System"; 
                           }
    }
    return $startshutTable
}

$output = Get-LoginLogoff -Day 14
$output | Out-String
$output = Get-StartShut -Day 14
$output | Out-String