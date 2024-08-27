Import-Module -Name .\Powershell-codes\question2.ps1

$newName = Read-Host "Enter the new name for the host"
$username = Read-Host "Enter the username for the server (should be Administrator)"
$password = Read-Host "Enter the password" -AsSecureString
$computername = Read-Host "Enter the Public Dns received by aws"


$data = Import-Csv -Path "D:\OM2 - Test\om2-candidate\examples\complete\Powershell-codes\Features and users.csv"
$Features = $data.Features | Where-Object {$_.trim() -ne "" }

Install-Feature -Features $Features -ComputerName $computername -Username $username -password $password
Rename-ComputerName -ComputerName $computername -NewName $newName -Username $username -password $password