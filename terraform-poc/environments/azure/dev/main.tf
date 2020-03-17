provider "azurerm" {}

resource "azurerm_resource_group" "RG_web_3_tier" {
  name = "web_3_tier"
  location = "WEST US 2"
}

module "network" {
  source = "../../../modules/core/azure/network"

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  env = var.environment_name 

  ressource_group_name = azurerm_resource_group.RG_web_3_tier.name
  ressource_group_location = azurerm_resource_group.RG_web_3_tier.location
}

module "frontend" {
  source = "../../../modules/core/azure/frontend"

  public_subnets_id = module.network.public_subnets_id
  nb_instance       = var.nb_instance
  key_name = var.key_name_front
  vpc_id = module.network.vpc_id

  ressource_group_name = azurerm_resource_group.RG_web_3_tier.name
  ressource_group_location = azurerm_resource_group.RG_web_3_tier.location
}

module "backend" {
  source = "../../../modules/core/azure/backend"

  private_subnets_id = module.network.public_subnets_id
  nb_instance        = var.nb_instance
  key_name = var.key_name_front
  vpc_id = module.network.vpc_id

  public_subnets_cidr = "${var.public_subnets}"

  ressource_group_name = azurerm_resource_group.RG_web_3_tier.name
  ressource_group_location = azurerm_resource_group.RG_web_3_tier.location
}

module "database" {
  source = "../../../modules/core/azure/database"

  vpc_id            = module.network.vpc_id
  public_subnets_id = module.network.public_subnets_id
  key_name          = var.key_name_front

  nb_instance = 1

  ressource_group_name = azurerm_resource_group.RG_web_3_tier.name
  ressource_group_location = azurerm_resource_group.RG_web_3_tier.location
}