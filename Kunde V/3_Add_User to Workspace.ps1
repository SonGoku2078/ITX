########################################################################################
# Author: Alexander Hauenstein, IT-Logix
#
# Description:
# ------------
# Script auto-connects to the PBI-Service-Account and add user(s) to a workspaces 
#
########################################################################################



# Auto Login
$password = "xxx" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential

#---------------------------------------------------------------------------------------
# Part 1 - get a list of Workspaces
#---------------------------------------------------------------------------------------
<#

# get all workspaces 
$Workspace = Get-PowerBIWorkspace  | Select-Object name , ID  | Out-String 

# write Workspaces and Id's to Screen
write-host $Workspace
#>


#---------------------------------------------------------------------------------------
# Part 2 - add user(s) to Workspace(s)
#---------------------------------------------------------------------------------------

#Workspace 
#$WS_ID   = '5f4c28ea-b82b-4e49-8fde-ad2a3fadbb2b' # AHAU - Spielwiese
$WS_ID   = '20ef428b-c15c-4965-974b-ab49232bff7e' # ITX ALL


# Add user to workspace
Add-PowerBIWorkspaceUser -Scope Organization -Id $WS_ID -AccessRight Member -PrincipalType User -Identifier 'sleuenberger@it-logix.ch' 
   

# Disconnect from PBI-Service
Disconnect-PowerBIServiceAccount