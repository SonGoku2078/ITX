#Connect Service
#Connect-PowerBIServiceAccount

$password = "Wongfeihung4" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential
$workspaces     = Get-PowerBIWorkspace -All 

$workspacesJson = $workspaces | Select-Object name, user, id #| ConvertTo-Json 
Write-Output $workspacesJson

$workspacesJson | Select-Object -Property user.user

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
Write-Host "Workspaces: $($workspacesRoh)"