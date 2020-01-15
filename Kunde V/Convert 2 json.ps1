
#source https://www.youtube.com/watch?v=gdoDqMin9WA



Connect-PowerBIServiceAccount

#Get-PowerBIWorkspace -All | Export-Csv -NoTypeInformation -Path "C:\Workspace2.csv"
Get-PowerBIWorkspace -All | ConvertTo-Json 





Disconnect-PowerBIServiceAccount

Read-Host "Press any key when cpmplete."






Connect-PowerBIServiceAccount
#Set-Variable -Name OutPath -Value 'C:\Users\ahau\Documents\GitHub\Kunde V'
$workspaces     = Get-PowerBIWorkspace -All 

$workspacesJson = $workspaces | Select-Object name, user, id #| ConvertTo-Json 
Write-Output $workspacesJson
#$workspacesJson = Get-PowerBIWorkspace -All | Select-Object name, id, user | ConvertTo-Json 

# Write Output File
Out-File   -InputObject $workspacesJson  -FilePath "C:\Workspace2.json"

#Print out Statistic
Write-Host "Total Number of Workspaces: $($workspaces.count) `n"
Disconnect-PowerBIServiceAccount

