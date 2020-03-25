# In production use different keys
# module "sshkey" {
#   source = "../../common/aws/sshkey"
# 
#   key_name = "${var.key_name}"
# }


module "sg-database" {
  source      = "../../../common/aws/security_group"
  name        = "open_database"
  description = "Allow traffic on 5432"
  vpc_id      = var.vpc_id

  ingress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }, {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "instance-database" {
  source        = "../../../common/aws/ec2"
  instance_name = "database"

  subnets_id  = var.public_subnets_id
  nb_instance = 1
  sg_id       = module.sg-database.id

  key_name = var.key_name
}