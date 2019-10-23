#
# Beschreibung :
# --------------
# Diese Skript erstellt neue Ordner auf dem Portal, anhand der definitionen aus dem XLS- bzw. CSV-File
# Existierende Ordner werden NICHT überschrieben, sondern einfach ignoriert.

# create Timestamp 
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Statische Variablen
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 1\Config.csv'
$CsvPortalFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 1\PortalOrdner.csv'


#-----------------------------------------------------------------------
# Teile 1: Configurationen einlesen 
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'


# Serveradresse aus Spalte lesen
ForEach ($item in $CsvConfig) {   
    $ReportServerURI     = $item.Server
}


#------------------------------------------------------------------------
# Teile 2: Lokale Ordner Inhalte in Portal Ordner rein transportieren
#
$CsvPortalFolders = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvPortalFoldersPath -ErrorAction  'Continue'


# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
$i1=0
ForEach ($item in $CsvPortalFolders)
    {
     $PortalPath  = $item.PortalPath
     $NewFolder  = $item.NewFolder
    # Ordner auf Portal erstellen
        Try{
        
            $i1++
            New-RsFolder -ReportServerUri $ReportServerURI -RSFolder $PortalPath -FolderName $NewFolder -ErrorAction  'Continue' 
            Write-Host
             "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            ,"#Info# "
            ,"#Info# Following Folders / Directories where created : " 
            ,"#Info#  - ${i1} - Source : |${PortalPath}| Target: |${NewFolder}|"
            ,"#Info# "
            ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
        }
        
        catch {
            # Report the specific error that occurred, accessible via $_
            Write-Host
            "#Error#------------------$(Get-TimeStamp)------------------#Error#"
            ,"#Error#"  
            ,"#Error# An error occurred for : New-RsFolder "
            ,"#Error#  - Folder          : |${NewFolder}|"
            ,"#Error#  - DataSourceVar   : |${DatasourceVar}|"
            ,"#Error#  - PortalDirectory : |${Portalpath}|"
            ,"#Error#  - Loop No.        : |${i1}|"
            ," "
            ,'#Error# ErrorMesaage looks as follows :'
            ,"#Error#  - |${ErrorMsg}|"
            ,"#Error#" 
            ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            
        }

    }
