Connect-AzAccount
$policyDisplayName="Audit VMs that do not use managed disks"
$policyName="Audit-VM-DISK"
$resourceGroup="rgpolicy"
$subscriptionName="Visual Studio Enterprise"

New-AzResourceGroup -Name $resourceGroup
# Register the resource provider if it's not already registered
Register-AzResourceProvider -ProviderNamespace 'Microsoft.PolicyInsights'

# Get a reference to the resource group that will be the scope of the assignment
$rg = Get-AzResourceGroup -Name $resourceGroup
$subscription=Get-AzSubscription | Where-Object {$_.Name -like $subscriptionName}
$scope="/Subscriptions/" + $subscription.SubscriptionId

# Get a reference to the built-in policy definition that will be assigned
$policy=Get-AzPolicyDefinition | where-object {$_.Properties.displayName -like  $policyDisplayName}

# Create the policy assignment with the built-in definition against your resource group
New-AzPolicyAssignment -Name $policyName -DisplayName $policyDisplayName -Scope $rg.ResourceId -PolicyDefinition $policy

# Assign policy at Subscription Level
New-AzPolicyAssignment -Name $policyName -DisplayName $policyDisplayName -Scope $scope -PolicyDefinition $policy

# Get All Subscriptions assigned at Subscription Level 
Get-AzPolicyAssignment -Scope $scope| Format-Table