# CORONAFOLD

Save the world with distributed computing to work against COVID-19!

## Introduction

This project allows users to make use of the free Microsoft Azure credits provided by MSDN subscriptions to contribute to the [Folding at Home](https://foldingathome.org/) project and perform biological simulations to aid in the fight against COVID-19.  [Read more](https://www.hpcwire.com/2020/03/16/foldinghome-turns-its-massive-crowdsourced-computer-network-against-covid-19/).

## Getting Started

1. If you have not activated your free Azure credits, sign in to my.visualstudio.com and under 'Benefits,' select 'Azure.'
    *Note - the benefits referenced here are specific to Professional and Enterprise subscriptions. For other subscription types, please pay attention to the payment options to avoid being unnecessarily charged for services.*
2. Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
3. Open an elevated PowerShell window (right click - run as administrator) and type `az login`.
4. Log in with your MSDN credentials.
5. Set the CLI context to your MSDN subscription.
    * if you do not know the name or GUID corresponding to your MSDN subscription, run `az account list` in the terminal window and copy your MSDN account name (It will likely be something like "Visual Studio Enterprise").
    * Run `az account set --subscription (the value copied from above)` in the terminal.
    * Run `az account show` in the terminal and verify that your MSDN subscription is returned.
6. In the terminal, navigate to the directory where you cloned the source code.
7. Run `.\fahinit.ps1` from the terminal window.  This will perform an unattended provisioning and initialization of the F@H client on the newly created machine.
8. Help save lives!

You can now view your folding operations from a computer on the same network as the one that executed the azure cli commands. So you run this on your laptop at home, you can access the web control by putting in the IP Address of the service, and port 7396. Example `https://127.0.0.1:7396/` where `127.0.0.1` is the IP of the new Azure VM.

You can find the Azure VM IP address in the script output in teh "publicIPAddress" field. It looks like this:

```json
{
  "fqdns": "",
  "id": "/subscriptions/xxxxxxx/resourceGroups/folding-at-home-rg/providers/Microsoft.Compute/virtualMachines/fah-vm",
  "location": "eastus",
  "macAddress": "xxxxxxxxx",
  "powerState": "VM running",
  "privateIpAddress": "x.x.x.x",
  "publicIpAddress": "100.6.12.15",
  "resourceGroup": "folding-at-home-rg",
  "zones": ""
}
```

Just copy that (without the quotes) and paste it into your browser address bar, followed by `:7396`.

## FAQ

## Azure/MSDN

* *Will I be charged for the resources created?*
  * You should not be if you are using an MSDN subscription and did not provide any credit card information. You do not need to specify a credit card for MSDN accounts. If your account type reads as 'Pay as you Go,' you will be charged for any resources created.
* *What happens if I go over the spending limit?*
  * If you exceed the available monthly credits, Microsoft will turn off your resources until the start of the next billing period. You should receive an email at the address registered to your MSDN. You may need to restart the virtual machine to continue folding if it is decomissioned.
* *What if I am using my MSDN for other resources and want to contribute on a smaller scale?*
  * In `setup.sh`, change the  parameter for CPUs - line 58 - to match the number of CPUs on your instance type
  * In `fahinit.ps1`, change the parameter in line 6 from `Standard_NC6_Promo` to a smaller and cheaper machine class. View the [Pricing Guide](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/) for information about the different machine classes.
  * If you change to a computer instance other than a name like `*_NC*_*`, then remove lines 13 in `fahinit.ps1`
* *What if I no longer wish to use resources for the Folding at Home project?*
  * Either navigate to your resources in the Azure portal and delete the resource group, or run the following command from the terminal: `az group delete --name folding-at-home-rg` (change the `--name` parameter accordingly if you modified the original script). This will tear down all resources created.

## Folding @ Home

* *How do I specify my F@H account to get me and/or my team credits?*
  * Run the script wit the following parameters
    * `-user`: your desired username
    * `-passkey`: your user passkey, if applicable
* *How do I ensure that the processes will be working toward Coronavirus research?*
  * F@H will address the problem of greatest need. Right now the default is COVID-19.

## Contributions / Enhancements

Any and all optimizations and ports welcome. It's entirely possible that greater results would be gained by different machine classes/containerization/orchestration/etc. Please let me know and I will happily accept pull requests and/or redirect to better solutions.
