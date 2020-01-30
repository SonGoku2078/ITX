########################################################################################
#                                                 Author: Alexander Hauenstein, IT-Logix
#
# Description:
# ------------
# Script auto-connects to the PBI-Service-Account and create workspaces based on a csv file
# or just a single Workspace.
# ONLY one Part can run at the time.
# 
# It contains 3 Parts: 
# - Part A creats a list of Workspaces which can be used as input for Part B
# - Part B adds only a single user to a existing workspace
# 
# PreConditions:
# - Auto-Login : add correct credentials
# - Part A : adapt input path and filename 
# - Part B : adapt parameter values 
#
# Compilation of CSV File looks like this:
#  workspace;   <---- Title (Fieldnames)
#  ws....id99;  <---- Data  (Values)
# 
########################################################################################



# Auto Login
$password = "xxx" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential

# ---------------------------------------------------------------------------------------
# Part A : Create multiple Workspace based on csv
# ---------------------------------------------------------------------------------------

# delete content of all variables
Clear-Variable WorkspaceName

# set path to input-file
$Directory =  '\\NB17-AS-1063\C$\WorkspaceName.csv' # NB17-AS-1063 = CMD hostname

# import workspace names from csv file 
$WorkspaceList = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $Directory -ErrorAction  'Continue'

# Create multiple workspaces
ForEach ($item in $WorkspaceList)
    {
     $WorkspaceName     = $item.WSName
     
     # Create new Workspace and adds the current user as the workspace administrator
     New-PowerBIWorkspace -Name $WorkspaceName 

     # write json file to console (on screen)
     Write-Output "WorkspaceName = $($WorkspaceName)"
    }


# ---------------------------------------------------------------------------------------
# Part B : Create a single workspace 
# ---------------------------------------------------------------------------------------
<#

New-PowerBIWorkspace -Name 'SingleWS_Name' 

#>


# Disconnect from PBI-Service
Disconnect-PowerBIServiceAccount