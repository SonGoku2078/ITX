#---------------------------------------------------------------------------------------------------------------------- 
# Wichtig:
# - Die Erkenntis bei der Fehlersuche was, dass der Ordner "Spitalbesuche" auf dem Portal schon vorhanden sein muss.
# Das verhält sich warscheinlich bei allen Reports so. Also es müssen alle Zielverzeichnisse vorhanden sein
#   Ansonnten kann der Report "Factsheet Spitalbesuche" nicht deployed werden.



$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$SubFolderParentPath 
$SubFolderName 
$ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV\BEA Controlling' 
$TargetPathFull  = '/DEV/BEA Controlling'

#---------------------------------------------------------------------------------------------------------------------- 
# Step 3 - Reports in Verzeichnis auf Portal raufladen
#----------------------------------------------------------------------------------------------------------------------


Write-RsRestFolderContent -Path $ReportPath -RsFolder $TargetPathFull -ReportPortalUri $ReportPortalUri  -Overwrite

 Try{
        Write-RsRestFolderContent -Path $ReportPath -RsFolder $TargetPathFull -ReportPortalUri $ReportPortalUri  -Overwrite

        Write-Host " No.${i}     ${TargetPathFull}"
        Write-Host " No.${i}     ${ReportPortalUri}${TargetPathFull}   "        
        Write-Host ""

    }
    Catch{
        Write-Host "#---------------- Error Beginn ----------------------------------------#" 
        Write-Host "# No.${i} !!!!!! An error occurred for : "
        Write-Host "# No.${i}     ${TargetPathFull}"
        Write-Host "# No.${i}     ${ReportPortalUri}${TargetPathFull}   "
    
        ,'#',$Error[0]
        Write-Host "#----------------- Error End ------------------------------------------#" 
    }