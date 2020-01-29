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


# Get all Workspaces
$Workspace   = Get-PowerBIWorkspace | Select-Object Name, ID #| Format-Table



# Get all User of a Workspace 
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