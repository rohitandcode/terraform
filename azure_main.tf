# Account details required for terraform
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}

   subscription_id = var.subscription_id
   client_id       = var.client_id
   client_secret   = var.client_secret
   tenant_id       = var.tenant_id
}

# Create random id for the resources
resource "random_id" "id" {
      byte_length = 8
}

# Create a new resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
        name = "TerraformRG-${random_id.id.hex}"
        location = var.rg_location

        tags = {
            environment = "Terraformtag"
        }
}

# Using existing subnet
data "azurerm_subnet" "existingsubnet" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_vnet
  resource_group_name  = var.subnet_rg
}

# create a network interface
resource "azurerm_network_interface" "myterraforminterface" {
  name                = "tfnic-${random_id.id.hex}"
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "TFIPconfig-${random_id.id.hex}"
    subnet_id                     = data.azurerm_subnet.existingsubnet.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
        environment = "Terraformtag"
  }
}

# Create a virtual machine from image

# Locate the existing custom golden image
data "azurerm_image" "search" {
  name                = var.search_image
  resource_group_name = var.search_rg
}

output "image_id" {
  value = var.search_image_id
}

resource "azurerm_virtual_machine" "myterraformvm" {
  name                             = var.deploy_image_name
  location                         = var.deploy_image_location
  resource_group_name              = azurerm_resource_group.myterraformgroup.name
  network_interface_ids            = [azurerm_network_interface.myterraforminterface.id] # leaving this out of var
  vm_size                          = var.deploy_image_size # Standard_DS1_v2
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.search.id
  }

  storage_os_disk {
        name              = "myTFOsDisk2-${random_id.id.hex}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = var.deploy_vm_name
        admin_username = var.deploy_username
        admin_password = var.deploy_password
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags = {
        environment = "Terraformtag"
    }
}

output "id" {
  description = "Virtual machine id created."
  value       = azurerm_virtual_machine.myterraformvm.id
}

output "ip" {
  description = "private ip addresses of the vm nics"
  value       = azurerm_network_interface.myterraforminterface.private_ip_address
}
