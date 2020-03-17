output instances_ids {
  value = google_compute_instance.frontend.*.instance_id
}

output instances_ips {
  value = google_compute_instance.frontend.*.network_interface.0.network_ip
}