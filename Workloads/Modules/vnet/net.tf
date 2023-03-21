// Create a Resource Group for the Virtual Network and Subnet
resource "azurerm_resource_group" "rg_net" {
  name     = "rg-net-${var.location}-${var.environment}"
  location = var.location
  tags     = var.tags

}

// Create a Virtual Network with a single subnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.location}-${var.environment}"
  address_space       = ["10.11.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  tags                = var.tags
}
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.location}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg_net.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.11.0.0/26"]
}

// Create a Subnet for AVD
resource "azurerm_subnet" "avd_subnet" {
  name                 = "avd-subnet-${var.location}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg_net.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.11.1.0/24"]
}

