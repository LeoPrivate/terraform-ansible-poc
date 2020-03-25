resource "azurerm_resource_group" "rg_poc" {
  name     = "web_3_tier"
  location = "West US 2"
}

module "network" {
  source = "../../../modules/core/azure/network"

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  env = var.environment_name

  ressource_group_name     = azurerm_resource_group.rg_poc.name
  ressource_group_location = azurerm_resource_group.rg_poc.location
}

module "frontend" {
  source = "../../../modules/core/azure/frontend"

  public_subnets_id = module.network.public_subnets_id
  nb_instance       = var.nb_instance
  key_name          = var.key_name_front
  vnet_id           = module.network.vnet_id

  ressource_group_name     = azurerm_resource_group.rg_poc.name
  ressource_group_location = azurerm_resource_group.rg_poc.location
}

module "backend" {
  source = "../../../modules/core/azure/backend"

  private_subnets_id = module.network.public_subnets_id
  nb_instance        = var.nb_instance
  key_name           = var.key_name_front
  vnet_id            = module.network.vnet_id

  ressource_group_name     = azurerm_resource_group.rg_poc.name
  ressource_group_location = azurerm_resource_group.rg_poc.location
}

module "database" {
  source = "../../../modules/core/azure/database"

  vnet_id            = module.network.vnet_id
  private_subnets_id = module.network.private_subnets_id
  key_name           = var.key_name_front

  nb_instance = 1

  ressource_group_name     = azurerm_resource_group.rg_poc.name
  ressource_group_location = azurerm_resource_group.rg_poc.location
}