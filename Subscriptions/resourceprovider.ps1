Connect-AzAccount
Get-AzResourceProviderAction | ConvertTo-Json | Out-File .\Subscriptions\json\"providersaction.json"

Register-AzResourceProvider -ProviderNamespace "" 