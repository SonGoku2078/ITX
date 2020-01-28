#Connect Service
<#Connect-PowerBIServiceAccount

$workspaces     = Get-PowerBIWorkspace -All     

$workspacesJson = $workspaces | Select-Object name, user, id #| ConvertTo-Json 
Write-Output $workspacesJson # | Get-Member 
#>


Connect-PowerBIServiceAccount 

$Workspace = Get-PowerBIWorkspace | Select-Object Name, ID | Format-Table

forea

$WorkspaceAndUser = $Workspace | ForEach-Object {
                                    $WorkspaceID = $_.ID    

                                }  


#Get-Variable $workspacesJson #| Select *

<#
$workspaces | 
    ForEach-Object {
        $Workspace = $_.name
        foreach ($User in $_.Users) {
            [PSCustomObject]@{
                Workspace = $Workspace
                User      = $User
            }
        }
    }
    #>
Write-Host "Workspaces: $($Workspace)"
Write-Host "Workspaces and User : $($WorkspaceAndUser)"
