#
# Beschreibung :
# --------------
# Diese Skript kopiert bestehende Berichte (*.pbi, *.xlsx, *.rdl) von einem (lokalen) Windows-Verzeichnis (Ordner) auf einen existierenden Portal Ordner
# Existierende Reports werden einfach überschrieben, es erfolgt keine Fehlermeldung !

# Timestamp aufbereiten
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Statische Variablen
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\Config.csv'
$CsvDeployFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\DeployFolders.csv'


#-----------------------------------------------------------------------
# Teile 1: Configurationen einlesen 
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'


# Serveradresse aus Spalte lesen
ForEach ($item in $CsvConfig) {   
    $ReportPortalURI     = $item.Portal
    $EnvServer           = $item.EnvServer
}


#----------------------------------------------------------------------------------------------
# Part B: Copy content (Reports) from local "Windows"-Folder to "Portal"Folder on PBI-Reporting-Server
#
$CsvDeployFolder = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvDeployFoldersPath -ErrorAction  'Continue'


# 1.Get all defined TargetFolders/Path from cvs and copy content into "Portal"Folder on PBI-Reporting-Server
$i1=0
ForEach ($item in $CsvDeployFolder)
    {
     $TargetFolder  = $item.TargetFolder
     $SourceFolder  = $item.SourceFolder   
    
    # 2. Copy Folder Content (Reports) to "Portal"Folder on PBI-Reporting-Server
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
} #ForEach

#-------------------------------------------------------------------------------------------
# 3. Get all PBI-Reports and update "DataSource" for each PBI-Report on PBI-Reporting-Server

# 4. Get Reports from "Portal"-Folder
$Content = Get-RsFolderContent -RsFolder $TargetFolder -ReportServerUri $ReportPortalURI -Recurse  
$i2=0

