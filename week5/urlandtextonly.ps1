$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.28/ToBeScraped.html
$scraped_page.Links | Format-List outerText, href