$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.28/ToBeScraped.html

$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Format-Table outerText
$h2s