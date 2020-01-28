# $method  = 'GET'
# $uri     = 'https://api.powerbi.com/v1.0/myorg/groups/5f4c28ea-b82b-4e49-8fde-ad2a3fadbb2b/users'
# $headers =  @{Authentication = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSIsImtpZCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSJ9.eyJhdWQiOiJodHRwczovL2FuYWx5c2lzLndpbmRvd3MubmV0L3Bvd2VyYmkvYXBpIiwiaXNzIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvNDRhNjQ3YjktZjAxZS00YzY1LThlZWYtNzc5ZjU1NGIzZGJhLyIsImlhdCI6MTU3OTAxMTIyNiwibmJmIjoxNTc5MDExMjI2LCJleHAiOjE1NzkwMTUxMjYsImFjY3QiOjAsImFjciI6IjEiLCJhaW8iOiI0Mk5nWURqSHQ5dzh5S2o1VEZMdHZlM1d5NHJLbWhNRVppMm9lVEhSNEhuR3I4cFhyS3dBIiwiYW1yIjpbInB3ZCJdLCJhcHBpZCI6IjdmNTlhNzczLTJlYWYtNDI5Yy1hMDU5LTUwZmM1YmIyOGI0NCIsImFwcGlkYWNyIjoiMiIsImZhbWlseV9uYW1lIjoiSGF1ZW5zdGVpbiIsImdpdmVuX25hbWUiOiJBbGV4YW5kZXIiLCJpcGFkZHIiOiI4Mi4yMjAuMjYuMjQyIiwibmFtZSI6IkFsZXhhbmRlciBIYXVlbnN0ZWluIiwib2lkIjoiYjczZTMzMDYtODRjZC00NDFjLThhMjAtYWU3MmY2MTVlYjJkIiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTEyMTQ0NDAzMzktNjMwMzI4NDQwLTY4MjAwMzMzMC0zNzIwIiwicHVpZCI6IjEwMDMzRkZGOTZEMURDNEYiLCJzY3AiOiJ1c2VyX2ltcGVyc29uYXRpb24iLCJzdWIiOiJwcERncWpPZjg1RlZYVmJ0eTM5Yi1fQXVhVjNmTk91SUswbzEyS2ZiZEZvIiwidGlkIjoiNDRhNjQ3YjktZjAxZS00YzY1LThlZWYtNzc5ZjU1NGIzZGJhIiwidW5pcXVlX25hbWUiOiJhaGF1ZW5zdGVpbkBpdC1sb2dpeC5jaCIsInVwbiI6ImFoYXVlbnN0ZWluQGl0LWxvZ2l4LmNoIiwidXRpIjoiZ29Gd1MzeDQ3VXFpN2xqREw4YmRBQSIsInZlciI6IjEuMCJ9.lmllgzO09nCoh-iWHosAwxbLRcS938OHoeLyLVOuLZMpFv4bwm_yjo-H3I_RY_gm5ciLx_eZNaZSFqYef_KdCr6ErlT7S5iQ8HeE2k0Z98o_-Oajw8xX_RWIFOZ2tHHFUaLSz90k9aiCUdk3YRAHlPbNnlfYgoZhnDUGZFpKMJeMhCCXVk0Cdb3fxMIVl1oRNXKLJUXTNHMzAdmeYTIBaCrgem9oYX0iwISwKHCeHGmuB0GiLM6DyYkKqaUieBPgAV0ixVU551Jy4TuUK_tMxK4iI2vp7_MGMZFejFN8O8GW5c-yBBsDv9vQ3RES5r9kv3vUgaWiyAi6Uv2OQC0Htw'}

# $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method $method -ContentType 'application/json'


Connect-PowerBIServiceAccount 

