#Connect Service
#Connect-PowerBIServiceAccount

$password = "Wongfeihung4" | ConvertTo-SecureString -asPlainText -Force
$username = "ahauenstein@it-logix.ch" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Connect-PowerBIServiceAccount -Credential $credential
#Set-Format  -Name 'workspaces' -Option get-help Set-Format
$workspaces     = Get-PowerBIWorkspace

# $workspacesJson = $workspaces | Select-Object name, user, id #| ConvertTo-Json 
# Write-Output $workspacesJson

$workspaces | Select-Object -Property user

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
Write-Host "Workspaces: $($workspaces)"