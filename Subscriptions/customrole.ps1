Connect-AzAccount -Subscription "Visual Studio Enterprise"

# View All Roles
Get-AzRoleDefinition | FT Name,IsCustom

# View only Custom Roles
Get-AzRoleDefinition | ? {$_.IsCustom -eq $false} | FT Name, IsCustom |Format-Table | Out-File .\Subscriptions\"json\roles.json"

# List a Role Definition 
$role=Get-AzRoleDefinition -Name "Virtual Machine Contributor" 
$role| ConvertTo-Json | Out-File .\Subscriptions\"json\Virtual Machine Contributor.json"
$role.Actions

Get-AzProviderOperation "Microsoft.Compute/virtualMachines/*" | `
 FT OperationName, Operation, Description -AutoSize | `
  Out-File .\Subscriptions\json\"virtualmachineoperations.json"

  $subscription=Get-AzSubscription -SubscriptionName "Visual Studio Enterprise" 
  $subscription

  
 $customRoleName="Virtual Machine Operator"
 $customRole=[Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition]::new()
 $customRole.Name=$customRoleName
 $customRole.Id=$null
 $customRole.Description = "Can monitor and restart virtual machines."
 $customRole.IsCustom=$true
 $perms = 'Microsoft.Storage/*/read','Microsoft.Network/*/read','Microsoft.Compute/*/read'
 $perms += 'Microsoft.Compute/virtualMachines/start/action','Microsoft.Compute/virtualMachines/restart/action'
 $perms += 'Microsoft.Authorization/*/read'
 $perms += 'Microsoft.ResourceHealth/availabilityStatuses/read'
 $perms += 'Microsoft.Resources/subscriptions/resourceGroups/read'
 $perms += 'Microsoft.Insights/alertRules/*','Microsoft.Support/*'
 $customRole.Actions=$perms
 $customRole.NotActions = (Get-AzRoleDefinition -Name 'Virtual Machine Contributor').NotActions
 
 $customRole.AssignableScopes="/subscriptions/"+$subscription.SubscriptionId
 
 New-AzRoleDefinition -Role $customRole
Get-AzRoleDefinition -Name $customRoleName | ConvertTo-Json | Out-File '.\Subscriptions\json\Virtual Machine Operator.json'

# If user tries to stop the virtual machine, then following error will be shown
#Failed to stop the virtual machine 'MACHINE_NAME'. Error: The client 'CLIENT NAME' with object id 'OBJECT_ID' does not have authorization to perform action 'Microsoft.Compute/virtualMachines/deallocate/action' over scope 'ROLE_NAME' or the scope is invalid. If access was recently granted, please refresh your credentials.
 