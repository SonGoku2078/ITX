########################################################################################
#                                                 Author: Alexander Hauenstein, IT-Logix
#
# Description:
# ------------
# Script auto-connects to the PBI-Service-Account and add user(s) to a workspaces. 
# ONLY one Part can run at the time.
# 
# It contains 3 Parts: 
# - Part A creats a list of Workspaces which can be used as input for Part B
# - Part B adds only a single user to a existing workspace
# - Part C adds 1-x user(s) to 1-x workspace(s)
# 
# 
# PreConditions:
# - Auto-Login : add correct credentials
# - Part C : adapt input path and filename 
# - Part B : adapt parameter values 
# 
#
# Compilation of CSV File looks like this:
#  scope;wsid;accesright;principaltype;identifier;        <---- Title (Fieldnames)
#  Organization;wsid.......1;Admin;User;xyz@domain.com;   <---- Data  (Values)
#
########################################################################################



# Auto Login
$password = "xxx" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential

#---------------------------------------------------------------------------------------
# Part A - get a list of Workspaces
#---------------------------------------------------------------------------------------
<#

# get all workspaces 
$Workspace = Get-PowerBIWorkspace  | Select-Object name , ID  | Out-String 

# write Workspaces and Id's to Screen
write-host $Workspace
#>


#---------------------------------------------------------------------------------------
# Part B - add single user to a Workspace
#---------------------------------------------------------------------------------------

#Workspace 
$WS_ID   = '5f4c28ea-b82b-4e49-8fde-ad2a3fadbb2b' # AHAU - Spielwiese

# Add user to workspace
Add-PowerBIWorkspaceUser -Scope Organization -Id $WS_ID -AccessRight Member -PrincipalType User -Identifier 'ahauenstein@it-logix.ch' 


#---------------------------------------------------------------------------------------
# Part C - add multipleuser(s) to Workspace(s)
#---------------------------------------------------------------------------------------


# delete content of all variables
Clear-Variable CDirectory
Clear-Variable CUser2WorkspaceList
Clear-Variable CScope
Clear-Variable CWsId
Clear-Variable CAccessRight  
Clear-Variable CPrincipalType
Clear-Variable CIdentifier
Clear-Variable Ci


# set path to input-file
$CDirectory =  '\\AL328\C$\addUsersToWorkspace.csv' # AL328 = CMD hostname

# import workspace names from csv file 
$CUser2WorkspaceList = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CDirectory -ErrorAction  'Continue'

# Create multiple workspaces
ForEach ($item in $CUser2WorkspaceList)
    {
     $CScope         = $item.scope
     $CWsId          = $item.wsid
     $CAccessRight   = $item.accessright
     $CPrincipalType = $item.principaltype
     $CIdentifier    = $item.identifier
     $Ci = $Ci + 1

     # Create new Workspace and adds the current user as the workspace administrator
     #Add-PowerBIWorkspaceUser -Scope $CScope -Id $CWsId -AccessRight $CAccessRight -PrincipalType $CPrincipalType -Identifier $CIdentifier 

     # write file to console (on screen)
     Write-Output "# $($Ci) | $($CScope) | $($CWsId) | $($CAccessRight) | $($CPrincipalType) | $($CIdentifier)" | Out-String -Width 160
    }

   

# Disconnect from PBI-Service
Disconnect-PowerBIServiceAccount