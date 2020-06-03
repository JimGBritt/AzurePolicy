[CmdletBinding()]
param (
    [Parameter(Mandatory=$True)]
    [string]$ARMTemplate,
    [Parameter(Mandatory=$True)]
    [guid]$subscriptionId
)
$ARMTemplateToProcess = Get-Content $ARMTemplate
$ResultSet = $ARMTemplateToProcess | ConvertFrom-Json
$Initiative = $($ResultSet.resources | Where-Object {$_.type -eq "Microsoft.Authorization/policySetDefinitions"})
$Policies = $($ResultSet.resources | Where-Object {$_.type -ne "Microsoft.Authorization/policySetDefinitions"})

if ($PSCmdlet.ShouldContinue("This is destructive. We are about to delete Custom Policy Initiative `"$($Initiative.Properties.displayname)`" and $($Policies.count) Custom Policy resources from your subscription $SubscriptionId. Continue?","Remove `"$($Initiative.Properties.displayname)`" Initiative?") )
{
    try
    {
        Write-host "Now removing Policy Initiative `"$($Initiative.Properties.displayname)`""
        $Null = Remove-AzPolicySetDefinition -Name $($Initiative.name) -SubscriptionId $subscriptionId -Force
        foreach($Policy in $Policies)
        {
            try 
            {
                Write-host "Now removing Custom Policy `"$($Policy.Properties.displayname)`""
                $Null = Remove-AzPolicyDefinition -Name $Policy.name -SubscriptionId $subscriptionId -Force
            }
            catch {
                Write-Host "Something went wrong!" -ForegroundColor Red
                break                
            }
            
        }    
    }
    catch{
        Write-Host "Something went wrong!" -ForegroundColor Red
        break
    }
}
else {
    Write-Host "You cancelled"    
}
Write-Host "Complete!" -ForegroundColor Green