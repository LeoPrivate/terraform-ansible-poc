module "sg-database" {
  source = "../../../common/azure/security_group"

  name        = "open_database"
  description = "Allow traffic on 5432"
  vnet_id     = var.vnet_id

  ingress_rules = [
    {
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }, {
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }]

  egress_rules = [
    {
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "instance-database" {
  source        = "../../../common/azure/vm"
  instance_name = "database"

  subnets_id  = var.private_subnets_id
  nb_instance = 1

  key_name = var.key_name

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}
