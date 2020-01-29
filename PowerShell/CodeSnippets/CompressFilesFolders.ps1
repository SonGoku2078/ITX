$FolderPath      = 'C:\Temp\Upload\' 

# Schritt 1: Rename PBIX auf ZIP
Get-ChildItem  $FolderPath -Name  -Recurse -include *.pbix   |  rename-item -newname {  $_.name  -replace ".pbix",".zip"  }

#
# Schritt 2: ZIP entpacken
$FolderPath      = 'C:\Temp\Upload\' 
Get-ChildItem  $FolderPath -Directory  -Recurse |
Expand-Archive -Path "C:\Temp\Upload\*.zip" -DestinationPath "C:\Temp\Upload\PBIX_Entzippt"


Get-ChildItem "C:\Temp\Upload\" -Name  -Recurse -include *.zip |
    ForEach-Object{
        Expand-Archive -Path "C:\Temp\Upload\" -DestinationPath "C:\Temp\Upload\`.name" 
    }


# !!!! Code Funktioniert  !!!!! #                  !!! OK !!!
$FolderPath      = 'C:\Temp\Upload\' 
$i=1

Write-Host "Folgendes Zip-File is vorhanden : "
Get-ChildItem $FolderPath -Filter *.zip | 
    ForEach-Object{ $i=$i ++; Write-Host "$i.) $_"
    }

Get-ChildItem $FolderPath -Filter *.zip | Expand-Archive -DestinationPath 'C:\Temp\Upload\TESTzIP\' -Force 


#
# Schritt 3: Connedction File austauschen           !!! OK !!!
Copy-Item -path 'C:\Temp\Upload\DEV\Connections' -Destination 'C:\Temp\Upload\TESTzIP\' 


#
# Schritt 4: Verzeichnis wieder zu zip packen
$i1=0
Get-ChildItem C:\Temp\Upload\TESTzIP\ | ForEach-Object {
                                                        Try{
                                                                #compress-archive -DestinationPath "C:\Temp\Upload\Testzip"}# compress-archive - -Path "C:\Temp\Upload\TESTzIP" -DestinationPath "C:\Temp\Upload\TESTzIP" }
                                                                $Filename   = $_.Fullname
                                                                $BaseName   = $_.BaseName
                                                                $DirectoryName = $_.DirectoryName
                                                                $LastIndexOf = $DirectoryName.LastIndexOf('\')
                                                                $DirNameRoot = $DirectoryName.Substring(0,$LastIndexOf)
                                                                $DirLength   = $DirectoryName.Length   
                                                                $NewFileName = $DirectoryName.Substring($LastIndexOf, $DirLength - $LastIndexOf)
                                                                #$zip = $BaseName + ".zip"
                                                                $zipPath = $DirNameRoot + $NewFileName + ".zip"
                                                                $i1 = $i1 + 1
                                                                Write-Host "+ -------------------------Beginn---------------------------------------------------"
                                                                Write-Host "+ No. ${i1} "
                                                                Write-Host "+ Last Index of DirectoryName = ${LastIndexOf}"
                                                                Write-Host "+ DirLength     = ${DirLength}"
                                                                Write-Host "+ DirectoryName = ${DirectoryName}"
                                                                Write-Host "+ DirNameRoot   = ${DirNameRoot}"
                                                                Write-Host "+ NewFileName   = ${NewFileName}"
                                                                Write-Host "+ DirectoryRoot = ${zipPath}"
                                                                Write-Host "+ FileName      = ${Filename}"
                                                                Write-Host "+ BaseName      = ${Basename}"
                                                                Write-Host "+ ZipPath       = ${zipPath}"
                                                                Write-Host "+ ---------------------------End----------------------------------------------------"
                                                                Write-Host " "
                                                                Compress-Archive -Path 'C:\Temp\Upload\TESTzIP\*' -Update -DestinationPath $zipPath 
                                                                #Compress-Archive -Path 'C:\Temp\Upload\TESTzIP\*' -DestinationPath 'C:\Temp\Upload\TESTzIP\NeuerReport.zip' -Update
                                                             }
                                                        Catch{
                                                                $ErrorMsgConsole = $Error[0]
                                                            #    Write-Host 
                                                                 '# ---------------------------------------------------------------------------------------------------------------'
                                                                ,'# Step X - Archiv wieder packen'
                                                                ,'#'
                                                                ,'# Fehlermeldung lautet wie folgt :'
                                                                ,'#',$Error[0]
                                                                ,'#'
                                                                ,"# No. ${i1} "
                                                                ,"# Last Index of DirectoryName = ${LastIndexOf}"
                                                                ,"# DirLength     = ${DirLength}"
                                                                ,"# DirectoryName = ${DirectoryName}"
                                                                ,"# DirNameRoot   = ${DirNameRoot}"
                                                                ,"# NewFileName   = ${NewFileName}"
                                                                ,"# DirectoryRoot = ${zipPath}"
                                                                ,"# FileName      = ${Filename}"
                                                                ,"# BaseName      = ${Basename}"
                                                                ,'# Ende der Fehlermeldung'
                                                                ,'#----------------------------------------------------------------------------------------------------------------
                                                                 '
                                                            }

                                                        }

# #
# # Schritt 5: ZIP wieder auf PBIX renamen
# Get-ChildItem "C:\Temp\" -Name  -Recurse -include *.pbix   |  rename-item -newname {  $_.name  -replace ".pbix",".zip"  }

# #
# # Schritt 6: Nicht benötigte Ordner / Files löschen (aufräumen)
