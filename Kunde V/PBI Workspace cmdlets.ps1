# -------------------------------------------------------------------
# 
#  !!!! Important !!! 
# 
#  Run PowerShell-Script as Administrator
# 
# 



# Abfrage tut noch nicht richtig!!

# Check Powershell execution right
<# $ExecutionRights =" "
$ExecutionRights = get-executionpolicy
Write-Host "Restricted":$($ExecutionRights)
if ($ExecutionRights = "Restricted" ) {
    Write-Host "Restricted":$($ExecutionRights)
       # Set-ExecutionPolicy RemoteSigned 
    }
    Else {
    Write-Host "NOT Restricted":$($ExecutionRights)
       # Set-ExecutionPolicy RemoteSigned 
    }

get-executionpolicy 

Set-ExecutionPolicy RemoteSigned  #>


	
#$UserCredential = Get-Credential
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#Import-PSSession $Session
#Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-90) -EndDate (Get-Date) -RecordType PowerBI -ResultSize 10

Connect-PowerBIServiceAccount
$workspaces = Get-PowerBIWorkspace -ALL # | Where {($_.Type -eq "Workspace") #-and ($_.State -eq "Active")
                                                 # } 
Write-Host "Workspaces: $($workspaces)"


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


#Get-PowerBIGroup -Scope

Disconnect-PowerBIServiceAccount

#Read-Host "Press any key when cpmplete."

