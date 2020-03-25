module "sg-backend" {
  source       = "../../../common/gcp/security_group"
  name         = "open-database"
  network_name = var.network_name

  ingress_rules = [
    {
      protocol    = "tcp"
      port        = ["5432", "22"]
      cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "instance-database" {
  source        = "../../../common/gcp/instance"
  instance_name = "database"

  subnets_name = var.private_subnets_name
  nb_instance  = 1
  key_name     = var.key_name

  zones = var.zones
}