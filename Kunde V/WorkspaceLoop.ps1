$password = "Wongfeihung4" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential

<#
Connect-PowerBIServiceAccount 



$uri         = "https://api.powerbi.com/v1.0/myorg/groups/5f4c28ea-b82b-4e49-8fde-ad2a3fadbb2b/users"


# Get User 
$response = Invoke-PowerBIRestMethod -Url $uri -Method Get | ConvertFrom-Json
$response.value | Select-Object groupUserAccessRight, displayName,identifier,principalType, emailAddress| ConvertTo-Json # Format-Table

write-host $response.value
#>


#$NewObjectID = New-Object -TypeName psobject
#$NewObjectID  | Add-Member  -NotePropertyName "WSid"   -NotePropertyValue $_.ID    | Out-String 




$Workspace   = Get-PowerBIWorkspace | Select-Object Name, ID #| Format-Table

clear-content C:\Workspace3.txt
$i=0
Write-Host "#   00"
$Workspace | ForEach-Object <#($Item in $Workspace)#> {
#               $WorkspaceId = $Item.Id   
                #Write-Host "#   01 - $($Workspace.Id)"
#                   Write-Host "#   01 - $($item.Id)"
                $WS_ID   = $_.ID
                $WS_NAme = $_.Name   
                $i = $i + 1
                Write-Host $i
                                      
                $uri      = "https://api.powerbi.com/v1.0/myorg/groups/$($WS_ID)/users" 
                $response = Invoke-PowerBIRestMethod -Url $uri -Method Get | ConvertFrom-Json

                # Select the necessary objects
                $Output1  = $response.value | Select-Object emailAddress,groupUserAccessRight, displayName,identifier,principalType # | Format-Table | Out-String -Width 160 

                # Add the Workspace Name & ID
                
                $Output1 | Add-Member -Membertype NoteProperty -Name id    -Value $WS_ID
                $Output1 | Add-Member -Membertype NoteProperty -Name Name  -Value $WS_NAME
                $Output1 | Add-Member -Membertype NoteProperty -Name RowNo -Value $i
                
                # Write the file in json formatAdd the Workspace Name & ID
                #$Output1 | ConvertTo-Json |  Out-File  -FilePath "C:\Workspace3.txt" 
                $OutToFile += $Output1  #| Format-List # | ConvertTo-Json
                #Write-Output $Output1 #| ConvertTo-Csv #| ConvertTo-Json 
                #add-Content -Path "C:\Workspace3.txt" -Value $Output1 #| ConvertTo-Json 
                #add-Content -Path "C:\Workspace3.txt" -Value $OutToFile #| ConvertTo-Json 
                 
            } 

            $OutToFile_JSON = $OutToFile | ConvertTo-Json 

Write-Host " 99 -------"
Write-Output $OutToFile | ConvertTo-Json 
Write-Host " 99 -------"

set-Content -Path "C:\Workspace4.txt" -Value $OutToFile_JSON # | ConvertTo-Json 
            
#Write-Output "WSInfos2 : $($WSInfos2 | ConvertTo-Json )"
#Out-File  -FilePath "C:\Workspace3.txt"  -InputObject $Output #$ResponseFORMAT

# Write the file in json formatAdd the Workspace Name & ID
#$Output1 | ConvertTo-Json |  Out-File  -FilePath "C:\Workspace3.txt" 


