Connect-ExchangeOnline
$GroupName = Read-Host "Please enter Dynamic Distribution Group Name"
$group = Get-DynamicDistributionGroup -Identity $GroupName | select Name
$groupmembers = Get-DynamicDistributionGroupMember -Identity $group.Name -ResultSize Unlimited | Select DisplayName, PrimarySMTPAddress, Title, Department, Office
#$allmail = Get-Mailbox -ResultSize Unlimited | Where {$_.AccountDisabled -eq $false} | Select Id, DisplayName, PrimarySMTPAddress
#$finaloutput = @()
#Foreach ($gmember in $groupmembers) {
#$tempvalue = $allmail| where {$_.ID -eq $gmember.Name} | select Id,DisplayName,PrimarySMTPAddress
#$finaloutput += ([pscustomobject]@{ID=$tempvalue.Id;DisplayName=$tempvalue.DisplayName;Email=$tempvalue.PrimarySMTPAddress;GroupName=$gmember.Name})
#}
#$finaloutput | Sort-Object -property DisplayName
$groupmembers | export-csv -path "$env:USERPROFILE\dynamicgroupexport.csv" -notypeinformation -encoding UTF8
write-host File saved to $env:USERPROFILE\dynamicgroupexport.csv