

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

resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "8080"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "target-proxy"
  description = "http proxy for frontend"
  url_map     = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "url-map-target-proxy"
  description     = "url for frontend"
  default_service = google_compute_backend_service.default.self_link

  host_rule {
    hosts        = module.instances-frontend.instances_ips
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.self_link

    path_rule {
      paths   = ["/"]
      service = google_compute_backend_service.default.self_link
    }
  }
}

resource "google_compute_backend_service" "default" {
  name        = "backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_http_health_check.default.self_link]


  dynamic "backend" {
    for_each = google_compute_instance_group.eu-ig1

    content {
      group = backend.value["self_link"]
    }
  }
/*
  backend {
    group = google_compute_instance_group.eu-ig1[1].self_link
  }*/
}

resource "google_compute_http_health_check" "default" {
  name               = "check-backend"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port = 8080
}

resource "google_compute_instance_group" "eu-ig1" {
  name = "eu-ig-${count.index}"

  instances = list(module.instances-frontend.self_links[count.index])

  zone = var.zones[count.index % length(var.zones)]

  named_port {
    name = "http"
    port = "8080"
  }

  count = var.nb_instance
}

#### old 


/*


resource "google_compute_health_check" "my-tcp-health-check" {
  name = "my-tcp-health-check"

  tcp_health_check {
    port = "8080"
  }
}

resource "google_compute_region_backend_service" "backendgroup" {
  name          = "my-ext-lb"
  health_checks = [google_compute_health_check.my-tcp-health-check.self_link]
  region        = var.region

  backend {
    group = google_compute_instance_group.eu-ig1[0].self_link
  }

  backend {
    group = google_compute_instance_group.eu-ig1[1].self_link
  }
}

module "gce-lb-http" {
  source = "GoogleCloudPlatform/lb-http/google"
  name = "webserver"
  project = var.project
  target_tags = ["http"]
  backends =  { 
    "0" = [
      {group = "${google_compute_region_backend_service.backendgroup}"}
    ],
  }
}*/

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