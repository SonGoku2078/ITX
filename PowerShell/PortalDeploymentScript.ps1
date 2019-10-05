#
# U P L O A D
#


#----------------------------------------------------------------------------------------------------------------------
# Step 1 - Report server Variablen setzen
#----------------------------------------------------------------------------------------------------------------------
$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$Folder1         = 'DEV'
$ErrorAction     = 'Continue'
$ErrorMsgConsole = ' '


#Schalter um Deployment je Folder festlegen zu können // 1= Ja, wird Deployed
$Deployment_Folder1 = 1

Write-Host 
 '# -------------------------------------------------------------------------------------------------------------------'
,'# '
,'# Step 1 - ReportServer - Variablen gesetzt'
,'#          $reportServerUri '
,'#          $ReportPortalUri '
,'#          $Folder1         '
,'# '
,'# -------------------------------------------------------------------------------------------------------------------'
,''



#----------------------------------------------------------------------------------------------------------------------
# Step 2 - Ordner auf dem Portal erstellen
#----------------------------------------------------------------------------------------------------------------------


Try{
    New-RsFolder -ReportServerUri $reportServerUri -Path / -Name $Folder1 -Verbose -ErrorAction Continue #-WarningAction Continue
    Write-Host 
     '# ---------------------------------------------------------------------------------------------------------------'
    ,'# Step 2 - ReportServer - Neues Verzeichnis erstellen' 
    ,'#'
    ,'# - Ordner    = $Folder1 '
    ,'# - PortalUri = $ReportPortalUri'
    ,'# ---------------------------------------------------------------------------------------------------------------'
    ,''
}
Catch{
    $ErrorMsgConsole = 
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


#---------------------------------------------------------------------------------------------------------------------- 
# Step 3 - Reports in Verzeichnis auf Portal raufladen
#----------------------------------------------------------------------------------------------------------------------

$ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST' 
Get-ChildItem $ReportPath -Recurse -Name -Directory # | #-include('*.xlsx','*.rdl','*.pbx')  

IF($Deployment_Folder1 = 1) {
    Try{
        Write-RsRestFolderContent -Path "C:\Users\ser-haa\Downloads\TEST PowerShell Reports" -RsFolder /$Folder1 -ReportPortalUri $ReportPortalUri  -Overwrite
        Write-Host
        ,'# ---------------------------------------------------------------------------------------------------------------'
        ,'# Step 3 - ReportServer - Neues Verzeichnis $Folder1 auf $ReportPortalUri befüllen mit Report-Artefakten'
        ,'# ---------------------------------------------------------------------------------------------------------------'
        ,' '
    }
    Catch{
        Write-Host 
         '# ---------------------------------------------------------------------------------------------------------------'
        ,'# Step 3 - Beim Report-Upload ging was schieff !!!'
        ,'#'
        ,'# Fehlermeldung lautet wie folgt :'
        ,'#',$Error[0]
        ,'#'
        ,'# Ende der Fehlermeldung'
        ,'#----------------------------------------------------------------------------------------------------------------'
        ,''
    }

    Write-Host
     ' '
    ,' '
    ,' '
    ,' ' 
}

#---------------------------------------------------------------------------------------------------------------------- 
# Step 4 - Auflisten alle Files des Quell- und des Zielverzeichnisses
#----------------------------------------------------------------------------------------------------------------------
<#
Try{
    Write-Host
     '# ---------------------------------------------------------------------------------------------------------------'
    ,'# Step 4.1 - Auflistung alle Files aus QUELL-Verzeichnis :'
    ,'#'
        Get-ChildItem -Path "C:\Users\ser-haa\Downloads\TEST PowerShell Reports" -Recurse -ErrorAction Continue
    Write-Host
    ,'#' 
    ,'# ENDE Step 4.1' 
    ,'# ---------------------------------------------------------------------------------------------------------------'

    Write-Host
     '# ---------------------------------------------------------------------------------------------------------------'
    ,'# Step 4.2 - Auflistung alle Files aus ZIEL-Verzeichnis :'
    ,'#'
        Get-RsFolderContent -RsFolder / -ReportServerUri $ReportServerUri -Recurse
    Write-Host
    ,'#' 
    ,'# ENDE Step 4.2' 
    ,'# ---------------------------------------------------------------------------------------------------------------'
}
Catch{
    Write-Host 
     '# ---------------------------------------------------------------------------------------------------------------'
    ,'# Step 3 - Beim Report-Upload ging was schieff !!!'
    ,'#'
    ,'# Fehlermeldung lautet wie folgt :'
    ,'#',$Error[0]
    ,'#'
    ,'# Ende der Fehlermeldung'
    ,'#----------------------------------------------------------------------------------------------------------------'
    ,''
}

#>

Write-Host 
 '# -------------------------------------------------------------------------------------------------------------------'
,'#      Script Ende'
,'# -------------------------------------------------------------------------------------------------------------------'

