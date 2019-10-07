#
# Beschreibung :
# --------------
# Ausgewählte File in selectierten PortalOrdner deployen.
#

# Statische Variablen
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$PathInputCSV    = '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Reports Transportieren.csv'

Write-RsRestCatalogItem -Path 'C:\Temp\pbi.pbix' -RsFolder '/DEV99' -ReportPortalUri $ReportPortalUri -Overwrite

  