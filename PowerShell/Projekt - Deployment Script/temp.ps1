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

     $Content = Get-RsFolderContent -RsFolder $TargetFolder -ReportServerUri $ReportPortalURI -Recurse  
     $i2=0
     ForEach ($item in $Content)
        {
        $Name       = $item.Name
        $TypeName  = $item.TypeName
        $Path       = $item.Path
        
        IF($TypeName -eq "PowerBIReport"){

            Write-Output "#Info#  - ${i2} |${Path}|${Name}|${TypeName}" 
        
            #save datasource configuration
            $DatasourceVar = Get-RsRestItemDataSource -RsItem '/RMC-Cockpit_v3.1' -ReportPortalUri 'https://sv-rc-310.rega.local/Reports' 
            #save ConnectionString for print (write-Host)
            $DatasourceVarConnectionString = $DatasourceVar[0].ConnectionString
            Write-Host 
             "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            ,"#Info# "
            ,"#Info#  - ReportItem       = |${path}|"
            ,"#Info#  - ConnectionString = |${DatasourceVar}|"
            ,"#Info# "
            ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"

            Try{
                # Modifizierte DataSource-Connection zuweisen/übergeben
                $DatasourceVar[0].ConnectionString = $DatasourceVarConnectionString
                Set-RsRestItemDataSource -RsItem $path -ReportPortalUri $ReportPortalUri -RsItemType 'PowerBIReport' -DataSources $DatasourceVar
    
                # Meta Infos speichern um diese als Info auszugeben
                $Modifiedby   = $DatasourceVar[0].ModifiedBy 
                $ModifiedDate = $DatasourceVar[0].ModifiedDate

                Write-Host 
                 "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
                ,"#Info# "
                ,"#Info# Datasource ConnectionString AFTER modification : " 
                ,"#Info# ReportItem       : |${path}|"
                ,"#Info# ConnectionString : |${DatasourceVarConnectionString}|"
                ,"#Info# modified by      : |${ModifiedBy}|"
                ,"#Info# modified Date    : |${ModifiedDate}|"
                ,"#Info# "
                ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            }
            catch {
                # Report the specific error that occurred, accessible via $_
                $ErrorMsg     = $Error[0]
                Write-Host 
                 "#Error#------------------$(Get-TimeStamp)------------------#Error#"
                ,"#Error#"  
                ,"#Error# An error occurred for : "
                ,"#Error#  - ReportItem       = |${ReportItem}|"
                ,"#Error#  - ConnectionString = |${DatasourceVarConnectionString}|"
                ,"#Error# "
                ,'#Error# Fehlermeldung lautet wie folgt :'
                ,"#Error#  - |${ErrorMsg}|"
                ,"#Error#" 
                ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            }
         } # IF
         $i2 ++
     }
}


