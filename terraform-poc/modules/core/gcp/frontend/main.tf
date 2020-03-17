

module "sg-frontend" {
  source = "../../../common/gcp/security_group"
  name = "open-website"
  network_name = var.network_name

  ingress_rules = [
    {
      protocol    = "tcp"
      port = ["80", "22", "8080"]
      cidr_blocks = ["0.0.0.0/0"]
    }]
}



module "instances-frontend" {
  source        = "../../../common/gcp/instance"
  instance_name = "frontend"

  subnets_name  = var.public_subnets_name
  nb_instance = var.nb_instance
  key_name = var.key_name

  zones = var.zones
  
}

/*
module "elb_http" {
  source = "terraform-aws-modules/elb/aws"
  name   = "elb-front"

  subnets         = var.public_subnets_id
  security_groups = [module.sg-frontend.id]
  internal        = false

  listener = [
    {
      instance_port     = 8080
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:8080/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = var.nb_instance
  instances           = module.instances-frontend.instances_ids
}
*/