# 5. loop over all reports from selected folder
ForEach ($item in $Content) 
    {          
    $Name       = $item.Name
    $TypeName  = $item.TypeName
    $Path       = $item.Path
    Write-Output "# A Info - ForEach #  - ${i2} |${Path}|${Name}|${TypeName}" 

    # 6. Datasource can only be changed for PBIX, therefore ItemType gets filtered
    IF($TypeName -eq "PowerBIReport") 
    {
        Write-Output "# Info#  - ${i2} |${Path}|${Name}|${TypeName}" 
        
        # 7. save existing "datasource connection string" configuration of PBI-Report (per Item)
        try {
            $DatasourceVar = Get-RsRestItemDataSource -RsItem $Path -ReportPortalUri $ReportPortalURI
            #$DSvarConString = $DatasourceVar[0].ConnectionString
        }
        catch {
             # Report the specific error that occurred, accessible via $_
             $ErrorMsg     = $Error[0]
             Write-Host 
             "#Error#------------------$(Get-TimeStamp)------------------#Error#"
             ,"#Error#"  
             ,"#Error# An error occurred for : Get-RsRestItemDataSource "
             ,"#Error#  - Path            = |${Path}|"
             ,"#Error#  - DataSourceVar   = |${DatasourceVar}|"
             ,"#Error#  - ReportPortalURI = |${ReportPortalURI}|"
             ,"#Error#  - ${i2}"
             ,"#Error# "
             ,'#Error# Fehlermeldung lautet wie folgt :'
             ,"#Error#  - |${ErrorMsg}|"
             ,"#Error#" 
             ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
        } #End Catch
            
                    
        # Write-Output ($DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") + 17)
        # Write-Output ($DatasourceVar[0].ConnectionString.Length - $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") -16)
        

        # 8. Splitt "ConnectionSting" into "ServerAdress" and "TabularModel"
        
        # ServerAdress
        $DSVarEnvServer = $DatasourceVar[0].ConnectionString.Substring(
                                    
                                    # "From" Subsring 
                                    $DatasourceVar[0].ConnectionString.IndexOf("Data Source=") + 12
                                    # in Length of (Substing)
                                    ,(
                                      $DatasourceVar[0].ConnectionString.IndexOf(";") - 
                                      $DatasourceVar[0].ConnectionString.IndexOf("Data Source=") +12  
                                     )
                          ) #End Substring

        # Write-Output "$DSVarEnvServer"
        # Write-Output " # => " $DatasourceVar[0].ConnectionString.Length -
        $DatasourceVar[0].ConnectionString.IndexOf(";")
        # Write-Output " # => |"+$DatasourceVar[0].ConnectionString+"|"

        # Tabular-Model
        $DSvarTabModelName = $DatasourceVar[0].ConnectionString.Substring(
                                    # "From" Subsring 
                                    $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") + 16
                                    # in Length (Substing)
                                    ,(
                                        $DatasourceVar[0].ConnectionString.Length -
                                        $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") -16
                                     )
                             ) #End Substring

        # Write-Output "DSvarTabModelName = |$DSvarTabModelName|"

        # 9. Compile "New" Connection-String
        #    Tabular-Model hasn't changed, only ServerAdress is replaced with the one from CSV 
        #$DataSourceConnectionUpdateString   = "Data Source=$EnvServer;$DSvarTabModelName"

        # Write-Output "DataSourceConnectionUpdateString = |$DataSourceConnectionUpdateString|"
        # Write-Output "# Info#  - ${i2}"

        # Write-Host 
        # "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
        # ,"#Info# "
        # ,"#Info# Datasource ConnectionString BEFOR modification : " 
        # ,"#Info#  - ReportItem       = |${path}|"
        # ,"#Info#  - ConnectionString = |${DatasourceVarConnectionString}|"
        # ,"#Info#  - ${i2}"
        # ,"#Info# "
        # ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"

        # 10. Compile "New" Connection-String and assign 
        $DatasourceVar[0].ConnectionString = "Data Source=$EnvServer;$DSvarTabModelName"

        Try{   
            # 11. Update PBI-Report on Report-Server-Portal with new DataSource-Connection 
            Set-RsRestItemDataSource -RsItem $path -ReportPortalUri $ReportPortalUri -RsItemType 'PowerBIReport' -DataSources $DatasourceVar[0]
            
            # 12. save Meta Data as additional Infos just in case
            # $Modifiedby   = $DatasourceVar[0].ModifiedBy 
            # $ModifiedDate = $DatasourceVar[0].ModifiedDate
            
            Write-Host 
            "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            # ,"#Info# "
            # ,"#Info# Datasource ConnectionString AFTER modification : " 
            ,"#Info# ReportItem       : |${path}}|"
            # ,"#Info# ConnectionString : |${DataSourceConnectionUpdateString}|"
            # ,"#Info# modified by      : |${ModifiedBy}|"
            # ,"#Info# modified Date    : |${ModifiedDate}|"
            # ,"#Info#  - ${i2}"
            # ,"#Info# "
            # ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
        } #End Try
        
        catch {
        # Report the specific error that occurred, accessible via $_
            $ErrorMsg     = $Error[0]
            Write-Host 
            "#Error#------------------$(Get-TimeStamp)------------------#Error#"
            ,"#Error#"  
            ,"#Error# An error occurred for : "
            ,"#Error#  - ReportItem       = |${ReportItem}|"
            ,"#Error#  - ConnectionString = |${DatasourceVarConnectionString}|"
            ,"#Info#  - ${i2}"
            ,"#Error# "
            ,'#Error# Fehlermeldung lautet wie folgt :'
            ,"#Error#  - |${ErrorMsg}|"
            ,"#Error#" 
            ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            Write-Host 
            "#Error#------------------$(Get-TimeStamp)------------------#Error#"
            ,"#Error#"  
            ,"#Error# An error occurred for : Set-RsRestItemDataSource "
            ,"#Error#  - Path            = |${Path}|"
            ,"#Error#  - DataSourceVar   = |${DatasourceVar[0]}|"
            ,"#Error#  - ReportPortalURI = |${ReportPortalURI}|"
            ,"#Error#  - ${i2}"
            ,"#Error# "
            ,'#Error# Fehlermeldung lautet wie folgt :'
            ,"#Error#  - |${ErrorMsg}|"
            ,"#Error#" 
            ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
        } #End Catch

    } # End IF
    $i2 ++
    Write-Output "#Info#  - ${i2}"
}