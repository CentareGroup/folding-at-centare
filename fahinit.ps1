$resourceGroupName = "folding-at-home-rg"
$vmName = "fah-vm"
$location = "eastus"

az group create --name $resourceGroupName --location $location
az vm create  --name $vmName --resource-group $resourceGroupName --image ubuntults --size Standard_F4s_v2 --generate-ssh-keys
az vm run-command invoke --name $vmName --command-id RunShellScript --scripts "@setup.sh" --resource-group $resourceGroupName