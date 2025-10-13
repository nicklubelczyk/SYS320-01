. "C:\Users\champuser\SYS320-01\week6\Turn to Menu\Event-Logs.ps1"
. "C:\Users\champuser\SYS320-01\week6\Local User Management\String-Helper.ps1"
. "C:\Users\champuser\SYS320-01\week7\Email.ps1"
. "C:\Users\champuser\SYS320-01\week7\Scheduler.ps1"
. "C:\Users\champuser\SYS320-01\week7\configmanagement.ps1"
. "C:\Users\champuser\SYS320-01\week7\AtRisk.ps1"

$configuration = readConfiguration
$Failed = getAtRiskUsers $configuration.Days
SendAlertEmail ($Failed | Format-Table | Out-String)
ChooseTimeToRun($configuration.ExecutionTime)