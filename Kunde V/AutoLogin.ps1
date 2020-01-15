#Import-Module MicrosoftPowerBIMgmt
#Import-Module MicrosoftPowerBIMgmt.Profile

$password = "xxx" | ConvertTo-SecureString -asPlainText -Force
$username = "yyyyy@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential

Get-PowerBIWorkspace -All

Disconnect-PowerBIServiceAccount