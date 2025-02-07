module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-poc-iac"
  cidr = "10.0.0.0/16"

  azs = ["eu-west-1a", "eu-west-1b"]

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    environement = var.env
  }
}