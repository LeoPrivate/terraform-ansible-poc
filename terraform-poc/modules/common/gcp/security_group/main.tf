

resource "google_compute_firewall" "firewall_gcp" {
  name = var.name
  network = var.network_name

  allow {
    protocol = "icmp"
  }

  dynamic "allow" {
    for_each = var.ingress_rules

    content {
      protocol = allow.value["protocol"]
      ports =  allow.value["port"]
      
    }
  }
}