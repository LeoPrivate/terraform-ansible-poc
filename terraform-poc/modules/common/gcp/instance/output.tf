output instances_ids {
  value = google_compute_instance.frontend.*.instance_id
}

output instances_ips {
  value = google_compute_instance.frontend.*.network_interface.0.access_config.0.nat_ip
}

output self_links {
  value = google_compute_instance.frontend.*.self_link
}