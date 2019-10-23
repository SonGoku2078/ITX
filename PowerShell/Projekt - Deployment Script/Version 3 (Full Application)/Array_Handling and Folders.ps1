
#----------------------------------------------------------------------------------------------------------------------
# Step 2 - Ordner auf dem Portal erstellen
#----------------------------------------------------------------------------------------------------------------------

$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$Folder1         = 'TestFolder1'
$Folder1         = 'TestFolder2'



$Folder          = 
                    @( 
                         'empty element 0' # [0]
                        ,'TestFolder1'     # [1]
<#                       ,'TestFolder2'     # [2]
                        ,'TestFolder3'     # [3]
                        ,'TestFolder4'     # [4]
                        ,'TestFolder5'     # [5]
                        #>
                    )


For($i=1; $i -le $Folder.GetUpperBound(0); $i++) {

#    Write-Host 'Runde',$Folder[$i]

    Try{
        New-RsFolder -ReportServerUri $reportServerUri -Path /DEV -Name $Folder[$i] -Verbose -ErrorAction Continue 
    }

    Catch{
        $ErrorMsgConsole = 
        Write-Host 
         '# ---------------------------------------------------------------------------------------------------------------'
        ,'# Step 2 - ReportServer -  !!!! Verzeichnis schon vorhanden !!!! '
        ,'#'
        ,'# Fehlermeldung lautet wie folgt :'
        ,'#',$Error[0]
        ,'#'
        ,'# Ende der Fehlermeldung'
        ,'#----------------------------------------------------------------------------------------------------------------
         '
    }
 
}

