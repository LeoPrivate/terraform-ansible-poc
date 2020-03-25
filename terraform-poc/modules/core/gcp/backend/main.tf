module "sg-backend" {
  source       = "../../../common/gcp/security_group"
  name         = "open-backend"
  network_name = var.network_name

  ingress_rules = [
    {
      protocol    = "tcp"
      port        = ["80", "22", "3000"]
      cidr_blocks = ["0.0.0.0/0"]
  }]
}



module "instances-backend" {
  source        = "../../../common/gcp/instance"
  instance_name = "backend"

  subnets_name = var.private_subnets_name
  nb_instance  = var.nb_instance
  key_name     = var.key_name

  zones = var.zones

}
/*
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
*/