########################################################################################
#                                                 Author: Alexander Hauenstein, IT-Logix
#
# Description:
# ------------
# Script auto-connects to the PBI-Service-Account and create a list of all workspaces 
# and all attachted users, their access level and their role, in a json file
#
# 
# PreConditions:
# - Auto-Login : add correct credentials
# - adapt output path and filename 
# 
#
# JSON File looks like this :
# ]
#     {
#         "emailAddress":  "ahauenstein@it-logix.ch",
#         "groupUserAccessRight":  "Admin",
#         "displayName":  "Alexander Hauenstein",
#         "identifier":  "ahauenstein@it-logix.ch",
#         "principalType":  "User",
#         "id":  "5fxxx8ea-b82b-4e49-8fde-ad2axxxxxb2b",
#         "Name":  "AHAU - Spxxxwiese",
#         "RowNo":  7
#     },
#     {
#         "emailAddress":  "sxxxxxxxxxxr@it-logix.ch",
#         "groupUserAccessRight":  "Member",
#         "displayName":  "Sexxxxn Lxxxxxxxxer",
#         "identifier":  "sxxxxxxxxxxr@it-logix.ch",
#         "principalType":  "User",
#         "id":  "5fxxx8ea-b8xx-4e49-8fde-adxxxxxxbb2b",
#         "Name":  "AHAU - Spxxxxiese",
#         "RowNo":  7
#     }
# ]
#
# File validation can be done here : http://json2table.com
#
########################################################################################

# Auto Login
$password = "xxx" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential


# set path to output file
$Directory =  "C:\Workspace4.txt"

# delete content of all variables
Clear-Content  $Directory
Clear-Variable i
Clear-Variable OutToFile
Clear-Variable Output1  
Clear-Variable OutToFile_JSON


# Collect all Workspaces
$Workspace   = Get-PowerBIWorkspace | Select-Object Name, ID #| Format-Table


# Collect all Users of each Workspace 
$Workspace | ForEach-Object  {

    $WS_ID   = $_.ID
    $WS_NAme = $_.Name   
    $i = $i + 1
    Write-Host "Loop : $($i) | $($_.ID) | $($_.Name)" 
                
    # Get all User which have access to a specific Workspace
    $uri      = "https://api.powerbi.com/v1.0/myorg/groups/$($WS_ID)/users" 
    $response = Invoke-PowerBIRestMethod -Url $uri -Method Get | ConvertFrom-Json

    # Select necessary objects
    $Output1  = $response.value | Select-Object emailAddress,groupUserAccessRight, displayName,identifier,principalType # | Format-Table | Out-String -Width 160 

    # Add the Workspace Name & ID
    $Output1 | Add-Member -Membertype NoteProperty -Name id    -Value $WS_ID
    $Output1 | Add-Member -Membertype NoteProperty -Name Name  -Value $WS_NAME
    $Output1 | Add-Member -Membertype NoteProperty -Name RowNo -Value $i
                
    # move each set of users and workspaces to the output-variable
    $OutToFile += $Output1  
                 
} 

# convert to JSON format
$OutToFile_JSON = $OutToFile | ConvertTo-Json 

# write json file to console (on screen)
Write-Output $OutToFile | ConvertTo-Json 

# write json file to disk
set-Content -Path $Directory  -Value $OutToFile_JSON # | ConvertTo-Json 

# Disconnect from PBI-Service
Disconnect-PowerBIServiceAccount