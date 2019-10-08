function Get-TimeStamp {
    
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    
}
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host "******************************************************************* "
Write-Host "*** Start Script ****   Startzeit $(Get-TimeStamp)    **********"
Write-Host "*** "


$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'

#$SubFolderName 
$SourceReportRootDir    = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV' 
$SourceReportPath       = $SourceReportRootDir + $SubFolderParentPath + $SubFolderNameTarget
#$SourceReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV'
#$TargetPathFull  = '/DEV'

#---------------------------------------------------------------------------------------------------------------------- 
# Step 3 - Reports in Verzeichnis auf Portal raufladen
#----------------------------------------------------------------------------------------------------------------------

Write-Host
,"# -------------------------------------- Startzeit $(Get-TimeStamp) -----------------------------------------"
,'# Step 3 - ReportServer - Neues Verzeichnis $Folder1 auf $ReportPortalUri befüllen mit Report-Artefakten'
,'# ---------------------------------------------------------------------------------------------------------------'
," "
,"                 Windows (lokal)                                                    Portal  "
," ----------------------------------------------------------         ---------------------------------------------"
," "


$i=0
Get-ChildItem $SourceReportPath -Recurse -Name -Directory | #-include('*.xlsx','*.rdl','*.pbx')  

    ForEach-Object { 
        $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
        $SubFolderNameSource =         Split-Path -Leaf $_ 
        $SubFolderNameTarget = '/' +  (Split-Path -Leaf $_) #-replace '\\', '/')





        $TargetPathFull_UNFORMAT = '/DEV/BEA Controlling'
        #$TargetPathFull_UNFORMAT = $SubFolderParentPath + $SubFolderNameSource
        $TargetPathFull_FORMAT   =  if ($TargetPathFull_UNFORMAT.Contains("/")){
                                    $TargetPathFull_UNFORMAT.Replace("/","\")
                                }
                                else {
                                    $TargetPathFull_UNFORMAT
                                }

        #$ReportPortalUri        = 'https://sv-rc-310.rega.local/Reports'
        $SourceReportPath       = $SourceReportRootDir + $TargetPathFull_FORMAT
           
         
  try{
        Write-RsRestFolderContent -Path $SourceReportPath -RsFolder '/BEA Controlling' -ReportPortalUri $ReportPortalUri   -Overwrite
        #Write-RsRestFolderContent -Path $SourceReportPath -RsFolder $TargetPathFull_UNFORMAT -ReportPortalUri $ReportPortalUri   -Overwrite
        $i=$i+1       
        Write-Host " *************    Startzeit $(Get-TimeStamp)    *************"
        Write-Host " *"
        Write-Host " No.${i} SourceReportRootDir              = ${SourceReportRootDir}"
        Write-Host " No.${i} SourceReportPath                 = ${SourceReportPath}"
        Write-Host " No.${i} SubFolderParentPath              = ${SubFolderParentPath}"
        Write-Host " No.${i} SubFolderNameSource              = ${SubFolderNameSource}"
        Write-Host " No.${i} SubFolderNameTarget              = ${SubFolderNameTarget}"
        Write-Host " No.${i} SourceReportPath                 = ${SourceReportPath}"
        Write-Host " No.${i} SourceReportPath      SOLL       = C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV\Assistancezentralen"
        Write-Host " No.${i} TargetPathFull_UNFORMAT          = ${TargetPathFull_UNFORMAT}"
        Write-Host " No.${i} TargetPathFull_FORMAT            = ${TargetPathFull_FORMAT}"
        Write-Host " No.${i} ReportPortalUri + TargetPathFull_FORMAT = ${ReportPortalUri} ${TargetPathFull_FORMAT}"        
        Write-Host " *"
        Write-Host " *************    Startzeit $(Get-TimeStamp)    *************"
        Write-Host ""
    }
    Catch{
        Write-Host "#---------------- Error Beginn ----------------------------------------#" 
        Write-Host " *************    Startzeit $(Get-TimeStamp)    *************"
        Write-Host " *"
        Write-Host " No.${i} SourceReportRootDir              = ${SourceReportRootDir}"
        Write-Host " No.${i} SourceReportPath                 = ${SourceReportPath}"
        Write-Host " No.${i} SubFolderParentPath              = ${SubFolderParentPath}"
        Write-Host " No.${i} SubFolderNameSource              = ${SubFolderNameSource}"
        Write-Host " No.${i} SubFolderNameTarget              = ${SubFolderNameTarget}"
        Write-Host " No.${i} SourceReportPath                 = ${SourceReportPath}"
        Write-Host " No.${i} SourceReportPath      SOLL       = C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV\Assistancezentralen"
        Write-Host " No.${i} TargetPathFull_UNFORMAT          = ${TargetPathFull_UNFORMAT}"
        Write-Host " No.${i} TargetPathFull_FORMAT            = ${TargetPathFull_FORMAT}"
        Write-Host " No.${i} ReportPortalUri + TargetPathFull_FORMAT = ${ReportPortalUri} ${TargetPathFull_FORMAT}"        
        Write-Host ""
                ,'#',$Error[0]
        Write-Host " *"
        Write-Host " *************    Startzeit $(Get-TimeStamp)    *************"
        Write-Host "#----------------- Error End ------------------------------------------#" 
        }

  }
Write-Host " "
Write-Host "*** "
Write-Host "*** Ende Script ****   Startzeit $(Get-TimeStamp)    *************"
Write-Host "********************************************************************* "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "