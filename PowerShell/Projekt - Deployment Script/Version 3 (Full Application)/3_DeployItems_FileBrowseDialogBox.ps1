#
# Beschreibung :
# --------------
# FileBrowserDialogbox um genau ein (1) ReportingFile zu selektieren
#


Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can be chosen
	Filter = 'BI-Files (*.rdl, *.pbix, *.xls*)|*.rdl;*.pbix;*.xls*' # Specified file types
}
 
[void]$FileBrowser.ShowDialog()

$file = $FileBrowser.FileName;

If($FileBrowser.FileNames -like "*\*") {

	# Do something 
	$FileBrowser.FileName #Lists selected files (optional)
	
}

else {
    Write-Host "Cancelled by user"
}

#Write-Output $FileBrowser.FileName