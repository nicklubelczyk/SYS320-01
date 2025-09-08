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


$output = Get-LoginLogoff -Day 14
$output