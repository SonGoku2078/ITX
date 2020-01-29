#
# Description :
# --------------
# Already existing reports (*.pbi, *.xlsx, *.rdl) can be copied from a (local) Windows-Directory (Folder) into an existing Folder on Reporting Server 
# Existing Reports will be replaced! No error message will pop up !!

# prepare Timestamp
function Get-TimeStamp {return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)}

# Static Variables
$CsvConfigPath        = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\Config.csv'
$CsvDeployFoldersPath = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Version 2\DeployFolders.csv'


#-----------------------------------------------------------------------
# Part A: read Configurationen 
#
$CsvConfig = Import-Csv -Delimiter ';' -Encoding UTF8 -Path $CsvConfigPath -ErrorAction  'Continue'


# read serveradresse out of csv column
ForEach ($item in $CsvConfig) {   
    $ReportPortalURI     = $item.Portal
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
        ,"#Info# Following Folders / Directories where created : " 
        ,"#Info#  - ${i1} - Source : |${SourceFolder}| Target: |${TargetFolder}|"
        ,"#Info# "
        ,"#Info#------------------$(Get-TimeStamp)-------------------#Info#"
    }
    
    catch {
        $ErrorMsg = $Error[0]
        Write-Host
         "#Error#------------------$(Get-TimeStamp)------------------#Error#"
        ,"#Error#"  
        ,"#Error# An error occurred for : Write-RsRestFolderContent "
        ,"#Error#  - Source Folder   : |${SourceFolder}|"
        ,"#Error#  - Target Folder   : |${TargetFolder}|"
        ,"#Error#  - ReportPortalURI : |${ReportPortalURI}|"
        ,"#Error#  - Loop No.        : |${i1}|"
        ,"#Error# "
        ,'#Error# ErrorMesaage looks as follows :'
        ,"#Error#  - |${ErrorMsg}|"
        ,"#Error#" 
        ,"#Error#------------------$(Get-TimeStamp)------------------#Error#"
    }
} #ForEach