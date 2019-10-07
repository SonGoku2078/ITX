#
# Beschreibung :
# --------------
# Diese Skript erstellt auf dem Portal Ordner, welche über das CSV erfasst wurden.
# Existierende Ordner werden einfach umgangen, bzw. es erfolgt keine Fehlermeldung und wird einfach mit dem nächsten Ordner auf der Liste weiter gemacht.

# Statische Variablen
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 1\Config.csv'
$CsvDeployFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 1\DeployFolders.csv'


#-----------------------------------------------------------------------
# Teile 1: Configurationen einlesen 
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'

# Serveradresse aus Spalte lesen
ForEach ($item in $CsvConfig) {   
    $ReportPortalURI     = $item.Portal
}


#------------------------------------------------------------------------
# Teile 2: Lokale Ordner Inhalte in Portal Ordner rein transportieren
#
$CsvDeployFolder = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvDeployFoldersPath -ErrorAction  'Continue'
Write-Host "# CsvDeployFoldersPath = |${CsvDeployFoldersPath}|"
Write-Host "# CsvDeployFolder      = |${CsvDeployFolder}|"

# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
$i1=0
ForEach ($item in $CsvDeployFolder)
    {
     $TargetFolder  = $item.TagetFolder
     $SourceFolder  = $item.SourceFolder
    # Ordner auf Portal erstellen
        Try{
        
            $i1++
            # Write-RsRestFolderContent -Path $SourceFolder -RsFolder $TargetFolder -ReportPortalUri $ReportPortalUri -Overwrite
            Write-Output "${i1} - SoureOrdner : ${SourceFolder}                     TargetFolder : ${TargetFolder}"
        }
        
        catch {
            # Report the specific error that occurred, accessible via $_
            Write-Host " ------------------------------------------------------------------"
            Write-Host " An error occurred for : "
            Write-Host "     ${i1} - Ornder : |${SourceFolder}| Verzeichnis: |${TargetFolder}|"
            Write-Host " ------------------------------------------------------------------"
        }

    }
