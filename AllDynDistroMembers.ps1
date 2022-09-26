Connect-ExchangeOnline
Write-Host `nProcess has begun to get all members for all dynamic distribution groups. This will take a while. -ForegroundColor Green
$allmail = Get-Mailbox -ResultSize Unlimited | Where {$_.AccountDisabled -eq $false} | Select Id, DisplayName, PrimarySMTPAddress
#$allAzure = Get-AzureADUser -All:$true | where {$_.AccountEnabled -eq $true} | Select DisplayName, UserPrincipalName, Department, JobTitle, PhysicalDeliveryOfficeName
$GroupName = Get-DynamicDistributionGroup -ResultSize Unlimited
$finaloutput = @()
foreach ($gname in $groupname) {
#	$groupmembers = Get-DynamicDistributionGroupMember -Identity $gname.Name -ResultSize Unlimited | Select DisplayName, PrimarySMTPAddress, Title, Department, @{N="GroupName";E={$$gname.name}}
#	Foreach ($gmember in $groupmembers) {
	#	$tempvalue = $allmail| where {$_.ID -eq $gmember.Name} | select Id,DisplayName,PrimarySMTPAddress
	#	$tempAzureAd = $allAzure | where {$_.UserPrincipalName -eq $tempvalue.PrimarySMTPAddress} | select Department, JobTitle, PhysicalDeliveryOfficeName
#		$finaloutput += ([pscustomobject]@{GroupName=$gname.Name;ID=$gmember.Id;DisplayName=$gmember.DisplayName;Email=$gmember.PrimarySMTPAddress;Department=$gmember.Department;JobTitle=$tempAzureAd.JobTitle;Office=$tempAzureAd.PhysicalDeliveryOfficeName})
	#	}
	$finaloutput += Get-DynamicDistributionGroupMember -Identity $gname.Name -ResultSize Unlimited | Select DisplayName, PrimarySMTPAddress, Title, Department, Office, @{N="GroupName";E={$gname.Name}}
	}
$pathforfile = $env:USERPROFILE+"\allmembers.csv"
$finaloutput | export-csv -path $pathforfile -NoTypeInformation -Encoding UTF8
Write-Host `nThe Output file available in $pathforfile -ForegroundColor Green