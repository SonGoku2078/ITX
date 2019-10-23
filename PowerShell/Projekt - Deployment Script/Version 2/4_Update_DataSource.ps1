#
# Beschreibung :
# --------------
# Diese Skript kopiert bestehende Berichte (*.pbi, *.xlsx, *.rdl) von einem (lokalen) Windows-Verzeichnis (Ordner) auf einen existierenden Portal Ordner
# Existierende Reports werden einfach überschrieben, es erfolgt keine Fehlermeldung !

# create Timestamp 
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Static Variables
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\Config.csv'
$CsvDeployFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\DeployFolders.csv'


#-----------------------------------------------------------------------
# Part A: read configurationen 
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'


# read serveradresse out of csv column
ForEach ($item in $CsvConfig) {   
    $ReportPortalURI     = $item.Portal
    $EnvServer           = $item.EnvServer
}


#----------------------------------------------------------------------------------------------
# Part B: Copy content (Reports) from local "Windows"-Folder to "Portal"Folder on PBI-Reporting-Server
#
$CsvDeployFolder = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvDeployFoldersPath -ErrorAction  'Continue'


# # 1.Get all defined TargetFolders/Path from cvs and copy content into "Portal"Folder on PBI-Reporting-Server

ForEach ($item in $CsvDeployFolder)
    {
     $TargetFolder  = $item.TargetFolder

    #-------------------------------------------------------------------------------------------
    # 3. Get all PBI-Reports and update "DataSource" for each PBI-Report on PBI-Reporting-Server

    # 4. Get Reports from "Portal"-Folder
    $Content = $null
    $Content = Get-RsFolderContent -RsFolder $TargetFolder -ReportServerUri $ReportPortalURI -Recurse  
    

    # 5. loop over all reports from selected folder
    $i4= $null
    ForEach ($item in $Content) 
        {          
        $Name       = $item.Name
        $TypeName  = $item.TypeName
        $Path       = $item.Path
        
        # 6. Datasource can only be changed for PBIX, therefore ItemType gets filtered
        IF($TypeName -eq "PowerBIReport") 
        {           
            # 7. save existing "datasource connection string" configuration of PBI-Report (per Item)
            try {
                #$DatasourceVar = $null
                $DatasourceVar = Get-RsRestItemDataSource -RsItem $Path -ReportPortalUri $ReportPortalURI
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
                ,"#Error#  - Loop No.        = |${i4}|"
                ,"#Error# "
                ,'#Error# Fehlermeldung lautet wie folgt :'
                ,"#Error#  - |${ErrorMsg}|"
                ,"#Error#" 
                ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            } #End Catch
                
                        
            # 8. Splitt "ConnectionSting" into "ServerAdress" and "TabularModel"
            
            # 8a. ServerAdress
            #     The serveradress is retrieved from the csv file. Therefore the following statements are set to "comment".
            #     Although this statement could be used to retrieve the existing "Report" serveradress from the "connectionString".
            
            # $DSVarEnvServer = $null
            # $DSVarEnvServer = $DatasourceVar[0].ConnectionString.Substring(
            #                             # "From" Substring 
            #                             $DatasourceVar[0].ConnectionString.IndexOf("Data Source=")
            #                             # in Length of (Substing)
            #                             ,
            #                             ($DatasourceVar[0].ConnectionString.IndexOf(";") -   
            #                             $DatasourceVar[0].ConnectionString.IndexOf("Data Source=")  
            #                             )
            #                 ) #End Substring

            
            # 8b. Tabular-Model
            #     Retrieve the Name of the Tabular-Model, out of the "ConnectionString" of each Report

            $DSvarTabModelName = $null
            $DSvarTabModelName = $DatasourceVar[0].ConnectionString.Substring(
                                        # "From" Subsring 
                                        $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=")
                                        # in Length (Substing)
                                        ,(
                                            $DatasourceVar[0].ConnectionString.Length -
                                            $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=")
                                        )
                                ) #End Substring

            
            # 9. Compile "New" Connection-String
            #    Tabular-Model hasn't changed, only ServerAdress is replaced with the one from CSV 
            
            $DsVarConnectionString_OLD = $DatasourceVar[0].ConnectionString # only needed for 'Write-Output' below

            $DatasourceVar[0].ConnectionString = "Data Source=$EnvServer;$DSvarTabModelName"
            $DsVarConnectionString = $DatasourceVar[0].ConnectionString     # only needed for 'Write-Output' below

            Try{   
                # 11. Update PBI-Report on Report-Server-Portal with new DataSource-Connection 
                Set-RsRestItemDataSource -RsItem $path -ReportPortalUri $ReportPortalUri -RsItemType 'PowerBIReport' -DataSources $DatasourceVar[0]
                
                # 12. save Meta Data as additional Infos just in case
                $Modifiedby   = $DatasourceVar[0].ModifiedBy 
                $ModifiedDate = $DatasourceVar[0].ModifiedDate
                
                Write-Host 
                "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
                ,"#Info# "
                ,"#Info# Datasource ConnectionString :"
                ,"#Info# BEFOR modification : " 
                ,"#Info# - ConnectionString : |${DsVarConnectionString_OLD}|"
                ,"#Info# "
                ,"#Info# AFTER modification : " 
                ,"#Info# - ConnectionString : |${DsVarConnectionString}|"                
                ,"#Info# - ReportItem       : |${path}|"
                ,"#Info# - ReportName       : |${Name}|"
                ,"#Info# - ReportTyp        : |${TypeName}|" 
                ,"#Info# - modified by      : |${ModifiedBy}|"
                ,"#Info# - modified Date    : |${ModifiedDate}|"
                ,"#Info# - Loop No.         : |${i4}|"
                ,"#Info# "
                ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            } #End Try
            
            catch {
            # Report the specific error that occurred, accessible via $_
                $ErrorMsg     = $Error[0]
                Write-Host 
                "#Error#------------------$(Get-TimeStamp)------------------#Error#"
                ,"#Error#"  
                ,"#Error# An error occurred for : "
                ,"#Error#  - ReportItem       = |${ReportItem}|"
                ,"#Error#  - ReportName       : |${Name}|"
                ,"#Error#  - ReportTyp        : |${TypeName}|" 
                ,"#Error#  - ConnectionString = |${DsVarConnectionString}|"
                ,"#Error#  - Path             = |${Path}|"
                ,"#Error#  - ReportPortalURI  = |${ReportPortalURI}|"
                ,"#Error#  - Loop No.         = |${i4}|"
                ,"#Error# "
                ,'#Error# ErrorMesaage looks as follows :'
                ,"#Error#  - |${ErrorMsg}|"
                ,"#Error#" 
                ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            } #End Catch

        } # End IF

        $i4 ++
        # Write-Output "#Info#  - ${i4}"
        #$EnvServer         = $null      # Only set once, for all Reports. Therefore no init necessary
        $DSvarTabModelName  = $null      # specific for each report, therefore init to Null
    }
} #ForEach