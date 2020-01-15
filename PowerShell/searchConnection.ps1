 
<#
Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU"  
#>
Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\AHAU"   -SimpleMatch <#-File "*Connections.*" #>

Get-ChildItem  -path "C:\Users\ahau\Downloads\TEST_7_ZIP\RMC-Cockpit_TEST"  -Include "Connections" -Recurse | Select-String "rmc-uat.rega.local"



function Edit-uc4ini($filespec, $search, $replace) {
    &lt;#
    .DESCRIPTION
    This function performs inline file editing like sed.
     
    .PARAMETER $filespec
    File to edit
     
    .PARAMETER $search
    Text to find in file
     
    .PARAMETER $replace
    Replacement text
     
    .EXAMPLE
    Edit-uc4ini "C:\Users\ahau\Downloads\TEST_7_ZIP\RMC-Cockpit_TEST\Connections" "rmc-uat.rega.local" "999_rmc-uat.rega.local_999" 
    #&gt;
    # foreach ($file in Get-ChildItem -Recurse $filespec | ? { Select-String $search $_ -Quiet } )
    foreach ($file in Get-ChildItem -Recurse "C:\Users\ahau\Downloads\TEST_7_ZIP\RMC-Cockpit_TEST\" | ? { Select-String "rmc-uat.rega.local" -Quiet } )
    {
    (Get-Content $file) |
    ForEach-Object {$_ -replace "rmc-uat.rega.local", "999_rmc-uat.rega.local_999" } |
    Set-Content $file
    }
    }