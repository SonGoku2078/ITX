$FolderPath      = 'C:\Temp\Upload\' 

# Schritt 1: Rename PBIX auf ZIP
Get-ChildItem  $FolderPath -Name  -Recurse -include *.pbix   |  rename-item -newname {  $_.name  -replace ".pbix",".zip"  }

#
# Schritt 2: ZIP entpacken
Get-ChildItem  $FolderPath -Directory  -Recurse |
Expand-Archive -Path "C:\Temp\Upload\*.zip" -DestinationPath "C:\Temp\Upload\PBIX_Entzippt"

Get-ChildItem "C:\Temp\Upload\" -Name  -Recurse -include *.zip |
    ForEach-Object{
        Expand-Archive -Path "C:\Temp\Upload\" -DestinationPath "C:\Temp\Upload\`.name" 
    }

    Get-ChildItem $FolderPath -Filter *.zip | Expand-Archive -DestinationPath 'C:\Temp\Upload\TESTzIP\.ZIP' -Force    
#
# Schritt 3: Connedction File austauschen

#
# # Schritt 4: Verzeichnis wieder zu zip packen
# compress-archive -Path "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU" -DestinationPath "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU.zip"

# #
# # Schritt 5: ZIP wieder auf PBIX renamen
# Get-ChildItem "C:\Temp\" -Name  -Recurse -include *.pbix   |  rename-item -newname {  $_.name  -replace ".pbix",".zip"  }

# #
# # Schritt 6: Nicht benötigte Ordner / Files löschen (aufräumen)
