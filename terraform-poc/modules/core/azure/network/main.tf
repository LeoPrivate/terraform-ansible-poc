module "vnet" {

  source = "Azure/vnet/azurerm"

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  address_space = ["10.0.0.0/16"]

  subnet_prefixes = concat(var.public_subnets, var.private_subnets)
  subnet_names    = ["public1", "public2", "private1", "private2"]

  tags = {
    environement = var.env
  }
}