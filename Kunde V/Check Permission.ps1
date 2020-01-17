# -------------------------------------------------------------------
# 
#  !!!! Important !!! 
# 
#  Run PowerShell-Script as Administrator
# 
# 

$PSVersionTable

# Abfrage tut noch nicht richtig!!

# Check Powershell execution right
 $ExecutionRights =" "
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

Set-ExecutionPolicy RemoteSigned  
