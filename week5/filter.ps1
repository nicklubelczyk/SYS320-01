. (Join-Path $PScriptRoot basicscrape.ps1)


$FullTable = gatherClasses
$FullTable = daysTranslator($FullTable)

# List all the classes of Instructor Furkan Paligu
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
                          Where-Object{ $_.Instructor -ilike "*Furkan Paligu*" }