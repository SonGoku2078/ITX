Get-Host

# gibt alle Variablen der Console aus
Get-Variable

#Variablen
$i1 = 1
$i1

#Mit den {} lassen sich ganze Befehle in Variablen speichern
$a = {Get-Process}

# Und so können diese Gespeicherten Befehle (wieder) ausgeführt werden
Invoke-Command $a

# Befehle gleich Cmdlets
Get-Verb
Get-Alias

#alle PS Module in einer Session geladen sind 
Get-Module

#So können Module importiert werden
Import-Module ScriptBrowser -Force

#Welche Befehle kennt / besitzt ein Modul
Get-Command -Module PackageManagement


#Hilfen
#Einfach Get-Help eingeben, gefolgt vom Modul-Namen und schon wird die Hilfe angezeigt
Get-Help Invoke-RestMethod -Examples
get-help Where-Object

#Welche Methoden udn Eigenschaften hat ein Rückgabewert von einem Befehl
Get-Process | select  -Property *

# Alias zeigt wie die "Copy-Folder" befehle aus Windows, in PowerShell heissen bzw. darüber sind die selben Befhel auch in PS nutzbar.
get-Alias


#Output/Ergebnis eines Cmdlets an ein anderes übergeben
Get-Service | Where-Object {$_.Status -eq 'Running'}
Get-Service | Select-Object -Property Name, StartType, Status | Where-Object {$_.Status -eq 'Stopped'}

# Messen (z.B. wieviele Prozesse laufen)
Get-Process | Measure-Object

