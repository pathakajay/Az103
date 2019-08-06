Connect-AzAccount -Subscription "Visual Studio Enterprise"

# View All Roles
Get-AzRoleDefinition | FT Name,IsCustom

# View only Custom Roles
Get-AzRoleDefinition | ? {$_.IsCustom -eq $false} | FT Name, IsCustom |Format-Table | Out-File .\Subscriptions\"json\roles.json"

# List a Role Definition 
$role=Get-AzRoleDefinition -Name "Virtual Machine Contributor" 
$role| ConvertTo-Json | Out-File .\Subscriptions\"json\Virtual Machine Contributor.json"
$role.Actions

Get-AzProviderOperation "Microsoft.Compute/virtualMachines/*" | FT OperationName, Operation, Description -AutoSize | Out-File .\Subscriptions\json\"virtualmachineoperations.json"