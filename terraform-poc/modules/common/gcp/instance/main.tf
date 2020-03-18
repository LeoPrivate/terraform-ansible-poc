resource "google_compute_instance" "frontend" {
  name = "${var.instance_name}-${count.index}"

  machine_type = var.instance_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "vpc-poc-iac-gcp"
    subnetwork = var.subnets_name[count.index]

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/${var.key_name}.pub")}"
  }

  tags = [var.instance_name]

  zone = var.zones[count.index % length(var.zones)]
  count = var.nb_instance
}
