#
# Beschreibung :
# --------------
# Diese Skript kopiert bestehende Berichte (*.pbi, *.xlsx, *.rdl) von einem (lokalen) Windows-Verzeichnis (Ordner) auf einen existierenden Portal Ordner
# Existierende Reports werden einfach überschrieben, es erfolgt keine Fehlermeldung !

# Timestamp aufbereiten
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

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


# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
$i1=0
ForEach ($item in $CsvDeployFolder)
    {
     $TargetFolder  = $item.TargetFolder
     $SourceFolder  = $item.SourceFolder   
    
    # Ordner auf Portal erstellen
        Try{
        
            $i1++
            Write-RsRestFolderContent -Path  $SourceFolder -RsFolder $TargetFolder -ReportPortalUri $ReportPortalURI -Overwrite 
            Write-Host 
             "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            ,"#Info# "
            ,"#Info# Folgende(r/s) Ordner/Verzeichnis(se) wurde erstellt : " 
            ,"#Info#  - ${i1} - Ornder : |${SourceFolder}| Verzeichnis: |${TargetFolder}|"
            ,"#Info# "
            ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
        }
        
        catch {
            $ErrorMsg = $Error[0]
            Write-Host 
             "#Error#------------------$(Get-TimeStamp)------------------#Error#"
            ,"#Error#"  
            ,"#Error# An error occurred for : "
            ,"#Error#  -  ${i1} - Ornder : |${SourceFolder}| Verzeichnis: |${TargetFolder}|"
            ,"#Error# "
            ,'#Error# Fehlermeldung lautet wie folgt :'
            ,"#Error#  - |${ErrorMsg}|"
            ,"#Error#" 
            ,"#Error#------------------$(Get-TimeStamp)------------------#Error#"
        }

    }
