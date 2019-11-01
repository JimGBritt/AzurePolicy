---
title: Step by Step on Using the Create-AzDiagPolicy.ps1 PowerShell script
description: Step by step process to cover how to leverage the Create-AzDiagPolicy.ps1 to create Azure Diagnostic Policies supporitng Log Analytics and Event Hubs.
author: jimgbritt
ms.author: jbritt
ms.date: 11/01/2019
ms.topic: conceptual
ms.service: cloud management
---
# OVERVIEW OF CREATE-AZDIAGPOLICY.PS1

**Create-AzDiagPolicy.ps1** is a script that creates Azure Custom Policies supporting Azure resource types that support Azure Diagnostics logs and metrics.  Policies can be created for both Event Hub and Log Analytics sink points with this script.  In addition, this script will only provide the policies for the resource types you have within the Azure Subscription that you provide either via the cmdline parameter -SubscriptionId or by selecting a subscription from the menu provided.  

* Optionally you can supply a tenant switch to scan your entire Azure AD Tenant.  

    > **Note**:
    > Please use caution when using this option as it will take quite some time to scan thousands of subscriptions!


## Parameters
The following cmdline parameters are available with this script to help customize the experience and remove all prompting during execution.

![Parameters](./media/params.png)

Parameter details are contained within the synopsis of the script for more information. From the PowerShell console type the following to get a full detailed listing of parameters and their use.

```azurepowershell-interactive
  get-help .\Create-AzDiagPolicy.ps1 -Parameter * 
```
## Executing the Script
Examples of how to use the script can be found by executing the following from the PowerShell console

```azurepowershell-interactive
  get-help .\Create-AzDiagPolicy.ps1 -examples 
```
### Exporting Event Hub and Log Analytics Policies
The following parameters will export Event Hub and Log Analytics Policies for Azure Diagnostics to a relative path of **.\PolicyExports** and validate all JSON export content as a last step.
```azurepowershell-interactive
  .\Create-AzDiagPolicy.ps1 -ExportEH -ExportLA -ExportDir .\PolicyExports -ValidateJSON -SubscriptionId "<SUBID>"
```
![ScriptLaunch](./media/ScriptLaunch.png)

You are then prompted with a list of resourceTypes to choose from. You can select “22” below to export all policies for all resourceTypes detected or you can simply select the one you care about.  You can also provide that on cmdline via parameter (-ExportAll).

![Menu ResourceTypes](./media/menu-resourceTypes.png)

Once you've selected your option and pressed enter, the details of the export / creation of Azure Policy files and optional validation is displayed.

![Menu ResourceTypes](./media/results-scanned.png)

The results of this export represent a series of subfolders for each ResourceType and Policy Type you have opted to create.

![Menu ResourceTypes](./media/Export-Files.png)

- azurepolicy.json : This is the full json file needed to create a policy within Azure
- azurepolicy.parameters.json : This file represents the parameters for your policy 
- azurepolicy.rules.json: This file has all the rules that your policy is leveraging to go against Azure for compliance evaluation 

    > **Note**:
    > Each of the above files are required and leveraged to create a custom Azure Policy in Azure via CLI or PowerShell (shown next)

## See also

- [PowerShell Gallery (https://aka.ms/CreateAzDiagPolicies)](https://aka.ms/CreateAzDiagPolicies)
