param (
  [string]$user="Anonymous",
  [string]$passkey
)

$resourceGroupName = "folding-at-home-rg"
$vmName = "fah-vm"
$location = "eastus"
$myPublicIP = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

az group create --name $resourceGroupName --location $location
az vm create  --name $vmName --resource-group $resourceGroupName --image ubuntults --size Standard_NC6_Promo --generate-ssh-keys
az vm run-command invoke --name $vmName --command-id RunShellScript --scripts "@setup.sh" --resource-group $resourceGroupName --parameters $myPublicIP $user $passkey
az network nsg rule create --resource-group $resourceGroupName --nsg-name $vmName'NSG' --name FAH_Web_Client --access allow --protocol Tcp --direction Inbound --priority 1010 --source-address-prefix "$myPublicIP" --source-port-range "*" --destination-address-prefix "*" --destination-port-range 7396
