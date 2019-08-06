Connect-AzAccount -Subscription "Visual Studio Enterprise"

Set-AzureSubscription -SubscriptionName "Visual Studio Enterprise"
$invoice=Get-AzBillingInvoice -Latest

Invoke-WebRequest -Uri $invoice.DownloadUrl -OutFile ("c:\temp\billing\" + $invoice.Name +".pdf")