#$method  =  'Get'
$uri     = "https://api.powerbi.com/v1.0/myorg/groups/5f4c28ea-b82b-4e49-8fde-ad2a3fadbb2b/users"
#$uri     = 'Groups'
#$headers =  @{Authentication = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSIsImtpZCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSJ9.eyJhdWQiOiJodHRwczovL2FuYWx5c2lzLndpbmRvd3MubmV0L3Bvd2VyYmkvYXBpIiwiaXNzIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvNDRhNjQ3YjktZjAxZS00YzY1LThlZWYtNzc5ZjU1NGIzZGJhLyIsImlhdCI6MTU3OTAxMTIyNiwibmJmIjoxNTc5MDExMjI2LCJleHAiOjE1NzkwMTUxMjYsImFjY3QiOjAsImFjciI6IjEiLCJhaW8iOiI0Mk5nWURqSHQ5dzh5S2o1VEZMdHZlM1d5NHJLbWhNRVppMm9lVEhSNEhuR3I4cFhyS3dBIiwiYW1yIjpbInB3ZCJdLCJhcHBpZCI6IjdmNTlhNzczLTJlYWYtNDI5Yy1hMDU5LTUwZmM1YmIyOGI0NCIsImFwcGlkYWNyIjoiMiIsImZhbWlseV9uYW1lIjoiSGF1ZW5zdGVpbiIsImdpdmVuX25hbWUiOiJBbGV4YW5kZXIiLCJpcGFkZHIiOiI4Mi4yMjAuMjYuMjQyIiwibmFtZSI6IkFsZXhhbmRlciBIYXVlbnN0ZWluIiwib2lkIjoiYjczZTMzMDYtODRjZC00NDFjLThhMjAtYWU3MmY2MTVlYjJkIiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTEyMTQ0NDAzMzktNjMwMzI4NDQwLTY4MjAwMzMzMC0zNzIwIiwicHVpZCI6IjEwMDMzRkZGOTZEMURDNEYiLCJzY3AiOiJ1c2VyX2ltcGVyc29uYXRpb24iLCJzdWIiOiJwcERncWpPZjg1RlZYVmJ0eTM5Yi1fQXVhVjNmTk91SUswbzEyS2ZiZEZvIiwidGlkIjoiNDRhNjQ3YjktZjAxZS00YzY1LThlZWYtNzc5ZjU1NGIzZGJhIiwidW5pcXVlX25hbWUiOiJhaGF1ZW5zdGVpbkBpdC1sb2dpeC5jaCIsInVwbiI6ImFoYXVlbnN0ZWluQGl0LWxvZ2l4LmNoIiwidXRpIjoiZ29Gd1MzeDQ3VXFpN2xqREw4YmRBQSIsInZlciI6IjEuMCJ9.lmllgzO09nCoh-iWHosAwxbLRcS938OHoeLyLVOuLZMpFv4bwm_yjo-H3I_RY_gm5ciLx_eZNaZSFqYef_KdCr6ErlT7S5iQ8HeE2k0Z98o_-Oajw8xX_RWIFOZ2tHHFUaLSz90k9aiCUdk3YRAHlPbNnlfYgoZhnDUGZFpKMJeMhCCXVk0Cdb3fxMIVl1oRNXKLJUXTNHMzAdmeYTIBaCrgem9oYX0iwISwKHCeHGmuB0GiLM6DyYkKqaUieBPgAV0ixVU551Jy4TuUK_tMxK4iI2vp7_MGMZFejFN8O8GW5c-yBBsDv9vQ3RES5r9kv3vUgaWiyAi6Uv2OQC0Htw"}


$response = Invoke-PowerBIRestMethod -Url $uri -Method Get  | ConvertFrom-Json
#$response = Invoke-RestMethod -Uri $uri -Headers $headers -Method $method

$responseTot = $response.value | ConvertTo-Json

Out-File   -InputObject $responseTot  -FilePath "C:\Workspace3.json"

Write-Host $responseTot



# A --------------------------------------------------------------------------------------------------
# A -- Der Code hier funktioniert

$Liste = Get-Service | select-object Name, Status  | Where-Object  {$_.Name -like "VMI*"}# | Add-Member -MemberType NoteProperty "Space" -Value "Hex-ID" #| Format-Table 
$Liste | Add-Member -MemberType NoteProperty "Space" -Value "Hex-ID" #| Format-Table 


Write-Output $Liste

# A -- Hier die Referenz aus dem Netz:
# A -- https://stackoverflow.com/questions/24259199/add-column-and-assign-value-to-an-existing-array
# A --------------------------------------------------------------------------------------------------

