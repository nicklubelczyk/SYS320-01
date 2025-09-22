$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
$A[0..4]