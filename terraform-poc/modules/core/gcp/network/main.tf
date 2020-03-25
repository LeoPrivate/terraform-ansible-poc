module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.1"

  project_id   = var.project_id
  network_name = "vpc-poc-iac-gcp"

  subnets = [
    {
      subnet_name   = "public-1"
      subnet_ip     = var.public_subnets[0]
      subnet_region = var.region
    },
    {
      subnet_name   = "public-2"
      subnet_ip     = var.public_subnets[1]
      subnet_region = var.region
    },
    {
      subnet_name   = "private-1"
      subnet_ip     = var.private_subnets[0]
      subnet_region = var.region
    },
    {
      subnet_name   = "private-2"
      subnet_ip     = var.private_subnets[1]
      subnet_region = var.region
    }
  ]

}