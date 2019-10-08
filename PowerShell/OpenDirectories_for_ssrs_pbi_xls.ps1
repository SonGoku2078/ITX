Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = 
    New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = 
                                    #\\C:\Users\ser-haa\source\Workspaces\REGA-RMC\RMC-Reporting\RMC-Reports 
                                   [Environment]::GetFolderPath('RMC-Reports') 
                                   #[Environment]::GetFolderPath('Desktop')
    Filter = 'SSRS (*.rdl)|*.rdl|PBI(*.pbix)|*.pbix|SpreadSheet(*.xlsx)|*.xlsx'
    }	
$null = $FileBrowser.ShowDialog()