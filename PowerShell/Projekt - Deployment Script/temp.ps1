# Timestamp aufbereiten
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Static Variables
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\Config.csv'
$CsvDeployFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\DeployFolders.csv'
           

#-----------------------------------------------------------------------
# Part A: Read Configuration from CSV
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'


# Get PortalURI and Database-Server
ForEach ($item in $CsvConfig) {   
    $ReportPortalURI     = $item.Portal
    $EnvServer           = $item.EnvServer
}


#----------------------------------------------------------------------------------------------
# Part B: Copy content (Reports) from local "Windows"-Folder to "Portal"Folder on PBI-Reporting-Server
#
$CsvDeployFolder = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvDeployFoldersPath -ErrorAction  'Continue'

# 1.Get all defined TargetFolders/Path from cvs and create those "Portal"Folder on PBI-Reporting-Server
$i2=0
ForEach ($item in $CsvDeployFolder)
    {

     $TargetFolder  = $item.TargetFolder
     
    #  2. Get all Reports(Content) of each "Windows"-folder
     $Content = Get-RsFolderContent -RsFolder $TargetFolder -ReportServerUri $ReportPortalURI -Recurse  
     $i2=0

    #  Über alle selektierten Reports aus dem Ordner iterieren / loopen
     ForEach ($item in $Content) 
        {          
        $Name       = $item.Name
        $TypeName  = $item.TypeName
        $Path       = $item.Path
        Write-Output "# A Info - ForEach #  - ${i2} |${Path}|${Name}|${TypeName}" 

        # Die DatasourceÄnderung soll /kann nur an PBI Reports vorgenommen werden
        IF($TypeName -eq "PowerBIReport") 
        {
            Write-Output "# Info#  - ${i2} |${Path}|${Name}|${TypeName}" 
            
            # save existing old datasource configuration of PBI-Report (Item)
            $DatasourceVar = Get-RsRestItemDataSource -RsItem $Path -ReportPortalUri https://sv-rc-310.rega.local/Reports 
            $DSvarConString = $DatasourceVar[0].ConnectionString

                       
            Write-Output ($DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") + 17)
            Write-Output ($DatasourceVar[0].ConnectionString.Length - $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") -16)
            $DSVarEnvServer        = $DatasourceVar[0].ConnectionString.Substring(
                                                                                            # "From" Subsring 
                                                                                            $DatasourceVar[0].ConnectionString.IndexOf("Data Source=") + 12
                                                                                            
                                                                                            # in Length of (Substing)
                                                                                            ,(
                                                                                                $DatasourceVar[0].ConnectionString.IndexOf(";") - 
                                                                                                $DatasourceVar[0].ConnectionString.IndexOf("Data Source=") +12
                                                                                                
                                                                                             )
                                                                                          ) #End Substring

            Write-Output "$DSVarEnvServer"
            Write-Output " # => " $DatasourceVar[0].ConnectionString.Length -
            $DatasourceVar[0].ConnectionString.IndexOf(";")
            Write-Output " # => |"+$DatasourceVar[0].ConnectionString+"|"
            $DSvarTabModelName = $DatasourceVar[0].ConnectionString.Substring(
                                                                                            # "From" Subsring 
                                                                                            $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") + 16
                                                                                            # in Length (Substing)
                                                                                            ,(
                                                                                                $DatasourceVar[0].ConnectionString.Length -
                                                                                                $DatasourceVar[0].ConnectionString.IndexOf("Initial Catalog=") -16
                                                                                            )
                                                                                         ) #End Substring
            
            Write-Output "DSvarTabModelName = |$DSvarTabModelName|"
            $DataSourceConnectionUpdateString   = "Data Source=$EnvServer;$DSvarTabModelName"
            Write-Output "DataSourceConnectionUpdateString = |$DataSourceConnectionUpdateString|"
            Write-Output "# Info#  - ${i2}"

            Write-Host 
             "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
            ,"#Info# "
            ,"#Info# Datasource ConnectionString BEFOR modification : " 
            ,"#Info#  - ReportItem       = |${path}|"
            ,"#Info#  - ConnectionString = |${DatasourceVarConnectionString}|"
            ,"#Info#  - ${i2}"
            ,"#Info# "
            ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"

            Try{
                
                # Modifizierte DataSource-Connection zuweisen 
                $DatasourceVar[0].ConnectionString = "Data Source=$EnvServer;$DSvarTabModelName"
                
                # Neue DataSource-Connection auf dem Report, auf dem Portal, ändern
                Set-RsRestItemDataSource -RsItem $path -ReportPortalUri $ReportPortalUri -RsItemType 'PowerBIReport' -DataSources $DatasourceVar[0]
                
                # Meta Infos speichern um diese als Info auszugeben
                $Modifiedby   = $DatasourceVar[0].ModifiedBy 
                $ModifiedDate = $DatasourceVar[0].ModifiedDate
                
                Write-Host 
                 "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
                ,"#Info# "
                ,"#Info# Datasource ConnectionString AFTER modification : " 
                ,"#Info# ReportItem       : |${path}}|"
                ,"#Info# ConnectionString : |${DataSourceConnectionUpdateString}|"
                ,"#Info# modified by      : |${ModifiedBy}|"
                ,"#Info# modified Date    : |${ModifiedDate}|"
                ,"#Info#  - ${i2}"
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
                ,"#Error#  - ConnectionString = |${DatasourceVarConnectionString}|"
                ,"#Info#  - ${i2}"
                ,"#Error# "
                ,'#Error# Fehlermeldung lautet wie folgt :'
                ,"#Error#  - |${ErrorMsg}|"
                ,"#Error#" 
                ,"#Error#------------------$(Get-TimeStamp)------------------#Error#" 
            } #End Catch

         } # End IF
         $i2 ++
         Write-Output "#Info#  - ${i2}"
     } # End ForEach
}

Write-Output "#Info#  - ${i2}"