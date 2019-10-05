#
# Beschreibung :
# --------------
# CSV File einlesen welches 2 spalten names "source" und "target" hat
#

# Statische Variablen
$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'

# Variablen leeren
Clear-Variable -Name MappingVerzeichnis
Clear-Variable -Name i1

# csv importieren
$MappingVerzeichnis = Import-Csv -Delimiter ';' -Encoding UTF8 -Path '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Powershell_import.csv' -ErrorAction  'Continue'

$i1=0
# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
ForEach ($item in $MappingVerzeichnis)
    {
     $RSFolder     = $item.RSFolder
     $FolderName   = $item.FolderName

     # Ordner auf Portal erstellen
     $i1++
     New-RsFolder -ReportServerUri $ReportServerURI -RSFolder $RSFolder -FolderName $FolderName 
     Write-Output "${i1} - Ordner : ${Foldername}                     Verzeichnis : ${RSFolder}"
    
    }
