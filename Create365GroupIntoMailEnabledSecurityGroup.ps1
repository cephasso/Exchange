New-UnifiedGroup -DisplayName "Dallas Office Team" -PrimarySmtpAddress "dallasot@riveron.com" -AutoSubscribeNewMembers:$true -AccessType private

Set-UnifiedGroup -Identity "dallasoffice@riveron.com" -UnifiedGroupWelcomeMessageEnabled:$false -HiddenFromAddressListsEnabled:$true -HiddenFromExchangeClientsEnabled:$true