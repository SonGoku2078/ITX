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
compress-archive - -Path "C:\Temp\Upload\TESTzIP" -DestinationPath "C:\Temp\Upload\TESTzIP"

# #
# # Schritt 5: ZIP wieder auf PBIX renamen
# Get-ChildItem "C:\Temp\" -Name  -Recurse -include *.pbix   |  rename-item -newname {  $_.name  -replace ".pbix",".zip"  }

# #
# # Schritt 6: Nicht benötigte Ordner / Files löschen (aufräumen)
