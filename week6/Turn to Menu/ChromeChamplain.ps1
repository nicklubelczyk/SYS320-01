function chromeChamplain(){
    if (Get-Process -Name "chrome" -ErrorAction SilentlyContinue) {
        Stop-Process -Name "chrome" -Force
        Write-Host "Chrome closed." | Out-String
    } 
    else {
        Start-Process "chrome" "https://champlain.edu"
        Write-Host "Chrome started with champlain.edu" | Out-String
    }
}