

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

terraform {
    backend "s3" {
        encrypt = true
        bucket = "terraform-remote-state-storage-nexworld"
        region = "eu-west-1"
        key = "dev/aws/terraform.tfstate"

        dynamodb_table = "lock-terraform-remote-storage"
    }
}

module "network" {
  source = "../../../modules/core/aws/network"

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  env = var.environment_name
}

module "frontend" {
  source = "../../../modules/core/aws/frontend"

  public_subnets_id = module.network.public_subnets_id
  nb_instance       = var.nb_instance
  key_name          = var.key_name_front
  vpc_id            = module.network.vpc_id

}

module "backend" {
  source = "../../../modules/core/aws/backend"

  private_subnets_id = module.network.public_subnets_id
  nb_instance        = var.nb_instance
  key_name           = var.key_name_front
  vpc_id             = module.network.vpc_id

  public_subnets_cidr = "${var.public_subnets}"
}

module "database" {
  source = "../../../modules/core/aws/database"

  vpc_id            = module.network.vpc_id
  public_subnets_id = module.network.public_subnets_id
  key_name          = var.key_name_front

  nb_instance = 1

}