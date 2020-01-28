# Create a new variable with today's date.
$todaysDate = Get-Date -Format "MM-dd-yyyy"

# Retreive a list of mailbox databases
$Databases = Get-MailboxDatabase | Where-Object { $_.Name -like "DB*" }

# Create an array to store the output
$Output = @()

# Go through each database and retreive the usage statistics
foreach ($Database in $Databases)
{
	# For each usage that exceeds limits
	foreach ($Usage in (Get-StoreUsageStatistics -Database $Database.Name | Where-Object { $_.TimeInServer -gt "5000" }))
	{
		# Collect information into a hashtable
		$Props = @{
			"Database Name" = $Database.Name
			"Display Name" = $Usage.DisplayName
			"Time In Server" = $Usage.TimeInServer
		}
		
		# Add the object to our array of output objects
		$Output += New-Object PSObject -Property $Props
	}
}

$Output | Sort-Object "Time In Server" | Export-CSV "$todaysDate.csv" -NoTypeInformation