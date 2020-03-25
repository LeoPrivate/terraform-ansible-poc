
provider "google" {
  credentials = file("key.json")
  project     = var.project_id
  region      = var.region
}


module "network" {
  source = "../../../modules/core/gcp/network"

  project_id = var.project_id

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  env    = var.environment_name
  region = var.region
}

module "frontend" {
  source = "../../../modules/core/gcp/frontend"

  public_subnets_name = module.network.public_subnets_name
  nb_instance         = var.nb_instance

  zones = list(var.zone1)

  network_name = module.network.network_name
  key_name     = var.key_name

  region  = var.region
  project = var.project_id
}


module "backend" {
  source = "../../../modules/core/gcp/backend"

  private_subnets_name = module.network.private_subnets_name
  nb_instance          = var.nb_instance

  zones = list(var.zone1)

  key_name     = var.key_name
  network_name = module.network.network_name

}

module "database" {
  source = "../../../modules/core/gcp/database"

  network_name         = module.network.network_name
  private_subnets_name = module.network.private_subnets_name
  key_name             = var.key_name

  nb_instance = 1

  zones = list(var.zone1)

}
