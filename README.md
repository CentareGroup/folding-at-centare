# Introduction 
This project allows users to make use of the free Microsoft Azure credits provided by MSDN subscriptions to contribute to the [Folding at Home](https://foldingathome.org/) project and perform biological simulations to aid in the fight against COVID-19.  [Read more](https://www.hpcwire.com/2020/03/16/foldinghome-turns-its-massive-crowdsourced-computer-network-against-covid-19/).

# Getting Started
1.	If you have not activated your free Azure credits, sign in to my.visualstudio.com and under 'Benefits,' select 'Azure.'   
    *Note - the benefits referenced here are specific to Professional and Enterprise subscriptions. For other subscription types, please pay attention to the payment options to avoid being unnecessarily charged for services.*
2.	Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
3.	Open an elevated PowerShell window (right click - run as administrator) and type `az login`.
4.	Log in with your MSDN credentials.
5.  Set the CLI context to your MSDN subscription.
    * if you do not know the name or GUID corresponding to your MSDN subscription, run `az account list` in the terminal window and copy your MSDN account name (It will likely be something like "Visual Studio Enterprise").
    * Run `az account set --subscription (the value copied from above)` in the terminal.
    * Run `az account show` in the terminal and verify that your MSDN subscription is returned.
6. In the terminal, navigate to the directory where you cloned the source code.  
7. Run `.\fahinit.ps1` from the terminal window.  This will perform an unattended provisioning and initialization of the F@H client on the newly created machine.
8. Help save lives!

# FAQ
## Azure/MSDN
*  *Will I be charged for the resources created?*
    * You should not be if you are using an MSDN subscription and did not provide any credit card information. You do not need to specify a credit card for MSDN accounts. If your account type reads as 'Pay as you Go,' you will be charged for any resources created.
* *What happens if I go over the spending limit?*
    * If you exceed the available monthly credits, Microsoft will turn off your resources until the start of the next billing period. You should receive an email at the address registered to your MSDN. You may need to restart the virtual machine to continue folding if it is decomissioned.
* *What if I am using my MSDN for other resources and want to contribute on a smaller scale?*
    * In `fahinit.ps1`, change the parameter in line 6 from `Standard_F4s_v2` to a smaller and cheaper machine class. View the [Pricing Guide](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/) for information about the different machine classes. 
* *What if I no longer wish to use resources for the Folding at Home project?*
    * Either navigate to your resources in the Azure portal and delete the resource group, or run the following command from the terminal: `az group delete --name folding-at-home-rg` (change the `--name` parameter accordingly if you modified the original script). This will tear down all resources created.
## Folding @ Home
* *How do I specify my F@H account to get me and/or my team credits?*
    * Modify the `setup.sh` file to include your user, team, and/or passcodes on lines 11, 14, and 17 respectively.
* *How do I ensure that the processes will be working toward Coronavirus research?*
    * F@H will address the problem of greatest need. Right now the default is COVID-19.
# Contributions / Enhancements
* Any and all optimizations and ports welcome. It's entirely possible that greater results would be gained by different machine classes/containerization/orchestration/etc. Please let me know and I will happily accept pull requests and/or redirect to better solutions.