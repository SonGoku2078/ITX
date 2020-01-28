$password = "Wongfeihung4" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential


$Workspace   = Get-PowerBIWorkspace | Select-Object Name, ID #| Format-Table

$i=0
Write-Host "#   00"
$Workspace | ForEach-Object <#($Item in $Workspace)#> {
#                   $WorkspaceId = $Item.Id   
                   #Write-Host "#   01 - $($Workspace.Id)"
#                   Write-Host "#   01 - $($item.Id)"
                     $WS_ID   = $_.ID
                     $WS_NAme = $_.Name   
                     $i = $i + 1
#                   Write-Host "#   $($i) - $($WS_ID)"
<#                          $NewObjectID | Add-Member -MemberType NoteProperty "id"    -Value $item.Id    
#                                $Liste | Add-Member -MemberType NoteProperty "Space" -Value "Hex-ID" #| Format-Table   
                          $responseList = $NewObjectID
#>                                      
                          $uri      = "https://api.powerbi.com/v1.0/myorg/groups/$($WS_ID)/users" 
                          $ResponseUNFormate = Invoke-PowerBIRestMethod -Url $uri -Method Get | ConvertFrom-Json
                          $ResponseFORMAT = $response.value | Select-Object groupUserAccessRight, displayName,identifier,principalType, emailAddress| Format-Table #ConvertTo-Json 
                          $ResponseOUT = $ResponseFORMAT 

#                         $WSInfos  = $response.value #| Select-Object emailAddress,groupUserAccessRight, displayName,identifier,principalType
#                         $WSInfos  = $response | Select-Object emailAddress,groupUserAccessRight, displayName,identifier,principalType
#                         $WSInfos  | Add-Member -MemberType NoteProperty "id"    -Value $item.Id    
#    Write-Host "# $($i)  -$($ResponseFORMAT)"
    
    # Write Output File 
    
            } |   Out-File  -FilePath "C:\Workspace3.txt" #  -InputObject $ResponseFORMAT

#Write-Host "#   99 -  $($WSInfos)"# | Select-Object *
