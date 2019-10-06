#$ListOfPortalFoldersCsv = Import-Csv -Delimiter ';' -Encoding UTF8 -Path chooseDirectoryFile -ErrorAction  'Continue'
$ListOfPortalFoldersCsv = Import-Csv -Delimiter ';' -Encoding UTF8 -Path '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Powershell_import.csv' -ErrorAction  'Continue'

#Write-Output "# 1 = ${ListOfPortalFoldersCsv} vvv"
#Write-Output "${i1} - Ordner : ${Foldername}                     Verzeichnis : ${RSFolder}"
$cbListofPortalFoldersCsvTemp = $ListOfPortalFoldersCsv  | select-object  RSFolder  -unique
Write-Output $cbListofPortalFoldersCsvTemp