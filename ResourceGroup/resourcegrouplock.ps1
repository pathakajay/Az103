Connect-AzAccount
$subname="Visual Studio Enterprise"

Set-AzContext -Subscription $subname

$resourceGroup="rez-net-rg"
$resource=Get-AzResourceGroup -Name $resourceGroup
New-AzResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName $resourceGroup

Get-AzResourceLock

Get-AzResourceLock -ResourceGroupName $resourceGroup

# Get Lock id by Lock Name
$lockname="LockGroup"
$lockid=(Get-AzResourceLock -LockName $lockname)

# Get Lock id by resource name 
$lockid=(Get-AzResourceLock -ResourceGroupName $resourceGroup).LockId
$lockid
# Remove lock by lock id 
Remove-AzResourceLock -LockId $lockid

