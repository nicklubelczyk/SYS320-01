if (Get-Process -Name "chrome") {
    Stop-Process -Name "chrome" -Force
} else {
    Start-Process "chrome" "https://champlain.edu"
}