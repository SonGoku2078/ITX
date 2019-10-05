function Get-TimeStamp {
    
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    
}
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host "************************************************************************* "
Write-Host "*** Start $(Get-TimeStamp)    "
Write-Host "*** "
Write-Host "*** Step 1 - Portal-Verzeichnis runterladen in lokales Verzeichnis auf C:\" 
Write-Host "*** "
#---------------------------------------------------------------------------------------------------------------------- 
# Step 1 - Portal-Verzeichnis runterladen in lokales Verzeichnis auf C:\
#----------------------------------------------------------------------------------------------------------------------
$ReportPortalUri = 'https://rmc-uat.rega.local/Reports'
#$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$ReportPath  = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST\DEV9999'


Out-RsRestFolderContent -RsFolder / -Destination $ReportPath  -ReportPortalUri $ReportPortalUri -Recurse #-ErrorAction Continue

$i=0
Write-Host "Created folder : "

Get-ChildItem $ReportPath -Recurse -Directory -Name | 
    ForEach-Object {
        $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
        $SubFolderName       = Split-Path -Leaf $_
        $i=$i+1
        Write-Host " No.${i} "
        Write-Host "       '${SubFolderParentPath}' '${SubFolderName}'"
    }

Write-Host " "
Write-Host "*** "
Write-Host "*** Step 1 - Portal-Verzeichnis runterladen in lokales Verzeichnis auf C:\" 
Write-Host "*** "
Write-Host "*** Ende  Startzeit $(Get-TimeStamp)   " 
Write-Host "************************************************************************** "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "