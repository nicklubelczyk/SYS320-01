$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.28/ToBeScraped.html

$divs1=$scraped_page.ParsedHTML.body.getElementsbyTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1