#
# Beschreibung :
# --------------
# CSV File einlesen welches 2 spalten names "source" und "target" hat
#

#Variablen
$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'


$MappingVerzeichnis = Import-Csv -Delimiter ';' -Encoding UTF8 -Path C:\Temp\Powershell_import.csv

ForEach ($item in $MappingVerzeichnis)
    {
     $RSFolder              = $item.RSFolder
     $FolderName            = $item.FolderName


     
     Write-Output "Ziel-Pfad   : $RSFolder"
     Write-Output "Ziel-Ordner : $FolderName"

     New-RsFolder -ReportServerUri $ReportServerURI -RSFolder $RSFolder -FolderName $FolderName #$ErrorAction
    }


#     Write-Host "Created folder ${SubFolderParentPath}/${SubFolderName}"
    


Write-RsRestCatalogItem -Path 'C:\Temp\pbi.pbix' -RsFolder '/DEV99' -ReportPortalUri 'https://sv-rc-310.rega.local/Reports'