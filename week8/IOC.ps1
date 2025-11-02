function gatherIOC {
    $page = Invoke-WebRequest -TimeoutSec 2 http://127.0.0.1/IOC.html
    
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")
    
    $Table = @()

    for($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")
        
        $Table += [PSCustomObject]@{
            "Pattern"     = $tds[0].innerText; `
            "Explaination" = $tds[1].innerText; `
        }
   }
    
    return $Table
}
