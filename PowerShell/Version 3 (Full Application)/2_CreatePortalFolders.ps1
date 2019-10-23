#----------------------------------------------------------------------------------------------------------------------

$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$Folder1         = 'DEV'
$ErrorAction     = 'Continue'
$ErrorMsgConsole = ' '
$ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST' 

    #----------------------------------------------------------------------------------------------------------------------
    # Step 2 - Ordner auf dem Portal erstellen
    #----------------------------------------------------------------------------------------------------------------------
    
    
    Try{

        Get-ChildItem $ReportPath -Recurse -Directory -Name | 
        
        ForEach-Object {
        # Split the relative input path into leaf (directory name)
        # and parent path, and convert the parent path to the target parent path
        # by prepending "/" and converting path-internal "\" instances to "/".
    
        $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
        $SubFolderName = Split-Path -Leaf $_
    
            try{
                New-RsFolder -ReportServerUri $ReportServerURI -RSFolder $SubFolderParentPath -FolderName $SubFolderName #$ErrorAction
                Write-Host "Created folder ${SubFolderParentPath}/${SubFolderName}"
            }
            catch {
                # Report the specific error that occurred, accessible via $_
                Write-Host "An error occurred for ${SubFolderParentPath}/${SubFolderName}: $_"
                Write-Host " *"
                Write-Host " No.${i} SubFolderParentPath              = ${SubFolderParentPath}"
                Write-Host " No.${i} SubFolderName                    = ${SubFolderName}"
                Write-Host " $_"
                Write-Host " ------------------------------------------------------------------"
        
            }
        }
    }
    
    Catch{
        $ErrorMsgConsole = $Error[0]
    #    Write-Host 
         '# ---------------------------------------------------------------------------------------------------------------'
        ,'# Step 2 - ReportServer -  !!!! Verzeichnis schon vorhanden !!!! '
        ,'#'
        ,'# Fehlermeldung lautet wie folgt :'
        ,'#',$Error[0]
        ,'#'
        ,'# Ende der Fehlermeldung'
        ,'#----------------------------------------------------------------------------------------------------------------
         '
    }
