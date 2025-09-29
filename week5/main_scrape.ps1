. (Join-Path $PScriptRoot basicscrape.ps1)


$classes = gatherClasses
$classes = daysTranslator($classes)
$classes