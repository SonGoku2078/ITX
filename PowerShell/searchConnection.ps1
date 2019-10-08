 
<#
Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU"  
#>
Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU"   -SimpleMatch <#-File "*Connections.*" #>

Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\RMC-Cockpit_TEST"  -Include "Connections" <#-Recurse | Select-String "rmc-uat.rega.local"#>