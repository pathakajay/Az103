Connect-AzAccount
# Get List of All Resource Groups

Get-AzResourceGroup |Format-Table

$resourceGroupName="rgtags"
$location="centralus"

# Createa new Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Get the reference of exisiting Resource Group
$res=Get-AzResourceGroup -Name $resourceGroupName

# Get All Tags
$tags=$res.Tags

# Append tags to exisiting tags 
$tags+=@{Project="Electrical"}

# Apply tags to resource 
Set-AzResourceGroup -Name $resourceGroupName -Tags $tags 

# Print the Tags
$tags

# Get Resource By Tags
Get-AzResourceGroup -Tag @{Project = "Electrical"}

# Get All Tags
Get-AzTag

# Remove All Tags 
Set-AzResourceGroup -Tag @{} -Name $resourceGroupName

# Clean Up Resources 
Remove-AzResourceGroup $resourceGroupName