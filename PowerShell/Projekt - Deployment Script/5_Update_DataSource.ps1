#
# Beschreibung :
# --------------
# Hier wird die DataSource eines PBI Reports geändert, welcher sich bereits auf dem Portal befindet.
#

# Timestamp aufbereiten
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Statische Variablen
$DataSourceConnectionUpdateString   = 'Data Source=sv-rc-310\MSSQLSERVER_TEST200;Initial Catalog=R4_RMC_Tabular_Cockpit_HAUI'
$ReportItem                         = '/RMC-Cockpit_v3.1'
$ReportPortalUri                    = 'https://sv-rc-310.rega.local/Reports'


# Read DataSource of existing Report 
Try{
    
    #save datasource configuration
    $DatasourceVar = Get-RsRestItemDataSource -RsItem $ReportItem -ReportPortalUri $ReportPortalUri 
    #save ConnectionString for print (write-Host)
    $DatasourceVarConnectionString = $DatasourceVar[0].ConnectionString
    Write-Host 
     "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
    ,"#Info# "
    ,"#Info# Datasource ConnectionString BEFOR modification : " 
    ,"#Info#  - ReportItem       = |${ReportItem}|"
    ,"#Info#  - ConnectionString = |${DatasourceVarConnectionString}|"
    ,"#Info# "
    ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
}
catch {
    # Report the specific error that occurred, accessible via $_
    $ErrorMsg = $Error[0]
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

# Update DataSource of existing Report
Try{
    # Modifizierte DataSource-Connection zuweisen/übergeben
    $DatasourceVar[0].ConnectionString = $DataSourceConnectionUpdateString
    Set-RsRestItemDataSource -RsItem $ReportItem -ReportPortalUri $ReportPortalUri -RsItemType 'PowerBIReport' -DataSources $DatasourceVar
    
    # Meta Infos speichern um diese als Info auszugeben
    $Modifiedby   = $DatasourceVar[0].ModifiedBy 
    $ModifiedDate = $DatasourceVar[0].ModifiedDate

    Write-Host 
     "#Info#------------------$(Get-TimeStamp)-------------------#Info#"
    ,"#Info# "
    ,"#Info# Datasource ConnectionString AFTER modification : " 
    ,"#Info# ReportItem       : |${ReportItem}|"
    ,"#Info# ConnectionString : |${DataSourceConnectionUpdateString}|"
    ,"#Info# modified by      : |${ModifiedBy}|"
    ,"#Info# modified Date    : |'${ModifiedDate}|"
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