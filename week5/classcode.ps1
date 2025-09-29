. (Join-Path $PScriptRoot basicscrape.ps1)


$FullTable = gatherClasses
$FullTable = daysTranslator($FullTable)

# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Monday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"