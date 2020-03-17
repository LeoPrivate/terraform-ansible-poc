#module "sshkey" {
#  source = "../../common/aws/sshkey"
#
#  key_name = var.key_name
#}

module "sg-backend" {
  source = "../../../common/aws/security_group"
  name = "open_backend"
  description = "Allow traffic on 3000"
  vpc_id = var.vpc_id

  ingress_rules = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }, {
      from_port   = 80
      to_port     = 80
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

module "instances-backend" {
  source = "../../../common/aws/ec2"

  instance_name = "backend"
  key_name      = var.key_name

  subnets_id  = var.private_subnets_id
  sg_id       = module.sg-backend.id
  nb_instance = var.nb_instance
}

module "elb_back" {
  source = "terraform-aws-modules/elb/aws"
  name   = "elb-back"

  subnets         = var.private_subnets_id
  security_groups = [module.sg-backend.id]

  # Should be true, but not in this PoC
  internal = false

  listener = [
    {
      instance_port     = 3000
      instance_protocol = "HTTP"
      lb_port           = 3000
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:3000/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = var.nb_instance
  instances           = module.instances-backend.instances_ids
}