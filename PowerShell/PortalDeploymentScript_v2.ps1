
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$SubFolderParentPath 
$SubFolderName 
$ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST' 
# $ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV\Spitalbesuche'

#---------------------------------------------------------------------------------------------------------------------- 
# Step 3 - Reports in Verzeichnis auf Portal raufladen
#----------------------------------------------------------------------------------------------------------------------

Write-Host
,'# ---------------------------------------------------------------------------------------------------------------'
,'# Step 3 - ReportServer - Neues Verzeichnis $Folder1 auf $ReportPortalUri befüllen mit Report-Artefakten'
,'# ---------------------------------------------------------------------------------------------------------------'
," "
,"                 Windows (lokal)                                                    Portal  "
," ----------------------------------------------------------         ---------------------------------------------"
," "

$i=0
Get-ChildItem $ReportPath -Recurse -Name -Directory  | #-include('*.xlsx','*.rdl','*.pbx')  

    ForEach-Object { 
        $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
        $SubFolderNameSource = Split-Path -Leaf $_ 
        $SubFolderNameTarget = '/' + (Split-Path -Leaf $_) #-replace '\\', '/')
        $TargetPathFullRaw   = $SubFolderParentPath  + $SubFolderNameTarget
        $TargetPathFull      =  if ($TargetPathFullRaw.Contains("//")){
                                    $TargetPathFullRaw.Replace("//","/")
                                }
                                else {
                                    $TargetPathFullRaw
                                }

    Try{
        Write-RsRestFolderContent -Path $ReportPath -RsFolder $TargetPathFull -ReportPortalUri $ReportPortalUri  -Overwrite

        $i=$i+1       
        Write-Host " No.${i}     ${SubFolderParentPath}"
        Write-Host " No.${i}     ${SubFolderNameSource}"
        Write-Host " No.${i}     ${TargetPathFull}"
        Write-Host " No.${i}     ${ReportPortalUri}${TargetPathFull}   "        
        Write-Host ""

    }
    Catch{
        Write-Host "#---------------- Error Beginn ----------------------------------------#" 
        Write-Host "# No.${i} !!!!!! An error occurred for : "
        Write-Host "# No.${i}     ${SubFolderParentPath}"
        Write-Host "# No.${i}     ${SubFolderNameSource}"
        Write-Host "# No.${i}     ${TargetPathFull}"
        Write-Host "# No.${i}     ${ReportPortalUri}${TargetPathFull}   "
    
        ,'#',$Error[0]
        Write-Host "#----------------- Error End ------------------------------------------#" 
    }

  }

