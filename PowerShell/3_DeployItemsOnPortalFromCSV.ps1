#
# Beschreibung :
# --------------
# CSV File einlesen welches 2 spalten names "source" und "target" hat
#

# Statische Variablen
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$PathInputCSV    = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Reports Transportieren.csv'

# Variablen leeren
#Clear-Variable -Name MappingVerzeichnis
#Clear-Variable -Name i1

# csv importieren
$MappingVerzeichnis = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $PathInputCSV -ErrorAction  'Continue'
$i1=0

# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
ForEach ($item in $MappingVerzeichnis)
    {
     $RSFolder     = $item.FileTarget
     $Path         = $item.FileSource

     # Ordner auf Portal erstellen
     $i1++
 
     Write-RsRestFolderContent -Path C:\Temp -RsFolder $RSFolder -ReportPortalUri $ReportPortalUri -Overwrite
    # Write-RsRestFolder -Path $Path -RsFolder $RSFolder -ReportPortalUri $ReportPortalUri -Overwrite
     Write-Output ""
     Write-Output "${i1} - Verzeichnis : ${RSFolder}"
     Write-Output "    Ordner      : ${Path}"
     Write-Output ""
    
    }
    